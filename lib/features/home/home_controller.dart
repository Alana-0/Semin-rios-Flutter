import 'package:shared_preferences/shared_preferences.dart';

class HomeCrontroller{

  static Future<bool> logout()async{
    var sp = await SharedPreferences.getInstance();

    bool loggedOut = await sp.remove('cpf');

    return loggedOut;
  }
}