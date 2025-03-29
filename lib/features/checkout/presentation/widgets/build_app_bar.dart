import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shop_app/core/utils/app_styles.dart';

AppBar buildAppBar({required String text}) {
  return AppBar(
    leading: MaterialButton(
      onPressed: () {
    
      },
      child: Center(
          child: SvgPicture.asset(
        "assets/images/Arrow 1.svg ",
        height: 24,
      )),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Text(
      text,
      style: AppStyles.medium25,
    ),
    centerTitle: true,
  );
}
