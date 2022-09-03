
// import 'package:firebase/Archive/login_screen.dart';
import 'package:firebase/add_note.dart';
import 'package:firebase/fb_storage.dart';
// import 'package:firebase/home_screen.dart.dart';
import 'package:firebase/home_screen.dart';
import 'package:firebase/register_screen.dart';
import 'package:firebase/login_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'launch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );

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
        primarySwatch: Colors.teal,
        // buttonColor:Colors.teal ,
        textTheme: TextTheme(headline6: TextStyle(fontSize: 20,color: Colors.white)),
        fontFamily: "Noto Serif"/*"laila"*/,
        // iconTheme: IconThemeData(color:Colors.teal ),

        // textTheme: GoogleFonts.lailaTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      initialRoute:'/launch_screen' ,
      routes: {
        '/launch_screen':(BuildContext)=>LaunchScreen(),
        '/register_screen':(BuildContext)=>RegisterScreen(),
        '/login_screen':(BuildContext)=>LoginScreen(),
        '/home_screen':(BuildContext)=>HomeScreen(),
        '/add_note':(BuildContext)=>AddNote(),

        // '/home_screen':(BuildContext)=>HomeScreen(),
        // '/fb_storage':(BuildContext)=>FbStorage(),
      },
    );
  }
}
