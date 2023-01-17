import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/model/populer_services_model.dart';
import 'package:get/get.dart';
import 'package:your_engineer/sharedpref/user_share_pref.dart';
import 'package:your_engineer/utilits/helper.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../enum/all_enum.dart';
import 'package:http/http.dart' as http;

import '../screen/services/sub_services_screen.dart';

class PopulerServicesController extends GetxController {
  ApiResponse apiResponse = ApiResponse();
  var loadingState = LoadingState.initial.obs;

  final SharedPrefUser _pref = SharedPrefUser();

  List<PopulerServicesModel> _listPopulerServices = [];

  List<PopulerServicesModel> get listPopulerServices => _listPopulerServices;
  String message = '';

  @override
  onInit() {
    super.onInit();
    getCategorys();
  }

  logout(BuildContext context) async {
    SharedPrefUser sharedPrefUser = SharedPrefUser();
    await sharedPrefUser.logout();

    return Navigator.of(context).pushNamed(AppConfig.login);
  }

  // islogout(Buldcon) {
  //   () => logout(context);
  // }

  Future<ApiResponse> getCategorys() async {
    /// This function call the data from the API
    /// The Post type function takes the search value from the body
    /// get List of Cars in Home Screen

    loadingState(LoadingState.loading);
    try {
      var token = await _pref.getToken();

      myLog("start methode", "getCategorys");
      myLog("toook================= : $token", '');
      // loadingState = LoadingState.loading.obs;
      // var response = await Dio()
      //     .get(
      //       ApiUrl.geCategory,
      //       options: Options(
      //         headers: ApiUrl.getHeader(token: token),
      //       ),
      //     )
      //     .timeout(Duration(seconds: ApiUrl.timeoutDuration));
      var response = await http.get(
        Uri.parse(ApiUrl.geCategory),
        headers: ApiUrl.getHeader(token: token),
      );

      myLog("start methode", "${loadingState.value}");
      myLog("statusCode=================${response.body}", '');

      if (response.statusCode == 200) {
        _listPopulerServices = populerServicesModelFromJson(response.body);

        if (_listPopulerServices.isEmpty) {
          loadingState(LoadingState.noDataFound);
        } else {
          loadingState(LoadingState.loaded);

          // setApiResponseValue('get Data Cars Sucsessfuly', true,
          //     _listPopulerServices, LoadingState.loaded.obs);
        }
      } else if (response.statusCode == 401) {
        loadingState(LoadingState.error);
        message = AppConfig.timeOut;
        // setApiResponseValue(AppConfig.unAutaristion, false,
        //     _listPopulerServices, LoadingState.error.obs);
      } else {
        loadingState(LoadingState.token);
        myLog("errrrrrrrorrrr", "${response.statusCode}");

        // setApiResponseValue(AppConfig.errorOoccurred, false,
        //     _listPopulerServices, LoadingState.error.obs);
      }
    } catch (error) {
      loadingState(LoadingState.error);
      message = AppConfig.failedInternet;
      // setApiResponseValue(error.toString(), false, _listPopulerServices,
      //     LoadingState.error.obs);
      if (error is TimeoutException) {
        // showseuessToast(error.toString());
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
        // showseuessToast(AppConfig.unAutaristion);
        message = AppConfig.unAutaristion;
      } else {
        // showseuessToast(error.toString());
      }

      // myLog("catch error", error.toString());
    }
    return apiResponse;
  }

  goToSubServicesScreen(String id, String title) {
    Get.to(SubServicesScreen(), arguments: {'id': id, 'title': title});
  }
  // setApiResponseValue(
  //     String message, bool status, List<dynamic> data, Rx<LoadingState> state) {
  //   apiResponse.message = message;
  //   apiResponse.status = status;
  //   // apiResponse.data = data;
  //   loadingState = state;
  // }
}
