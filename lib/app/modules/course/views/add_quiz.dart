import 'package:elearning/app/data/meeting/meeting.dart';
import 'package:elearning/app/data/question/question.dart';
import 'package:elearning/app/data/quiz/controller/quiz_controller.dart';
import 'package:elearning/app/data/quiz/quiz.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';

class AddQuizForm extends StatefulWidget {
  final Meeting meeting;

  const AddQuizForm({Key? key, required this.meeting}) : super(key: key);

  @override
  _AddQuizFormState createState() => _AddQuizFormState();
}

class _AddQuizFormState extends State<AddQuizForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  static final quizController = Get.put<QuizController>(QuizController());
  List<QuestionItem> questions = [QuestionItem()];

  void addQuestion() {
    setState(() {
      questions.add(QuestionItem());
    });
  }

  void removeQuestion(int index) {
    setState(() {
      questions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buat Quiz"), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Judul Quiz',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (val) => val == null || val.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return QuestionForm(
                    key: UniqueKey(),
                    question: questions[index],
                    onRemove: () => removeQuestion(index),
                  );
                },
              ),
              SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: addQuestion,
                icon: Icon(Icons.add),
                label: Text("Tambah Pertanyaan"),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final quizTitle = titleController.text;
                      final quizQuestions =
                          questions.map((q) {
                            return QuizQuestion(
                              questionText: q.questionTextController.text,
                              options:
                                  q.optionsControllers
                                      .map((c) => c.text)
                                      .where((opt) => opt.trim().isNotEmpty)
                                      .toList(),
                              correctAnswer: q.correctAnswerController.text,
                            );
                          }).toList();

                      quizController.postQuiz(
                        QuizModel(
                          title: quizTitle,
                          meetingId: widget.meeting.id,
                          questions: quizQuestions,
                        ),
                      );

                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Simpan Quiz",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
