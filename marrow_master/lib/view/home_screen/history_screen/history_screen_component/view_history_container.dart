import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget viewHistoryContainer({
  required IconData icon,
  required String text,
  required String img,
  required String description,
  required String time,
  required BuildContext context,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
    width: 98.w,
    decoration: BoxDecoration(
        color: const Color.fromARGB(255, 252, 243, 243),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, //New
            blurRadius: 2.0,
          )
        ],
        border: Border.all(color: Colors.black.withOpacity(.2)),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        SizedBox(height: .5.h),
        Row(
          children: [
            SizedBox(width: 1.w),
            Container(
                height: 4.h,
                width: 10.w,
                decoration: BoxDecoration(
                    color: const Color(0xff184C9A),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, size: 25, color: Colors.white)),
            SizedBox(
              width: 2.w,
            ),
            Text(
              time,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.bar_chart_rounded,
                size: 30, color: Color(0xff184C9A))
          ],
        ),
        const Divider(),
        Container(
          width: 98.w,
          padding: EdgeInsets.only(right: 3.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.9.h,
                width: 35.w,
                child: Image.network(img, fit: BoxFit.fill),
              ),
              SizedBox(width: 1.w),
              Flexible(
                child: Text(
                  description,
                  softWrap: true,
                  maxLines: 6,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        // Text(time),
      ],
    ),
  );
}
