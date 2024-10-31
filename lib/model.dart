class User{
  int? _id;
  String? _question;
  String? _answer;

  User(this._question,this._answer);

  get question=>_question;
  get answer=> _answer;
  get id => _id;

  User.map(dynamic obj){
    _id=obj['id'];
    _question=obj['question'];
    _answer=obj['answer'];
  }

  Map<String,dynamic> toMap(){
    var map= Map<String,dynamic>();
      map['answer']=_answer;
      map['question']=_question;
      if(id!=null){
        map['id']=_id;
      }
      return map;
  }

  User.fromMap(Map<String,dynamic> map){
    _id=map['id'];
    _answer=map['answer'];
    _question=map['question'];
  }




}