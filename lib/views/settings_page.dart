import 'package:flutter/material.dart';
import 'package:piggy/controllers/settings_controller.dart';
import 'package:piggy/entities/settings.dart';
import 'package:preferences/preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsController _settingsController = SettingsController();
  Settings _settings = Settings();

  @override
  void initState() {
    super.initState();

    _settingsController.getSettings().then((settings) {
      setState(() {
        this._settings = settings;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 6.0),
        child: _settings == null
            ? Center(child: Image(image: AssetImage("lib/assets/piggy.gif")))
            : PreferencePage([
                PreferenceTitle('Langauge'),
                DropdownPreference(
                  'Select your prefered langauge: ',
                  'langauges',
                  defaultVal: _settings.language,
                  values: _settings.languages,
                  onChange: changeLanguage,
                ),
                PreferenceTitle('Currency'),
                DropdownPreference(
                  'Select your prefered currency: ',
                  'currency',
                  defaultVal: _settings.currency,
                  values: _settings.currencies,
                  onChange: changeCurrency,
                ),
                PreferenceTitle('BackUp to GDrive'),
                SwitchPreference(
                  'Turn On/Off backup to GDrive',
                  'backup',
                  defaultVal: _settings.backup == 'yes' ? true : false,
                  onChange: changeBackup,
                ),
                ButtonBar(children: <Widget>[
                  RaisedButton(
                    color: Colors.pink[500],
                    child: Text('Save Changes'),
                    onPressed: () {
                      _settingsController
                          .changeSettings(_settings)
                          .then((count) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Text('Settings Changed Succesfully'),
                          backgroundColor: Colors.green[500],
                        ));
                      });
                    },
                  ),
                ]),
              ]),
      ),
    );
  }

  void changeLanguage(String language) {
    setState(() {
      _settings.language = language;
    });
  }

  void changeCurrency(String currency) {
    setState(() {
      _settings.currency = currency;
    });
  }

  void changeBackup() {
    setState(() {
      _settings.backup = _settings.backup == 'yes' ? 'no' : 'yes';
    });
  }
}
