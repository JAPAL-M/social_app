class UserCreate{
 String? name;
 String? email;
 String? phone;
 String? uid;
 String? cover;
 String? image;
 String? bio;
 bool? isEmailVerified;
 String? token;

 UserCreate({
    this.name,
    this.email,
    this.phone,
    this.uid,
    this.cover,
    this.image,
    this.bio,
    this.isEmailVerified,
    this.token
 });

 UserCreate.fromJson(Map<String,dynamic> json){
   email = json['email'];
   name = json['name'];
   phone = json['phone'];
   uid = json['uid'];
   cover = json['cover'];
   image = json['image'];
   bio = json['bio'];
   isEmailVerified = json['isEmailVerified'];
   token = json['token'];
 }
 Map<String,dynamic> toMap(){
  return {
    'email' : email,
    'name' : name,
    'phone' : phone,
    'uid' : uid,
    'cover' : cover,
    'image' : image,
    'bio' : bio,
    'isEmailVerified' : isEmailVerified,
    'token' : token,
  };
}
}

