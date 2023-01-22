import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
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
  var loadingState = LoadingState.initial.obs;
  final _shared = SharedPrefUser();
  UserProfileModel userProfile = UserProfileModel();
  ApiResponse apiResponse = ApiResponse();
  bool isloding = false;
  String message = "";
  bool get status => _status;
  bool _status = false;
  @override
  onInit() {
    super.onInit();
    initializeDateFormatting();
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
}
