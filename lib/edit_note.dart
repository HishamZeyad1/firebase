import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/helper/helpers.dart';
import 'package:firebase/helper/shared_component.dart';
import 'package:firebase/widget/AppTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class EditNote extends StatefulWidget {
  late String documentId, title, note,imageUrl;

  /*,imageUrl;*/

  // late File file;
  // late Reference ref;
  EditNote({required this.documentId, required this.title, required this.note ,required this.imageUrl,
/*   required this.file,required this.ref*/
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> with Helpers {
  late String documentId;
  late String? title, note, imageUrl;
  File? file;
  Reference? ref;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController _titleEditingController;
  late TextEditingController _noteEditingController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    documentId = widget.documentId;
    title = widget.title;
    note = widget.note;
    // imageUrl=widget.imageUrl;
    // file=widget.file;
    // ref=widget.ref;
    _titleEditingController = TextEditingController(text: title);
    _noteEditingController = TextEditingController(text: note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        elevation: 5,
      ),
      body: Form(
        key: formState,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            SizedBox(
              height: 20,
            ),
            AppTextField(
                hintText: "Note Title",
                icon: Icons.title,
                // controller: _titleEditingController,
                initialValue:widget.title,
                validationFn: (val) {
                  if (val != null && val.length > 100) {
                    return "Note Title can not to be larger than 100";
                  } else if (val != null && val.length < 3) {
                    return "Note Title can not to be less than 3";
                  }
                  return null;
                },
                savedFn: (val) {
                  title = val!;
                }),
            SizedBox(
              height: 10,
            ),
            AppTextField(
                hintText: "Note Details",
                // controller:_noteEditingController,
                initialValue:widget.note,
                icon: Icons.description,
                maxLine: 5,
                validationFn: (val) {
                  if (val != null && val.length > 300) {
                    return "Note Details can not to be larger than 300";
                  } else if (val != null && val.length < 3) {
                    return "Note Details can not to be less than 3";
                  }
                  return null;
                },
                savedFn: (val) {
                  note = val;
                }),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                  child: Text(
                    "Upload Image",
                    style: TextStyle(fontSize: 18, color: Colors.teal.shade300),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: /*Colors.teal.shade300,*/Colors.grey.shade200,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius:
                    //     BorderRadiusDirectional.all(Radius.circular(20))),
                  ),
                  onPressed: () async {
                    // await signIn();
                    viewImage();
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text(
                  "Edit Note",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.teal.shade500,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(20))),
                ),
                onPressed: () async {
                  // await signIn();
                  await editNote();
                }),
          ],
        ),
      ),
    );
  }

  void viewImage() {
    showModalBottomSheet<void>(
        clipBehavior: Clip.antiAlias,
        enableDrag: true,
        constraints: BoxConstraints(minHeight: 100),
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return Card(
            // clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(children: [
                        Container(
                          child: Text(
                            "Edit Image",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          alignment: Alignment.center,
                          color: Colors.teal.shade600,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            elevation: 20,
                            color: Colors.grey.shade200,
                            //getColor(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.vertical(
                                  bottom: Radius.circular(15)),
                              // borderRadius: BorderRadius.circular(15),
                              /*side: BorderSide(width: 2)*/),
                            child: Container(
                                height: 100,
                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.image,
                                                    color: Colors.teal
                                                        .shade300)),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text("From Gallery",
                                              style: TextStyle(
                                                  color: Colors.teal
                                                      .shade300),),
                                          ],
                                        ),
                                        onPressed: () async {
                                          XFile? imagePicker = await ImagePicker()
                                              .pickImage(
                                              source: ImageSource.gallery);
                                          if (imagePicker != null) {
                                            // SharedComponent.showLoading(context);
                                            file = File(imagePicker.path);
                                            var imageName = "image" + Random()
                                                .nextInt(1000)
                                                .toString();
                                            ref = FirebaseStorage.instance.ref(
                                                "images/${imageName}");
                                            Navigator.pop(context);
                                            // Navigator.of(context).pop();
                                          }
                                          // print("clicked");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.grey.shade200,),
                                      ),
                                      // SizedBox(height: 10,),
                                      ElevatedButton(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  XFile? imagePicker = await ImagePicker()
                                                      .pickImage(
                                                      source: ImageSource
                                                          .camera);
                                                  if (imagePicker != null) {
                                                    file =
                                                        File(imagePicker.path);
                                                    var imageName = "image" +
                                                        Random()
                                                            .nextInt(1000)
                                                            .toString();
                                                    ref =
                                                        FirebaseStorage.instance
                                                            .ref(
                                                            "images/${imageName}");

                                                    Navigator.pop(context);
                                                  }
                                                },
                                                icon: Icon(Icons.camera_alt,
                                                  color: Colors.teal
                                                      .shade300,)),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text("From Camera",
                                              style: TextStyle(
                                                color: Colors.teal.shade300,),),
                                          ],
                                        ),
                                        onPressed: () async {
                                          XFile? imagePicker = await ImagePicker()
                                              .pickImage(
                                              source: ImageSource.camera);
                                          if (imagePicker != null) {
                                            file = File(imagePicker.path);
                                            var imageName = "image" + Random()
                                                .nextInt(1000)
                                                .toString();
                                            ref = FirebaseStorage.instance.ref(
                                                "images/${imageName}");
                                            Navigator.pop(context);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.grey.shade200),
                                      ),
                                    ]
                                ))),
                      ]),
                    )
                  ]));
        });
  }

  Future<void> editNote() async {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();
      //if file,reference is null =>having image and not editing until now so we need only edit [title,note]
      //else if file,reference is not null =>having image and editing with new image so we need only edit [title,note,imageurl]
      // and storage.
      if (file == null) {
        SharedComponent.showLoading(context);
        CollectionReference noteRef = FirebaseFirestore.instance.collection(
            "notes");
        await noteRef.doc(documentId)
            .update({"title": title, "note": note,})
            .then((value) {
          showSnackBar(context: context,
              message: "The Note has been updated",
              error: false);
          Navigator.of(context).pushReplacementNamed("/home_screen");
          // title="";
          // note="";
          // file=null;
          // ref=null;
          // formState.currentState!.reset();
        }).onError((error, stackTrace) {
          showSnackBar(context: context,
              message: "Failed:${error.toString()}",
              error: true);
        });
      }
      else if (file != null) {
        SharedComponent.showLoading(context);
        //add new image
        UploadTask uploadTask = ref!.putFile(file!);
        imageUrl = await (await uploadTask).ref.getDownloadURL();

        //remove old image
        bool b1=await FirebaseStorage.instance.refFromURL(widget.imageUrl).delete().then((value) => true).onError((error, stackTrace) => false);

        CollectionReference noteRef = FirebaseFirestore.instance.collection(
            "notes");
        await noteRef.doc(documentId).update(
            {"title": title, "note": note, "imageUrl": imageUrl,}).then((
            value) {
          showSnackBar(context: context,
              message: "The Note has been updated",
              error: false);
          // Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed("/home_screen");

        }).onError((error, stackTrace){
            showSnackBar(context: context, message: "Failed:${error.toString()}",error: true);
        });
      }
      // else{
      //   showSnackBar(context: context, message: "please choose an image",error: true);
      // }
    }
  }}
//*******************************
