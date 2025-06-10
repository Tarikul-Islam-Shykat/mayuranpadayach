import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialistController extends GetxController{

  Rx<TextEditingController> nameTEC = TextEditingController().obs;
  Rx<TextEditingController> specialistTEC = TextEditingController().obs;
  Rx<TextEditingController> specialistExperienceTEC = TextEditingController().obs;
}