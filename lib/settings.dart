import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:smart_glasses/darkmode.dart';

class Settings extends StatefulWidget {
  @override
  SettingsState createState() {
    return SettingsState();
  }
}

class SettingsState extends State<Settings> {
  bool showSeconds = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: new Text("Settings"),
          centerTitle: true,
          backgroundColor: Colors.purple[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings_display,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToggleDark()),
                );
              },
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: 'Time',
              tiles: [
                SettingsTile.switchTile(
                  title: 'Show seconds',
                  leading: Icon(Icons.lock_clock),
                  switchValue: showSeconds,
                  onToggle: (bool value) {
                    setState(() {
                      showSeconds = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),

        // Consumer<ThemeNotifier>(
        //   builder: (context, notifier, child) => SwitchListTile(
        //     title: Text('Dark Mode'), //Icon(Icons.settings_display)
        //     value: notifier.darkTheme,
        //     onChanged: (val) {
        //       setState(() {
        //         notifier.toggleTheme();
        //       });
        //     },
        //   ),
        //  ),

        //       // if (_darkMode) {
        //       //    _themeChanger.setTheme(ThemeData.dark());
        //       // } else {
        //       //   _themeChanger.setTheme(ThemeData.light());
        //       // }
      ),
    );
  }
}
