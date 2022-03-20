import 'package:cv/Screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuthGate extends StatefulWidget {
  AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
              sideBuilder: (context, constraints) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image(image: AssetImage('images/MyCV.jpg')),
                  ),
                );
              },
              providerConfigs: const [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(
                  clientId:
                      '713899481742-2jo0lriscslarjjm3mio7k5elkqlg2cg.apps.googleusercontent.com',
                ),
              ]);
        }

        // Render your application if authenticated
        return Home(
          title: "My CV !!",
        );
      },
    );
  }
}
