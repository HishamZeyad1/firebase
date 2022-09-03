import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        child: ListView(children: [
          // Text("Good Job!"),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  15), /*side: BorderSide(color: Colors.teal)*/
            ),
            child: ListTile(
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
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg" /*"images/3.png"*/,
                  fit: BoxFit.cover, /*width: 200,height: 200,*/
                ),
              ),
              title: Text("Title"),
              subtitle: Text(
                  "consistent pageview and exposes a pageToken that allows control over when to fetch additional results",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis),
              trailing: Icon(Icons.edit, color: Colors.teal.shade500),
            ),

            // child: Card(
            //   child: Container(
            //     height: 100,padding: EdgeInsets.all(5),
            //     child: Column(
            //       children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Image.asset(
            //                 "images/3.png",
            //                 fit: BoxFit.cover,
            //                 width: 70,
            //                 height: 70,
            //               ),
            //               SizedBox(
            //                 width: 20,
            //               ),
            //               Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text("Title"),
            //                   SizedBox(
            //                     height: 7,
            //                   ),
            //                   Wrap(children:[ Text("consistent consistent kdkj kjjj"/*,maxLines: 1*/,overflow:TextOverflow.clip ,)]),
            //                 ],
            //               ),
            //               SizedBox(width: 10,),
            //               SizedBox(
            //                 width: 50,
            //                 height: 50,
            //                 child: IconButton(
            //                   onPressed: () {},
            //                   icon: Icon(Icons.edit),
            //                 ),
            //               ),
            //             ],
            //           ),
            //       ],
            //     ),
            //   ),
            // ))
            // ],
          ),
        ]),
      ),
    );
  }
}
