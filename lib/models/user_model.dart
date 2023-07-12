
class UserModel {
  String? id;
  String? token;
  String? name = "";
  String? email;
  String? phone;
  String? profileImage;
  bool? isAdmin;
  UserModel({
    this.id,
    this.token,
    this.name,
    this.email,
    this.phone,
    this.profileImage,
    this.isAdmin,
  });
 UserModel fromJson(Map<String, Object> json) {
    return UserModel().fromJson(json);
  }
}
