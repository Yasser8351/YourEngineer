import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';

class MyProjectOffersScreenController extends GetxController {
  late String projectId;
  @override
  void onInit() {
    projectId = Get.arguments['projectId'];
    getProjectsOffers(projectId);
    super.onInit();
  }

  ApiResponse apiResponse = ApiResponse();

  TextEditingController daysController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final SharedPrefUser _pref = SharedPrefUser();
  bool status = false;

  int totalPages = 0;
  int totalItems = 0;
  int currentPage = 0;
  List<dynamic> resulte = [];
  var loadingState = LoadingState.initial.obs;

  //

  Future<ApiResponse> getProjectsOffers(String proID) async {
    loadingState(LoadingState.loading);
    try {
      var token = await _pref.getToken();

      myLog("start methode", "getProjectsOffers");
      myLog("Project ID", "${proID}");

      // loadingState = LoadingState.loading.obs;
      var response = await Dio()
          .get(
            "${ApiUrl.getProjectsOffers}${proID}?page=1&size=10",
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));
      // myLog("response.statusCode methode", "${response.data['results']}");

      // var projectModel = projectModelFromJson(jsonEncode(response.data));
      // _listprojects = projectModel.results;
      myLog("response.statusCode methode", "${response.statusCode}");
      myLog("response.Data methode", "${response.data}");

      if (response.statusCode == 200) {
        Map<String, dynamic> map = response.data;
        resulte = map['results'];
        totalPages = map["totalPages"];
        totalItems = map["totalItems"];
        currentPage = map["currentPage"];
        // ProjectModel projectModel =
        //     projectModelFromJson(jsonDecode(response.data));
        // _listprojects = projectModel.results;
        // if (_listprojects == null) {
        //   loadingState(LoadingState.noDataFound);
        // } else {
        loadingState(LoadingState.loaded);

        // setApiResponseValue('get Data Cars Sucsessfuly', true,
        //     _listprojects, LoadingState.loaded.obs);
        // }
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
      // myLog("start _listprojects", "${_listprojects}");
    }
    return apiResponse;
  }

//
  void clearController() {
    daysController.clear();
    descriptionController.clear();
    priceController.clear();
  }
}
