// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import '../api/api_response.dart';
// import '../app_config/api_url.dart';
// import '../debugger/my_debuger.dart';
// import '../enum/all_enum.dart';
// import '../sharedpref/user_share_pref.dart';
// import '../utilits/helper.dart';

// import 'dart:io';

// // import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:http_parser/http_parser.dart';

import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';

class AddProtofilioController extends GetxController {
  ApiResponse apiResponse = ApiResponse();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime dateOfProject = DateTime.now();
  String? day;

  final SharedPrefUser _pref = SharedPrefUser();
  bool status = false;
  var loadingState = LoadingState.initial.obs;

  //

  Future<bool> addProtofilio(
    BuildContext context,
    File? imageFile,
  ) async {
    myLog('start methode', 'addoffer');
    // myLog('projectId', projectId);

    var token = await _pref.getToken();
    // final data = {
    //   'title': titleController.text,
    //   'description': descriptionController.text,
    //   'PortfolioImg': imageFile,
    //   'urllink': '',
    // };
    //

    // FormData data = FormData.fromMap({
    //   'title': titleController.text,
    //   'description': descriptionController.text,
    //   // "PortfolioImg": "",
    //   'PortfolioImg': imageFile == null
    //       ? ""
    //       : await MultipartFile.fromFile(
    //           imageFile.path,
    //           filename: imageFile.path + ".png",
    //           // contentType: MediaType,
    //         ),
    //   'urllink': '',
    // });

    try {
      // var response = await http
      //     .post(
      //       // 'https://calm-cyan-bullfrog-tie.cyclic.app/api/v1/project',
      //       Uri.parse(ApiUrl.addprotofilio),
      //       body: data,
      //       headers: ApiUrl.getHeaderImage(token: token),
      //     )
      //     .timeout(const Duration(seconds: 20));

      String fileName = imageFile!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'title': titleController.text,
        'description': descriptionController.text,
        'urllink': '',
        "PortfolioImg": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: MediaType("image", "${imageFile.path.split(".").last}"),
        ),
      });
      Dio dio = new Dio();

      var response = await dio.post(
        ApiUrl.addprotofilio,
        data: formData,
        options: Options(
          headers: ApiUrl.getHeaderImage(token: token),
        ),
      );

      // var response = await Dio()
      //     .post(
      //       ApiUrl.addprotofilio,
      //       data: data,
      //       options: Options(
      //         headers: ApiUrl.getHeaderImage(token: token),
      //       ),
      //     )
      //     .timeout(Duration(seconds: 40));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.data}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        status = true;
      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());

        status = false;
      }
    } catch (error) {
      status = false;

      myLog('error', error);

      if (error.toString().contains('TimeoutException')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
      } else {
        Helper.showError(context: context, subtitle: 'حث خطأ في الاتصال');
      }
      myLog('catch  erroor', '$error');
    }

    return status;
  }

//
//
  void clearController() {
    titleController.clear();
    descriptionController.clear();
  }
}
