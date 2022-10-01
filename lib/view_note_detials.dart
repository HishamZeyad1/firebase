import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ViewNoteDetails extends StatefulWidget {
  late String title;
  late String note;
  late String imageUrl;

  ViewNoteDetails(
      {required this.title, required this.note, required this.imageUrl});

  @override
  State<ViewNoteDetails> createState() => _ViewNoteDetailsState();
}

class _ViewNoteDetailsState extends State<ViewNoteDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view Note"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            Container(
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,fit: BoxFit.cover,height: 300,
                placeholder: (context, url) => Container(child: CircularProgressIndicator(),color: Colors.grey,height: 300,width: double.infinity,),
                errorWidget: (context, url, error) => Icon(Icons.error),
                // child: Image(
                //   image: NetworkImage(
                //     widget.imageUrl,
                //   ),
                //   width: double.infinity,
                //   height: 300,
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(widget.title,style: Theme.of(context).textTheme.headline5,textAlign: TextAlign.center,),
            SizedBox(
              height: 10,
            ),
            Text(widget.note,style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.center,),

          ],
        ),
      ),
    );
  }
}
