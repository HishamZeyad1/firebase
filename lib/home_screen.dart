import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/edit_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                return Center(child: CircularProgressIndicator(value: 20,color: Colors.blue,strokeWidth: 2.2,));
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

                return Column(
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
                    child: Image.network(imageUrl,
                    // "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg" /*"images/3.png"*/,
                    fit: BoxFit.cover, /*width: 200,height: 200,*/
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
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("Something Error has occurred "),
                );
              }else{
                print("4");
                return Container(
                  width: 200,
                  height: 200,
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
