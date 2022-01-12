import 'dart:async';
import 'dart:ffi';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/Home.dart';
import 'package:tasks_app/Taches_restantes.dart';

import 'package:tasks_app/history.dart';
import 'package:tasks_app/tache.dart';
import 'package:tasks_app/typeTache.dart';
import 'package:tasks_app/user.dart';
import 'package:http/http.dart' as http;

import 'Expired_taches.dart';
import 'database.dart';
import 'dart:io';

import 'new_task.dart';
import 'user.dart';
import 'typeTache.dart';

import 'package:flutter/services.dart';
import 'package:weather/weather.dart';




class Home_user extends StatefulWidget {

  User user; 
  Home_user(this.user);

  @override
  _Home_userState createState() => _Home_userState();
  
 
}


class _Home_userState extends State<Home_user>   {


  String _timeString;
  int nbre=0;
  int nbre0,total0=0;
  int nbre2,total2=0;
  int nbre3,total3=0;
  int nbre1,total1=0;
 
  String temperature,ville,pays;
  @override
  void setState(fn) {
    _getAllCountGroupBy();
     _getCountGroubBy();
    _getCount();
    super.setState(fn);
  }
 @override
  void initState() {
    
    _getTemperature();
    _timeString = DateTime.now().toString();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
    setState(() {
      _getCount();
    });
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy HH:mm:ss').format(dateTime);
  }


  _getTemperature()async 
  {
  WeatherStation weatherStation = new WeatherStation(aPPID);
  Weather weather = await weatherStation.currentWeather();
  if(weather!=null)
  { double  celsius = weather.temperature.celsius;
   ville=weather.areaName;
   pays=weather.country;
   temperature=celsius.toString();
   print(temperature );
  }

  }

  _getCount()async{
     var db2=DatabaseHelper();
     nbre=await db2.getCountTaksRestants(widget.user.username); 
       
  }

  _getCountGroubBy()async{
     var db2=DatabaseHelper();
     nbre0=await db2.getCountGroubBy(widget.user.username,listTachNom[0]);
       nbre1=await db2.getCountGroubBy(widget.user.username,listTachNom[1]); 
         nbre2=await db2.getCountGroubBy(widget.user.username,listTachNom[2]); 
           nbre3=await db2.getCountGroubBy(widget.user.username,listTachNom[3]);  
       
  }
   _getAllCountGroupBy()async{
     var db2=DatabaseHelper();
     total0=await db2.getAllCountGroubBy(widget.user.username,listTachNom[0]);
       total1=await db2.getAllCountGroubBy(widget.user.username,listTachNom[1]); 
         total2=await db2.getAllCountGroubBy(widget.user.username,listTachNom[2]); 
           total3=await db2.getAllCountGroubBy(widget.user.username,listTachNom[3]);  
       
  }

    String aPPID="5fcca15ca9bd358e09f7472f00a23e1f";
  
    double mediaw;
    double mediah;
   var _img ,photo;
   
   var db=DatabaseHelper();
   String chemin;
  
    Future getImage() async {
    var  image = await ImagePicker.pickImage(source:ImageSource.gallery);
    String path=image.path;
    
      // _img=new File(path); 
           final entier=await  db.updateImageUser(new User(widget.user.username,widget.user.password,path));
           if(entier>0)
           print("Image  de "+ widget.user.username+" est mise a jour ");
           
     
      setState(() {
        
      _img=new File(path); 

    });
  }



Future<void>_exit() async {
           
   return showDialog<void>(
    context: context,
    barrierDismissible: false, //a rechercher
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('LOGOUT'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You are going to disconnect'),
              Text('Are you sure ????'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
              
            },
            
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: ()async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('email');
            prefs.remove('mdp');
              
              Navigator.pushReplacement(context, 
                    MaterialPageRoute(
                    builder:(context)=>Home()));
             },
          ),
        ],
      );
    },
  );
}

void infos(String type,int res,int tot)async{
  await showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel"))
          ],
          title: Text(type),
          content: tot!=0?Text("For this section that is "+type+", you have in total defined " +tot.toString()+" task,  "+(tot-res).toString()+" completed and "+res.toString()+" remaining. Which give you a percentage of "+(((tot-res)/tot)*100).toString()+" %")
          :Text("For this section that is "+type+", you have in total defined 0 task, so 0 completed and 0 remaining. Which give you a percentage of 0 %"),
        );
    }
  );
}




  //pour definition des   string (les types de taches)le listView Horizontal
  List <String> listTachNom = ["READ","VISIT","EAT","SPORT"];
    //la methode pour choisir la tache a afficher  
  Widget itemListView(String nomTache,int nb,int total){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, 
                    MaterialPageRoute(
                    builder:(context)=>Taches_restantes(widget.user.username,nomTache)));
      },
      child:Container(
       decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.circular(30.0)),
      height:mediah/1.32,
      width: mediaw/1.32,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
     
      child:  total!=0?Column(children:<Widget>[
        Row(
         
          children: <Widget>[
            Expanded(
             
              child:Container(
                 alignment: new Alignment(-1,-1),
                 child:Icon(Icons.school,size: 27,color: Colors.lightBlue,))
              ,
            
              ),
            Expanded(
             
              child:Container(
                 alignment: new Alignment(1, 1),
                 child:GestureDetector(
                   onLongPress: (){ infos( nomTache, nb, total);},
                  
                   child:Icon(Icons.more_vert,size: 27,)))
              ,
            
              )
          ],
        ),
        Expanded(
          child: Text(""),
         
        ),
        Container(
          margin: EdgeInsets.only(left:10),
          alignment: Alignment(-1, -1),
          
       child:Column(
            children: <Widget>[
              Text(nomTache,style: TextStyle(color:Colors.blue),),
              Row(children: <Widget>[
                   Text(nb.toString()+" task(s) restant(s) "),
                    Text( "(sur "+total.toString()+" )",),
              ]),
             
            Text((((total-nb)/total)*100).toString()+" %")
            ],
        )
        
        ), Container(
         margin: EdgeInsets.only(left: 10,right: 10,bottom: 12),
         child:LinearProgressIndicator(
        value:(total-nb)/total,
        backgroundColor: Colors.grey,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
)
        
      ]
      ):
      Column(children:<Widget>[
        Row(
         
          children: <Widget>[
            Expanded(
             
              child:Container(
                 alignment: new Alignment(-1,-1),
                 child:Icon(Icons.school,size: 27,color: Colors.lightBlue,))
              ,
            
              ),
            Expanded(
             
              child:Container(
                 alignment: new Alignment(1, 1),
                 child:GestureDetector(
                   onTapDown:(TapDownDetails tapDownDetails){
               infos(nomTache, nb, total);

                   } ,
                   child:Icon(Icons.more_vert,size: 27,)))
              ,
            
            
              )
          ],
        ),
        Expanded(
          child: Text(""),
         
        ),
        Container(
          margin: EdgeInsets.only(left:10),
          alignment: Alignment(-1, -1),
          
       child:Column(
            children: <Widget>[
              Text(nomTache,style: TextStyle(color:Colors.blue),),
              Row(children: <Widget>[
                   Text("0"+" task(s) restant(s) "),
                    Text("(sur 0 )" ,),
              ]),
             
            Text(((0)*100).toString()+" %")
            ],
        )
        
        ), Container(
         margin: EdgeInsets.only(left: 10,right: 10,bottom: 12),
         child:LinearProgressIndicator(
        value:0,
        backgroundColor: Colors.grey,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
)
        
      ]
      )
      ) ,


    );
  }
  
  @override
  Widget build(BuildContext context) {

    mediaw = MediaQuery.of(context).size.width;
    mediah = MediaQuery.of(context).size.height;
    return Scaffold(
      
      backgroundColor: 
      Colors.lightBlue,
      appBar: AppBar(title: Text(" Tasks APP "),
      actions: <Widget>[
          GestureDetector(
            
            onTap: (){

                  _exit();
               
            },
            child:Container(
              margin: EdgeInsets.only(right:20),
              child:Icon(Icons.exit_to_app,size: 30))
          )
      ],  
      centerTitle: true,),
      drawer:new Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(right:mediaw/3.99,top:20),
        
        child:new Drawer(
          child:Column(children:<Widget>[
            Container(
              child:CircleAvatar(backgroundColor: Colors.white,child: Icon(Icons.person,size: mediah/4),),
              width: mediah/2.4,
              color: Colors.blue,
              height: mediah/2.7,
            )
            ,
          Expanded(
        child: ListView(
          
            children: <Widget>[
             
              

               ListTile(
                leading: Icon(Icons.explicit),
                title: Text("Expired tasks  ",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                onTap: (){
                  print("Expired tasks");
                  Navigator.push(context, 
                    MaterialPageRoute(
                    builder:(context)=>Expired(widget.user.username)));
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text("History  ",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                onTap: (){
                  print("History");
                  Navigator.push(context, 
                    MaterialPageRoute(
                    builder:(context)=>History(widget.user.username)));
                },
              ),
               ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Exit",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                onTap: (){
                  _exit();
                },
              ),

              ListTile(
                leading: Icon(Icons.star),
                title: Text("Giving  mark",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                onTap: (){
                  
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add),
                title: Text("Invite a friend",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                onTap: (){
                  
                },
              ),
             
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About us",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                onTap: (){
                  
                },
              ),
              

            ],
        ),
      )
          ]
          )
          ),
      ),
      body:Column(
          children: <Widget>[

                
                            Center(child: Container(
                              
                                
                                width: mediaw/3.4,
                                height: mediaw/3.4,
                                margin: EdgeInsets.only(top: 10),
                                
                                child:GestureDetector(
                                
                                    onTap: getImage,
                                    child:FutureBuilder(
                        
                        future:db.selectImage(widget.user.username) ,
                         builder: (BuildContext context,AsyncSnapshot snapshot){
                       if(snapshot.hasError)
                                 {
                                       return Text(snapshot.error.toString());
            
                                 }
                        else   if(snapshot.hasData)
                          {
                            
                          return snapshot.data[0]["imageUser"]!=null?CircleAvatar(
                                   
                                     backgroundImage:FileImage(new File(snapshot.data[0]["imageUser"])),
                                     
                                  ):CircleAvatar(
                                   backgroundColor: Colors.white,
                                     child: Icon(Icons.add_a_photo),
                                     
                                  );
                          
                          }
                
                            else
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
                         
                        },)
                                  
                               
                                 
                              ),
                            ),),
                            Center(child:Text("Hello " +widget.user.username+" !",
                            style: TextStyle(fontSize: 17,color: Colors.white)
                            )
                            ),
                            Center(child: Text("Il vous reste  "+nbre.toString()+"  tache(s) , ce :  ",style:TextStyle(color:Colors.white)),),
                             
                            
                            Center(child: Text(_timeString.toString(),style: TextStyle(color:Colors.red),),),
                            Container(

                      margin: EdgeInsets.only(left:15),    
                                child:Row(children: <Widget>[
                                  
                                  
                                  Icon(Icons.location_on,size: 25,color: Colors.red,),
                                  
                                  
                                  Text(
                                    ville.toString()+"("+pays.toString()+") ",style:
                                   TextStyle(color:Colors.white),
                                  ),
                                  Expanded(child:
                                  Container(
                                    margin: EdgeInsets.only(right:20),  
                                    alignment: new Alignment(1,1),
                                    child:
                                  Text(
                                   temperature.toString()+" °c",style:
                                   TextStyle(color:Colors.white),
                                  )
                                  )
                                  )
                                ]
                                )
                            
                                  ),
                         
                         
                       Expanded(
                         child: Center(
                          child:Container(
                             
                            height:mediah/2.5,
                            margin: EdgeInsets.only(bottom:18,left:30,top: 40),
                           // color: Colors.yellow,
                          child: ListView(
                            scrollDirection:Axis.horizontal,
                            children: <Widget>[
                               itemListView(listTachNom[0],nbre0,total0) ,
                                itemListView(listTachNom[1],nbre1,total1),
                                 itemListView(listTachNom[2],nbre2,total2),
                                  itemListView(listTachNom[3],nbre3,total3)
                
                            ],
                
                        ),)))
                         
                         
                          ],
                          
                        
                      ),
                     
                      floatingActionButton: SpeedDial(
                        
                          
                          marginRight: 18,
                          marginBottom: 20,
                          animatedIcon: AnimatedIcons.menu_close,
                      
                          closeManually: false,
                          curve: Curves.bounceIn,
                          overlayColor: Colors.black,
                          overlayOpacity: 0.5,
                    
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.black,
                          elevation: 8.0,
                         // shape: CircleBorder(),
                          children: [
                            SpeedDialChild(
                              child: Icon(Icons.book),
                              backgroundColor: Colors.red,
                              label: 'READ',
                              labelStyle: TextStyle(fontSize: 18.0),
                             onTap: ()async  {
                                TypeTache read=new TypeTache("READ");
                               Navigator.push(context, 
                                    MaterialPageRoute(
                                    builder:(context)=> New(read,widget.user.username)));
                   
                                }
                            ),
                            SpeedDialChild(
                              child: Icon(Icons.directions_run),
                              backgroundColor: Colors.blue,
                              label: 'SPORT ',
                              labelStyle: TextStyle(fontSize: 18.0),
                              onTap: () {
                                TypeTache sport=new TypeTache("SPORT");
                                
                               Navigator.push(context, 
                                    MaterialPageRoute(
                                    builder:(context)=> New(sport,widget.user.username)));
                                
                                }
                            ),
                            SpeedDialChild(
                              child: Icon(Icons.arrow_right),
                              backgroundColor: Colors.purple,
                              label: 'VISIT',
                              labelStyle: TextStyle(fontSize: 18.0),
                              onTap: () {
                                TypeTache visite=new TypeTache("VISIT");
                                
                                
                               Navigator.push(context, 
                                    MaterialPageRoute(
                                    builder:(context)=> New(visite,widget.user.username)));
                                }
                            ),
                
                
                             SpeedDialChild(
                              child: Icon(Icons.fastfood),
                              backgroundColor: Colors.green,
                              label: 'EAT',
                              
                              labelStyle: TextStyle(fontSize: 18.0,),
                              onTap: () {
                
                            TypeTache at=new TypeTache("EAT");
                               
                               Navigator.push(context, 
                                    MaterialPageRoute(
                                    builder:(context)=> New(at,widget.user.username)));
                                }
                            ),
                          ],
                        ),
                
                    );
                  }
}