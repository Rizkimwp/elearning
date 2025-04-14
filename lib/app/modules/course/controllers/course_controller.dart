import 'dart:convert';

import 'package:elearning/app/components/hook/global_config.dart';
import 'package:elearning/app/data/meeting/meeting.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CourseController extends GetxController {
  var meeting = <Meeting>[].obs;
  var isLoading = false.obs;

  // Fetch data from API
  Future<void> fetchPosts() async {
    isLoading.value = true;
    try {
      final response = await http.get(GlobalConfig.getMeetingUrl);
      final responseJson = jsonDecode(response.body);

      if (responseJson['success'] == true) {
        List<dynamic> data = responseJson['data']; // Mengakses array 'data'
        meeting.value = data.map((post) => Meeting.fromJson(post)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load posts');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Add a new post to the API
  Future<void> addPost(String title, String description, int order) async {
    try {
      final response = await http.post(
        GlobalConfig.postMeetingUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'description': description,
          'order': order,
        }),
      );

      final responseJson = jsonDecode(response.body);

      if (responseJson['success'] == true) {
        // Jika response success == true, ambil data baru dan perbarui tampilan
        fetchPosts(); // Refresh data after adding a post
        Get.snackbar('Success', 'Post added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add post');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  // Update a post by ID
  Future<void> updatePost(
    String id,
    String title,
    String description,
    int order,
  ) async {
    try {
      final response = await http.put(
        GlobalConfig.putMeetingByIdUrl(id),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'description': description,
          'order': order,
        }),
      );

      if (response.statusCode == 200) {
        await fetchPosts(); // Refresh data after updating
        Get.snackbar('Success', 'Post updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update post');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  // Delete a post by ID
  Future<void> deletePost(String id) async {
    try {
      final response = await http.delete(GlobalConfig.deleteMeetingByIdUrl(id));

      if (response.statusCode == 200) {
        fetchPosts(); // Refresh data after deleting
        Get.snackbar('Success', 'Post deleted successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete post');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
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
