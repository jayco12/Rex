import 'package:flutter/material.dart';
import 'package:rex/components/utilities/rex_colors.dart';

const kGasFormStylePoppins = TextStyle(
  fontFamily: 'fonts/Poppins-SemiBold.ttf',
  fontWeight: FontWeight.w500,
  color: RexColors.orderTextColor,
  fontSize: 20.0,
);

const kFormStyleRoboto = TextStyle(
  fontFamily: 'fonts/Roboto-Regular.ttf',
  fontWeight: FontWeight.w500,
  color: Color.fromARGB(255, 11, 11, 11),
  fontSize: 15.0,
);

const kHeadings = TextStyle(
  fontFamily: 'fonts/Poppins-Bold.ttf',
  fontWeight: FontWeight.bold,
  color: RexColors.textColor,
  fontSize: 20.0,
);

const kSubHeadings = TextStyle(
  fontFamily: 'fonts/Poppins-Regular.ttf',
  fontWeight: FontWeight.w400,
  color: RexColors.sauvegarder,
  fontSize: 16.0,
);

const kLeadText = TextStyle(
  fontFamily: 'fonts/Poppins-Medium.ttf',
  fontWeight: FontWeight.w500,
  color: RexColors.textColor,
  fontSize: 29.0,
);

const kActualContact = TextStyle(
  fontFamily: 'fonts/Poppins-Medium.ttf',
  fontWeight: FontWeight.w500,
  color: RexColors.orderColorShadow,
  fontSize: 16.0,
);

const kCart0 = TextStyle(
  fontFamily: 'fonts/Poppins-Bold.ttf',
  fontWeight: FontWeight.bold,
  color: RexColors.orderColorShadow,
  fontSize: 19.0,
);

const kCart1 = TextStyle(
  fontFamily: 'fonts/Poppins-Regular.ttf',
  fontWeight: FontWeight.w400,
  color: RexColors.orderColorShadow,
  fontSize: 16.0,
);

const kCart2 = TextStyle(
  fontFamily: 'fonts/Poppins-Regular.ttf',
  fontWeight: FontWeight.w400,
  color: RexColors.orderTextColor,
  fontSize: 11.0,
);

const kCart3 = TextStyle(
  fontFamily: 'fonts/Poppins-Medium.ttf',
  fontWeight: FontWeight.w400,
  color: RexColors.textColor,
  fontSize: 9.0,
);

const kCart4 = TextStyle(
  fontFamily: 'fonts/Poppins-SemiBold.ttf',
  fontWeight: FontWeight.bold,
  color: RexColors.orderTextColor,
  fontSize: 16.0,
);

const kInformationUtilisateur = TextStyle(
  fontFamily: 'fonts/Poppins-Medium.ttf',
  fontWeight: FontWeight.w600,
  color: RexColors.textColor,
  fontSize: 24.0,
);

const kUserInfoHolder = TextStyle(
  fontFamily: 'fonts/Poppins-Regular.ttf',
  fontWeight: FontWeight.w400,
  color: RexColors.sauvegarder,
  fontSize: 11.0,
);

const kUserInfoText = TextStyle(
  fontFamily: 'fonts/Poppins-Regular.ttf',
  fontWeight: FontWeight.w200,
  color: RexColors.sauvegarder,
  fontSize: 11.0,
);

const kButton = TextStyle(
  fontFamily: 'fonts/Poppins-Regular.ttf',
  fontWeight: FontWeight.w500,
  color: RexColors.pageColor,
  fontSize: 8.0,
);

const kBusinesses = TextStyle(
  fontFamily: 'fonts/Poppins-SemiBold.ttf',
  fontWeight: FontWeight.bold,
  color: RexColors.textColor,
  fontSize: 14.0,
);

const kChoiceText = TextStyle(
  fontFamily: 'fonts/Poppins-Regular.ttf',
  fontSize: 20.0,
);

const kSalonFormStylePoppins = TextStyle(
  fontFamily: 'fonts/Poppins-Regular.ttf',
  fontWeight: FontWeight.w500,
  color: RexColors.orderTextColor,
  fontSize: 10.0,
);

final kGasFormDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: RexColors.orderColorShadow.withOpacity(0.16),
      offset: Offset.infinite,
      blurRadius: 4.0,
      blurStyle: BlurStyle.outer,
    ),
  ],
  backgroundBlendMode: BlendMode.darken,
  color: RexColors.orderColor,
  borderRadius: const BorderRadius.all(
    Radius.circular(20),
  ),
);
