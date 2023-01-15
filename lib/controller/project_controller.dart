import 'dart:async';
import 'dart:convert';
// import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:http/http.dart' as http;

import '../model/populer_services_model.dart';
import '../model/price_range_model.dart';
import '../model/sub_catigory.dart';
import 'populer_services_controller.dart';

class ProjectController extends GetxController {
  ApiResponse apiResponse = ApiResponse();
  var loadingState = LoadingState.initial.obs;

  final SharedPrefUser _pref = SharedPrefUser();

  List<Result?>? _listprojects = [];
  List<SubCatigoryModel> listSubCat = [];
  List<PriceRangeModel> listPriceRange = [];

  List<Result?>? get listprojects => _listprojects;
  bool get status => _status;
  bool _status = false;
  final _shared = SharedPrefUser();
  TextEditingController daysController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController skillsController = TextEditingController();

  String? selectedCat;
  String? selectedPriceRange;
  // RangeValues selectedRange = const RangeValues(25, 50);
  // bool isSelectedRange = false;
  //
  // PopulerServicesController populerServicesController = Get.find();

  @override
  onInit() async {
    super.onInit();
    await getProjects();
    // await getsubCatigory();
    await getPriceRange();
  }

  void clearController() {
    daysController.clear();
    descriptionController.clear();
    titleController.clear();
  }

  //addProject
  Future<bool> addProject(BuildContext context) async {
    myLog('start methode', 'addProject');

    var token = await _shared.getToken();
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

        setValueResponse(true);
      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());
        print("nnnnnnnnnnonnnnoooooooooooo");

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
      myLog('catch  erroor', '$error');
    }

    return status;
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
      // myLog("response.statusCode methode", "${response.data['results']}");

      // var projectModel = projectModelFromJson(jsonEncode(response.data));
      // _listprojects = projectModel.results;
      myLog("response.statusCode methode", "${response.statusCode}");
      myLog("response.Data methode", "${response.data}");

      if (response.statusCode == 200) {
        ProjectModel projectModel =
            projectModelFromJson(jsonDecode(response.data));
        _listprojects = projectModel.results;
        if (_listprojects == null) {
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
      myLog("start _listprojects", "${_listprojects}");
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

// {
  
//   id: 654f0679-8a1c-4848-887a-c07bb1ea4eed,
//    proj_title: beko 333333333333, 
//    proj_description: التفاصيل, 
//    skills: null, 
//    proj_period: 30, 
//    CreatedAt: 2023-01-11T17:14:34.000Z, 
//    attatchment_file: null, 
//    OffersCount: 0, 
//    owner: {fullname: test123, avatar: calm-cyan-bullfrog-tie.cyclic.app/uploads\2023-01-09T23_54_43.689Zuse_autocarsLogin.PNG}, 
//     SubCategory: {name: CMSC, Category: {cat_name: Enginnering, cat_img: calm-cyan-bullfrog-tie.cyclic.app/uploads\2023-01-09T00_28_03.624Zcat_4.png}},
//      PriceRange: {range_name: 1000 - 2500},
//     ProjStatus: {stat_name: Open}
//   }