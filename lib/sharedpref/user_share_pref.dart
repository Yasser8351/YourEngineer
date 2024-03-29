import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import '/model/user_model.dart';

class SharedPrefUser {
  late SharedPreferences _prefs;
  Future<bool> login(UserDataLogin userModel) async {
    _prefs = await SharedPreferences.getInstance();

    await _prefs.setString('id', userModel.userId);
    await _prefs.setString('fullName', userModel.fullName);
    await _prefs.setString('phone', userModel.phone);
    await _prefs.setString('email', userModel.email);
    await _prefs.setBool('isActive', userModel.isActive);
    await _prefs.setString('roleId', userModel.role_id);
    await _prefs.setString('updatedAt', userModel.updatedAt);
    await _prefs.setString('createdAt', userModel.createdAt);
    // await _prefs.setString('token', userModel.token);

    myLog('userId', userModel.userId);
    myLog('fullName', userModel.fullName);
    myLog('roleId', userModel.role_id);
    myLog('email', userModel.email);
    myLog('isActive', userModel.isActive);
    myLog('role_id', userModel.role_id);
    myLog('updatedAt', userModel.updatedAt);
    myLog('createdAt', userModel.createdAt);

    return await _prefs.setBool('login', true);
  }

  Future<void> save(
      {required String userId,
      required String fullname,
      required String phone,
      required String email,
      required String userImage}) async {
    _prefs = await SharedPreferences.getInstance();

    await _prefs.setString('id', userId);
    await _prefs.setString('full_name', fullname);
    await _prefs.setString('image', userImage);
    await _prefs.setString('phone', phone);
  }

  Future<void> saveUserId({required String userId}) async {
    _prefs = await SharedPreferences.getInstance();
    myLog('save UserId', userId);

    await _prefs.setString('id', userId);
  }

  Future<bool> saveToken(String token, String status, String email,
      [String userId = '']) async {
    _prefs = await SharedPreferences.getInstance();

    await _prefs.setString('token', token);
    await _prefs.setString('status', status);
    await _prefs.setString('email', email);
    await _prefs.setString('id', userId);

    log("userId form SharedPreferences :   $userId");

    return await _prefs.setBool('login', true);
  }

  Future<bool> isLogin() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('login') ?? false;
  }

  Future<String> getID() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('userId') ?? '';
  }

  // get role id

  Future<int> getRoleID() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getInt('roleid') ?? -1);
  }

  Future<String> getRoleName() async {
    _prefs = await SharedPreferences.getInstance();

    myLog("role_id pref", _prefs.getString('roleId'));
    return (_prefs.getString('roleId') ?? '');
  }

  /// get the Representive token from share
  Future<String> getToken() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token') ?? '';
  }

  Future<String> getId() async {
    _prefs = await SharedPreferences.getInstance();
    String userId = _prefs.getString('id') ?? '';

    return userId;
  }

  Future<String> getEmail() async {
    _prefs = await SharedPreferences.getInstance();
    String email = _prefs.getString('email') ?? '';

    return email;
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
