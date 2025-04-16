import 'dart:convert';

import 'package:elearning/app/data/quiz/quiz.dart';
import 'package:elearning/utils/auth_helper.dart';
import 'package:elearning/utils/global_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QuizController extends GetxController {
  var quiz = <QuizModel>[].obs;
  var isLoading = false.obs;

  Future<void> postQuiz(QuizModel quiz) async {
    try {
      final response = await http.post(
        GlobalConfig.postQuizUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(quiz),
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

  Future<void> getQuizzes() async {
    try {
      final response = await http.get(GlobalConfig.getQuizUrl);
      final responseJson = jsonDecode(response.body);

      if (responseJson['success'] == true) {
        final List<dynamic> quizzes = responseJson['data'];

        // TODO: proses data ke model atau tampilkan
        quiz.value = quizzes.map((p) => QuizModel.fromJson(p)).toList();

        Get.snackbar('Success', 'Quiz list fetched successfully');
      } else {
        Get.snackbar('Error', 'Failed to fetch quizzes');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getQuizzes();
    print(quiz);
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
