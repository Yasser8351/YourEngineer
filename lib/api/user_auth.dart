import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:your_engineer/model/user_profile_model.dart';

import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
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
  RxString errorMessage = "".obs;
  List<RolesModel> listrole = [];
  var loadingState = LoadingState.initial.obs;

  Future<void> getUsersShow(String token) async {
    try {
      var response = await Dio()
          .post(
            ApiUrl.getUsersShow,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      if (response.statusCode == 200) {
        await _shared.saveUserId(
            userId: userProfileModelFromJson(jsonEncode(response.data)).id);
      }
    } catch (error) {}
  }

  Future<List<RolesModel>> getRoles() async {
    /// This function call the data from the API
    /// The Post type function takes the search value from the body
    /// get List of Cars in Home Screen

    loadingState(LoadingState.loading);
    try {
      var token = await _shared.getToken();

      var response = await Dio()
          .get(
            // "http://194.195.87.30:91/api/v1/roles?page=1&size=10",
            ApiUrl.getRoles,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      if (response.statusCode == 200) {
        var roles = rolesModelFromJson(jsonEncode(response.data));
        listrole =
            roles.where((element) => element.roleName != "admin").toList();

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
        if (error.response!.statusCode == 401) {}
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
    }
    return listrole;
  }

  setValueResponse(bool status) {
    status = status;
  }

  Future<bool> userSignup(BuildContext context, UserModel userModel,
      String password, int selectedrole, File imageFile, File imageId) async {
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

      if (response.statusCode == 201) {
        status = true;
        setValueResponse(true);
        UserDataLogin userDataLogin = UserDataLogin(
            userId: response.data["id"] ?? "",
            isActive: response.data["is_active"] ?? false,
            email: response.data["email"] ?? "",
            password: response.data["password"] ?? "",
            role_id: response.data["role_id"] ?? "",
            fullName: response.data["fullname"] ?? "",
            phone: response.data["phone"] ?? "",
            createdAt: response.data["createdAt"] ?? "",
            updatedAt: response.data["updatedAt"] ?? "");
        await _shared.login(userDataLogin);
        // await _shared.login(userModel, selectedrole);
        dialogApp();
      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());

        errorMessage = response.data['msg'].obs;

        setValueResponse(false);
        status = false;
      }
    } catch (error) {
      status = false;
      setValueResponse(false);

      if (error is DioError) {
        if (error.response!.statusCode == 400) {
          errorMessage = 'الايميل او رقم الهاتف مسجل مسبقا'.obs;
        } else {
          errorMessage = AppConfig.errorOoccurred.tr.obs;
        }
        // Helper.showError(
        //     context: context, subtitle: error.response!.data['msg'].toString());
      } else if (error.toString().contains('TimeoutException') ||
          error.toString().contains("SocketException") ||
          error.toString().contains("Network is unreachable")) {
        errorMessage = 'يبدو ان اتصال الانترنت ضعيف'.obs;
        Helper.showError(
            context: context, subtitle: 'يبدو ان اتصال الانترنت ضعيف');
      } else {
        errorMessage = AppConfig.errorOoccurred.tr.obs;

        Helper.showError(context: context, subtitle: 'حث خطأ في الاتصال');
      }
    }
    return status;
  }

  Future<bool> userSignIn(
      BuildContext context, String email, String password) async {
    final data = {
      ApiParameters.email: email,
      ApiParameters.password: password,
    };

    final headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
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

      if (response.statusCode == 200) {
        getUsersShow(response.data['token']);
        await _shared.saveToken(response.data['token'], response.data['status'],
            email, response.data['id']);

        setValueResponse(true);
        status = true;
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
      } else if (error.toString().contains('TimeoutException')) {
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
      } else if (error.toString().contains('TimeoutException')) {
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
