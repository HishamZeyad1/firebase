
import 'package:firebase/home.dart';
import 'package:firebase/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'launch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute:'/launch_screen' ,
      routes: {
        '/launch_screen':(BuildContext)=>LaunchScreen(),
        '/register_screen':(BuildContext)=>RegisterScreen(),
        '/home_screen':(BuildContext)=>HomeScreen(),
      },
    );
  }
}
