import 'sub_services_model.dart';

class PopulerServicesModel {
  String titleServices;
  String imageUrlServices;
  List<SubServicesModel> listSubServices;

  PopulerServicesModel(
      {required this.titleServices,
      required this.imageUrlServices,
      required this.listSubServices});
}
