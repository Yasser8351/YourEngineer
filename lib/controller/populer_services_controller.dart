import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/model/populer_services_model.dart';
import 'package:get/get.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../enum/all_enum.dart';
import '../utilits/helper.dart';

class PopulerServicesController extends GetxController {
  ApiResponse apiResponse = ApiResponse();
  LoadingState loadingState = LoadingState.initial;

  List<PopulerServicesModel> _list = [];

  List<PopulerServicesModel> get list => _list;

  @override
  onInit() {
    super.onInit();
    getCategorys();
  }

  Future<ApiResponse> getCategorys() async {
    // This function call the data from the API
    // The Post type function takes the search value from the body
    // get List of Cars in Home Screen
    try {
      // Helper.showError(
      //     context: context, subtitle: 'start methode getCategorys');

      loadingState = LoadingState.loading;
      var response = await Dio().get(
        ApiUrl.geCategory,
        options: Options(
          headers: ApiUrl.getHeader(),
        ),
      );
      // .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        // _list = categoryModelFromJson(response.data);
        // var list = categoryModelFromJson(response.data).obs;
        final populerServicesModel =
            populerServicesModelFromJson(jsonEncode(response.data));
        // final populerServicesModel =
        myLog("populerServicesModel", populerServicesModel);
        if (_list.isEmpty) {
          loadingState = LoadingState.noDataFound;
        } else {
          setApiResponseValue(
              'get Data Cars Sucsessfuly', true, _list, LoadingState.loaded);
        }
      } else if (response.statusCode == 401) {
        setApiResponseValue(
            AppConfig.unAutaristion, false, _list, LoadingState.error);
      } else if (response.statusCode == 500) {
        setApiResponseValue(
            AppConfig.serverError, false, _list, LoadingState.error);
      } else {
        setApiResponseValue(
            AppConfig.errorOoccurred, false, _list, LoadingState.error);
      }
    } catch (error) {
      setApiResponseValue(error.toString(), false, _list, LoadingState.error);
      if (error.toString().toUpperCase().contains('TimeoutException')) {
        Get.snackbar("title", "time out", snackPosition: SnackPosition.BOTTOM);
        // Helper.showError(context: context, subtitle: AppConfig.failedInternet);
      } else {
        // Helper.showError(context: context, subtitle: AppConfig.errorOoccurred);
      }
      myLog("catch error", error.toString());
    }

    return apiResponse;
  }

  setApiResponseValue(
      String message, bool status, List<dynamic> data, LoadingState state) {
    apiResponse.message = message;
    apiResponse.status = status;
    // apiResponse.data = data;
    loadingState = state;
  }
}
