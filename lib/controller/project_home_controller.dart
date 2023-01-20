import 'dart:async';
// import 'dart:html';

import 'package:dio/dio.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:get/get.dart';
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
  List<dynamic> results = [];

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

        results = map['results'];
        totalPages = map["totalPages"];
        totalItems = map["totalItems"];
        currentPage = map["currentPage"];
        loadingState(LoadingState.loaded);
        if (results.isEmpty) {
          loadingState(LoadingState.noDataFound);
        }

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
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
      } else {}

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
