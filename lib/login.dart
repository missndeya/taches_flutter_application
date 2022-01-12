import 'package:flutter/material.dart';
import 'package:tasks_app/home_user.dart';
import 'package:tasks_app/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'database.dart';
class Login extends StatelessWidget {
  String username,password;
   final _final = new GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    double mediaw;
    double mediah;
    mediaw = MediaQuery.of(context).size.width;
    mediah = MediaQuery.of(context).size.height;
     return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(title: Text("Login"),
      //backgroundColor: Colors.blueAccent,
      centerTitle: true,)
      ,


      body: 
      Form(
        key: _final,
        child:ListView(
          children: <Widget>[
          Center(
            
            child:Container(
              margin: EdgeInsets.only(top: 20),
              width: 100,
              height: 100,
            child:Material(
            
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
            //child: Image.asset("image_asset/user.jpg",width: 30,height: 20)
            child:Icon(Icons.person,size: 80,)
            )
            ),
          ),
          Container(
              width: 100,
              margin: EdgeInsets.all(30),
         child: TextFormField(
           
            decoration: InputDecoration(
               fillColor: Colors.white,
                filled: true,
             hintText: " Give your Username"
            ),
            
            onChanged: (value){
              username = value ;
              
            },
          validator: (value){
                return value.length<5? " username trop court": null ;
              },
          
            
          ),
 ),

             Container(
              width: 100,
            margin: EdgeInsets.only(right:30,left: 30,bottom: 30),
         child: TextFormField(
            decoration: InputDecoration(
               fillColor: Colors.white,

                filled: true,
             hintText: "Give your Password"
            ),
            onChanged: (value){
             password = value ;
            },
              keyboardType: TextInputType.number,
            validator: (value){
                return value.length<5? " password trop court": null ;
              },
            
            obscureText: true,
            
          ),
             ),
      
       Container(
  width: 100,
  margin: EdgeInsets.only(left: 90,right: 90),
            child:RaisedButton(
              color:Colors.greenAccent, 
              textColor: Colors.blueGrey,
              child: Text("Valider",style: TextStyle(fontSize: 21,color: Colors.blueGrey),),
          
          onPressed: () async {
                 if( _final.currentState.validate()==true) 
               {
         var dbhelper=DatabaseHelper();
         User pers =new User(username, password,null);
         var user= await dbhelper.selectUser(username,password);
         if(user!=null)
         {
           SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', username);
            prefs.setString('mdp', password);


           print("user in DB...OK!!!  ");
            Navigator.pushReplacement(context, 
           MaterialPageRoute(
            builder:(context)=>Home_user(pers)));
         
         }

            else {print("this user is not found");}
           
          }
          }
           //color: Colors.greenAccent,
        ),
       ),

        



        ],
      ),
      ), 
    );
  }
}