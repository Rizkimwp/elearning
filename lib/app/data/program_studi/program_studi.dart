class ProgramStudi {
  final String id;
  final String nama;

  ProgramStudi({
    required this.id,
    required this.nama,
  });

  factory ProgramStudi.fromJson(Map<String, dynamic> json) {
    return ProgramStudi(
      id: json['id'] as String,
      nama: json['nama'] as String,
    );
  }
}
