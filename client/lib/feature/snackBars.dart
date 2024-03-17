import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSnackBar(String message, int duration) {
  var context = Get.context!;

  final snackBar = SnackBar(
    content: Text(
      message,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.onErrorContainer),
    ),
    duration: Duration(seconds: duration),
    backgroundColor: Theme.of(context).colorScheme.errorContainer,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
