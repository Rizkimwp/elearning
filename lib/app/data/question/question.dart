import 'package:flutter/material.dart';

class QuestionItem {
  final TextEditingController questionTextController = TextEditingController();
  final List<TextEditingController> optionsControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final TextEditingController correctAnswerController = TextEditingController();
}

class QuestionForm extends StatelessWidget {
  final QuestionItem question;
  final VoidCallback onRemove;

  const QuestionForm({Key? key, required this.question, required this.onRemove})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: question.questionTextController,
              decoration: InputDecoration(labelText: 'Pertanyaan'),
              validator:
                  (val) =>
                      val == null || val.isEmpty
                          ? 'Pertanyaan wajib diisi'
                          : null,
            ),
            SizedBox(height: 8),
            Column(
              children: List.generate(question.optionsControllers.length, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextFormField(
                    controller: question.optionsControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Pilihan ${String.fromCharCode(65 + i)}',
                    ),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Opsi tidak boleh kosong'
                                : null,
                  ),
                );
              }),
            ),
            TextFormField(
              controller: question.correctAnswerController,
              decoration: InputDecoration(labelText: 'Jawaban Benar'),
              validator:
                  (val) =>
                      val == null || val.isEmpty ? 'Jawaban wajib diisi' : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onRemove,
                icon: Icon(Icons.delete_forever, color: Colors.red),
                label: Text("Hapus", style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
