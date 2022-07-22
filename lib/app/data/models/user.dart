class Usermodel {
  String id;
  String? uid;
  final String? uname;
  final String? email;
  final String? image;

  Usermodel({this.uid, this.uname, this.email, this.image, this.id = ""});

  Map<String, dynamic> toJson() => {
        "id" : id,
        "uid": uid,
        "user_name": uname,
        "email": email,
        "image": image,
      };

  static Usermodel fromJson(Map<String, dynamic> json) => Usermodel(
        id: json["id"],  
        uid: json["uid"],
        uname: json["user_name"],
        email: json["email"],
        image: json["image"],  
      );
}
