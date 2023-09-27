import 'package:flutter/material.dart';
import 'package:flutter_movies/resources/components/roun_button.dart';

import '../colors/app_colors.dart';

class InternetExceptionWidget extends StatelessWidget {
  final VoidCallback onPress;

  InternetExceptionWidget({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    //
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.015,
        ),
        const Icon(
          Icons.cloud_off,
          size: 50,
          color: AppColor.redColor,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Text(
            'Lost somewhere\n\nTry again',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.black, fontSize: 30),
          ),
        ),
        SizedBox(
          height: height * 0.15,
        ),
        RoundButton(
          onPress: onPress,
          height: 50,
          width: 150,
          title: "Retry",
        ),
      ],
    );
  }
}
