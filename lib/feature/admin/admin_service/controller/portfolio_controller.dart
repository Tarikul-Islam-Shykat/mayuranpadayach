
import 'package:get/get.dart';

class PortfolioController extends GetxController{


  var selectSpecialist= ''.obs;

  void onSelectSpecialist(String value) {
    selectSpecialist.value = value;
  }
  List<String> specialistName = ["specialist 1","specialist 2"];
}