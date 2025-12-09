import 'package:hive_flutter/adapters.dart';
import 'package:sgima_chat/models/message_model.dart';
import 'package:sgima_chat/utils/app_constants.dart';

class HiveLocalDatabase {
  HiveLocalDatabase._();
  static final HiveLocalDatabase getinstance = HiveLocalDatabase._();
  static HiveLocalDatabase get instance => getinstance;
  static Future<void> hiveInit() async {
    await Hive.initFlutter();
    Hive.registerAdapter((MessageModelAdapter()));
    await Hive.openBox(AppConstants.messageKey);
  }

  final box = Hive.box(AppConstants.messageKey);
  Future<void> saveData<T>(String key, T value) async {
    await box.put(key, value);
  }

  dynamic getData(String key) {
    return box.get(key);
  }

  Future<void> deleteData(String key) async {
    await box.delete(key);
  }
}
