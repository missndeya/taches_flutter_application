//import 'package:file/file.dart';

class User
{
  String username;
  String password;
  String imageUser ;
  
  User(this.username,this.password,this.imageUser);
 
  Map<String,dynamic> toMap() 
  {
    Map<String,dynamic> map =Map<String,dynamic>();
    map["username"]=username;
    map["password"]=password;
    map["imageUser"]=imageUser;
    
    return map;
    
  }  
  User.fromMap(dynamic obj)
  {
      username=obj[username];
      password=obj[password];
      imageUser=obj[imageUser];
  }

}