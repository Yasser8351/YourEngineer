import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'package:http/http.dart' as http;

class AddSkillsController extends GetxController {
  ApiResponse apiResponse = ApiResponse();

  TextEditingController titleController = TextEditingController();

  final SharedPrefUser _pref = SharedPrefUser();
  bool status = false;
  var loadingState = LoadingState.initial.obs;

  //

  Future<bool> addSkills(BuildContext context) async {
    myLog('start methode', 'addoffer');
    // myLog('projectId', projectId);

    var token = await _pref.getToken();
    final data = {
      'skillname': titleController.text,
    };
    //

    try {
      var response = await http
          .post(
            Uri.parse(ApiUrl.addskill),
            body: data,
            headers: ApiUrl.getHeader2(token: token),
          )
          .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        ''
            'response : ${response.body}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        status = true;
        // await _shared.saveToken(response.body['token']);

      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());
        print("nnnnnnnnnnonnnnoooooooooooo");

        status = false;
      }
    } catch (error) {
      status = false;

      myLog('error', error);

      if (error.toString().contains('TimeoutException')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
      } else if (error.toString().contains('Http status error [401]')) {
        Helper.showError(
            context: context, subtitle: "خطأ في اسم المستخدم او كلمة المرور");
      } else {
        Helper.showError(context: context, subtitle: 'حث خطأ في الاتصال');
      }
      myLog('catch  erroor', '$error');
    }

    return status;
  }

  Future<bool> contactUs(BuildContext context) async {
    myLog('start methode', 'addoffer');
    // myLog('projectId', projectId);

    var token = await _pref.getToken();
    final data = {
      'skillname': titleController.text,
    };
    //

    try {
      var response = await http
          .post(
            Uri.parse(ApiUrl.addskill),
            body: data,
            headers: ApiUrl.getHeader(token: token),
          )
          .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        ''
            'response : ${response.body}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        status = true;
        // await _shared.saveToken(response.body['token']);

      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());
        print("nnnnnnnnnnonnnnoooooooooooo");

        status = false;
      }
    } catch (error) {
      status = false;

      myLog('error', error);

      if (error.toString().contains('TimeoutException')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
      } else if (error.toString().contains('Http status error [401]')) {
        Helper.showError(
            context: context, subtitle: "خطأ في اسم المستخدم او كلمة المرور");
      } else {
        Helper.showError(context: context, subtitle: 'حث خطأ في الاتصال');
      }
      myLog('catch  erroor', '$error');
    }

    return status;
  }

//
//
  void clearController() {
    titleController.clear();
  }
}
