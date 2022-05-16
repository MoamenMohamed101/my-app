class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  dynamic password;
  bool? isEmailVerified;
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    password = json['password'];
    isEmailVerified = json['isEmailVerified'];
  }
  SocialUserModel(
      {this.email,
      this.name,
      this.phone,
      this.uId,
      this.image,
      this.bio,
      this.cover,
      this.password,
      this.isEmailVerified});
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
      'password': password,
    };
  }
}