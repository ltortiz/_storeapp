class UserDataModel {
  final String id;
  final String name;
  final String email;
  final String photo;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"name": name, "email": email, "photo": photo};
  }
}
