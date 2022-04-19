import 'package:applore_task/pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);

      return user;
    } catch (e) {
      // print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/aplore.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                children: [
                  const Text(
                    'Sign in to Continue',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'APPLORE ',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.black,
                              offset: Offset(3, 3))
                        ]),
                  ),
                  const Text(
                    'TECHNOLOGY',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.black,
                              offset: Offset(3, 3))
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SignInButton(
                    Buttons.Apple,
                    onPressed: () {},
                  ),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () async {
                      await _googleSignUp().then(
                        (value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//Ultra Flutter Food app
