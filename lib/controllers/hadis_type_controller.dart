import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrf/model/hadis/hadis_list.dart';

class HadisTypeController extends GetxController {
  var isLoading = true.obs;
  var hadisList = List<Hadis>.empty(growable: true).obs;

  TextEditingController hadisNameController = TextEditingController();
  TextEditingController hadisNumberController = TextEditingController();

  @override
  void onInit() {
   
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
