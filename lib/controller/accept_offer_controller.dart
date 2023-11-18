import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:your_engineer/controller/offers_controller.dart';
import 'package:your_engineer/model/resp.dart';

import '../app_config/api_url.dart';
import '../debugger/my_debuger.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'package:http/http.dart' as http;

class AcceptOfferController extends GetxController {
  final SharedPrefUser _pref = SharedPrefUser();
  bool status = false;
  RxBool isLoading = false.obs;

  Future<bool> acceptOfferMyProject(
      BuildContext context, String projectId, String offerId) async {
    myLog('start methode', 'acceptOffer');
    var token = await _pref.getToken();
    final data = {
      'proj_id': projectId,
    };

    isLoading(true);
    try {
      var response = await http
          .put(
            Uri.parse(ApiUrl.acceptOffer(offerId)),
            body: data,
            headers: ApiUrl.getHeader2(token: token),
          )
          .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.body}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        OfferController controller = Get.find();
        Helper.showseuess(
            context: context,
            subtitle: responseModelFromJson(response.body.toString()).msg);

        controller.getProjectsById(projectId, 0);
        status = true;
        isLoading(false);
      } else {
        isLoading(false);

        Helper.showError(
            context: context,
            subtitle: responseModelFromJson(response.body.toString()).msg);

        status = false;
      }
    } catch (error) {
      isLoading(false);
      status = false;
      myLog('error', error);
      if (error is DioError) {
        Helper.showError(
            context: context, subtitle: error.response!.data['msg']);
      }

      if (error.toString().contains('TimeoutException')) {
        Helper.showError(context: context, subtitle: 'اتصال الانترنت ضعيف');
      } else {
        Helper.showError(context: context, subtitle: 'حث خطأ في الاتصال');
      }
      myLog('catch  erroor', '$error');
    }

    return status;
  }
}
