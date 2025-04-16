import 'package:elearning/app/data/meeting/meeting.dart';

class QuizModel {
  final String title;
  final String? meetingId;
  final List<QuizQuestion> questions;
  final Meeting? meeting;

  QuizModel({
    required this.title,
    this.meetingId,
    required this.questions,
    this.meeting,
  });

  // Convert QuizModel from JSON
  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      title: json['title'],
      meetingId: json['meetingId'],
      questions:
          (json['questions'] as List)
              .map((q) => QuizQuestion.fromJson(q))
              .toList(),
      meeting: Meeting.fromJson(json['meeting']),
    );
  }

  // Convert QuizModel to JSON
  Map<String, dynamic> toJson() => {
    'title': title,
    'meetingId': meetingId,
    'questions': questions.map((q) => q.toJson()).toList(),
    'meeting': meeting?.toJson(),
  };
}

class QuizQuestion {
  final String? id;
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  QuizQuestion({
    this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'],
      questionText: json['questionText'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'questionText': questionText,
    'options': options,
    'correctAnswer': correctAnswer,
  };
}
