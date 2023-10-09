import 'package:get_storage/get_storage.dart';
import 'package:tqrc_app/src/services/enums.dart';

class LocalStorage{
  static final _box = GetStorage();

  static saveData({required LocalStorageKey key, required dynamic data})async{
    await _box.write(key.name, data);
  }

  static getData({required LocalStorageKey key}){
    return _box.read(key.name);
  }

  static removeData({required LocalStorageKey key})async{
    await _box.remove(key.name);
  }
}