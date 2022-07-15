import 'package:firebase/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'controller/fb_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:twitter_login/twitter_login.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late UserCredential userCredential;

  @override
  Widget build(BuildContext context) {
    // print("is Logged:${FirebaseAuth.instance.currentUser!=null}");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: Text("Sign With Anymous"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity,50)
                ),
                onPressed: () async {
                  bool logged=await FbAuth().loginAnyomous();
                  print("logged:$logged");
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
                }),
            SizedBox(height: 10,),
            ElevatedButton(
                child: Text("create Account"),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity,50)
                ),
                onPressed: () async {
                  bool created=await FbAuth().createAccount(emailAddress: "hishamzeyad498@gmail.com", password: "123456");
                  print("created:$created");
                }),
            SizedBox(height: 10,),
            ElevatedButton(
                child: Text("Sign With Email And Password"),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity,50)
                ),
                onPressed: () async {
                  bool logged=await FbAuth().signEmailAndPassword(emailAddress: "hishamzeyad498@gmail.com", password: "123456");
                  print("logged:$logged");
                  // await signEmailAndPassword(emailAddress: "hishamzeyad498@gmail.com", password: "123456");
                    if(logged)
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
                }),
            SizedBox(height: 10,),
            ElevatedButton(
                child: Text("Sign With Google"),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity,50)
                ),
                onPressed: () /*async*/ {
                  // await signInWithGoogle();
                }),
            SizedBox(height: 10,),
            ElevatedButton(
                child: Text("Sign With Facebook"),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity,50)
                ),
                onPressed: () /*async*/ {
                  // await loginAnyomous();
                }),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }







}
