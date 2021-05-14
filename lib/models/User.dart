class User{

  String _name;
  String _email;
  String _urlImage;
  String _uid;

  User();

  Map<String, dynamic> toMap(){
    Map<String,dynamic> map = {
      "name": this._name,
      "email": this._email,
      "urlImage": this._urlImage,
      "uid": this._uid,
    };
    return map;
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
}