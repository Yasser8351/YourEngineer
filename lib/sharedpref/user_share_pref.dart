import 'package:shared_preferences/shared_preferences.dart';
import '/model/user_model.dart';

class SharedPrefUser {
  late SharedPreferences _prefs;
  Future<bool> login(UserModel userModel, int selectedrole) async {
    _prefs = await SharedPreferences.getInstance();

    await _prefs.setString('id', userModel.userId);
    await _prefs.setString('fist_name', userModel.fistName);
    await _prefs.setString('last_name', userModel.lastName);
    await _prefs.setString(
        'full_name', '${userModel.fistName} ${userModel.lastName}');
    await _prefs.setString('token', userModel.token);
    await _prefs.setString('phone', userModel.phone);
    await _prefs.setString('email', userModel.email);
    await _prefs.setString('image', userModel.userImage);
    await _prefs.setInt('roleid', selectedrole);

    return await _prefs.setBool('login', true);
  }

  Future<bool> saveToken(String token, String status) async {
    _prefs = await SharedPreferences.getInstance();

    await _prefs.setString('token', token);
    await _prefs.setString('status', status);

    return await _prefs.setBool('login', true);
  }

  Future<bool> isLogin() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('login') ?? false;
  }

  Future<int> getID() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getInt('id') ?? -1);
  }

  // get role id

  Future<int> getRoleID() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getInt('roleid') ?? -1);
  }

  /// get the Representive token from share
  Future<String> getToken() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token') ?? '';
  }

  Future<String> getId() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('id') ?? '';
  }

  Future<String> getUserAccountType() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('status') ?? '';
  }

  Future<bool> logout() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('login', false);
    return await _prefs.clear();
  }

  Future<UserModel> getUserData() async {
    _prefs = await SharedPreferences.getInstance();

    var model = UserModel(
      userId: _prefs.getString('id') ?? '',
      email: _prefs.getString('email') ?? '',
      fistName: _prefs.getString('fist_name') ?? '',
      fullName: _prefs.getString('full_name') ?? '',
      lastName: _prefs.getString('last_name') ?? '',
      phone: _prefs.getString('phone') ?? '',
      token: _prefs.getString('token') ?? '',
      userImage: _prefs.getString('image') ?? '',
    );
    return model;
  }

  // Future<bool> saveStudentsParent(int studentId, String studentName) async {
  //   _prefs = await SharedPreferences.getInstance();
  //   await _prefs.setInt('studentId', studentId);
  //   await _prefs.setString('studentName', studentName);

  //   return true;
  // }
}
