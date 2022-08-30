import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                print("Before logout:");
                bool logged=FirebaseAuth.instance.currentUser!=null;
                print("is logged:$logged");
                await FirebaseAuth.instance.signOut();

                print("After logout:");
                logged=FirebaseAuth.instance.currentUser!=null;
                print("is logged:$logged");
                Navigator.pushNamed(context, "/login_screen");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Text("Good Job!"),
        ],
      ),
    );
  }
}
