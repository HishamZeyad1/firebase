import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class FbStorage extends StatefulWidget {
  const FbStorage({Key? key}) : super(key: key);

  @override
  State<FbStorage> createState() => _FbStorageState();
}

class _FbStorageState extends State<FbStorage> {
  File? file; //used for upload image
  ImagePicker _imagePicker =
      ImagePicker(); //used for click/choose image from camera or callery
  // the picked file when i use _imagePicker.pick() will be (XFile)
  XFile? _pickedFile; //File(_imagePicker.path)

  @override
  initState() {
    super.initState();
    getImageAndFolderName();
  }

  Future<void> uploadImages(File? file1,BuildContext context) async {
    if (file1 == null) {
      XFile? impicked =
          await _imagePicker.pickImage(source: ImageSource.camera);
      if (impicked != null) {
        file = File(impicked.path);
        print("file:$file");
      } else {
        print("please choose image");
      }
    }

    // Reference refStorage = FirebaseStorage.instance.ref().child("images");
    Random r = Random();
    int number = r.nextInt(10000);
    Reference refStorage =
        FirebaseStorage.instance.ref('images/image${number}.png');
    print("refStorage:$refStorage");

    showLoading(context,0);
    UploadTask uploadTask = refStorage.putFile(file1 != null ? file1 : file!);
    // var url = await (await refStorage).getDownloadURL();
    var dowurl = await (await uploadTask).ref.getDownloadURL();


    //final imageUrl = await FirebaseStorage.instance.ref().child("images/image1.png").getDownloadURL();
    // String url = (await refStorage.getDownloadURL()).toString();

    print("url:$dowurl");
    Navigator.of(context).pop();


    // String baseName = impicked.path.split('/').last;
    //
    // print("imageName:$baseName");

    print("sucessfully");
  }

  Future<void> PickImage() async {
    XFile? imageFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _pickedFile = imageFile;
        // file = File(imageFile!.path);
      });
    }
  }

  getImageAndFolderName() async {
    ListResult ref = await FirebaseStorage.instance
        .ref("images")
        .list(ListOptions(maxResults: 3));
    // ListResult ref=await FirebaseStorage.instance.ref("images").listAll();

    print("==================view Image in Root=================");
    ref.items.forEach((element) {
      print(element.name);
      print(element.fullPath);
    });
    print("==================view Folder=================");
    ref.prefixes.forEach((element) {
      print(element.name);
      print(element.fullPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireStorage"),
      ),
      body: Column(
        children: [
          Expanded(
            child: _pickedFile != null
                ? Image.file(File(_pickedFile!.path))
                : TextButton(
                    onPressed: () async {
                      await PickImage();
                    },
                    child: Text("picked Image"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 0)),
                  ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await uploadImages(file!,context);
            },
            icon: Icon(Icons.cloud_upload),
            label: Text("Upload"),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60)),
          ),
        ],
      ),

      // ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     minimumSize: Size(double.infinity, 50),
      //     padding: EdgeInsets.symmetric(horizontal: 20),
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //     primary: Colors.cyan
      //   ),
      //   onPressed: () async {
      //     await uploadImages();
      //   },
      //   child: Text("Upload Image"),
      // ),
    );
  }
  showLoading(BuildContext context,int state) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: state==0?Text("please,waiting"):Text("The operation has been Sucessfuly"),
            content: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),height: 60,
            ),
          );
        });
  }

}
