import 'package:flutter/material.dart';

import '../helper/constant.dart';

class ErrorFieldRequired extends StatelessWidget {
  const ErrorFieldRequired({Key? key,
    this.paddingTop = 2,
    this.paddingBottom = 0,
    this.paddingLeft = 1,
    this.message,
  }) : super(key: key);

  final double paddingLeft;
  final double paddingBottom;
  final double paddingTop;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: paddingLeft, top: paddingTop, bottom: paddingBottom),
      child: Text(
        message ?? 'This Field Required',
        style: const TextStyle(
          color: MyColors.errorColor,
          fontSize: MyFontSize.medium,
        ),
      ),
    );
  }
}
