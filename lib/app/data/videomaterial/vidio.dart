import 'package:elearning/app/data/meeting/meeting.dart';

class VidioPost {
  final String title;
  final String? file;
  final String meetingId;
  final String uploadById;

  VidioPost({
    required this.title,
    this.file,
    required this.meetingId,
    required this.uploadById,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'file': file,
      'meetingId': meetingId,
      'uploadById': uploadById,
    };
  }
}

class Vidio {
  final String? id;
  final String title;
  final String? videoUrl;
  final Meeting? meeting;

  Vidio({required this.title, this.videoUrl, required this.meeting, this.id});

  factory Vidio.fromJson(Map<String, dynamic> json) {
    return Vidio(
      id: json['id'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      title: json['title'] ?? '',
      meeting:
          json['meeting'] != null ? Meeting.fromJson(json['meeting']) : null,
    );
  }
}
