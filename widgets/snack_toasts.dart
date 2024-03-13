

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

showSnackAtTheTop({
  String message = "",
  Color? color,
  bool isSuccess = false}){

  return showSimpleNotification(
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          softWrap: true,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ),
    duration: const Duration(seconds: 3),
    slideDismissDirection: DismissDirection.horizontal,
    background: color ?? (isSuccess ? Colors.green : Colors.pink),
  );
}