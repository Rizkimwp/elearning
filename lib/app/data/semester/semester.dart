class Semester {
  final String id;
  final String tahun_ajaran;
  final String start_at;
  final String end_at;

  Semester({
    required this.id,
    required this.tahun_ajaran,
    required this.start_at,
    required this.end_at,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      id: json['id'] as String,
      tahun_ajaran: json['tahun_ajaran'] as String,
      start_at: json['start_at'] as String,
      end_at: json['end_at'] as String,
    );
  }
}
