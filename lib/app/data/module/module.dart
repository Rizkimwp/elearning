import 'dart:convert';

import 'package:elearning/app/data/meeting/meeting.dart';

class Module {
  final String? id;
  final String title;
  final String content;
  final String? file;
  final Meeting? meeting;

  Module({
    this.id,
    required this.title,
    required this.content,
    this.file,
    this.meeting,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      file: json['fileUrl'],
      meeting:
          json['meeting'] != null ? Meeting.fromJson(json['meeting']) : null,
    );
  }
}

class ModulePost {
  final String title;
  final String content;
  final String meetingId;
  final String createBy;
  final String? file;

  ModulePost({
    required this.title,
    required this.content,
    required this.meetingId,
    required this.createBy,
    this.file,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'meetingId': meetingId,
      'create_by': createBy,
      'file': file,
    };
  }
}
