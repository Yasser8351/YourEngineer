import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:your_engineer/app_config/api_url.dart';
import 'package:your_engineer/debugger/my_debuger.dart';

import '../utilits/helper.dart';
import 'api_parameters.dart';

class UserAuth {
  bool status = false;

  Future<bool> userSignup(BuildContext context, String email, String fullname,
      String password, String phone) async {
    myLog('start methode', 'userSignup');

    final data = {
      ApiParameters.email: email,
      ApiParameters.fullname: fullname,
      ApiParameters.password: password,
      ApiParameters.phone: phone,
      ApiParameters.roleId: 'f1f56154-3b95-11ed-8686-ecf4bb83b19b',
    };

    final headers = {
      "Content-Type": "application/json",
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

      if (error.toString().toUpperCase().contains('TIMEOUT EEXEPTION')) {
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

    final data = {
      ApiParameters.email: email,
      ApiParameters.password: password,
    };

    final headers = {
      "Content-Type": "application/json",
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
          .timeout(const Duration(seconds: 15));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.data}',
      );

      if (response.statusCode == 200) {
        status = true;
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

      if (error.toString().toUpperCase().contains('TIMEOUT EEXEPTION')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
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
