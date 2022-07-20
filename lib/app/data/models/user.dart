class Usermodel{
  String? uid;
  final String? uname;
  final String? email;
  final String? image;

  Usermodel({this.uid,this.uname,this.email,this.image});


  Map<String, dynamic> toJson() =>{
    "uid" : uid,
    "user_name" : uname,
    "email" : email,
    "image" : image,

  };

  static Usermodel fromJson(Map<String, dynamic> json) => Usermodel(
    uid: json["uid"],
    uname: json["user_name"],
    email: json["email"],
    image: json["image"],

  ) ;
 
}