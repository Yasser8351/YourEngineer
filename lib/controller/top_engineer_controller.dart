import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:get/get.dart';
import 'package:your_engineer/model/top_engineer_rating_model.dart';
import 'package:your_engineer/sharedpref/user_share_pref.dart';
import 'package:your_engineer/utilits/helper.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../enum/all_enum.dart';

class TopEngineerController extends GetxController {
  ApiResponse apiResponse = ApiResponse();
  var loadingState = LoadingState.initial.obs;

  final SharedPrefUser _pref = SharedPrefUser();

  List<dynamic> _listTopEngineer = [];

  List<dynamic> get listTopEngineer => _listTopEngineer;
  String message = '';

  @override
  onInit() {
    super.onInit();
    getTopEngineer();
  }

  Future<ApiResponse> getTopEngineer() async {
    /// This function call the data from the API
    /// The Post type function takes the search value from the body
    /// get List of Top Engineer Rating in Home Screen

    loadingState(LoadingState.loading);
    try {
      var token = await _pref.getToken();

      myLog("start methode", "getTopEngineer");

      var response = await Dio()
          .post(
            ApiUrl.getTopEngineer,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("start methode  statusCode", "${response.statusCode}");
      // myLog("start methode  data", "${response.data}");

      if (response.statusCode == 200) {
        // = topEngineerRatingModelFromJson((response.data));

        var _modelEngineer =
            topEngineerRatingModelFromJson(jsonEncode(response.data));
        myLog("_modelEngineer", "${_modelEngineer}");

        _listTopEngineer = _modelEngineer.results;
        // _listTopEngineer = _modelEngineer.results;

        if (_listTopEngineer.isEmpty) {
          loadingState(LoadingState.noDataFound);
        } else {
          loadingState(LoadingState.loaded);

          // setApiResponseValue('get Data Cars Sucsessfuly', true,
          //     _listPopulerServices, LoadingState.loaded.obs);
        }
      } else if (response.statusCode == 401) {
        loadingState(LoadingState.error);
        message = AppConfig.unAutaristion;

        // setApiResponseValue(AppConfig.unAutaristion, false,
        //     _listPopulerServices, LoadingState.error.obs);
      } else {
        loadingState(LoadingState.error);
        message = AppConfig.unAutaristion;

        // setApiResponseValue(AppConfig.errorOoccurred, false,
        //     _listPopulerServices, LoadingState.error.obs);
      }
    } catch (error) {
      loadingState(LoadingState.error);
      message = AppConfig.failedInternet;
      // setApiResponseValue(error.toString(), false, _listPopulerServices,
      //     LoadingState.error.obs);
      if (error.toString().toUpperCase().contains('TimeoutException')) {
        showseuessToast(error.toString());
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
        // showseuessToast(AppConfig.unAutaristion);
        message = AppConfig.unAutaristion;
      } else {
        // showseuessToast(error.toString());
      }

      myLog("catch error", error.toString());
    }

    return apiResponse;
  }

  // setApiResponseValue(
  //     String message, bool status, List<dynamic> data, Rx<LoadingState> state) {
  //   apiResponse.message = message;
  //   apiResponse.status = status;
  //   // apiResponse.data = data;
  //   loadingState = state;
  // }
}
