class Meeting {
  final String id;
  final String title;
  final String description;
  final int order;
  final String createdAt;
  final String updatedAt;
  final String? createdBy;

  Meeting({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      order: json['order'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      createdBy: json['createdBy'],
    );
  }
}
