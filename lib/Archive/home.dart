import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../controller/fb_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Object? value1;

  void addData() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("users");
    // Section(1) add doc with generic id
    // await collectionReference.add({"username":"fadi","age":35,"email":"fadi@gmail.com",});//add doc with generic id
    // Section(2) add doc with specific id
    collectionReference.doc("1234").set(
      {
        "username": "fadi",
        "age": 35,
        "email": "fadi@gmail.com",
      },
    ); //add doc with specific id
  }

  void updateData() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("users");
    // Section(1) update specific doc with specific id,if it not found ,the exception will appear
    // await collectionReference.doc("12341").update({"age":"20",});//add doc with generic id
    // Section(2) delete specific doc and add new doc,if it not found ,it will add doc as new doc
    // await collectionReference.doc("1234").set( {"age": 35},);
    // Section(3) update a specific field with merge other field
    // await collectionReference.doc("1234").set({"age": 22,},SetOptions(  merge: true,)); //add doc with specific id
    // Section(4) update a specific field with merge other field
    // await collectionReference.doc("1234").set({"age": 22,},SetOptions(  merge: true,));
    //Then catch
    collectionReference.doc("1234").update({
      "age": 35,
    }).then((value) {
      print("updated sucessfuly");
    }).onError((error, stackTrace) {
      print("Error: $error");
    });
  }

  void deleteData() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("users");
    /*await*/
    collectionReference.doc("pB0SlyOiEEV5zjpuR7aT").delete().then((value) {
      print("deleted sucessfuly");
    }).onError((error, stackTrace) {
      print("Error:$error");
    });
  }

  void getData() async {
//**** section(1) CollectionReference & Filtering **********

    // CollectionReference usersref=FirebaseFirestore.instance.collection("users");
    // QuerySnapshot querySnapshot=await usersref.
    // // where("username",isEqualTo: "basel")
    // // where("age",isGreaterThanOrEqualTo: 20)
    // // where("age",isLessThan: 30)
    // // where("age",isNotEqualTo: 20)
    // // where("age",whereIn:[20,40,60] )
    // // where("age",whereNotIn:[30,40,60,] )
    // // where("lang",arrayContains:"fr" )//for one value
    // // where("lang",arrayContainsAny:["ar","en"] )//contain for any value [Or]
    // // where("age",isGreaterThan: 60).where("lang",arrayContains: "ar")//search in two field[And]
    // // orderBy("username",descending: false)
    // // limit(2)
    // // orderBy("age",descending: true).limitToLast(1)
    // // orderBy("age",descending: false/*true will make mistake*/).startAt([20])//>=2=
    // // orderBy("age",descending: false/*true will make mistake*/).startAfter([20])//>20
    // // orderBy("age",descending: false/*true will make mistake*/).endAt([60])//>20
    // orderBy("age",descending: false/*true will make mistake*/).endBefore([60])//>20
    //
    //     .get();
    // List<QueryDocumentSnapshot> listdocs =querySnapshot.docs;
    // listdocs.forEach((element) {
    //   print(element.data());
    //
    //   print(element['phone']);
    // });
//*** section(2) CollectionReference **********
    // print("====================first=========================");
    // CollectionReference usersref=FirebaseFirestore.instance.collection("users");
    // print("====================second=========================");
    // await usersref.get().then((value) {value.docs.forEach((element) {print(element.data());print("====================inner value=========================");});});
    // print("====================third=========================");
    // await FirebaseFirestore.instance.collection("users").get().then((value){value.docs.forEach((element) {print(element.data());});}).onError((error, stackTrace){print(error);});
    //Collection->get,where->docs->forEach(element)->element.data()
    //CollectionReference->QuerySnapshot->List<QueryDocumentSnapshot>->QueryDocumentSnapshot.()data
//***********************DocumentReference***********************************
//     DocumentReference documentReferene=FirebaseFirestore.instance.collection("/users").doc("pB0SlyOiEEV5zjpuR7aT");
//     // DocumentSnapshot documentSnapshot=await documentReferene.get();
//     // setState((){value1=documentSnapshot.data(); });
//     // print(value1);
//       await documentReferene.get().then((value) {
//         // Future.delayed(Duration(seconds: 3,),() {
//           setState((){value1=value.data(); });
//         // } ,);
//         print(value1);
//         print(value.exists);
//         print(value.id);
//       });

//*** section(3) snapshot.Listen() the data will update on the same time when the date is changed *************
//   FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
//     event.docs.forEach((element) {
//       print(element.data()['username']);
//       print(element.data()['phone']);
//       print(element.data());
//     });
//   });
    //*** section(4) Nasted Colletion  *************
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("users")
        .doc("zvPF3wvM77thB0Af4lxv")
        .collection("address");
    // QuerySnapshot v=await collectionReference.get();
    await collectionReference.get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
      });
    });
  }

  void trans() {
    //To ensure All the operations are done at the same time
    // or no operation is done at all [read then write]
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("users")
        .doc("q43TIWyFUAvK02lOIrYx");
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot =
      await transaction.get(documentReference);
      if (documentSnapshot.exists) {
        transaction.update(documentReference, {"age": 20});
      } else {
        print("User Not Found");
      }
    });
  }

  void writeBatch() async {
    //set,update,delete =>write operation, get =>read operation
    //to  make more than operation whether[read or write] at the same time
    DocumentReference documentReference1 = FirebaseFirestore.instance
        .collection("users")
        .doc("q43TIWyFUAvK02lOIrYx");
    DocumentReference documentReference2 = FirebaseFirestore.instance
        .collection("users")
        .doc("OfuZOu3Qws4fMXzj5oTp");
    WriteBatch writeBatch = FirebaseFirestore.instance.batch();
    writeBatch.delete(documentReference1);
    writeBatch.update(documentReference2, {"phone": "5959"});
    writeBatch.commit();
  }

  List<QueryDocumentSnapshot> users = [];
  CollectionReference userReference =
  FirebaseFirestore.instance.collection("users");

  void showData() async {
    QuerySnapshot querySnapshot = await userReference.get();
    setState(() {
      users = querySnapshot.docs;
    });
    // querySnapshot.docs.forEach((element) {
    //   setState((){
    //     users.add(element.data());
    //   });
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addData();
    // updateData();
    // getData();
    // deleteData();
    // trans();
    // writeBatch();
    showData();
  }

  @override
  Widget build(BuildContext context) {
    // print("is Logged:${FirebaseAuth.instance.currentUser != null}");
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                bool islogout = await FbAuth().logout();
                print("is Logout:$islogout");
                if (islogout) Navigator.pop(context);
              },
            ),
          ],
        ),
        body:
//#1 View Data by list

        /*ListView.builder(
          itemBuilder: (context, index) {
            // return Text(value1 == null ? "Empty" : value1.toString());
            return users.isEmpty||users==null?Text("Loading"):ListTile(
              title: Text(users[index]['username'].toString()),
              // title: Text(users[index]['email']),
              // trailing: Text(users[index]['age'].toString()),
              // subtitle:Text(users[index]['phone']),
              );
            return FutureBuilder(builder: (context, snapshot) {

            },);
            },
          itemCount: users.length,
        )*/
//#2 View Data byFuture Builder
        //   FutureBuilder(
        //     future: userReference.get(),//documentReference
        //     builder: (context, snapshot) {
        //       // QuerySnapshot? querySnapshot=snapshot.data as QuerySnapshot<Object?>?;
        //       // querySnapshot.docs.
        //       // return Text("data");
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(child: CircularProgressIndicator(value: 20,color: Colors.blue,strokeWidth: 2.2,));
        //       }
        //       else if (snapshot.hasData && snapshot.data != null) {
        //         QuerySnapshot querySnapshot=snapshot.data as QuerySnapshot;
        //         List<QueryDocumentSnapshot> docs=querySnapshot.docs;
        //         return ListView.builder(itemBuilder: (context, index)  {
        //           return ListTile(leading:Text(docs[index]['username'].toString()));
        //         }, itemCount: docs.length,);
        //         // return ListTile(leading: snapshot.data,);
        //       }
        //       else {
        //         return Text("Something has Error!");
        //       }
        //     },
        //   ),
//#3 View Data by Stream Builder
        StreamBuilder(
          stream:userReference.snapshots(),//documentReference
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(value: 20,color: Colors.blue,strokeWidth: 2.2,));
            }else if(snapshot.hasData&&snapshot.data!=null){
              QuerySnapshot querySnapshot=snapshot.data as QuerySnapshot;
              List<QueryDocumentSnapshot> docs=querySnapshot.docs;

                return ListView.builder(itemBuilder: (context, index)  {
                return ListTile(leading:Text(docs[index]['username'].toString()));
              }, itemCount: docs.length,);
            }
            else{
                return Text("Something has Error!");
            }
        },)
    );
  }

  Future<void> logout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    }
    print("is Logged:${FirebaseAuth.instance.currentUser != null}");
    // print("is Logged:${FirebaseAuth.instance.currentUser.uid}");

    // print(FirebaseAuth.instance.currentUser);
  }
}
