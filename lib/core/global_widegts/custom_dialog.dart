import 'package:flutter/material.dart';
import 'package:get/get.dart';


alertDialog({
  required String title,
  required String content,
  required VoidCallback onOk,
}){
  return Get.defaultDialog(
    title: title,
    content:  Text(content),
    actions: [
      TextButton(
        onPressed: onOk,
        child: const Text("YES"),
      ),
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text("NO"),
      ),
    ],
  );
}