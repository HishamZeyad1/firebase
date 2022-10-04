// Replace with server token from firebase console settings.
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final String serverToken = 'AAAAbzRpdjY:APA91bFMniaxvu1MpX5eyAJAWi_RgDQS3Pq3Zi1lSaFujasohdKhjXt9R1L3QxUF9BdxVqFf4EU2eqbxq36jpcNgrTqtZ3k54zTkJuDAPKY79D2XGUrYDDnO5HfCn-u5WvCczNLst0Xi';

  sendNotify(String title,String body,String id) async {
    // var url=Uri(scheme:'https',host:'fcm.googleapis.com',path:'fcm/send',);
    var url=Uri.parse("https://fcm.googleapis.com/fcm/send");
    try{
      await http.post(url/*Uri('https://fcm.googleapis.com/fcm/send')*/,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': id.toString(),
              'status': 'done'
            },
            'to': /*await FirebaseMessaging.instance.getToken()*/'/topics/ProgramingChannel',
          },
        ),
      );
    }catch(error){
      print("============error==============");
      print(error.toString());}
  }
  getMessage(){
    FirebaseMessaging.onMessage.listen((message){
      print(message.notification!.title);
      print(message.notification!.body);
      print(message.data);
      // print(message.data['name']);
    });
  }
  @override
  void initState() {
    print("hello");
    // TODO: implement initState
    super.initState();
    getMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification"),),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Spacer(),
            Text("Programing Channel"),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              sendNotify("Welcome", "How are you", "1");
              print("send Notify");
            }, child: Text("send Notify")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              await FirebaseMessaging.instance.subscribeToTopic("ProgramingChannel");
              print("Subscuribe");
              }, child: Text("Subscuribe")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              await FirebaseMessaging.instance.unsubscribeFromTopic("ProgramingChannel");
              print("Un Subscuribe");
            }, child: Text("Un Subscuribe")),
            SizedBox(height: 20,),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
