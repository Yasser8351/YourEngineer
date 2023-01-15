import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../app_config/api_url.dart';
import '../debugger/my_debuger.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'package:http/http.dart' as http;

class OfferController extends GetxController {
  TextEditingController daysController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final SharedPrefUser _pref = SharedPrefUser();
  bool status = false;

  Future<bool> addOffer(BuildContext context, String projectId) async {
    myLog('start methode', 'addoffer');
    myLog('projectId', projectId);

    var token = await _pref.getToken();
    final data = {
      'proj_id': projectId,
      'price': priceController.text,
      'days_to_deliver': daysController.text,
      'message_desc': descriptionController.text,
      'OfferAttach': '',
    };
    //

    try {
      var response = await http
          .post(
            // 'https://calm-cyan-bullfrog-tie.cyclic.app/api/v1/project',
            Uri.parse(ApiUrl.addoffer),
            body: data,
            headers: ApiUrl.getHeader(token: token),
          )
          .timeout(const Duration(seconds: 20));
      // var response = await Dio()
      //     .post(

      //       ApiUrl.addoffer,
      //       data: data,
      //       options: Options(
      //         headers: ApiUrl.getHeader(token: token),
      //       ),
      //     )
      //     .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        ''
            'response : ${response.body}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        status = true;
        // await _shared.saveToken(response.body['token']);

      } else {
        Helper.showError(
            context: context, subtitle: response.statusCode.toString());
        print("nnnnnnnnnnonnnnoooooooooooo");

        status = false;
      }
    } catch (error) {
      status = false;

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

  void clearController() {
    daysController.clear();
    descriptionController.clear();
    priceController.clear();
  }
}
