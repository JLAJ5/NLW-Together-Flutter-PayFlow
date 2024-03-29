import 'package:flutter/material.dart';
import 'package:pay_flow/shared/themes/app_colors.dart';

class DividerVerticalWidget extends StatelessWidget {
  final double height;
  const DividerVerticalWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: height,
      color: AppColors.stroke,
    );
  }
}
