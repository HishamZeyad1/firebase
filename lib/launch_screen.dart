
import 'package:firebase/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bool isloged=FirebaseAuth.instance.currentUser!=null;
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context,isloged?'/home_screen':'/login_screen'),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   // gradient: LinearGradient(
        //   //     colors: [Colors.orange, Colors.blue],
        //   //     begin: Alignment.topLeft,
        //   //     end: Alignment.bottomRight),
        //   image: DecorationImage(image: AssetImage("images/note1.png",),fit: BoxFit.contain,),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(alignment: Alignment.center,child: Image.asset("images/note1.png",fit: BoxFit.cover,height: 100,width: 100,)),
            SizedBox(height: 10,),
            Text(
              "Note App",style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
