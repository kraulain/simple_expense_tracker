/*
*
* Controller to hold settings business logic
*
*/

import 'package:piggy/dao/settings_dao.dart';
import 'package:piggy/entities/settings.dart';
import 'package:piggy/services/db_connect.dart';

class SettingsController {
  SettingsDao settingsDao;

  SettingsController() {
    final DBConnect dBConnect = DBConnect.db;
    this.settingsDao = SettingsDao(dBConnect);
  }

  Future<Settings> getSettings() async{
    Settings settings = await settingsDao.selectById();
    return settings;
  }

  Future<int> changeSettings(Settings settings) async{
    int updateCount = await settingsDao.update(settings);
    return updateCount;
  }

}
