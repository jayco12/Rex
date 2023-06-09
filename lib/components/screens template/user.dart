import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rex/components/utilities/rex_colors.dart';
import '../utilities/constants.dart';

class User extends StatelessWidget {
  const User({Key? key, required this.image, required this.placeholder, this.onTap})
      : super(key: key);

  final String? placeholder;
  final String image;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37.0,
      margin: const EdgeInsets.only(left: 34.0, right: 33.0),
      child: CupertinoTextField(
        onTap: onTap,
        prefix: Container(
          margin: const EdgeInsets.only(left: 14.9, right: 16.27),
          child: ImageIcon(
            AssetImage(image),
            color: RexColors.sauvegarder,
          ),
        ),
        placeholder: placeholder,
        placeholderStyle: GoogleFonts.poppins(
          textStyle: kUserInfoHolder,
        ),
        style: GoogleFonts.poppins(
          textStyle: kUserInfoText,
        ),
        decoration: const BoxDecoration(
          color: RexColors.orderColor,
        ),
      ),
    );
  }
}
