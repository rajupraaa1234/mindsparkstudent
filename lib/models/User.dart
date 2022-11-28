class User{

  String username;
  String password;

  User(this.username,this.password);




  String get UserName => username;
  String get Password => password;

  set setUserName(String user){
    this.username = user;
  }

  set setPassword(String pass){
    this.password = pass;
  }

  Map<String,dynamic> toMap() {
    var map = Map<String,dynamic>();
      map['username'] = username;
      map['password'] = password;
    return map;
  }

  fromMapObject(Map<String,dynamic> map){
    this.password = map['password'];
    this.username = map['username'];
  }


}