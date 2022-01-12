import 'package:flutter/material.dart';
import 'package:tasks_app/user.dart';

import 'database.dart';
import 'home_user.dart';
class SignUP extends StatelessWidget {
  @override
  final _final = new GlobalKey<FormState>() ;

  String username,password, passwordConf ;

  // bool verifiePassword(String value){
  //   if(value == password) 
  //     return true ;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text("SignUp"),
        centerTitle: true,
      ),

      body: Form(
        key: _final,
              child:Center(

          child: ListView(
          children: <Widget>[
       Center(child:Container(
         margin: EdgeInsets.all(20),
         child:Text(" ",style: TextStyle(fontSize: 9),))),
            Container(
              width: 100,
              margin: EdgeInsets.all(30),
              child:TextFormField(
                
              decoration: InputDecoration(
                hintText: "UserName",
                fillColor: Colors.white,
                filled: true,
              
              ),
              onChanged: (value){
                  username=value;
              },

              validator: (value){
                return value.length<5? " username trop court": null ;
              },
            ),
            ),
            Container(
              width: 100,
              margin: EdgeInsets.only(left: 30,right: 30),
              
           child: TextFormField(
             
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                //border: BorderRadius.all(radius),
                fillColor: Colors.white,
                filled: true,
                hintText: "Give your password"
              ),
              onChanged: (value){

                password = value ;
              },

              validator: (value){
                return value.length<5? "mdp trop court ": null ;
                
              },
            ),
            ),
 Container(
              width: 100,
              margin: EdgeInsets.all(30),
           child: TextFormField(
           
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Confirmer votre  Password"
              ),
              onChanged: (value){

                passwordConf = value ;

              },

              validator: (value){

                // if(value.length < 6 && value != password)
                if(value.length < 6)
                  return "mdp trop court " ;
                else
                {
                  if(value != password)
                            return "Les deux Mdp sont non conformes " ;
                  else if(value.length < 5 && value != password)
                             return "mdp trop court mais aussi les deux Mdp sont non conformes " ;
                  else
                             return null ;
                }
                  
              },
            ),
 ),
Container(
  width: 100,
  margin: EdgeInsets.only(left: 90,right: 90),
            child:RaisedButton(
              textColor: Colors.blueGrey,
              child: Text("Valider",style: TextStyle(fontSize: 21,color: Colors.blueGrey),),
              
              onPressed: ()async {
               if( _final.currentState.validate()==true) 
               {
                 var dbhelper=DatabaseHelper();
                User monClient=new User(username, password,null);
                final numRow=  await dbhelper.insertUSer(monClient);
                 if(numRow>0)
                 {
                   print("Ligne $numRow est inserée");
              
                    Navigator.pushReplacement(context, 
                    MaterialPageRoute(
                    builder:(context)=>Home_user(monClient)));
                 }
                 else 
                 {
                   print("Not Ok");
                 }
               }
               

              },
            
              color: Colors.greenAccent,
            ),
),

           

          ],

        ),
      ),
      ),

    );
  }
}