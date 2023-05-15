import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sabitler {
  static const MaterialColor anaRenk = Colors.indigo;

  static const String baslikText = "Ortalama Hesapla";

  static final TextStyle baslikStyle = GoogleFonts.quicksand(
      fontSize: 24, fontWeight: FontWeight.w900, color: anaRenk);

  static final TextStyle dersSayisiStyle = GoogleFonts.quicksand(
      fontSize: 16, fontWeight: FontWeight.w500, color: anaRenk);

  static final TextStyle ortalamaStyle = GoogleFonts.quicksand(
      fontSize: 40, fontWeight: FontWeight.w800, color: anaRenk);

  static BorderRadius borderRadius = BorderRadius.circular(16);

  static const EdgeInsetsGeometry dropDownPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  static const yatayPadding8 = EdgeInsets.symmetric(horizontal: 8);
}
