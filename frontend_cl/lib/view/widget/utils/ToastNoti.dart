import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void errorToast(String message, String? subMessage) {
  toastification.show(
    title: Text(message),
    style: ToastificationStyle.flat,
    type: ToastificationType.error,
    description: Text(subMessage!),
    autoCloseDuration: const Duration(seconds: 3),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    showProgressBar: false,
    icon: const Icon(Icons.error),
  );
}

void successToast(String message) {
  toastification.show(
    title: Text(message),
    style: ToastificationStyle.flat,
    type: ToastificationType.success,
    autoCloseDuration: const Duration(seconds: 3),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    showProgressBar: false,
    icon: const Icon(Icons.check_circle_outline),
  );
}
