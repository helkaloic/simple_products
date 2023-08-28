import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  static const Color blue = Colors.blue;
  static const Color green = Color(0xFF1ed860);
  static const Color lightBlue = Color(0xFF5685D0);
  static const Color deepBlack = Color(0xFF121212);
  static const Color cardGrey = Color(0xFF2a2a2a);
  static const Color cardLightGrey = Color.fromARGB(255, 74, 74, 74);
  static const Color textGrey = Color(0xFFa7a7a7);
}

class AppTheme {
  static TextStyle bigTitle = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.w900,
    color: Colors.white,
  );
  static TextStyle mediumText = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}
