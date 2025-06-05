import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController{

  var isPending = true.obs;

  void showPending() {
    isPending.value = true;
  }

  void showComplete() {
    isPending.value = false;
  }
}