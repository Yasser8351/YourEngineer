import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/utilits/helper.dart';

import '../app_config/api_url.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/notification_model/all_notification_model.dart';
import '../sharedpref/user_share_pref.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  final SharedPrefUser _pref = SharedPrefUser();
  var loadingState = LoadingState.initial.obs;

  List<Result> results = [];

  int unreadCount = 0;
  String imggProfile = '';

  Future<void> getAllNotification() async {
    loadingState(LoadingState.loading);

    try {
      var token = await _pref.getToken();

      myLog("start methode", "getAllNotification");

      var response = await Dio()
          .get(
            ApiUrl.getAllNotification(1, 25),
            options: Options(
              headers: ApiUrl.getHeader2(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("response.statusCode methode", "${response.statusCode}");

      if (response.statusCode == 200) {
        final allNotificationModel =
            AllNotificationModel.fromJson(response.data);

        results = allNotificationModel.results;
        loadingState(LoadingState.loaded);

        update();
      } else {
        loadingState(LoadingState.error);
      }
    } catch (error) {
      loadingState(LoadingState.error);
      if (error is DioError) {
        showseuessToast(error.response!.data['msg']);
        // Get.defaultDialog(title: AppConfig.timeOut.tr);
      }
      if (error is TimeoutException) {
        showseuessToast(AppConfig.timeOut.tr);
        // Get.defaultDialog(title: AppConfig.timeOut.tr);
      }
      if (error is SocketException) {
        // Get.defaultDialog(title: AppConfig.failedInternet.tr);
        showseuessToast(AppConfig.failedInternet.tr);
      } else {
        // Get.defaultDialog(title: AppConfig.errorOoccurred.tr);

        showseuessToast(AppConfig.errorOoccurred.tr);
      }

      myLog("catch getAllNotification", error.toString());
    }
  }

  Future<void> getNotificationUnRead() async {
    try {
      var token = await _pref.getToken();

      myLog("start methode", "getNotificationUnRead");

      var response = await Dio()
          .post(
            ApiUrl.getNotificationUnRead,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      // final notificationUnReadModel =
      //     notificationUnReadModelFromJson(response.data);

      myLog("response.statusCode methode", "${response.statusCode}");
      myLog("response.Data methode", "${response.data}");

      if (response.statusCode == 200) {
        Map<String, dynamic> map = response.data;
        unreadCount = map['unreadCount'] ?? 0;
        imggProfile = map['imgPath'] ?? '';

        // unreadCount = notificationUnReadModel.unreadCount;
        myLog("unreadCount", "${unreadCount}");

        update();
      } else {}
    } catch (error) {
      myLog("catch Notifcation", error.toString());
    }
  }

  Future<void> readNotification(String notificationId) async {
    var token = await _pref.getToken();

    try {
      var response = await http
          .put(
            Uri.parse(ApiUrl.readNotification(notificationId)),
            // '61a7d5de-e6ef-4677-932f-88177c43a934')),
            headers: ApiUrl.getHeader(token: token),
          )
          .timeout(const Duration(seconds: 20));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.body}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        getNotificationUnRead();
      }
    } catch (error) {}
  }
}
