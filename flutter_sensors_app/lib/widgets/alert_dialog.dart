import 'package:flutter/material.dart';

showAlertDialog<String>(
    BuildContext context, TextEditingController controller) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Start Recording"),
    onPressed: () {
      Navigator.of(context).pop(controller.text);
    },
  );
  // final _formkey = GlobalKey<FormState>();

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    // key: _formkey,
    title: Text("My title"),
    content: TextField(
      decoration: InputDecoration(hintText: "Enter your file name"),
      autofocus: true,
      controller: controller,
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
