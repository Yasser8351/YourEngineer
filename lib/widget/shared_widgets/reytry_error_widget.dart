import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../app_config/app_config.dart';

class ReyTryErrorWidget extends StatelessWidget {
  const ReyTryErrorWidget({
    Key? key,
    required this.title,
    this.onTap,
    this.isClear = false,
    this.hiderButtonTryAgent = false,
  }) : super(key: key);
  final String title;
  final Function()? onTap;
  final bool isClear;
  final bool hiderButtonTryAgent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 222,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          height: 222,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 40),
              hiderButtonTryAgent
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: size.width * .45,
                        height: size.height * .06,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              AppConfig.tryAgain.tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
