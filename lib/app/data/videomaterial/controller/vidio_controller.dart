import 'dart:convert';
import 'dart:io';

import 'package:elearning/app/data/videomaterial/vidio.dart';
import 'package:elearning/utils/global_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class VidioController extends GetxController {
  var vidio = <Vidio>[].obs;
  var isLoading = false.obs;

  Future<void> postVidio(VidioPost vidio) async {
    try {
      final uri = GlobalConfig.postVidioUrl;
      final request = http.MultipartRequest('POST', uri);

      // Tambahkan form fields
      request.fields['title'] = vidio.title;
      request.fields['meetingId'] = vidio.meetingId;
      request.fields['uploadedById'] = vidio.uploadById;

      // Tambahkan file jika ada
      if (vidio.file != null && vidio.file!.isNotEmpty) {
        final file = File(vidio.file!); // path lokal dari file
        final multipartFile = await http.MultipartFile.fromPath(
          'file',
          file.path,
          contentType: MediaType('video', 'mp4'), // ganti sesuai kebutuhan
        );
        request.files.add(multipartFile);
      }

      // Kirim request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseJson = jsonDecode(response.body);

      if (response.statusCode == 201 && responseJson['success'] == true) {
        fetchVidio(); // fungsi milikmu
        Get.snackbar('Success', 'Video berhasil diupload');
      } else {
        Get.snackbar('Error', 'Gagal mengupload video');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  Future<void> fetchVidio() async {
    isLoading.value = true;
    try {
      final response = await http.get(GlobalConfig.getVidioUrl);
      final responseJson = jsonDecode(response.body);

      if (responseJson['success'] == true) {
        List<dynamic> data = responseJson['data']; // Mengakses array 'data'
        vidio.value = data.map((post) => Vidio.fromJson(post)).toList();
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

  @override
  void onInit() {
    super.onInit();
    fetchVidio();
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
