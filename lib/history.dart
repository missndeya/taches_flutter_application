
import 'package:flutter/material.dart';

import 'database.dart';

class History extends StatefulWidget {
  String user;
  History(this.user);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
 var db=DatabaseHelper();
 
 

 boitedeDialogue(String texte)
  {
 
              return
              AlertDialog(
        title: Row(children: <Widget>[
          Icon(Icons.info),Text(" Information !")
        ],),



        
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(texte),
              
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
  
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title:Text("History"),
        centerTitle:true,
        
      ),
      //backgroundColor:Colors.blue,
      
      body: FutureBuilder(
        
        future:db.selectExpiredTache(widget.user) ,
         builder: (BuildContext context,AsyncSnapshot snapshot){

          
          
           if(snapshot.hasError)
          {
            return Text(snapshot.error.toString());
            
          }
          else if(snapshot.hasData)
          {
            
           
              return ListView.builder(
                
                itemCount: snapshot.data.length,
                 itemBuilder: (BuildContext context, int index)
               {  
                var item=snapshot.data[index];
        
                    var  now_string=DateTime.now().toString();
          var now=now_string.substring(0,10);
          DateTime date_now=DateTime.parse(now);

          
          var  date_stringf =item["df"].substring(0,10);
          DateTime datef=DateTime.parse(date_stringf);
                     var  etat =item["etat"];
                   var etat_acc="accomplie";
                   

          if (datef.isBefore(date_now))
          {
        //print(datef);
          
        return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
                color: Colors.white,
               borderRadius:BorderRadius.circular(0.0)),
        margin: EdgeInsets.only(bottom:4,top: 4,left: 10,right: 10),
        

        child:etat!=etat_acc?ListTile(
          subtitle: Text("Expired",style: TextStyle(color:Colors.red),),
          trailing: Text("Not done ",style: TextStyle(color:Colors.red),),
      
        onTap: ()async {
          var database =DatabaseHelper();
          
         
          setState(() {
        
           
            print(item["nom"]);
          
          });
        },
        title:Text(item["nom"]),
       
      )
      
      :ListTile(
      
        title:Text(item["nom"]),
        subtitle: Text("Expired",style: TextStyle(color:Colors.red),),
        trailing: Text("Done",style: TextStyle(color:Colors.green),),
      ),
        )
        );
      }
      else {
        return
       GestureDetector(
      child: Container(
        decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.circular(12.0)),
        margin: EdgeInsets.only(bottom:4,top: 4,left: 10,right: 10),
        

        child:etat!=etat_acc?ListTile(
          subtitle: Text("Not expired",style: TextStyle(color:Colors.green),),
          trailing: Text("Not done ",style: TextStyle(color:Colors.red),),
      
        onTap: ()async {
          var database =DatabaseHelper();
          
         
          setState(() {
        
           
            print(item["nom"]);
          
          });
        },
        title:Text(item["nom"]),
       
      )
      
      :ListTile(
      
        title:Text(item["nom"]),
        subtitle: Text("Not expired",style: TextStyle(color:Colors.green),),
        trailing: Text("Done",style: TextStyle(color:Colors.green),),
      ),
        )
        );
      }
      }
      
      );
          }
          else
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
         
        },)

    );
  
  
  }
  
}