import 'package:flutter/material.dart';

import '../../model/sub_services_model.dart';
import '../../widget/list_sub_services_widget.dart';
import '../../widget/shared_widgets/text_widget.dart';

class SubServicesScreen extends StatefulWidget {
  const SubServicesScreen(
      {Key? key, required this.titleServices, required this.listSubServices})
      : super(key: key);
  final String titleServices;
  final List<SubServicesModel> listSubServices;

  @override
  State<SubServicesScreen> createState() => _SubServicesScreenState();
}

class _SubServicesScreenState extends State<SubServicesScreen> {
  // List<SubServicesModel> listSubServices = [
  //   //Sketches
  //   SubServicesModel(id: 0, title: "All"),
  //   SubServicesModel(id: 1, title: "Electricity Distribution Scheme"),
  //   SubServicesModel(id: 2, title: "Pumbing Distribution Chart"),
  //   SubServicesModel(id: 3, title: "Furniture Distribution Chart"),
  //   SubServicesModel(id: 4, title: "Full Scheme"),
  // ];

  int expandeIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppBar(context, widget.titleServices),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * .01),
            // List Sub Services horizantial this list using to
            // filter main List by title Sub Services
            SizedBox(
              height: size.height,
              width: double.infinity,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                scrollDirection: Axis.horizontal,
                itemCount: widget.listSubServices.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        expandeIndex = index;
                      });
                    },
                    child: ListSubServicesWidget(
                      subServicesModel: widget.listSubServices[index],
                      colorScheme: colorScheme,
                      size: size,
                      index: index,
                      expandeIndex: expandeIndex,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getAppBar(BuildContext context, String titleServices) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child:
            TextWidget(title: titleServices, fontSize: 18, color: Colors.white),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.navigate_before, size: 40),
        color: Colors.white,
      ),
    );
  }
}
