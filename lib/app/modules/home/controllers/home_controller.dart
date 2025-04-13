import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:elearning/app/data/program_studi/program_studi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isLoading = false.obs;
  var programStudiList = '';
  var assignments = [].obs;
  var username = ''.obs;
  @override
  void onInit() {
    fetchProgramStudi();
    super.onInit();
  }

  void fetchProgramStudi() {
    final box = GetStorage();
    final token = box.read('jwt_token');
    Map<String, dynamic> decoded = JwtDecoder.decode(token);
    final role = decoded['nama'];
    username.value = role;
  }
}
