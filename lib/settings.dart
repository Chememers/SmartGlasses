import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
      appBar: AppBar(
          title: new Text('Settings'),
          centerTitle: true,
          backgroundColor: Colors.purple[900]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SettingsList(
          backgroundColor: Colors.white,
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
      ),
    );
  }
}
