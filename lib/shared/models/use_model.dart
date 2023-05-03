class UserModel {
  String? email;
  String? name;
  String? photoUrl;

  UserModel({this.name, this.email, this.photoUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    photoUrl = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['profilePic'] = photoUrl;
    return data;
  }
}