import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../enum/all_enum.dart';
import '../model/sub_catigory.dart';
import '../sharedpref/user_share_pref.dart';
// import 'package:http/http.dart' as http;

class SubServiceScreenController extends GetxController {
  String id = '';
  String title = '';
  String scatidvvv = '';
  int selectedscat = 0;
  var results = [];

  ApiResponse apiResponse = ApiResponse();

  var loadingState = LoadingState.initial.obs;
  var isLoadingProject = false;
  final SharedPrefUser _pref = SharedPrefUser();
  List<SubCatigoryModel> _listSubServices = [];
  List<SubCatigoryModel> get listSubServices => _listSubServices;

  // late ProjectBySubCatModel projectBySubCatModel;

  List<dynamic> _listProjectSubServices = [];
  List<dynamic> get listProjectSubServices => _listProjectSubServices;
  String message = '';
  changesubcat() async {
    // isLoadingProject = true;
    selectedscat = listSubServices[selectedscat].id! as int;
    await getProjectBySubCatigory(listSubServices[selectedscat].id!);
    update();
  }

  @override
  void onInit() {
    id = Get.arguments['id'];
    title = Get.arguments['title'];
    getSubCatigory(id);
    String scatid = scatidvvv;
    getProjectBySubCatigory(scatid);
    update();
    super.onInit();
  }

  Future<ApiResponse> getSubCatigory(String id) async {
    /// This function call the data from the API
    /// The Post type function takes the search value from the body
    /// get List of Cars in Home Screen

    loadingState(LoadingState.loading);
    try {
      var token = await _pref.getToken();

      var response = await Dio()
          .get(
            "${ApiUrl.getSubCatigory}${id}",
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("getSubCatigory ", response);

      loadingState(LoadingState.loaded);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _listSubServices = subCatigoryFromJson(jsonEncode(response.data));
        scatidvvv = _listSubServices[selectedscat].id.toString();

        if (_listSubServices.isEmpty) {
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

        // setApiResponseValue(AppConfig.errorOoccurred, false,
        //     _listPopulerServices, LoadingState.error.obs);
      }
    } catch (error) {
      myLog("getSubCatigory error", error);

      loadingState(LoadingState.error);
      message = AppConfig.noData;
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
    }

    return apiResponse;
  }

  Future<ApiResponse> getProjectBySubCatigory(String id) async {
    /// This function call the data from the API
    /// The Post type function takes the search value from the body
    /// get List of Cars in Home Screen

    // loadingState(LoadingState.loading);
    isLoadingProject = true;
    try {
      var token = await _pref.getToken();

      var response = await Dio()
          .get(
            "${ApiUrl.getProjectBySubCatigory}${id}",
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      if (response.statusCode == 200 || response.statusCode == 201) {
        results = response.data['results'];
        int totalItems = response.data['totalItems'];
        int totalPages = response.data['totalPages'];
        int currentPage = response.data['currentPage'];
        isLoadingProject = false;
        loadingState(LoadingState.loaded);

        if (results.isEmpty) {
          loadingState(LoadingState.noDataFound);
          message = 'Empty';
        } else {
          // setApiResponseValue('get Data Cars Sucsessfuly', true,
          //     _listPopulerServices, LoadingState.loaded.obs);
        }
      } else if (response.statusCode == 401) {
        // loadingState(LoadingState.error);
        message = AppConfig.timeOut;
        // setApiResponseValue(AppConfig.unAutaristion, false,
        //     _listPopulerServices, LoadingState.error.obs);
      } else {
        // loadingState(LoadingState.token);

        // setApiResponseValue(AppConfig.errorOoccurred, false,
        //     _listPopulerServices, LoadingState.error.obs);
      }
    } catch (error) {
      // loadingState(LoadingState.error);
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
    }

    return apiResponse;
  }
}
