import 'package:elearning/app/data/diskusi/diskusi.dart';

class DiskusiReplyPost {
  final String message;
  final String discussionId;
  final String createdById;

  DiskusiReplyPost({
    required this.message,
    required this.discussionId,
    required this.createdById,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'discussionId': discussionId,
      'createdById': createdById,
    };
  }
}

class DiskusiReply {
  final String id;
  final String message;
  final String? createdAt;
  final CreateBy? createBy; // Nullable if it can be null

  DiskusiReply({
    required this.id,
    required this.message,
    this.createdAt,
    this.createBy, // Nullable constructor parameter
  });

  factory DiskusiReply.fromJson(Map<String, dynamic> json) {
    return DiskusiReply(
      id: json['id'] ?? '', // If 'id' is not available, fallback to an empty string
      message: json['message'] ?? '', // Same for 'message'
      createdAt: json['createdAt'], // It's already nullable, no need for `?? ''`
      createBy: json['create_by'] != null 
          ? CreateBy.fromJson(json['create_by']) 
          : null, // If 'create_by' is not present, assign null
    );
  }
}


class CreateBy {
  final String id;
  final String nama;

  CreateBy({required this.id, required this.nama});

  factory CreateBy.fromJson(Map<String, dynamic> json) {
    return CreateBy(id: json['id'] ?? '', nama: json['nama'] ?? '');
  }
}
