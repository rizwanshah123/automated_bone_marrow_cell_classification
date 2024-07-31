import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget customButton(String title, VoidCallback callback) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      alignment: Alignment.center,
      width: 95.w,
      height: 6.h,
      decoration: BoxDecoration(
        color: const Color(0xff184C9A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 1,
            color: Colors.white),
      ),
    ),
  );
}
