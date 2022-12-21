// import 'package:firebase/Archive/login_screen.dart';
import 'package:firebase/add_note.dart';
import 'package:firebase/fb_storage.dart';
import 'package:firebase/helper/fb_notifications.dart';

// import 'package:firebase/home_screen.dart.dart';
import 'package:firebase/home_screen.dart';
import 'package:firebase/register_screen.dart';
import 'package:firebase/login_screen.dart';
import 'package:firebase/test.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'launch_screen.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  print("=========background=========");
  print(message.notification!.title);
  print(message.notification!.body);
  print("Handling a background message: ${message.messageId}");
  print("from : ${message.from}");
  print("senderId: ${message.senderId}");
}
void main() async {
  print("=========main=========");
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  await FbNotifications.initNotifications();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20, color: Colors.white),
          headline5: TextStyle(fontSize: 30, color: Colors.green),
          bodyText1:TextStyle(fontSize: 20, color: Colors.grey.shade500),
        ),
        fontFamily: "Noto Serif" /*"laila"*/,
        // iconTheme: IconThemeData(color:Colors.teal ),

        // textTheme: GoogleFonts.lailaTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (BuildContext) => LaunchScreen(),
        '/register_screen': (BuildContext) => RegisterScreen(),
        '/login_screen': (BuildContext) => LoginScreen(),
        '/home_screen': (BuildContext) => HomeScreen(),
        '/add_note': (BuildContext) => AddNote(),
        '/test': (BuildContext) => Test(),
        // '/home_screen':(BuildContext)=>HomeScreen(),
        // '/fb_storage':(BuildContext)=>FbStorage(),
      },
    );
  }
}


