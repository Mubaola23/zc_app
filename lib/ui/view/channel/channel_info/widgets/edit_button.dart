import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zurichat/constants/app_strings.dart';
import 'package:zurichat/ui/shared/text_styles.dart';

import '../channel_info_view_model.dart';

class EditButton extends StatelessWidget {
  final ChannelInfoViewModel model;
  const EditButton({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 48,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      //margin: const EdgeInsets.only(right: 5, left: 5, bottom: 15),
      /*decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(width: 1.0, color: AppColors.borderColor)),*/
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          Edit,
          style: AppTextStyle.darkGreySize16Bold,
        ),
      ),
    );
  }
}
