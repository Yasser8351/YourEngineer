import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http_parser/http_parser.dart';
import 'package:your_engineer/model/commission_model.dart';
import 'package:your_engineer/model/portfolio_model.dart';
// import 'package:get/get.dart';
// import 'package:intl/date_symbol_data_local.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
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
  UserProfileModel userProfile = UserProfileModel(
      id: '',
      email: '',
      fullname: '',
      talentreview: [],
      usercredentials: Usercredentials(attachments: '', isAuthorized: false),
      userportfolio: [],
      userskills: [],
      userprofiles: Userprofiles(aboutUser: '', specialization: ''),
      wallet:
          Wallet(id: '', user_id: '', credit: '', createdAt: '', updatedAt: ''),
      phone: '',
      imgpath: '',
      review_avg: '',
      isActive: false);
  ApiResponse apiResponse = ApiResponse();
  bool isLoding = false;
  String message = "";
  bool get status => _status;
  bool _status = false;
  bool statuse = false;
  int commission = 0;
  // List<PortfolioModel> listportfolioModel = [];

  @override
  onInit() {
    super.onInit();
    initializeDateFormatting();
    // getUsersShow('');
    getCurrentrateCommission();
    // getPortfolioEngenneir();
  }

  Future<ApiResponse> getUsersShow(String engeneerId) async {
    loadingState(LoadingState.loading);

    try {
      var token = await _shared.getToken();
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

      if (response.statusCode == 200) {
        userProfile = userProfileModelFromJson(jsonEncode(response.data));

        log("nnnnnnnnnnonnnnoooooooooooo   $response");

        update();

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

      if (error is TimeoutException) {
        message = AppConfig.timeOut;
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
        message = AppConfig.unAutaristion;
      } else {
        message = AppConfig.noNet;
      }
    }
    update();
    return apiResponse;
  }

  Future<bool> accountChargeRequest(
      BuildContext context, File imageFile) async {
    var token = await _shared.getToken();

    FormData data = FormData.fromMap({
      'amount': amountController.text,
      'attachment': await MultipartFile.fromFile(
        imageFile.path,
        filename: 'upload.jpg',
        contentType: MediaType(
            "multipart/form-data", "${imageFile.path.split(".").last}"),
      ),
    });

    try {
      isLoding = true;
      update();
      var response = await Dio()
          .post(
            ApiUrl.getTransactionsHistory(page: 1),
            data: data,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(const Duration(seconds: 20));

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
    }

    return status;
  }

  Future<bool> addPaypal(BuildContext context) async {
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        statuse = true;
        update();
        // await _shared.saveToken(response.body['token']);
      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());

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
    }

    return status;
  }

//
//
  void clearController() {
    amountController.clear();
    emailController.clear();
  }

  Future<void> getPortfolioEngenneir() async {
    loadingState(LoadingState.loading);

    try {
      var token = await _shared.getToken();

      var response = await Dio()
          .get(
            ApiUrl.addprotofilio,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      if (response.statusCode == 200) {
        PortfolioModel listportfolioModel =
            PortfolioModel.fromJson(response.data);
        // listportfolioModel = portfolioModelFromJson(response.data);
        update();
      } else {
        loadingState(LoadingState.error);
      }
    } catch (error) {
      loadingState(LoadingState.error);
      if (error is DioError) {
        // showseuessToast(error.response!.data['msg']);
      }
      if (error is TimeoutException) {
        // showseuessToast(AppConfig.timeOut.tr);
      }
      if (error is SocketException) {
        // showseuessToast(AppConfig.failedInternet.tr);
      } else {
        // showseuessToast(AppConfig.errorOoccurred.tr);
      }
    }
  }

  Future<bool> addVisa(BuildContext context) async {
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

  /// getCurrentrateCommission

  Future<void> getCurrentrateCommission() async {
    loadingState(LoadingState.loading);

    try {
      var token = await _shared.getToken();

      var response = await Dio()
          .get(
            ApiUrl.getCurrentrateCommission,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      if (response.statusCode == 200) {
        // final allNotificationModel =
        commission = CommissionModel.fromJson(response.data).ratepercent!;

        loadingState(LoadingState.loaded);

        update();
      } else {
        loadingState(LoadingState.error);
      }
    } catch (error) {
      loadingState(LoadingState.error);
      if (error is DioError) {
        // showseuessToast(error.response!.data['msg']);
        // Get.defaultDialog(title: AppConfig.timeOut.tr);
      }
      if (error is TimeoutException) {
        // showseuessToast(AppConfig.timeOut.tr);
        // Get.defaultDialog(title: AppConfig.timeOut.tr);
      }
      if (error is SocketException) {
        // Get.defaultDialog(title: AppConfig.failedInternet.tr);
        // showseuessToast(AppConfig.failedInternet.tr);
      } else {
        // Get.defaultDialog(title: AppConfig.errorOoccurred.tr);

        // showseuessToast(AppConfig.errorOoccurred.tr);
      }
    }
  }
}
