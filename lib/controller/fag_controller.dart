import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/faq_model.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'package:http/http.dart' as http;

class FaqController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getFaq();
  }

  var loadingState = LoadingState.initial.obs;
  final _shared = SharedPrefUser();
  List<FaqtModel> faq = [];
  ApiResponse apiResponse = ApiResponse();
  bool isloding = false;

  getFaq() async {
    // loadingState(LoadingState.loading);
    isloding = true;
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
        loadingState(LoadingState.loaded);
        isloding = false;
        update();

        // faq =
        //     populerServicesModelFromJson(jsonEncode(response.body));

        if (faq.isEmpty) {
          loadingState(LoadingState.noDataFound);
        } else {
          // setApiResponseValue('get Data Cars Sucsessfuly', true,
          //     _listPopulerServices, LoadingState.loaded.obs);
        }
      } else if (response.statusCode == 403) {
        loadingState(LoadingState.error);

        // setApiResponseValue(AppConfig.unAutaristion, false,
        //     _listPopulerServices, LoadingState.error.obs);
      } else {
        loadingState(LoadingState.error);

        // setApiResponseValue(AppConfig.errorOoccurred, false,
        //     _listPopulerServices, LoadingState.error.obs);
      }
    } on SocketException {
      loadingState(LoadingState.error);
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

      myLog("catch error getFaq: ", error.toString());
    }
    return apiResponse;
  }
}
