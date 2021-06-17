class User{

  String _name;
  String _email;
  String _urlImage;
  String _uid;
  String _pushId;

  User();

  Map<String, dynamic> toMap(){
    Map<String,dynamic> map = {
      "name": this._name,
      "email": this._email,
      "urlImage": this._urlImage,
      "uid": this._uid,
      "pushId": this._pushId
    };
    return map;
  }

  User mapToUser(Map<String,dynamic> mapUser){
    User user = new User();
    user.name = mapUser["name"];
    user.email = mapUser["email"];
    user.urlImage = mapUser["urlImage"];
    user.uid = mapUser["uid"];
    user._pushId = mapUser["pushId"];
    return user;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get email => _email;

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get urlImage => _urlImage;

  set urlImage(String value) {
    _urlImage = value;
  }

  set email(String value) {
    _email = value;
  }

  String get pushId => _pushId;

  set pushId(String value) {
    _pushId = value;
  }
}