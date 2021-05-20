class User{
  int userId;
  String userName;
  String userPassword;
  User({this.userId,this.userName, this.userPassword});
  Map<String, dynamic> toMap() {
    return {
      'userid': userId,
      'username': userName,
      'userpassword': userPassword,
    };
  }
  User.fromMap(Map<String , dynamic> map){
    this.userId = map['userid'] ;
    this.userName = map['username'] ;
    this.userPassword = map['userpassword']  ;
  }
  @override
  String toString() {
    return 'User{userid: $userId, username: $userName, userpassword: $userPassword}';
  }

}