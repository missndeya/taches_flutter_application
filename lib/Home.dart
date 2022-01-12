
import 'package:flutter/material.dart';
import 'package:tasks_app/signup.dart';

import 'login.dart';
class Home extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    double mediaw;
    double mediah;
    mediaw = MediaQuery.of(context).size.width;
    mediah = MediaQuery.of(context).size.height;
    return Scaffold(
     
    backgroundColor: Colors.lightBlue,
        body: Container(
        decoration: BoxDecoration(
          
        ),
        child:Center(
          child:Container(
            padding: EdgeInsets.all(mediaw/20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
             
              
              children: <Widget>[
                
                Center(child: Icon(Icons.home),),
                
               
                Text("Welcome !!!",textAlign: TextAlign.center,style: TextStyle(fontSize: (mediaw/12),),),
                Text(" "),
                Text("This application will allow you to manage your tasks every day.",textAlign: TextAlign.center,style: TextStyle(fontSize: (mediaw/19)),),
                 Text(" "),
                Text("If you do not have an account, you must register !",textAlign: TextAlign.center,style: TextStyle(fontSize: (mediaw/24)),),
 Text(" "),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child:Text("Login",style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold,
                        ),),
                        color:Colors.lightBlue,
                        onPressed:(){
                              Navigator.pushReplacement(context, 
          MaterialPageRoute(
            builder:(context)=>Login()));
                        }
                      ),

                      RaisedButton(
                        child:Text("SignUp",style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold,
                        ),),
                        color:Colors.lightBlue,
                        onPressed:(){
Navigator.pushReplacement(context, 
          MaterialPageRoute(
            builder:(context)=>SignUP()));
                        }
                      ),
                      
                    ]

                ),
                

            Text(" "),
                
                

              ],
              
            ),
            color: Colors.white,
            width: mediaw-(mediaw/6),
            height:( mediah/1.77)
            
            
            ,
          ),
        
     
        ),
      ),
    
      
    );
  }
}