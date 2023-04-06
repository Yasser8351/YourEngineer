import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/state_manager.dart';
import 'package:http_parser/http_parser.dart';

import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/roles_model.dart';
import '../model/user_model.dart';
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
        listrole =
            roles.where((element) => element.roleName != "دعم فني").toList();

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
      if (error is DioError) {
        showseuessToast(
            error.response!.data['msg'] ?? AppConfig.errorOoccurred.tr);
      }
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
      String password, int selectedrole, File imageFile, File imageId) async {
    myLog('start methode', 'userSignup');

    // final data = {
    //   ApiParameters.email: userModel.email,
    //   ApiParameters.fullname: userModel.fistName + " " + userModel.lastName,
    //   ApiParameters.password: password,
    //   ApiParameters.phone: userModel.phone,
    //   ApiParameters.roleId: listrole[selectedrole].id,
    //   ApiParameters.profileImage: userModel.userImage,
    // };

    final headers = {
      'Accept': '*/*',
      'Content-Type': 'multipart/form-data',
    };
    FormData data = FormData.fromMap({
      ApiParameters.email: userModel.email,
      ApiParameters.fullname: userModel.fistName + " " + userModel.lastName,
      ApiParameters.password: password,
      ApiParameters.phone: userModel.phone,
      ApiParameters.roleId: listrole[selectedrole].id,
      ApiParameters.profileImage: await MultipartFile.fromFile(
        imageFile.path,
        contentType: MediaType("image", "${imageFile.path.split(".").last}"),
      ),
      ApiParameters.credentials: await MultipartFile.fromFile(
        imageId.path,
        contentType: MediaType("image", "${imageId.path.split(".").last}"),
      ),
    });

    myLog("imageFile", imageFile.path);

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
        'response id : ${response.data['id']}',
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
      if (error is DioError) {
        Helper.showError(
            context: context,
            subtitle:
                error.response!.data['msg'] ?? AppConfig.errorOoccurred.tr);
      }

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
        // await _shared.login(userModel, selectedrole)
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
      if (error is DioError) {
        Helper.showError(
            context: context,
            subtitle:
                error.response!.data['msg'] ?? AppConfig.errorOoccurred.tr);
      }

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

  Future<bool> resetPassword(BuildContext context, String email) async {
    myLog('start methode', 'resetPasseord');

    // var token = _shared.getToken();

    final data = {
      ApiParameters.email: email,
    };

    final headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
    };

    try {
      var response = await Dio()
          .post(
            ApiUrl.resetPassword,
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
        Helper.showseuess(
            context: context, subtitle: response.data['msg'].toString());

        setValueResponse(true);
      } else {
        status = false;
        Helper.showError(
            context: context, subtitle: response.data['msg'].toString());

        setValueResponse(false);
      }
    } catch (error) {
      status = false;

      setValueResponse(false);
      if (error is DioError) {
        Helper.showError(
            context: context,
            subtitle:
                error.response!.data['msg'] ?? AppConfig.errorOoccurred.tr);
      }

      myLog('error', error);

      if (error.toString().contains('TimeoutException')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
      } else if (error.toString().contains('Http status error [404]')) {
        Helper.showError(
            context: context, subtitle: "الايميل غير موجود او غير مسجل");
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
