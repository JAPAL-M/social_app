class PostModel{
 String? name;
 String? uid;
 String? text;
 String? datetime;
 String? Postimage;
 String? Profileimage;

 PostModel({
    this.name,
    this.uid,
    this.datetime,
    this.text,
    this.Postimage,
    this.Profileimage
 });

 PostModel.fromJson(Map<String,dynamic> json){
   name = json['name'];
   uid = json['uid'];
   text = json['text'];
   datetime = json['datetime'];
   Postimage = json['Postimage'];
   Profileimage = json['Profileimage'];
 }
 Map<String,dynamic> toMap(){
  return {
    'name' : name,
    'uid' : uid,
    'text' : text,
    'datetime' : datetime,
    'Postimage' : Postimage,
    'Profileimage' : Profileimage,
  };
}
}

