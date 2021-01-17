import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class Settings extends StatefulWidget {
  @override
  SettingsState createState() {
    return SettingsState();
  }
}

class DarkMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.indigo,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            home: SettingsState(),
          );
        });
  }
}

class SettingsState extends State<Settings> {
  bool showSeconds = false;
  bool darkMode = false;
  String colVal = "white";

  @override
  Widget build(BuildContext context) {
    // if (darkMode) {
    //   colVal = "backgroundColor: Colors.black";
    // } else {
    //   colVal = "backgroundColor: Colors.white";
    // }
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
                SettingsTile.switchTile(
                  title: 'Dark Mode',
                  leading: Icon(Icons.settings_display),
                  switchValue: darkMode,
                  onToggle: (bool value) {
                    toggleTheme();
                    setState(() {
                      darkMode = value;
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

  void toggleTheme() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}
