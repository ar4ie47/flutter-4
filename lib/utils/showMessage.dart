import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

void showMessage(BuildContext context, ContentType contentType, String message,
    String title) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
        content: AwesomeSnackbarContent(
            contentType: contentType, message: message, title: title),
        backgroundColor: DarkColors.background));
}
