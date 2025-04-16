import 'dart:convert';
import 'package:elearning/utils/auth_helper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isLoading = false.obs;
  var programStudiList = '';
  var assignments = [].obs;
  var username = ''.obs;

  void decodeToken() {
    username.value = AuthHelper.nama;
  }

  @override
  void onInit() {
    decodeToken();
    super.onInit();
  }
}
