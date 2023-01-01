class ChatModel{
 String? text;
 String? datetime;
 String? reciverId;
 String? senderId;
 String? token;

 ChatModel({
    this.datetime,
    this.text,
    this.reciverId,
    this.senderId,
    this.token
 });

 ChatModel.fromJson(Map<String,dynamic> json){
   text = json['text'];
   datetime = json['datetime'];
   reciverId = json['reciverId'];
   senderId = json['senderId'];
   token = json['token'];
 }
 Map<String,dynamic> toMap(){
  return {
    'text' : text,
    'datetime' : datetime,
    'reciverId' : reciverId,
    'senderId' : senderId,
    'token' : token,
  };
}
}

