import 'dart:async';
// import 'dart:html';

import 'package:dio/dio.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:get/get.dart';
import 'package:your_engineer/screen/login_screen.dart';
import 'package:your_engineer/sharedpref/user_share_pref.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../enum/all_enum.dart';

class ProjectControllerHome extends GetxController {
  ApiResponse apiResponse = ApiResponse();
  var loadingState = LoadingState.initial.obs;

  final SharedPrefUser _pref = SharedPrefUser();

  // List<Result?>? _listprojects = [];

  // List<Result?>? get listprojects => _listprojects;

  int totalPages = 0;
  int totalItems = 0;
  int currentPage = 0;
  String priceRange = '';
  String projPeriod = '';
  List<dynamic> results = [];
  RxString errorMessage = ''.obs;
  @override
  onInit() {
    super.onInit();
    getProjects();
  }

  //get Project

  Future<ApiResponse> getProjects() async {
    /// This function call the data from the API
    /// The Post type function takes the search value from the body
    /// get List of Cars in Home Screen

    loadingState(LoadingState.loading);
    try {
      var token = await _pref.getToken();

      myLog("start methode", "getProjects");

      // loadingState = LoadingState.loading.obs;
      var response = await Dio()
          .get(
            ApiUrl.getProject,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("response  getProjects", "${response.data}");

      if (response.statusCode == 200) {
        Map<String, dynamic> map = response.data;

        // priceRange = ProjectModel.fromJson(map).results[0].priceRange.rangeName;
        results = map['results'] ?? "";
        totalPages = map["totalPages"] ?? "";
        totalItems = map["totalItems"] ?? "";
        currentPage = map["currentPage"] ?? "";
        projPeriod = map["proj_period"] ?? "";
        loadingState(LoadingState.loaded);
        if (results.isEmpty) {
          loadingState(LoadingState.noDataFound);
        }
      }
    } catch (error) {
      loadingState(LoadingState.error);

      if (error is DioError) {
        if (error.toString().contains('TimeoutException') ||
            error.toString().contains("SocketException") ||
            error.toString().contains("Network is unreachable")) {
          errorMessage = AppConfig.failedInternet.tr.obs;
        } else if (error.toString().contains("403")) {
          Get.offAll(() => LoginScreen());
        } else {
          errorMessage = AppConfig.errorOoccurred.tr.obs;
          // errorMessage = error.response!.data['msg'].obs;
        }
      }

      myLog("catch error", error.toString());
      // myLog("start _listprojects", "${_listprojects}");
    }
    return apiResponse;
  }

  setValueResponse(bool status) {
    status = status;
  }

  // setApiResponseValue(
  //     String message, bool status, List<dynamic> data, Rx<LoadingState> state) {
  //   apiResponse.message = message;
  //   apiResponse.status = status;
  //   // apiResponse.data = data;
  //   loadingState = state;
  // }
}
