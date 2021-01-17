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
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send a Message"),
        centerTitle: true,
        backgroundColor: Colors.purple[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Send text',
                ),
                controller: controller,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FloatingActionButton.extended(
                    onPressed: () {
                      if (!(connection == null || !connection.isConnected)) {
                        sendString(controller.text);
                      }
                    },
                    label: Text('Send'),
                    icon: Icon(Icons.send)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }
}
