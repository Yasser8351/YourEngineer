import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:get/get.dart';
import 'package:your_engineer/model/project_model.dart';
import 'package:your_engineer/sharedpref/user_share_pref.dart';
import 'package:your_engineer/utilits/helper.dart';
import '../api/api_parameters.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../enum/all_enum.dart';

class ProjectController extends GetxController {
  ApiResponse apiResponse = ApiResponse();
  var loadingState = LoadingState.initial.obs;

  final SharedPrefUser _pref = SharedPrefUser();

  List<Project> _listprojects = [];

  List<Project> get listprojects => _listprojects;
  bool get status => _status;
  bool _status = false;
  final _shared = SharedPrefUser();

  @override
  onInit() {
    super.onInit();
    getProjects();
  }

  //addProject
  Future<bool> addProject(
      BuildContext context, String email, String password) async {
    myLog('start methode', 'addProject');

    var token = await _shared.getToken();

    final data = {
      'user_added_id': '57493cf4-adea-4299-9953-a9bb64b1ec4f',
      'proj_title': 'Title',
      'proj_description': 'description description description',
      'category_id': 'ef14bad9-583a-4278-bd43-7daed9d24956',
      'price_range_id': '0bbb2d2e-3c57-11ed-8686-ecf4bb83b19b',
      'proj_period': '30',
      'ProjectAttach': '',
    };

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

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.data}',
      );

      if (response.statusCode == 200) {
        _status = true;
        await _shared.saveToken(response.data['token']);

        setValueResponse(true);
      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());

        setValueResponse(false);
        _status = false;
      }
    } catch (error) {
      _status = false;

      setValueResponse(false);

      myLog('error', error);

      if (error.toString().contains('TimeoutException')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
      } else if (error.toString().contains('Http status error [401]')) {
        Helper.showError(
            context: context, subtitle: "خطأ في اسم المستخدم او كلمة المرور");
      } else {
        Helper.showError(context: context, subtitle: 'حث خطأ في الاتصال');
      }
    }
    return status;
  }

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

      myLog("start methode", "${loadingState.value}");

      if (response.statusCode == 200) {
        var projectModel = projectModelFromJson(jsonEncode(response.data));
        _listprojects = projectModel.results;

        if (_listprojects.isEmpty) {
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
