class PostModel {
  String? name;
  String? dateTime;
  String? uId;
  String? image;
  String? postImage;
  String? text;

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    uId = json['uId'];
    image = json['image'];
    text = json['text'];
  }

  PostModel({
    this.text,
    this.name,
    this.dateTime,
    this.uId,
    this.image,
    this.postImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'name': name,
      'dateTime': dateTime,
      'uId': uId,
      'image': image,
      'postImage': postImage,
    };
  }
}
