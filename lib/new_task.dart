import 'package:flutter/material.dart';
import 'package:tasks_app/tache.dart';
import 'Sous_Tache.dart';
import 'database.dart';
import 'typeTache.dart';
import 'package:intl/intl.dart';//pour pouvoir utiliser dateformat ----dependances deja ajoute 
//dans le pub Yam 

class New extends StatefulWidget {

  TypeTache typee;
  String login;
  

  New(this.typee,this.login);
  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {


DateTime debut,fin;
var debut1,fin1;


  DateTime  _date=DateTime.now();


  Future  selectDateDebut(BuildContext context) async 
  {
  final  DateTime picked =await showDatePicker(
     builder: (context, child) {
          return Container(
            child: Theme(
              child: child,
              data: ThemeData.dark(),
            ),
          );
        },
  context: context, 
  initialDate: _date,
  firstDate: DateTime.now().subtract((Duration(days:1))), 
  //firstDate: DateTime(2020),
   lastDate: DateTime(2100),
   );
   if(picked!=null   )
   {
     setState(() {
        
         debut =picked;
         
           debut1= DateFormat.yMMMMd().format(debut);
          print(debut1.toString());
         
         
     });
    
   }
  }






 Future  selectDateFin(BuildContext context) async //la methode pour choisir la date de fin 
  {
    double mediah=MediaQuery.of(context).size.height;
    double mediaw=MediaQuery.of(context).size.width;
  final  DateTime picked =await showDatePicker(
    builder: (context, child) {
          return Container(
            child: Theme(
              child: child,
              data: ThemeData.dark(),
            ),
          );
        },
   
  context: context, 
  initialDate: _date,
 
  //firstDate: DateTime(2020),
   firstDate: DateTime.now().subtract((Duration(days:1))), 
   
   lastDate: DateTime(2100),
   );
   if(picked!=null  )
   {
     setState(() {
      
         fin =picked;
          fin1= DateFormat.yMMMMd().format(fin);
         print(fin1.toString());
         
     });
    
   }
  }







 final control = TextEditingController();

  List<Sous_Tache> listTache=[];
    String tache;
   // Sous_Tache st;

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      //bottomSheet: Container(child:Text("ndeyasu"),),
      
      backgroundColor: Colors.lightBlue,

      appBar: AppBar(
        title: Text("New Task "+widget.typee.typeTache),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right:14),
          child:GestureDetector(
            onTap: () async
             {
              
              print("gesture ckecked "); 
              
              //var date = new DateFormat("yyyy/MM/dd hh:mm:ss:ttt", "en_US").parse(debut.toString());
              //if(date.isBefore(fin))
             // print("c'est super ");s
              if(debut!=null  && fin!=null && debut.isBefore(fin) && tache !=null)
             {
                
              //print("C'est OK "+debut.toString()+" est avant "+fin.toString());
              
              for(int i=0;i<listTache.length;i++)
              {
              Tache t=new Tache(widget.typee.typeTache, listTache[i].tache_a_faire, widget.login, listTache[i].date_debut, listTache[i].date_fin,"neutre");
            
                var dbhelper=DatabaseHelper();

                final numRow=  await dbhelper.insertTache(t);
                 if(numRow>0)
                 {
                   print("tache $numRow :"+listTache[i].tache_a_faire +" est inserée");
                  
                 }
                 else 
                 print("Echeeec de l'insertion  ");


              }

             
             }
              else
              print("Erreur");
                listTache.clear();
                Navigator.pop(context);
           },
            child:Icon(Icons.check,size: 35,color: Colors.greenAccent,)),
            
          ),
        ],
        
      ),
      

      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
       
        Expanded(
          
       child: 
       Container(
         
          //height:1700,
        
          child:listTache.length!=0 ? ListView.builder(
           padding: EdgeInsets.all(10),
    
            itemCount: listTache.length,
            itemBuilder: (BuildContext context ,int position){
             return Container(
               
               padding: EdgeInsets.only(left:3.0,bottom: 14),
               margin: EdgeInsets.all(4),
               //color: Colors.white,
            
             child:Text("Date debut : "+debut1.toString()+ "\nTache à faire :  "
             + listTache[position].tache_a_faire+" \nDate fin  : "+fin1.toString(),
             style: TextStyle(fontSize: 15,
               color: Colors.white,
             ),
             )
             );
            },
          )
       :ListView()
         ),
      ),
        _buildEcrireUneTache(),
              ],
              ),
            );
          }
        
          _buildEcrireUneTache() {
            return Container(
              margin: EdgeInsets.only(bottom:10),
              decoration: BoxDecoration(

                border: Border.all(color:Colors.white,
                width:1
               ),
                
               // color: Colors.white,
                borderRadius:BorderRadius.circular(20.0)
              ),
             // padding: EdgeInsets.only(right:18.0),
             height: 65 ,
              padding: EdgeInsets.all(10),
           child: Row(
              children: <Widget>[
                Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                   
                   
                   
                   
                   GestureDetector(
                     onTap: (){
                          selectDateDebut(context);
                     },




                     child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children:<Widget>[
                         Icon(Icons.timer,color: Colors.white,),
                         Text("Debut",style: TextStyle(color:Colors.white),),
                       ],
                     )
                   )
                  ],
                ),
                Expanded(
                  
                  
                  
                  child: TextFormField(

                    controller: control,
                   onChanged: (value){
                   tache=value;
                   
                    
                   },
                    decoration: InputDecoration.collapsed(
                      
                      hintText: "Que voulez vous faire ? ",
                      border: OutlineInputBorder(
                        borderSide:BorderSide(color:Colors.green)
                      ),
                      
                      fillColor: Colors.white,

                filled: true,
                    
                    ),
                     
                  ),




               
                  ),
                    Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                   GestureDetector(
                     onTap: (){
                       selectDateFin(context);
                       
                       


                     },
                     child:Column(
                       children:<Widget>[
                         Icon(Icons.timer,color: Colors.white,),
                         Text("Fin",style: TextStyle(color:Colors.white),),
                       ],
                     )
                   )
                  ],
                ),
                Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                   GestureDetector(
                     onTap: (){
                       setState(() {
                         if(tache!=null)
                         {
                           Sous_Tache st=new Sous_Tache(debut.toString(), tache, fin.toString());
                        listTache.add(st);

                       print(st.date_debut +" "+st.tache_a_faire+" "+st.date_fin);
                       control.text='';
                         }
                        });
                     
                       
                     },
                     child:Column(
                       children:<Widget>[
                         Icon(Icons.arrow_upward),
                         Text("Valider"),
                       ],
                     )
                   )
                  ],
                ),
              ],
            ),
            );
         
          }
          
}