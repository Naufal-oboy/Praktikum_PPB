import 'package:flutter/material.dart';

import 'profile_image_io.dart'
    if (dart.library.html) 'profile_image_web.dart' as platform;

Widget profileImage(
  String path, {
  required double width,
  required double height,
}) {
  return platform.profileImage(path, width: width, height: height);
}
