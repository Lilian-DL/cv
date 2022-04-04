import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  height: 500,
                  width: 500,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('web/assets/images/MyCV.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              buttondoawnload(_viewFile),
              const Padding(padding: EdgeInsets.only(top: 25, bottom: 25)),
              const Text(
                "Mes Projets",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              // projetGitHub(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Projet(id: "Hpn7IpCsxjmXfN6w58DF"),
                      Projet(id: "KA1LIkuBYc6aSRAaltj4"),
                      Projet(id: "dDvsC9iKaZcoGN7kqfFh"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buttondoawnload(viewFile) {
  return SizedBox(
    height: 40,
    width: 400,
    child: ElevatedButton(
      child: const Text('Vous pouvez télécharger mon CV ici !'),
      onPressed: viewFile,
    ),
  );
}

// ignore: must_be_immutable
class Projet extends StatelessWidget {
  String id;
  Projet({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Projet');
    return FutureBuilder<DocumentSnapshot>(
        future: collection.doc(id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
                top: 25,
                bottom: 25,
              ),
              margin: const EdgeInsets.only(
                  left: 50, right: 50, top: 50, bottom: 50),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${data['Title']}",
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: const Text('Voir ici!',
                        style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      _launchURL("${data['Url']}");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          return const Text("loading");
        });
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
