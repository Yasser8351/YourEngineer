import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http_parser/http_parser.dart';
// import 'package:get/get.dart';
// import 'package:intl/date_symbol_data_local.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/user_profile_model.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'package:intl/date_symbol_data_local.dart';

class ProfileUserController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController amountVisaController = TextEditingController();
  TextEditingController attachmentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumController = TextEditingController();
  TextEditingController expirationController = TextEditingController();
  var loadingState = LoadingState.initial.obs;
  final _shared = SharedPrefUser();
  UserProfileModel userProfile = UserProfileModel();
  ApiResponse apiResponse = ApiResponse();
  bool isLoding = false;
  String message = "";
  bool get status => _status;
  bool _status = false;
  bool statuse = false;

  @override
  onInit() {
    super.onInit();
    initializeDateFormatting();
    getUsersShow('');
  }

  Future<ApiResponse> getUsersShow(String engeneerId) async {
    loadingState(LoadingState.loading);
    // isloding = true;
    // update();
    try {
      var token = await _shared.getToken();
      myLog("strtmethod", "getUsersShow");
      var response = await Dio()
          .post(
            // ApiUrl.getUsersById,
            engeneerId.isEmpty
                ? ApiUrl.getUsersShow
                : ApiUrl.getUsersById(engeneerId),
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.data}',
      );

      if (response.statusCode == 200) {
        userProfile = userProfileModelFromJson(jsonEncode(response.data));

        if (userProfile == null) {
          message = "no data found";
          loadingState(LoadingState.noDataFound);
        } else {
          loadingState(LoadingState.loaded);
        }
      } else if (response.statusCode == 403) {
        message = "دخول غير مصرح به";
        loadingState(LoadingState.error);

        // setApiResponseValue(AppConfig.unAutaristion, false,
        //     _listPopulerServices, LoadingState.error.obs);
      } else {
        loadingState(LoadingState.error);

        // setApiResponseValue(AppConfig.errorOoccurred, false,
        //     _listPopulerServices, LoadingState.error.obs);
      }
    } on SocketException {
      message = AppConfig.noNet;

      loadingState(LoadingState.error);
    } catch (error) {
      loadingState(LoadingState.error);
      // setApiResponseValue(error.toString(), false, _listPopulerServices,
      //     LoadingState.error.obs);
      if (error is TimeoutException) {
        message = AppConfig.timeOut;

        showseuessToast(error.toString());
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
        showseuessToast(AppConfig.unAutaristion);
      } else {
        message = AppConfig.noNet;

        showseuessToast(error.toString());
      }

      myLog("catch error getUsersShow: ", error.toString());
    }
    return apiResponse;
  }

  Future<bool> accountChargeRequest(
      BuildContext context, File imageFile) async {
    myLog('start methode', 'accountChargeRequest');

    var token = await _shared.getToken();
    // final data = {
    //   'amount': amountController.text,
    //   //payments/feed
    //   'attachment': '',
    // };
    FormData data = FormData.fromMap({
      'amount': amountController.text,
      'attachment': await MultipartFile.fromFile(
        imageFile.path,
        contentType:
            MediaType("multipart", "${imageFile.path.split(".").last}"),
      ),
    });

    try {
      isLoding = true;
      update();
      var response = await Dio()
          .post(
            ApiUrl.accountChargeRequest,
            data: data,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        ''
            'response : ${response.data}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        statuse = true;
        Helper.showseuess(
            context: context, subtitle: response.data['msg'].toString());
        isLoding = false;
        update();
        // await _shared.saveToken(response.body['token']);

      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());
        print("nnnnnnnnnnonnnnoooooooooooo");

        statuse = false;
        update();
      }
    } catch (error) {
      statuse = false;
      update();

      if (error.toString().contains('TimeoutException')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
      } else if (error.toString().contains('Http status error [401]')) {
        Helper.showError(
            context: context, subtitle: "خطأ في اسم المستخدم او كلمة المرور");
      } else {
        Helper.showError(context: context, subtitle: 'حث خطأ في الاتصال');
      }
      myLog('catch error accountChargeRequest :', '$error');
    }

    return status;
  }

  Future<bool> addPaypal(BuildContext context) async {
    myLog('start methode', 'addPaypal');
    // myLog('projectId', projectId);

    var token = await _shared.getToken();
    final data = {
      'amount': amountController.text,
      'attachment': '',
      'email': emailController.text,
    };
    //

    try {
      var response = await Dio()
          .post(
            ApiUrl.addPaypal,
            //accountChargeRequest
            data: data,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        ''
            'response : ${response.data}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        statuse = true;
        update();
        // await _shared.saveToken(response.body['token']);

      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());
        print("nnnnnnnnnnonnnnoooooooooooo");

        statuse = false;
        update();
      }
    } catch (error) {
      statuse = false;
      update();

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
    amountController.clear();
    emailController.clear();
  }

  Future<bool> addVisa(BuildContext context) async {
    myLog('start methode', 'addPaypal');
    // myLog('projectId', projectId);

    var token = await _shared.getToken();
    final data = {
      'amount': amountVisaController.text,
      'attachment': attachmentController,
      'name': nameController,
      'card_number': cardNumController,
      'expiration': expirationController,
      'security_code': '',
    };
    //

    try {
      // var response = await http
      //     .post(
      //       // 'https://calm-cyan-bullfrog-tie.cyclic.app/api/v1/project',
      //       Uri.parse(ApiUrl.addprotofilio),
      //       body: data,
      //       headers: ApiUrl.getHeader2(token: token),
      //     )
      //     .timeout(const Duration(seconds: 20));
      var response = await Dio()
          .post(
            ApiUrl.addVisa,
            data: data,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        ''
            'response : ${response.data}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        statuse = true;
        update();
        // await _shared.saveToken(response.body['token']);

      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());
        print("nnnnnnnnnnonnnnoooooooooooo");

        statuse = false;
        update();
      }
    } catch (error) {
      statuse = false;
      update();

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
}
