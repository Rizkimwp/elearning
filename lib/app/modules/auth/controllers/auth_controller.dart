import 'dart:convert';

import 'package:elearning/app/components/hook/global_config.dart';
import 'package:elearning/app/data/program_studi/program_studi.dart';
import 'package:elearning/app/data/semester/semester.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var obscureText = true.obs;
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var errorMessage = "".obs; // Untuk menyimpan pesan error
  var isLoading = false.obs;
  var isLoadingRegister = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login() async {
    try {
      isLoading.value = true; // Set loading menjadi true saat mulai login

      final loginBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      final res = await http.post(
        GlobalConfig.loginUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(loginBody),
      );

      final responseJson = jsonDecode(res.body);

      if (responseJson['status'] == 'success') {
        // Jika status code 200 dan status adalah success
        final token = responseJson['access_token'];

        if (token != null) {
          // Simpan token ke storage
          await GetStorage().write('jwt_token', token);

          // Navigasi ke halaman utama setelah login sukses
          Get.offNamed('/bottom-nav');
        } else {
          errorMessage.value = "Token tidak ditemukan, login gagal.";
        }
      } else {
        // Menangani jika status bukan success atau response gagal
        errorMessage.value =
            responseJson['message'] ?? "Email atau password salah";
      }
    } catch (e) {
      // Menangani kesalahan pada saat koneksi atau lainnya
      errorMessage.value = "Terjadi kesalahan: $e";
    } finally {
      // Mengubah status loading menjadi false setelah login selesai
      isLoading.value = false;
    }
  }

  // Fungsi untuk submit form registrasi dan login
  Future<void> submitForm() async {
    try {
      isLoadingRegister.value = true;
      final body = {
        "nama": namaController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "role": 'siswa',
      };

      // 1. Registrasi Pengguna
      final res = await http.post(
        GlobalConfig.registerUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (res.statusCode == 201 || res.statusCode == 200) {
        Get.snackbar("Sukses", "Registrasi Berhasil");
        Future.delayed(Duration(milliseconds: 100), () {
          login();
        });
      } else {
        // Menangani jika registrasi gagal
        final errorResponse = jsonDecode(res.body);
        Get.snackbar(
          "Gagal",
          errorResponse['message'] ?? "Terjadi kesalahan saat registrasi",
        );
      }
    } catch (e) {
      // Menangani error lain yang mungkin terjadi
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      // Mengubah status loading menjadi false setelah login selesai
      isLoadingRegister.value = false;
    }
  }

  @override
  void onClose() {
    // Pastikan untuk membersihkan controller ketika tidak digunakan
    passwordController.dispose();
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
