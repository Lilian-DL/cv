import 'package:cv/Screens/AuthScreens/authGate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // ignore: prefer_const_constructors
      options: FirebaseOptions(
          apiKey: "AIzaSyCm5XWHTKlFR9hMlP86uAq8iXqvbp4Xfqc",
          authDomain: "demontliliancv-ec82b.firebaseapp.com",
          projectId: "demontliliancv-ec82b",
          storageBucket: "demontliliancv-ec82b.appspot.com",
          messagingSenderId: "713899481742",
          appId: "1:713899481742:web:7b6ed92a4a2236b09147df",
          measurementId: "G-L7M0F8M99Q"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthGate(),
    );
  }
}
