import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
          TextButton(
            onPressed: () {},
            child: Text("Sign Up"),
          ),
        ],
      ),
    );
  }
}
