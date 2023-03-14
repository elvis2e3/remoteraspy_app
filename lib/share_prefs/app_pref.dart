import 'package:shared_preferences/shared_preferences.dart';

class AppPref{
  static final AppPref _appPrefs = AppPref._internal();

  factory AppPref() {
    return _appPrefs;
  }

  AppPref._internal();
  late SharedPreferences _prefs;

  Future initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GETTER

  String get url {
    return _prefs.getString('url')??"";
  }

  String get image {
    return _prefs.getString('image')??"";
  }

  String get rutaPage {
    return _prefs.getString('ruta')??"/";
  }

  bool get isDarkMode {
    return _prefs.getBool('isDarkMode')??false;
  }

  // SETTER

  set url(String value){
    _prefs.setString('url', value);
  }

  set image(String value){
    _prefs.setString('image', value);
  }

  set rutaPage(String value){
    _prefs.setString('ruta', value);
  }

  set isDarkMode(bool value){
    _prefs.setBool('isDarkMode', value);
  }
}