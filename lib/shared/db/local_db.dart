import 'package:hive/hive.dart';
import 'package:phone_contact_app/shared/db/table.dart';

class DbHelper {

  static Future<void> createTable()async{
    await Hive.openBox<dynamic>(DbTable.userInfo);
  }

  static void saveData(String table,String key,dynamic value){
    final box = Hive.box(table);
    box.put(key, value);
  }

  static dynamic getData(String table,String key){
    final box = Hive.box(table);
    final data = box.get(key);
    return data;
  }

  static deleteData(String table){
    final box = Hive.box(table);
    box.clear();
  }

}