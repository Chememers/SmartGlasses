import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:smart_glasses/main.dart';

class Messager extends StatefulWidget {
  @override
  MessagerState createState() {
    return MessagerState();
  }
}

class MessagerState extends State<Messager> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Send text',
              ),
              controller: myController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (!(connection == null || !connection.isConnected)) {
                  List<int> list = myController.text.codeUnits;
                  Uint8List bytes = Uint8List.fromList(list);
                  connection.output.add(bytes);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
}
