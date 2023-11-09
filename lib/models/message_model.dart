class  MessageModel{

  String? receiverId;
  String? senderId;
  String? dateTime;
  String? text;




  MessageModel(this.receiverId,this.senderId,this.dateTime,this.text,);

  MessageModel.fromjson(Map<String,dynamic> json){
    receiverId=json['receiverId'];
    senderId=json['senderId'];
    dateTime=json['dateTime'];
    text=json['text'];

  }

  Map<String,dynamic> toMap(){

    return{
      'receiverId':receiverId,
      'senderId':senderId,
      'dateTime':dateTime,
      'text':text,
    };

  }



}