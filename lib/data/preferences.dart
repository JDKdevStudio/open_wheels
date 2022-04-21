import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  //Instancia de las preferencias de usuario
  static late SharedPreferences _prefs;

  //propiedades de usuario local
  static bool _autoLogin = false;
  static String _user = '';
  static String _password = '';

  //Inicializar instancia de las preferencias de usuario
  static Future init() async => _prefs = await SharedPreferences.getInstance();

  //set & get _autoLogin
  static bool get autoLogin => _prefs.getBool('autologin') ?? _autoLogin;
  static set autoLogin(bool value) {
    _autoLogin = value;
    _prefs.setBool('autologin', value);
  }

  //set & get _user
  static String get user => _prefs.getString('user') ?? _user;
  static set user(String value) {
    _user = value;
    _prefs.setString('user', value);
  }

  //set & get _password
  static String get password => _prefs.getString('password') ?? _password;
  static set password(String value) {
    _password = value;
    _prefs.setString('password', value);
  }
}
