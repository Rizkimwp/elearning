import 'package:elearning/app/data/meeting/meeting.dart';
import 'package:get/get.dart';

class DiskusiPost {
  final String title;
  final String content;
  final String? createById;
  final String? meetingId;

  DiskusiPost({
    required this.title,
    required this.content,
    this.meetingId,
    this.createById,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'meetingId': meetingId,
      'create_by': createById,
    };
  }
}

class Discussion {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final Meeting meeting;
  final RxList<DiscussionReply> discussionReplies;

  Discussion({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.meeting,
    List<DiscussionReply>?  discussionReplies,
  }) : discussionReplies =  discussionReplies?.obs ?? <DiscussionReply>[].obs;
  

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      meeting: Meeting.fromJson(json['meeting']),
      discussionReplies: (json['discussionReplies'] as List)
          .map((e) => DiscussionReply.fromJson(e))
          .toList(),
    );
  }
}


class DiscussionReply {
  final String id;
  final String message;
  final DateTime createdAt;
  final User createBy;

  DiscussionReply({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.createBy,
  });

  factory DiscussionReply.fromJson(Map<String, dynamic> json) {
    return DiscussionReply(
      id: json['id'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      createBy: User.fromJson(json['create_by']),
    );
  }
}

class User {
  final String id;
  final String nama;

  User({
    required this.id,
    required this.nama,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
    );
  }
}
