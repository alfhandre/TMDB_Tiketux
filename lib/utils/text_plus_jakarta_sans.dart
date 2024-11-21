import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';

class JakartaSans {
  static bold({
    required text,
    required double fontSize,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(text,
        style: GoogleFonts.plusJakartaSans(
            fontSize: fontSize,
            color: color ?? black,
            fontWeight: FontWeight.w700),
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign);
  }

  static regular({
    required text,
    required double fontSize,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(text,
        style: GoogleFonts.plusJakartaSans(
            fontSize: fontSize,
            color: color ?? black,
            fontWeight: FontWeight.w500),
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign);
  }

  static light({
    required text,
    required double fontSize,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
          fontSize: fontSize,
          color: color ?? black,
          fontWeight: FontWeight.w400),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }

  static custom({
    required text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
          fontSize: fontSize, color: color, fontWeight: fontWeight),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
