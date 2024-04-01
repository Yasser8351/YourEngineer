//AddReviewScreen

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/controller/fag_controller.dart';
import 'package:your_engineer/screen/notifcation_screen.dart';
import 'package:your_engineer/utilits/app_ui_helpers.dart';
import 'package:your_engineer/widget/shared_widgets/my_button.dart';
import 'package:your_engineer/widget/shared_widgets/rating_bar.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../../enum/all_enum.dart';
import '../../widget/shared_widgets/fcb_input.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key, required this.projectId});
  // final String talentId;
  final String projectId;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  var rating = 0.0;
  FaqController faqController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, AppConfig.addReview.tr),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFaildInput(
              controller: faqController.commentController,
              inputAction: TextInputAction.next,
              hint: "Comment",
              maxLines: 3,
            ),
            verticalSpaceSmall,
            // RatingBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  RatingBar(
                    sizeIcon: px25,
                    color: Colors.amber,
                    rating: rating,
                    onRatingChanged: (_rating) {
                      setState(() => rating = _rating);
                    },
                  ),
                  const SizedBox(width: 7),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: TextWidget(
                      title: rating.toString(),
                      fontSize: px20,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<FaqController>(builder: (_) {
              return MyButton(
                busy: handlingLoadinButton(faqController.loadingAddReview),
                text: AppConfig.addReview.tr,
                color: Colors.green,
                onTap: () => faqController.addReviews(
                    talentId: "widget.talentId",
                    projectId: widget.projectId,
                    starRate: rating),
              );
            }),
          ],
        ),
      ),
    );
  }
}

handlingLoadinButton(LoadingState loadingState) {
  if (loadingState == LoadingState.loading) {
    return true;
  } else {
    return false;
  }
}
