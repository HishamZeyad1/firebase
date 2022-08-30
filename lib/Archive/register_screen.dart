import 'package:firebase/Archive/login_screen.dart';
import 'package:firebase/home.dart';
// import 'package:firebase/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/fb_auth.dart';

// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:twitter_login/twitter_login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late UserCredential userCredential;
  int clicked = 0; //0 default,1 clickedLoading,2 clickingStop
  @override
  Widget build(BuildContext context) {
    // print("is Logged:${FirebaseAuth.instance.currentUser!=null}");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //     child: Text("Sign With Anymous"),
            //     style: ElevatedButton.styleFrom(
            //       minimumSize: Size(double.infinity,50)
            //     ),
            //     onPressed: () async {
            //       bool logged=await FbAuth().loginAnyomous();
            //       print("logged:$logged");
            //       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
            //     }),
            // SizedBox(height: 10,),
            Image.asset(
              "images/note1.png",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                hintText: "Enter your Username",
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.teal.shade300)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.teal.shade300)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.teal.shade500)),
                // disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.teal.shade300)),
                // focusColor:Colors.teal.shade300,
                iconColor: Colors.teal.shade300,
                hoverColor: Colors.teal.shade300,
                fillColor: Colors.teal.shade300,
                prefixIconColor: Colors.teal.shade300,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                ),
                hintText: "Enter your Email",
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.teal.shade300)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.teal.shade300)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.teal.shade500)),
                // disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.teal.shade300)),
                // focusColor:Colors.teal.shade300,
                iconColor: Colors.teal.shade300,
                hoverColor: Colors.teal.shade300,
                fillColor: Colors.teal.shade300,
                prefixIconColor: Colors.teal.shade300,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                ),
                hintText: "Enter your Password",
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.teal.shade300)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.teal.shade300)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.teal.shade500)),
                // disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.teal.shade300)),
                // focusColor:Colors.teal.shade300,
                iconColor: Colors.teal.shade300,
                hoverColor: Colors.teal.shade300,
                fillColor: Colors.teal.shade300,
                prefixIconColor: Colors.teal.shade300,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ElevatedButton(
                child: Text("create Account"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.teal.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(20))),
                ),
                onPressed: () async {
                  bool created = await FbAuth().createAccount(
                      emailAddress: "hishamzeyad498@gmail.com",
                      password: "123456");
                  print("created:$created");
                }),
            // ElevatedButton(
            //     child: Text("Sign With Email And Password"),
            //     style: ElevatedButton.styleFrom(
            //       minimumSize: Size(double.infinity, 50),
            //       primary: Colors.teal.shade300,
            //       shape: RoundedRectangleBorder(
            //           borderRadius:
            //               BorderRadiusDirectional.all(Radius.circular(20))),
            //     ),
            //     onPressed: () async {
            //       bool logged = await FbAuth().signEmailAndPassword(
            //           emailAddress: "hishamzeyad498@gmail.com",
            //           password: "123456");
            //       print("logged:$logged");
            //       // await signEmailAndPassword(emailAddress: "hishamzeyad498@gmail.com", password: "123456");
            //       if (logged)
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (BuildContext context) => HomeScreen()));
            //     }),
            // SizedBox(height: 10,),
            // ElevatedButton(
            //     child: Text("Sign With Google"),
            //     style: ElevatedButton.styleFrom(
            //         minimumSize: Size(double.infinity,50)
            //     ),
            //     onPressed: () /*async*/ {
            //       // await signInWithGoogle();
            //     }),
            SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("if you have an account?"),
                TextButton(
                  onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));},
                  child: Text("Sign Up"),
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                ),
              ],
            ),

            // ElevatedButton(
            //     child: Text("Sign With Facebook"),
            //     style: ElevatedButton.styleFrom(
            //         minimumSize: Size(double.infinity,50)
            //     ),
            //     onPressed: () /*async*/ {
            //       // await loginAnyomous();
            //     }),
            // SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  showLoading(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("please,waiting"),
            content: Container(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }
}
