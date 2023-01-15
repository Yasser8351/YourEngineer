import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/api_url.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/model/user_model.dart';
import '../enum/all_enum.dart';
import '../model/roles_model.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'api_parameters.dart';

class UserAuth {
  bool status = false;
  final _shared = SharedPrefUser();
  String? roleId;
  List<RolesModel> listrole = [];
  var loadingState = LoadingState.initial.obs;
  Future<List<RolesModel>> getRoles() async {
    /// This function call the data from the API
    /// The Post type function takes the search value from the body
    /// get List of Cars in Home Screen

    loadingState(LoadingState.loading);
    try {
      var token = await _shared.getToken();

      myLog("start methode", "getProjects");

      // loadingState = LoadingState.loading.obs;
      var response = await Dio()
          .get(
            ApiUrl.getRoles,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("start methode", "${loadingState.value}");

      if (response.statusCode == 200) {
        var roles = rolesModelFromJson(jsonEncode(response.data));
        listrole = roles;
        // print("listttttttttttttttttttt======== ${listrole}");
        // roleId = _listrole;

        if (listrole.isEmpty) {
          loadingState(LoadingState.noDataFound);
        } else {
          loadingState(LoadingState.loaded);

          // setApiResponseValue('get Data Cars Sucsessfuly', true,
          //     _listprojects, LoadingState.loaded.obs);
        }
      } else if (response.statusCode == 401) {
        loadingState(LoadingState.error);

        // setApiResponseValue(AppConfig.unAutaristion, false,
        //     _listPopulerServices, LoadingState.error.obs);
      } else {
        loadingState(LoadingState.error);

        // setApiResponseValue(AppConfig.errorOoccurred, false,
        //     _listPopulerServices, LoadingState.error.obs);
      }
    } catch (error) {
      loadingState(LoadingState.error);
      // setApiResponseValue(error.toString(), false, _listPopulerServices,
      //     LoadingState.error.obs);
      if (error is TimeoutException) {
        showseuessToast(error.toString());
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
        showseuessToast(AppConfig.unAutaristion);
      } else {
        showseuessToast(error.toString());
      }

      myLog("catch error", error.toString());
    }
    return listrole;
  }

  setValueResponse(bool status) {
    status = status;
  }

  Future<bool> userSignup(BuildContext context, UserModel userModel,
      String password, int selectedrole) async {
    myLog('start methode', 'userSignup');
    print("selectedroole   iiiiddd===============${listrole[selectedrole].id}");

    final data = {
      ApiParameters.email: userModel.email,
      ApiParameters.fullname: userModel.fistName + " " + userModel.lastName,
      ApiParameters.password: password,
      ApiParameters.phone: userModel.phone,
      ApiParameters.roleId: listrole[selectedrole].id,
      ApiParameters.profileImage: userModel.userImage,
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
        await _shared.login(userModel, selectedrole);
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

    // var token = _shared.getToken();

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
        await _shared.saveToken(
            response.data['token'], response.data['status']);
        // await _shared.login();
        // print("toooken===========${response.data['token']}");

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
