class Meeting {
  final String id;
  final String title;
  final String description;
  final int order;

  Meeting({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'order': order,
  };
}
