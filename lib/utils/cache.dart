import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  saveInfo(final String cache, final String data) async {
    SharedPreferences info = await SharedPreferences.getInstance();
    info.setString(cache, data);
  }

  getInfo(final String cache) async {
    SharedPreferences info = await SharedPreferences.getInstance();
    String? object = info.getString(cache);
    return object;
  }

  removeInfo(final String cache) async {
    SharedPreferences info = await SharedPreferences.getInstance();
    info.remove(cache);
  }

  clearInfo() async {
    SharedPreferences info = await SharedPreferences.getInstance();
    info.clear();
  }
}
