import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/price_range_model.dart';
import '../model/sub_catigory.dart';
import '../screen/project_screen.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';

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

  String? selectedCat;
  String? selectedPriceRange;
  bool get status => _status;
  bool _status = false;
  String message = "";

  @override
  void onInit() {
    getsubCatigory();
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

  //Get Sub Cat
  Future<ApiResponse> getsubCatigory() async {
    try {
      var token = await _pref.getToken();

      myLog("start methode", "getSubCatigory");

      // loadingState = LoadingState.loading.obs;
      var response = await Dio()
          .get(
            ApiUrl.getSubCatigory,
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
      myLog("getPriceRange response.statusCode", "${response.statusCode}");
      myLog("getPriceRange data", "${response.data}");
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
  Future<bool> addProject(BuildContext context) async {
    myLog('start methode', 'addProject');

    var token = await _pref.getToken();
    // print("token========================$token");

    final data = {
      // 'user_added_id': '9a49a238-218f-4eb3-8407-1db07ac7dc37',
      'proj_title': titleController.text,
      'proj_description': descriptionController.text,
      'category_id': selectedCat,
      'price_range_id': selectedPriceRange,
      'proj_period': daysController.text,
      'ProjectAttach': '',
      'skills': skillsController.text,
    };
    //

    try {
      var response = await Dio()
          .post(
            // 'https://calm-cyan-bullfrog-tie.cyclic.app/api/v1/project',
            ApiUrl.addProject,
            data: data,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(const Duration(seconds: 20));
      // var response = await http
      //     .post(
      //       // 'https://calm-cyan-bullfrog-tie.cyclic.app/api/v1/project',
      //       Uri.parse(ApiUrl.addProject),
      //       body: data,
      //       headers: ApiUrl.getHeader(token: token),
      //     )
      //     .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        ''
            'response : ${response.data}',
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

      myLog('error', error);

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
