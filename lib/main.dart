

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/Home.dart';
import 'package:tasks_app/home_user.dart';
import 'package:tasks_app/login.dart';
import 'package:tasks_app/user.dart';


Future<void >main()async{
   WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('email');
      var mdp= prefs.getString('mdp');
      User user=new User(email, mdp, null);
     // print(email+" "+mdp);

 var app=MaterialApp(
   debugShowCheckedModeBanner: false,
 
home: email == null ? Home() : Home_user(user),
);
runApp(app);




}
