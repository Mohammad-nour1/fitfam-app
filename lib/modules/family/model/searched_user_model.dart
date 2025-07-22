class SearchedUserModel {
  final int id;
  final String name;
  final String email;

  SearchedUserModel(
      {required this.id, required this.name, required this.email});

  factory SearchedUserModel.fromJson(Map<String, dynamic> json) {
    return SearchedUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

