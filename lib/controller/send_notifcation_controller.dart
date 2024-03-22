import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendNotifcationController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController notsController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool showMyName = true;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    notsController.dispose();
  }
/*
  addNotificationToServer({
    required String text,
    required String description,
    required String phoneNumber,
  }) async {
  UserNotificationsServices notificationServices = UserNotificationsServices();
    // changeLoadingState(LoadingState.loading);
    AuthController authController = Get.find();

    try {
      await notificationServices
          .addNotificationToServer(
              files: authController.ImageProfile,
              text: text,
              description: description,
              phoneNumber: phoneNumber)
          .timeout(Duration(seconds: ApiUrl.timeLimit));
      // changeLoadingState(LoadingState.loaded,
      //     key: "get Data", value: listNotifications.length.toString());
    } catch (error) {
      // HandlingCatchError(
      //   error: error,
      //   changeLoadingState: () => changeLoadingState(LoadingState.error),
      //   errorMessageUpdate: (message) => errorMessageUpdate(message),
      // );
    }
  }
  */

  Future<bool> callOnFcmApiSendPushNotifications(
      {required String topic,
      required String title,
      String image = "",
      required String body}) async {
    // List<dynamic> tokens = await pushNotificationsManager.getTokens(receivers);

    log("callOnFcmApiSendPushNotifications");
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      // "to": "/topics/2a0997d3-936d-40a0-b4aa-6a5671b34306",
      "to": "/topics/$topic",
      "notification": {
        "title": title,
        "body": body,
        "sound": "default",
        "image": image,
        // "registration_ids" : tokens,
        // "event_time":
        //     Timestamp.fromDate(dtTomorrow).millisecondsSinceEpoch.toString(),
        // "https://sar-i1.fnp.com/images/pr/l/beauty-of-love-roses-bouquet_1.jpg",
      },
      "data": {
        "id": '28',
        "screen": "",
        // "type": '0rder',
        // "click_action": 'FLUTTER_NOTIFICATION_CLICK',
        // "title": title,
        // "body": body,
        // "scheduledTime": "2023-08-31 14:32:00"
        // "event_time": Timestamp.fromDate(dtTomorrow).millisecondsSinceEpoch.toString(),
        /// 0901378989-9898
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          //'key=YOUR_SERVER_KEY'
          'key=AAAA43LZwLg:APA91bHZV8_6AqZwhvuiHPRz03muO1IXSdZ8gRUocmAD-1cOqVEMpBXivn3Kl8nPYutMtVVRFcSXNaqAmX8vGbK5VqVIv1lnL4W-CajkIDvfQXBLOUr-2jAKNNXou7oTQfcwrAxXkpSy'
    };

    Dio dio = Dio();

    try {
      // if (formKey.currentState!.validate()) {
      final response = await dio.post(
        postUrl,
        data: json.encode(data),
        options: Options(
          headers: headers,
        ),
        // encoding: Encoding.getByName('utf-8'),
      );
      if (response.statusCode == 200) {
        /// on success do sth
        // await addNotificationToServer(
        //     text: title, description: body, phoneNumber: topic);
        changeLoadingState(false);
        clearController();

        return true;
      } else {
        changeLoadingState(false);

        /// on failure do sth
        return false;
      }
    } catch (error) {
      changeLoadingState(false);

      return false;
    }
  }

  changeLoadingState(bool _isLoading) {
    isLoading = _isLoading;
    update();
  }

  changeShowMyName() {
    showMyName = !showMyName;
    update();
  }

  clearController() {
    phoneController.clear();
    notsController.clear();
  }
}
