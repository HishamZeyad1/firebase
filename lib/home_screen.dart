import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/edit_note.dart';
import 'package:firebase/view_note_detials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference noteref = FirebaseFirestore.instance.collection("notes");
  var pressedNote;

  var fbm = FirebaseMessaging.instance;
  initalMessage() async {
    var message =   await FirebaseMessaging.instance.getInitialMessage() ;
    if (message != null){
      Navigator.of(context).pushNamed("/add_note") ;
    }
  }
  requestPermssion() async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

  }
  @override
  void initState() {
    print("=========initState=========");
    // TODO: implement initState
    super.initState();
    requestPermssion() ;//for ios
    initalMessage() ;
    print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");

    fbm.getToken().then((value) {
      print("================================");
      print(value);
      print("================================");
    } );
    //Forground Notification
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification);
      print(event.senderId);
      print(event.data);
      print(event.notification!.title);
      print(event.notification!.body);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: event.notification!.title,
          desc: event.notification!.body,
          // btnCancelOnPress: () {},
          // btnOkOnPress: () {},
      )..show();
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.of(context).pushNamed("/add_note");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("UID: "+FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: Icon(Icons.home),
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                print("Before logout:");
                bool logged = FirebaseAuth.instance.currentUser != null;
                print("is logged:$logged");
                await FirebaseAuth.instance.signOut();

                print("After logout:");
                logged = FirebaseAuth.instance.currentUser != null;
                print("is logged:$logged");
                Navigator.pushNamed(context, "/login_screen");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add_note");
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: StreamBuilder(
            stream: noteref.where("userId",isEqualTo:FirebaseAuth.instance.currentUser!.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("1");
                // return Center(child: CircularProgressIndicator(value: 20,color: Colors.blue,strokeWidth: 2.2,));
                return Container(alignment: Alignment.center,child: CircularProgressIndicator());
              }
              else if(snapshot.hasData&&snapshot.data!=null){
                print("2");
                print(snapshot.hasData);
                QuerySnapshot querySnapshot=snapshot.data as QuerySnapshot;
              List<QueryDocumentSnapshot> docs=querySnapshot.docs;
                print(docs.length);
                return docs.length!=0?
                 ListView.builder(itemBuilder: (context, index) {
                   String title=docs[index]['title'].toString();
                   String note=docs[index]['note'].toString();
                   String imageUrl=docs[index]['imageUrl'].toString();
                   String documentId=docs[index].id;

                return GestureDetector(
                  child: Column(
                    children: [
                    SizedBox(
                    height: 5,
                    ),
                    Dismissible(
                      key: UniqueKey(),
                      confirmDismiss:(DismissDirection direction) async{
                        bool b1=false;
                        bool b2=false;
                        try{
                          print("******1*********");
                          bool b1=await FirebaseStorage.instance.refFromURL(imageUrl).delete().then((value) => true).onError((error, stackTrace) => false);
                          print("******2*********");
                          bool b2= await noteref.doc(documentId).delete().then((value) => true).onError((error, stackTrace) => false);
                          print(b1&&b2);
                          return b1&&b2;
                        }catch(error){return false;}
                        print("deleted");
                      },
                      child: Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                      15), /*side: BorderSide(color: Colors.teal)*/
                      ),
                      child:ListTile(
                      horizontalTitleGap: 15,
                      minVerticalPadding: 0,
                      contentPadding: EdgeInsets.all(10),
                      /*minLeadingWidth: 0,*/
                      leading: Container(
                      color: Colors.green,
                      width: 77,
                      height: 77,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      // constraints: BoxConstraints(minWidth: 120,minHeight: 120,maxHeight: 200,maxWidth: 200,),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,fit: BoxFit.cover,
                        placeholder: (context, url) => Container(child: CircularProgressIndicator(),color: Colors.grey,),
                        errorWidget: (context, url, error) => Icon(Icons.error),

                        // child: Image.network(imageUrl,
                        // // "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg" /*"images/3.png"*/,
                        // fit: BoxFit.cover, /*width: 200,height: 200,*/
                        // ),
                      ),
                      ),
                      title: Text(title/*"Title"*/),
                      subtitle: Text(
                      note,
                      // "consistent pageview and exposes a pageToken that allows control over when to fetch additional results",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                      trailing: IconButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return EditNote(documentId:documentId,title: title, note: note,imageUrl:imageUrl);
                        }));
                      }, icon: Icon(Icons.edit, color: Colors.teal.shade500)),
                      ),
                      ),
                    ),
                    ]
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNoteDetails(title: title, note: note, imageUrl: imageUrl),));
                  },
                );
              },itemCount:docs.length ,):
              Container(
                // width: 200,
                // height: 200,
                // color: Colors.black,
                alignment: Alignment.center,
                child: Text("No Data"),
              );
              }
              else if(snapshot.hasError){
                print("3");
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text("Something Error has occurred "),
                );
              }
              else{
                print("4");
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: Text("No Data"),
                );
              }
            },
        ),
      ),
    );
  }
}
