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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Download my CV !'),
          onPressed: _viewFile,
        ),
      ),
    );
  }
}
