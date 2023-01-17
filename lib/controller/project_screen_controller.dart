import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:your_engineer/screen/project/add_project_screen.dart';
import '../api/api_response.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/owner_project_model.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'package:http/http.dart' as http;

class ProjectScreenController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getOwnerProject();
  }

  var loadingState = LoadingState.initial.obs;
  final _shared = SharedPrefUser();
  List<OwnerProjectModel> myProjects = [];
  ApiResponse apiResponse = ApiResponse();
  bool isloding = false;
  String message = "";
  bool get status => _status;
  bool _status = false;

  Future<ApiResponse> getOwnerProject() async {
    loadingState(LoadingState.loading);
    // isloding = true;
    // update();
    try {
      var token = await _shared.getToken();
      myLog("strtmethod", "getOwnerProject");
      // myLog("strtmethod", "getOwnerProject");
      var response = await http
          .get(
            headers: ApiUrl.getHeader(token: token),
            Uri.parse(ApiUrl.getOwnerProject),
            // options: Options(
            //   headers: ApiUrl.getHeader(token: token),
            // ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog(
        'statusCode getOwnerProject : ${response.statusCode} \n',
        'response getOwnerProject: ${response.body}',
      );

      if (response.statusCode == 200) {
        myProjects = ownerProjectModelFromJson((response.body));

        if (myProjects.isEmpty) {
          message = "no data found";
          loadingState(LoadingState.noDataFound);
        } else {
          loadingState(LoadingState.loaded);
        }
      } else if (response.statusCode == 403) {
        message = "دخول غير مصرح به";
        loadingState(LoadingState.error);

        // setApiResponseValue(AppConfig.unAutaristion, false,
        //     _listPopulerServices, LoadingState.error.obs);
      } else {
        loadingState(LoadingState.error);

        // setApiResponseValue(AppConfig.errorOoccurred, false,
        //     _listPopulerServices, LoadingState.error.obs);
      }
    } on SocketException {
      message = AppConfig.noNet;

      loadingState(LoadingState.error);
    } catch (error) {
      loadingState(LoadingState.error);
      // setApiResponseValue(error.toString(), false, _listPopulerServices,
      //     LoadingState.error.obs);
      if (error is TimeoutException) {
        message = AppConfig.timeOut;

        showseuessToast(error.toString());
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
        showseuessToast(AppConfig.unAutaristion);
      } else {
        message = AppConfig.noNet;

        showseuessToast(error.toString());
      }

      myLog("catch error getOwnerProject: ", error.toString());
    }
    return apiResponse;
  }

  goToAddProjectScreen() {
    Get.to(() => AddProjectScreen());
  }
}
