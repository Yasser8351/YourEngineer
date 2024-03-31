import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/screen/profile/add_review_screen.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/faq_model.dart';
import '../model/privacy_policy_model.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'package:http/http.dart' as http;

class FaqController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getFaq();
    getContactNumber();
  }

  var loadingState = LoadingState.initial.obs;
  var loadingPhoneNumber = LoadingState.initial;
  var loadingAddReview = LoadingState.initial;
  final _shared = SharedPrefUser();

  var loadingStateCompleteProject = LoadingState.initial.obs;

  List<FaqtModel> faq = [];
  ApiResponse apiResponse = ApiResponse();
  bool isloding = false;
  String message = "";
  String errorMessage = "";
  String whatsappPhoneNumber = "";
  bool get status => _status;
  bool _status = false;
  PrivacyPolicyModel privacyPolicyModel =
      PrivacyPolicyModel(id: '', description: '', createdAt: '', updatedAt: '');

  Future<ApiResponse> getFaq() async {
    loadingState(LoadingState.loading);
    // isloding = true;
    // update();
    try {
      var token = await _shared.getToken();

      var response = await http
          .get(
            headers: ApiUrl.getHeader(token: token),
            Uri.parse(ApiUrl.getFaq),
            // options: Options(
            //   headers: ApiUrl.getHeader(token: token),
            // ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.body}',
      );

      if (response.statusCode == 200) {
        faq = faqtModelFromJson(response.body);

        if (faq.isEmpty) {
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
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
      } else {
        message = AppConfig.noNet;
      }

      myLog("catch error getFaq: ", error.toString());
    }
    return apiResponse;
  }

  Future<void> getPrivacyPolicy() async {
    loadingState(LoadingState.loading);

    try {
      var token = await _shared.getToken();

      myLog("start methode", "getPrivacyPolicy");

      var response = await Dio()
          .get(
            ApiUrl.getPrivacyPolicy,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("response.statusCode methode", "${response.statusCode}");

      if (response.statusCode == 200) {
        privacyPolicyModel = PrivacyPolicyModel.fromJson(response.data);

        loadingState(LoadingState.loaded);

        update();
      } else {
        loadingState(LoadingState.error);
      }
    } catch (error) {
      loadingState(LoadingState.error);
      if (error is TimeoutException) {
        Get.defaultDialog(title: AppConfig.timeOut.tr);
      }
      if (error is SocketException) {
        Get.defaultDialog(title: AppConfig.failedInternet.tr);
      } else {
        Get.defaultDialog(title: AppConfig.errorOoccurred.tr);
      }

      myLog("catch getPrivacyPolicy", error.toString());
    }
  }

  Future<void> getContactNumber() async {
    changeLoadingState(LoadingState.loading, LodingType.loadingPhoneNumber);

    try {
      var token = await _shared.getToken();

      var response = await Dio()
          .get(
            ApiUrl.getContactNumber,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("response.statusCode methode", "${response.statusCode}");

      if (response.statusCode == 200) {
        changeLoadingState(LoadingState.loaded, LodingType.loadingPhoneNumber);
        whatsappPhoneNumber = response.data['phone'].toString();
      } else {
        errorMessage = AppConfig.errorOoccurred.tr;
        changeLoadingState(LoadingState.error, LodingType.loadingPhoneNumber);
      }
    } catch (error) {
      changeLoadingState(LoadingState.error, LodingType.loadingPhoneNumber);

      handlingCatchError(
          error: error,
          changeLoadingState: () => changeLoadingState(
              loadingPhoneNumber, LodingType.loadingPhoneNumber),
          errorMessageUpdate: (meesgae) => errorMessageUpdate(meesgae));
    }
  }

  Future<bool> completeProject(BuildContext context, String projectId) async {
    var token = await _shared.getToken();

    dialogConfirm(
      onCancel: () => Get.back(),
      onOk: () async {
        await confirmComplete(projectId, token, context);
      },
    );

    return status;
  }

  Future<void> confirmComplete(
      String projectId, String token, BuildContext context) async {
    Get.back();
    loadingStateCompleteProject(LoadingState.loading);
    try {
      var response = await http
          .put(
            Uri.parse(ApiUrl.completeProject(projectId: projectId)),
            headers: ApiUrl.getHeader2(token: token),
          )
          .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.body}',
      );
      final Map parsed = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        loadingStateCompleteProject(LoadingState.loaded);

        Helper.showseuess(context: context, subtitle: parsed['msg']);

        Get.to(() => const AddReviewScreen());
      } else {
        loadingStateCompleteProject(LoadingState.error);

        Helper.showError(context: context, subtitle: parsed['msg'].toString());
      }
    } catch (error) {
      loadingStateCompleteProject(LoadingState.error);
      if (error.toString().contains('TimeoutException') ||
          error.toString().contains("SocketException") ||
          error.toString().contains("Network is unreachable")) {
        Helper.showError(context: context, subtitle: AppConfig.noNet.tr);
      } else if (error is DioError) {
        Helper.showError(
            context: context, subtitle: error.response!.data['msg']);
      } else {
        Helper.showError(
            context: context, subtitle: AppConfig.errorOoccurred.tr);
      }
      myLog('catch  erroor', '$error');
    }
  }

  Future<void> addReviews() async {
    changeLoadingState(LoadingState.loading, LodingType.addReview);

    try {
      var token = await _shared.getToken();

      var response = await Dio()
          .post(
            ApiUrl.addReviews,
            data: {
              "talent_id": "dac20c02-74e8-419f-a924-84753252c36c",
              "comment": "This is a nice working",
              "star_rate": 5,
              "proj_id": "d0da3a92-f7a0-4446-8ede-8386512c16e7"
            },
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("response", "${response}");

      if (response.statusCode == 200) {
        changeLoadingState(LoadingState.loaded, LodingType.addReview);
      } else {
        errorMessage = AppConfig.errorOoccurred.tr;
        changeLoadingState(LoadingState.error, LodingType.addReview);
      }
    } catch (error) {
      changeLoadingState(LoadingState.error, LodingType.addReview);

      handlingCatchError(
          error: error,
          changeLoadingState: () =>
              changeLoadingState(loadingPhoneNumber, LodingType.addReview),
          errorMessageUpdate: (meesgae) => errorMessageUpdate(meesgae));
    }
  }

  ///////////////////////////////////

  changeLoadingState(LoadingState _isLoading, LodingType lodingType) {
    if (lodingType == LodingType.addReview) {
      loadingAddReview = _isLoading;
    } else {
      loadingPhoneNumber = _isLoading;
    }

    update();
  }

  errorMessageUpdate(String error) {
    errorMessage = error;
    update();
  }
}
