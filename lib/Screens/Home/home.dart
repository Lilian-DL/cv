import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  String title;
  Home({Key? key, required this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _viewFile() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('pdf/DEMONT_LILIAN.pdf')
        .getDownloadURL();
    final _url = downloadURL;
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _signOut() async {
      await FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: () {
            _signOut();
          },
        ),
      ]),
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),
            const InfoUser(),
            const Padding(padding: EdgeInsets.all(10.0)),
            ElevatedButton(
              child: const Text('Download my CV !'),
              onPressed: _viewFile,
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            const Text("En cours De développement !"),
          ],
        ),
      ),
    );
  }
}

class InfoUser extends StatelessWidget {
  const InfoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: user.doc("bUiZ3KHaaIfMaeyGT9RPaxY6KeH2").get(),
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("${data['FirstName']} ${data['LastName']}");
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
