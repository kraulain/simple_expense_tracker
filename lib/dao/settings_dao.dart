/*
*
* Dao for persisting an expense
*
*/

import 'package:piggy/entities/settings.dart';
import 'package:piggy/services/db_connect.dart';

class SettingsDao {
  DBConnect dbConnect;

  SettingsDao(this.dbConnect){
    selectById().then((results) {
      if(results == null){
        initialise();
      }
    });
  }

  initialise() async {
    final db = await dbConnect.database;
    return db.insert("settings", getDefault().toJson());
  }

  Future<Settings> selectById() async {
    final db = await dbConnect.database;
    var res = await db.query("settings", where: "id = ?", whereArgs: [0]);
    return res.isNotEmpty ? Settings.fromJson(res.first) : null;
  }

  Future<int> update(Settings settings) async {
    final db = await dbConnect.database;
    var res = await db.update("settings", settings.toJson(),
        where: "id = ?", whereArgs: [0]);
    return res;
  }

  getDefault(){
    return Settings(language: "en", currency: "\$", backup: 'true');
  }

}
