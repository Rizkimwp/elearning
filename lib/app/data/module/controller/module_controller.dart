import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Untuk menentukan jenis MIME file
import 'package:get/get.dart'; // Untuk JSON encoding dan decoding
import 'package:elearning/app/data/module/module.dart';
import 'package:elearning/utils/auth_helper.dart';
import 'package:elearning/utils/global_config.dart';

class ModuleController extends GetxController {
  var modul = <Module>[].obs;
  var isLoading = false.obs;

  Future<void> refreshData() async {
    // Simulasi proses data baru (misalnya dari API)
    await Future.delayed(Duration(seconds: 2));
    fetchModule();
  }

  Future<void> fetchModule() async {
    isLoading.value = true;
    try {
      final response = await http.get(GlobalConfig.getModuleUrl);
      final responseJson = jsonDecode(response.body);

      if (responseJson['success'] == true) {
        List<dynamic> data = responseJson['data']; // Mengakses array 'data'
       modul.value = data.map((post) => Module.fromJson(post)).toList();
      print('cek: $data');
      } else {
        Get.snackbar('Error', 'Failed to load posts');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPost(ModulePost modul) async {
    try {
      // Buat multipart request
      var uri = GlobalConfig.postModuleUrl;
      var request =
          http.MultipartRequest('POST', uri)
            ..fields['title'] = modul.title
            ..fields['content'] = modul.content
            ..fields['meetingId'] = modul.meetingId
            ..fields['create_by'] = AuthHelper.userId;

      // Pastikan file tidak null dan menggunakan MultipartFile
      if (modul.file != null) {
        var file = File(modul.file!); // Pastikan file adalah path yang valid
        var fileBytes = await file.readAsBytes();
        var multipartFile = http.MultipartFile.fromBytes(
          'file', // Nama parameter form data untuk file
          fileBytes,
          filename: file.uri.pathSegments.last,
          contentType: MediaType(
            'application',
            'octet-stream',
          ), // Bisa ganti sesuai dengan tipe file
        );
        request.files.add(multipartFile);
      }
      // Kirim request
      var response = await request.send();

      // Periksa status code
      if (response.statusCode == 201) {
        final responseJson = await response.stream.bytesToString();
        final data = jsonDecode(responseJson);
        if (data['success'] == true) {
          fetchModule();
          // Jika response success == true
          Get.snackbar('Success', 'Post added successfully');
        } else {
          Get.snackbar('Error', 'Failed to add post');
        }
      } else {
        Get.snackbar('Error', 'Failed to add post');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchModule();
    print('modul : $modul');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
