

import 'dart:convert';

import 'package:elearning/app/data/diskusireply/diskusi_reply.dart';
import 'package:elearning/utils/global_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
class DiskusiReplyController extends GetxController{
  var isLoading = false.obs;
  

  @override
  void onInit() {
    super.onInit();
   
  }

 
  Future<void> postReply(DiskusiReplyPost diskusi) async {
    try {
      final response = await http.post(
        GlobalConfig.postDiskusiReplyUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(diskusi),
      );

      final responseJson = jsonDecode(response.body);

      if (responseJson['success'] == true) {
      
        // Jika response success == true, ambil data baru dan perbarui tampilan
        Get.snackbar('Success', 'Post added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add post');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
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