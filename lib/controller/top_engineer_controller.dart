import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:get/get.dart';
import 'package:your_engineer/model/top_engineer_rating_model.dart';
import 'package:your_engineer/screen/login_screen.dart';
import 'package:your_engineer/sharedpref/user_share_pref.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../enum/all_enum.dart';

class TopEngineerController extends GetxController {
  ApiResponse apiResponse = ApiResponse();
  var loadingState = LoadingState.initial.obs;
  var loadingStateAllEng = LoadingState.initial.obs;

  final SharedPrefUser _pref = SharedPrefUser();

  List<dynamic> _listTopEngineer = [];
  List<Result> listTopPagen = [];

  List<dynamic> get listTopEngineer => _listTopEngineer;
  String message = '';
  RxString userAccountType = "".obs;

  int totalItems = 0;
  int pageNumber = 1;
  TopEngineerRatingModel modelEngineer = TopEngineerRatingModel(
      results: [], totalItems: 0, totalPages: 0, currentPage: 0);
  @override
  onInit() {
    super.onInit();
    getUserAccount();
    getTopEngineer(5);
  }

  getUserAccount() async {
    userAccountType.value = await _pref.getUserAccountType();
    myLog("key", "${userAccountType.value}");
  }

  Future<ApiResponse> getTopEngineer(int size, {bool isMore = false}) async {
    /// This function call the data from the API
    /// The Post type function takes the search value from the body
    /// get List of Top Engineer Rating in Home Screen

    if (isMore) pageNumber++;
    myLog("start pageNumber", pageNumber);

    loadingState(LoadingState.loading);
    try {
      var token = await _pref.getToken();

      var response = await Dio()
          .post(
            ApiUrl.getTopEngineer(page: isMore ? pageNumber : 1, size: size),
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      if (response.statusCode == 200) {
        var _modelEngineer =
            topEngineerRatingModelFromJson(jsonEncode(response.data));

        totalItems = _modelEngineer.totalItems ?? 0;

        _listTopEngineer = _modelEngineer.results
            .where((element) => !element.roleId.toUpperCase().contains("ADMIN"))
            .toList();
        listTopPagen.addAll(_modelEngineer.results);

        if (_listTopEngineer.isEmpty) {
          message = AppConfig.noData.tr;
          loadingState(LoadingState.noDataFound);
        } else {
          loadingState(LoadingState.loaded);
        }
      } else if (response.statusCode == 401) {
        Get.off(() => const LoginScreen());
      } else {
        loadingState(LoadingState.error);
        message = AppConfig.unAutaristion.tr;
      }
    } catch (error) {
      loadingState(LoadingState.error);
      myLog("error", "${error}");

      if (error.toString().toUpperCase().contains('TimeoutException') ||
          error.toString().contains("connection timeout") ||
          error.toString().contains("SocketException") ||
          error.toString().contains("Network is unreachable")) {
        message = AppConfig.failedInternet.tr;
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
        message = AppConfig.unAutaristion.tr;
      } else {
        message = AppConfig.errorOoccurred.tr;
      }
    }

    return apiResponse;
  }
}
