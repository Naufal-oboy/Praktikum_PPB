import 'dart:io';

import 'package:flutter/material.dart';

Widget profileImage(
  String path, {
  required double width,
  required double height,
}) {
  return Image.file(
    File(path),
    width: width,
    height: height,
    fit: BoxFit.cover,
  );
}
