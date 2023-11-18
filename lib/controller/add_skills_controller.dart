import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
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
  TextEditingController specializationController = TextEditingController();
  TextEditingController aboutUserController = TextEditingController();

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

  Future<bool> addInfoAboutMe(BuildContext context) async {
    myLog('start methode', 'addInfoAboutMe');

    var token = await _pref.getToken();
    final data = {
      'about_user': aboutUserController.text,
      'specialization': specializationController.text,
    };

    try {
      var response = await http
          .post(
            Uri.parse(ApiUrl.profile),
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
        Helper.showseuess(
            context: context, subtitle: AppConfig.addSuccesfuly.tr);

        specializationController.clear();
        aboutUserController.clear();

        status = true;
      } else {
        var msg = jsonEncode(response.body);

        Helper.showError(
          context: context,
          subtitle: msg,
        );

        status = false;
      }
    } catch (error) {
      status = false;

      myLog('error', error);
      if (error is DioError) {
        if (error.toString().contains('TimeoutException') |
            error.toString().contains('Connection failed')) {
          Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
        } else {
          Helper.showError(
              context: context,
              subtitle: error.response!.data['msg'].toString());
        }
      } else {
        Helper.showError(
            context: context, subtitle: AppConfig.errorOoccurred.tr.toString());
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

class ResponseMessage {
  ResponseMessage({
    required this.message,
  });

  String message;

  factory ResponseMessage.fromJson(Map<String, dynamic> json) =>
      ResponseMessage(
        message: json["msg"] ?? '',
      );
}
