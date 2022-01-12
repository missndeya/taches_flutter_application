import 'package:flutter/material.dart';
import 'package:tasks_app/database.dart';
import 'package:tasks_app/tache.dart';
import 'package:intl/intl.dart';
class Taches_restantes extends StatefulWidget {

  
  String type,user;
  Taches_restantes(this.user,this.type);
  @override
  _Taches_restantesState createState() => _Taches_restantesState();
}

class _Taches_restantesState extends State<Taches_restantes> {

 DateTime debut,fin;
var debut1,fin1;


  DateTime  _date=DateTime.now();
  
  var db=DatabaseHelper();
  var cocher=false;
  
 var _tapPosition;
 void _storePosition(TapDownDetails details) 
  {
    _tapPosition = details.globalPosition;
  }


  void _showPopupMenu(Tache t) async {
 final RenderBox overlay = Overlay.of(context).context.findRenderObject();
  await showMenu(
  
    context: context,
    position: RelativeRect.fromRect(
          _tapPosition & Size(40, 30), 
          Offset.zero & overlay.size   
      ),
    items: [
      PopupMenuItem<String>(
          child: GestureDetector(
            onTap: ()async{
              Navigator.pop(context);
                supprimerTache(t);
            },
            child: ListTile(leading: Icon(Icons.delete,color: Colors.red,),
            title:Text("Delete",style: TextStyle(color:Colors.red),)
            ,),)),

             PopupMenuItem<String>(
          child: GestureDetector(
            onTap: ()async{
              Navigator.pop(context);
          
                
            },
            child: ListTile(leading: Icon(Icons.edit,color: Colors.blueAccent,),
            title:Text("Modify",style: TextStyle(color:Colors.blueAccent),)
            ,),)),
     
            
    ],
    
  );
}


  void supprimerTache(Tache t )async {
      var db=DatabaseHelper();
    await showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel")),
             FlatButton(onPressed: ()async{
            var a=await db.delete(t);
            Navigator.pop(context);
            setState(() {
              
            });
            }, child: Text("yes"))
          ],
          title: Text("Remove  this Task"),
          content: 
          Text("Are you sure to remove this task "),
        );
    }
  );

  }


  void modifierTache(Tache t )async {
      var db=DatabaseHelper();
    await showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel")),
             FlatButton(onPressed: ()async{
            //var a=await db.delete(t);
            Navigator.pop(context);
            setState(() {
              
            });
            }, child: Text("Apply"))
          ],
          title: Text("Modify   this Task"),
          content: 
          ListView(
            children:<Widget>[

            ]
          )
        );
    }
  );

  }



void accomplirTache(Tache t )async {
      var db=DatabaseHelper();
    await showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel")),
             FlatButton(onPressed: ()async{
            var a=await db.updateTache(t);
            Navigator.pop(context);
            setState(() {
              
            });
            }, child: Text("yes"))
          ],
          title: Text("Done this task"),
          content: 
          Text("Are you sure to done this task "),
        );
    }
  );

  }





  

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
        title:Text("Tasks "+widget.type+""),
       

        
        //centerTitle:true,
        
      ),

      //backgroundColor:Colors.blue,
      body: Column(children: <Widget>[
        Center(child:Icon(Icons.school,size: 42,)),
      Expanded(child: FutureBuilder(
        
        future:db.selectAllTache(widget.user,widget.type) ,
         builder: (BuildContext context,AsyncSnapshot snapshot){

          
            if(snapshot.hasError)
          {
            return Text(snapshot.error.toString());
            
          }
          else if(snapshot.hasData)
          {
            
           
            if(snapshot.data.length==0)
            {
             return boitedeDialogue('you have no task that has been defined before');
           }




            
              return ListView.builder(
                
                itemCount: snapshot.data.length,
                 itemBuilder: (BuildContext context, int index)
           {  
             
          var item=snapshot.data[index];
        
          var  date_string =item["dd"];
          DateTime date=DateTime.parse(date_string);
          var  date_stringf =item["df"];
          DateTime datef=DateTime.parse(date_stringf);
          var  etat =item["etat"];
          var etat_acc="accomplie";
          if((date.isBefore(DateTime.now())||date==DateTime.now()) && (datef.isAfter(DateTime.now()) ||datef==DateTime.now()))
          {
            Tache task=new Tache(item["type"],item["nom"],item["user"],item["dd"],item["df"],item["etat"]);
        return GestureDetector(
          onLongPress: (){
            _showPopupMenu(task);
          },
          onTapDown: _storePosition,
      child: Container(
        decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.circular(12.0)),
        margin: EdgeInsets.only(bottom:4,top: 4,left: 10,right: 10),
        //color: Colors.white ,
        child:etat!=etat_acc?ListTile(
        //subtitle:Text('Debut:'+item["dd"].substring(0,item["dd"].length-13)+" \nFin:"+item["df"].substring(0,item["dd"].length-13)) ,
        onTap: () {
          
          Tache t=new Tache(item["type"],item["nom"],item["user"],item["dd"],item["df"],"accomplie");
            
         accomplirTache(t);
        },
        title:Text(item["nom"]),
        trailing: Checkbox(value: cocher, onChanged: null),
      )
      
      :ListTile(
        //subtitle:Text('Debut:'+item["dd"].substring(0,item["dd"].length-13)+" \nFin:"+item["df"].substring(0,item["df"].length-13)) ,
        title:Text(item["nom"]),
        trailing: Checkbox(value: true, onChanged: null),
      ),
        )
        );
          }

           else 
            {
            Container();
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
      )
      ]
      )

    );
  }

  

  
}