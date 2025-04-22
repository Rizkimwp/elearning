import 'package:elearning/app/data/quiz/quiz.dart';
import 'package:flutter/material.dart';

class QuizAnswerPage extends StatefulWidget {
  final QuizModel quiz;

  const QuizAnswerPage({Key? key, required this.quiz}) : super(key: key);

  @override
  State<QuizAnswerPage> createState() => _QuizAnswerPageState();
}

class _QuizAnswerPageState extends State<QuizAnswerPage> {
  // Menyimpan jawaban user per soal
  final Map<int, String> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
        print(selectedAnswers);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kerjakan Quiz"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              widget.quiz.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...widget.quiz.questions.asMap().entries.map((entry) {
              final index = entry.key;
              final question = entry.value;
              final selected = selectedAnswers[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pertanyaan ${index + 1}: ${question.questionText}',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        ...question.options.map((opt) {
                          final isSelected = opt == selected;
                          return RadioListTile<String>(
                            value: opt,
                            groupValue: selected,
                            onChanged: (value) {
                              setState(() {
                                selectedAnswers[index] = value!;
                              });
                            },
                            title: Text(opt),
                            activeColor: Colors.blue,
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Misalnya kirim atau proses hasil quiz
                print("Jawaban user: $selectedAnswers");

                // Navigasi ke hasil atau apapun
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Quiz disubmit")),
                );
              },
              child: Text("Kirim Jawaban"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
