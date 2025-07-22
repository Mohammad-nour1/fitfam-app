class FamilyMember {
  final String id;
  final String name;
  final String avatar;
  final int steps;
  final double progress;

  FamilyMember({
    required this.id,
    required this.name,
    required this.avatar,
    required this.steps,
    required this.progress,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
    id: json['id'],
    name: json['name'],
    avatar: json['avatar'],
    steps: json['steps'],
    progress: json['progress'].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar,
    'steps': steps,
    'progress': progress,
  };
}
