import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  HiCache._();
  static HiCache? _insatance;
  static HiCache getInstance() {
    if (_insatance == null) {
      _insatance = HiCache._();
    }
    return _insatance!;
  }

  SharedPreferences? prefs;

  void init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  static Future<HiCache> preInit() async {
    if (_insatance == null) {
      var prefs = await SharedPreferences.getInstance();
      _insatance = HiCache._pre(prefs);
    }
    return _insatance!;
  }

  HiCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  T? get<T>(String key) {
    var v = this.prefs?.get(key);
    if (v != null) {
      return v as T;
    }
    return null;
  }
}
