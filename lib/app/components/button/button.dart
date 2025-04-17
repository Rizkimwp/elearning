import 'package:flutter/material.dart';

ButtonStyle buildButtonStyle({
  Color? backgroundColor,
  LinearGradient? gradient,
 bool? isLoading,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: gradient == null ? backgroundColor : null,
    surfaceTintColor: gradient == null ? null : Colors.transparent,
    minimumSize: Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.2),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );
}