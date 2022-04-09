class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  dynamic password;
  bool? isEmailVerified;
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    password = json['password'];
    isEmailVerified = json['isEmailVerified'];
  }
  SocialUserModel(
      {this.email,
      this.name,
      this.phone,
      this.uId,
      this.password,
      this.isEmailVerified});
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'password': password,
    };
  }
}