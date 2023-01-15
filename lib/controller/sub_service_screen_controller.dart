import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/project_by_subcat_model.dart';
import '../model/sub_catigory.dart';
import '../sharedpref/user_share_pref.dart';
// import 'package:http/http.dart' as http;

class SubServiceScreenController extends GetxController {
  late String id;
  late String title;
  late String scatidvvv;
  int selectedscat = 0;
  var results = [];

  @override
  void onInit() async {
    id = Get.arguments['id'];
    title = Get.arguments['title'];
    await getSubCatigory(id);
    myLog("start methode  ''''''''''''''''''''''''''", "${scatidvvv}");
    String scatid = scatidvvv;
    await getProjectBySubCatigory(scatid);
    super.onInit();
  }

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
    myLog('iiiiiiiiidddddddddddddd', '${listSubServices[selectedscat].id!}');
    update();
  }

  Future<ApiResponse> getSubCatigory(String id) async {
    /// This function call the data from the API
    /// The Post type function takes the search value from the body
    /// get List of Cars in Home Screen

    loadingState(LoadingState.loading);
    try {
      var token = await _pref.getToken();

      myLog("start methode", "getCategorys");
      // myLog("toook================= : $token", '');
      loadingState = LoadingState.loading.obs;
      var response = await Dio()
          .get(
            "${ApiUrl.getSubCatigory}${id}",
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));
      // var response = await http.get(
      //   Uri.parse(ApiUrl.geCategory),
      //   headers: ApiUrl.getHeader(token: token),
      // );

      myLog("statusCode=================${response.statusCode}", '');
      myLog("statusCode=================${response.data}", '');

      if (response.statusCode == 200 || response.statusCode == 201) {
        _listSubServices = subCatigoryFromJson(jsonEncode(response.data));
        scatidvvv = _listSubServices[selectedscat].id.toString();
        // myLog("start methode  _listSubServices_listSubServices", "${scatid}");

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
        myLog("errrrrrrrorrrr", "${response.statusCode}");

        // setApiResponseValue(AppConfig.errorOoccurred, false,
        //     _listPopulerServices, LoadingState.error.obs);
      }
    } catch (error) {
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

      myLog("catch error", error.toString());
    }
    // myLog("start methode  _listSubServices", "${_listSubServices}");

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

      myLog("start methode", "getProjectBySubCatigory");
      // myLog("toook================= : $token", '');
      // loadingState = LoadingState.loading.obs;
      var response = await Dio()
          .get(
            "${ApiUrl.getProjectBySubCatigory}${id}",
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("statusCode=================${response.statusCode}", '');
      // myLog("statusCode=================${response.data}", '');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Map<String, dynamic> data =
        //     new Map<String, dynamic>.from(jsonEncode(response.data.toString()));

        // Map<String, dynamic> map = json.decode(response.data);
        // List<dynamic> data = map["results"];
        // log(data.toString());
        isLoadingProject = false;

        results = response.data['results'];
        int totalItems = response.data['totalItems'];
        int totalPages = response.data['totalPages'];
        int currentPage = response.data['currentPage'];
        // projectBySubCatModel = ProjectBySubCatModel(
        //     currentPage: currentPage,
        //     totalItems: totalItems,
        //     totalPages: totalPages,
        //     results: results);

        myLog(results, totalItems);
        myLog(currentPage, totalPages);
        myLog("isLoadingProjectpppppppp", isLoadingProject);
        // _listProjectSubServices =
        //     projectBySubCatModelFromJson(jsonDecode(response.data)).results!;
        //         as List<ProjectBySubCatModel>;
        // as List<ProjectBySubCatModel>;
        // myLog("start methode  _listSubServices", "${_listSubServices}");

        if (_listSubServices.isEmpty) {
          // loadingState(LoadingState.noDataFound);
          message = 'Empty';
        } else {
          loadingState(LoadingState.loaded);

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

      myLog("catch error", error.toString());
    }
    myLog("start methode  results", "${results}");

    return apiResponse;
  }
}
