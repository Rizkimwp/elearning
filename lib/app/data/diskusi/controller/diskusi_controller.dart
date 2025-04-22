import 'dart:convert';

import 'package:elearning/app/data/diskusi/diskusi.dart';
import 'package:elearning/utils/global_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DiskusiController extends GetxController {
  var diskusi = <Discussion>[].obs;
  var isLoading = false.obs;
  late IO.Socket socket;
  @override
  void onInit() {
    super.onInit();
    fetchDiskusi();
    initSocket();
  }

  Future<void> refreshData() async {
    // Simulasi proses data baru (misalnya dari API)
    await Future.delayed(Duration(seconds: 2));

    fetchDiskusi();
  }

  void initSocket() {
    socket = IO.io(GlobalConfig.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print('WebSocket connected');
    });
    socket.on('new_comment', (data) {
      try {
        // Try to find the discussion by ID
        final discussion = diskusi.firstWhere(
          (disk) => disk.id == data['discussionId'],
          orElse: () {
            throw Exception(
              'Discussion with ID ${data['discussionId']} not found',
            );
          },
        );
        // Create a new reply based on incoming data
        final reply = DiscussionReply(
          id: data['id'],
          message: data['message'],
          createdAt: DateTime.parse(data['createdAt']),
          createBy: User(
            id: data['create_by']['id'],
            nama: data['create_by']['nama'],
          ),
        );

        // Add the new reply to the discussion's replies
        discussion.discussionReplies.add(reply);
        // Since `discussion.discussionReplies` is an RxList, it will update the UI automatically
        update(); // Update UI to reflect changes
      } catch (e) {
        print('Error saat menambah komentar: $e');
      }
    });

    socket.onDisconnect((_) => print('WebSocket disconnected'));
  }

  Future<void> fetchDiskusi() async {
    isLoading.value = true;
    try {
      final response = await http.get(GlobalConfig.getDiskusiUrl);
      final responseJson = jsonDecode(response.body);

      if (responseJson['success'] == true) {
        List<dynamic> data = responseJson['data']; // Mengakses array 'data'
        diskusi.value = data.map((post) => Discussion.fromJson(post)).toList();
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

  Future<void> postDiskusi(DiskusiPost diskusi) async {
    try {
      final response = await http.post(
        GlobalConfig.postDiskusiUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(diskusi),
      );

      final responseJson = jsonDecode(response.body);

      if (responseJson['success'] == true) {
        fetchDiskusi();
        // Jika response success == true, ambil data baru dan perbarui tampilan
        Get.snackbar('Success', 'Post added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add post');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  RxList<DiscussionReply> getRepliesByDiskusiId(String id) {
    return diskusi.firstWhere((d) => d.id == id).discussionReplies;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    socket.dispose();
    super.onClose();
  }
}
