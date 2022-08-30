import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  late final String hintText;
  late final IconData icon;
  late final TextInputType keyboardType;
  late final IconData? lasticon;

  // late final TextEditingController? controller;
  late final FormFieldValidator<String>? validationFn/*=(val) {return "dd";}*/;

  late final FormFieldSetter<String>? savedFn/*=(val) {}*/;

  bool? obscure;

  AppTextField(
      {required this.hintText,
      required this.icon,
      this.lasticon,this.obscure=false,
      this.keyboardType = TextInputType.text /*,this.controller*/,
      required this.validationFn,
      required this.savedFn,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscure!,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.teal.shade300)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.teal.shade300)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.teal.shade500)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.red)),
      ),
      validator:
          validationFn /*(val) {
        if (val != null && val!.length > 25) {
          return "email can not to be larger than 100";
        } else if (val != null && val!.length < 3) {
          return "email can not to be less than 3";
        }
        return null;
      }*/
      ,
      onSaved: savedFn,
    );

    // return TextField(
    //   keyboardType: keyboardType,
    //   // controller: controller,
    //   decoration: InputDecoration(
    //     //fillColor: Colors.blue,hoverColor: Colors.red,
    //     border: OutlineInputBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(10))),
    //     prefixIcon: IconButton(
    //       onPressed: () {},
    //       icon: Icon(icon),
    //     ),
    //     hintText: hintText,
    //     focusColor: Colors.blue,
    //     suffixIcon: Icon(lasticon),
    //
    //   ),
    // );
  }
}
