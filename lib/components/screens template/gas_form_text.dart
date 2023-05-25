import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rex/components/utilities/constants.dart';

class GasFormText extends StatelessWidget {
  const GasFormText({
    Key? key,
    required this.enabled,
    this.onChanged,
    this.controller,
    required this.margin,
    required this.text,
  }) : super(key: key);

  final bool enabled;
  final dynamic margin;
  final String text;
  final controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          textStyle: kGasFormStylePoppins,
        ),
      ),
    );
  }
}
