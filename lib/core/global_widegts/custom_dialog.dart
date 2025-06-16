import 'package:flutter/material.dart';
import 'package:get/get.dart';


deleteDialog({
  required String title,
  required String content,
  required VoidCallback onOk,
}){
  return Get.defaultDialog(
    title: title,
    content:  Text(content),
    actions: [
      TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.green),
        ),
        onPressed: onOk,
        child: const Text("YES",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
      ),
      TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.red),),
        onPressed: () {
          Get.back();
        },
        child: const Text("NO",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
      ),
    ],
  );
}