import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:your_engineer/app_config/api_url.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/model/user_model.dart';

import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'api_parameters.dart';

class UserAuth {
  bool status = false;
  final _shared = SharedPrefUser();

  Future<bool> userSignup(
      BuildContext context, UserModel userModel, String password) async {
    myLog('start methode', 'userSignup');

    final data = {
      ApiParameters.email: userModel.email,
      ApiParameters.fullname: userModel.fistName + " " + userModel.lastName,
      ApiParameters.password: password,
      ApiParameters.phone: userModel.phone,
      ApiParameters.roleId: 'f1f56154-3b95-11ed-8686-ecf4bb83b19b',
      ApiParameters.profileImage: '',
    };

    final headers = {
      "Content-Type": "application/json",
      'Accept': '*/*',
    };

    try {
      var response = await Dio()
          .post(
            ApiUrl.signup,
            data: data,
            options: Options(
              headers: headers,
            ),
          )
          .timeout(const Duration(seconds: 15));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.data}',
      );

      if (response.statusCode == 201) {
        status = true;
        setValueResponse(true);
        await _shared.login(userModel);
      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());

        setValueResponse(false);
        status = false;
      }
    } catch (error) {
      status = false;

      setValueResponse(false);

      myLog('error', error);

      if (error.toString().contains('TimeoutException')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
      } else {
        Helper.showError(context: context, subtitle: 'حث خطأ في الاتصال');
      }
    }
    return status;
  }

  Future<bool> userSignIn(
      BuildContext context, String email, String password) async {
    myLog('start methode', 'userSignIn');

    var token = _shared.getToken();

    final data = {
      ApiParameters.email: email,
      ApiParameters.password: password,
    };

    final headers = {
      "Content-Type": "application/json",
      "Accept": "*/*", // "Authorization": token,
    };

    try {
      var response = await Dio()
          .post(
            ApiUrl.signin,
            data: data,
            options: Options(
              headers: headers,
            ),
          )
          .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.data}',
      );

      if (response.statusCode == 200) {
        status = true;
        await _shared.saveToken(response.data['token']);

        setValueResponse(true);
      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());

        setValueResponse(false);
        status = false;
      }
    } catch (error) {
      status = false;

      setValueResponse(false);

      myLog('error', error);

      if (error.toString().contains('TimeoutException')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
      } else if (error.toString().contains('Http status error [401]')) {
        Helper.showError(
            context: context, subtitle: "خطأ في اسم المستخدم او كلمة المرور");
      } else {
        Helper.showError(context: context, subtitle: 'حث خطأ في الاتصال');
      }
    }
    return status;
  }
}

setValueResponse(bool status) {
  status = status;
}
