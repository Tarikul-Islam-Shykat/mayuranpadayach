import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController{

  Rx<TextEditingController>  dateTimeController = TextEditingController().obs;
  var isPending = true.obs;
  var selectedTime = (-1).obs;

  void showPending() {
    isPending.value = true;
  }

  void showComplete() {
    isPending.value = false;
  }
}