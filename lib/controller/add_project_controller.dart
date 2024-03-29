import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:http_parser/http_parser.dart';
// import 'package:get/get.dart';

import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/populer_services_model.dart';
import '../model/price_range_model.dart';
import '../model/sub_catigory.dart';
import '../screen/project_screen.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'package:http/http.dart' as http;

class AddProjectController extends GetxController {
  ApiResponse apiResponse = ApiResponse();

  final SharedPrefUser _pref = SharedPrefUser();
  List<SubCatigoryModel> listSubCat = [];
  List<PriceRangeModel> listPriceRange = [];
  var loadingState = LoadingState.initial.obs;
  TextEditingController daysController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController skillsController = TextEditingController();

  List<PopulerServicesModel> _listPopulerServices = [];

  List<PopulerServicesModel> get listPopulerServices => _listPopulerServices;
  String? selectedCat;
  String? selectedSubCat;
  String? selectedPriceRange;
  bool get status => _status;
  bool _status = false;
  String message = "";

  @override
  void onInit() {
    super.onInit();
    getCategorys();
    // selectedCat = listPopulerServices[0].id;
    // myLog("caaaaat idddddd", "$selectedCat");
    // getsubCatigory(selectedCat);
    getPriceRange();
  }

  //
  void clearController() {
    daysController.clear();
    descriptionController.clear();
    titleController.clear();
  }

  back() {
    Get.off(ProjectScreen());
  }

  //Get Cat

  Future<ApiResponse> getCategorys() async {
    /// This function call the data from the API
    /// The Post type function takes the search value from the body
    /// get List of Cars in Home Screen

    loadingState(LoadingState.loading);
    try {
      var token = await _pref.getToken();

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

  //Get Sub Cat
  Future<ApiResponse> getsubCatigory(String catId) async {
    try {
      var token = await _pref.getToken();

      myLog("start methode", "getSubCatigory");

      // loadingState = LoadingState.loading.obs;
      var response = await Dio()
          .get(
            "${ApiUrl.getSubCatigory}${catId}",
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));
      myLog("getsubCatigory response.statusCode", "${response.statusCode}");
      myLog("getsubCatigory data", "${response.data}");
      if (response.statusCode == 200) {
        listSubCat = subCatigoryFromJson(jsonEncode(response.data));
        // listSubCat = lstSubcatModel;
        // myLog("lstSubcatModel lstSubcatModel", "${lstSubcatModel}");
        // if (listSubCat.isEmpty) {
        //   loadingState(LoadingState.noDataFound);
        // } else {
        //   loadingState(LoadingState.loaded);

        //   // setApiResponseValue('get Data Cars Sucsessfuly', true,
        //   //     _listprojects, LoadingState.loaded.obs);
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
    }
    return apiResponse;
  }

  // get Price Range

  Future<ApiResponse> getPriceRange() async {
    try {
      var token = await _pref.getToken();

      myLog("start methode", "getSubCatigory");

      // loadingState = LoadingState.loading.obs;
      var response = await Dio()
          .get(
            ApiUrl.getPricerange,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));
      myLog("statusCode", "${response.statusCode}");
      myLog("getPriceRange", "${response.data}");
      if (response.statusCode == 200) {
        listPriceRange = priceRangeModelFromJson(jsonEncode(response.data));
        // listSubCat = lstSubcatModel;
        // myLog("lstSubcatModel lstSubcatModel", "${lstSubcatModel}");
        if (listSubCat.isEmpty) {
          loadingState(LoadingState.noDataFound);
        } else {
          loadingState(LoadingState.loaded);

          // setApiResponseValue('get Data Cars Sucsessfuly', true,
          //     _listprojects, LoadingState.loaded.obs);
        }
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
    }
    return apiResponse;
  }

  //addProject
  Future<bool> addProject(
    BuildContext context,
    File? imageFile,
  ) async {
    myLog('start methode', 'addProject');

    var token = await _pref.getToken();

    FormData data = FormData.fromMap({
      'proj_title': titleController.text,
      'proj_description': descriptionController.text,
      'category_id': selectedSubCat,
      'price_range_id': selectedPriceRange,
      'proj_period': daysController.text,
      'skills': skillsController.text,
      "ProjectAttach": imageFile == null
          ? ""
          : await MultipartFile.fromFile(imageFile.path,
              filename: 'upload.jpg'),
      // "ProjectAttach": imageFile == null
      //     ? ""
      //     : await MultipartFile.fromFile(
      //         imageFile.path,
      //         contentType: MediaType(
      //           "image",
      //           "${imageFile.path.split(".").last}",
      //         ),
      //       ),
    });
    //

    try {
      var response = await Dio()
          .post(
            ApiUrl.addProject,
            data: data,
            options: Options(
              headers: ApiUrl.getHeaderImage(token: token),
            ),
          )
          .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        ''
            'data : ${response.data}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = true;
        // await _shared.saveToken(response.body['token']);
      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());
        print("nnnnnnnnnnonnnnoooooooooooo");

        _status = false;
      }
    } catch (error) {
      _status = false;
      if (error is DioError) {
        message = error.response!.data['msg'];
        Helper.showError(
            context: context, subtitle: error.response!.data['msg']);
      }

      if (error.toString().contains('TimeoutException')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
      } else if (error.toString().contains('Http status error [401]')) {
        Helper.showError(
            context: context, subtitle: "خطأ في اسم المستخدم او كلمة المرور");
      } else {
        Helper.showError(context: context, subtitle: 'حث خطأ في الاتصال');
      }
      myLog('catch  erroor', '$error');
    }

    return status;
  }
}
