import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart';
import 'package:smart_glasses/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToggleDark extends StatefulWidget {
  @override
  _ToggleDarkState createState() => _ToggleDarkState();
}

class _ToggleDarkState extends State<ToggleDark> {
  bool showSeconds = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: new Text('Dark Mode'),
          centerTitle: true,
          backgroundColor: Colors.purple[900]),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => SwitchListTile(
                  title: Text('Dark Mode'), //Icon(Icons.settings_display)
                  value: notifier.darkTheme,
                  onChanged: (val) {
                    setState(() {
                      notifier.toggleTheme();
                    });
                  },
                ),
              ),
            ],
          )),
    );
  }
}
