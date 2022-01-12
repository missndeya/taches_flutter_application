import 'dart:io';

import 'package:path/path.dart';
import 'package:tasks_app/tache.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'user.dart';
import 'tache.dart';

class DatabaseHelper{

  

Database _db;
Future<Database> get db async
{
  if(_db!=null)
      return _db;
  else
  {
    _db=await initDb();
    return _db;

      }
    }
    
      initDb() async
      {
        Directory documentsDirectory=await getApplicationDocumentsDirectory();
        String path=join(documentsDirectory.path,"todo.db");
        return await openDatabase(path,
        version:1,
        onCreate: (Database db ,int version )async 
        {
             await db.execute('''
                create table users(
                
                  username text primary key not null,
                  password int not null,
                  imageUser text

                )
                ''');



                 await db.execute('''
                create table taches(
                
                  type text not null,
                  nom text not null,
                  user text not null,
                  dd text not null,
                  df text not null,
                  etat text not null

                )
                ''');

                
        }
        

        );
      }
      Future<int> insertUSer(User user) async
      {
        var client =await db;
        int i=await client.insert("users",user.toMap());
        return i;
      }
Future<User> selectUser(String nom,String pwd) async
{
  var dbb=await db;
  var dbbb=await dbb.query("users",where: "username=? and password=?",whereArgs:[nom,pwd]);
   
  if(dbbb.isNotEmpty==true)
  return User.fromMap(dbbb.first);
  else 
  return null;

}
















 


 Future<int> insertTache(Tache t)async
      {
        var tache =await db;
        int i1=await tache.insert("taches",t.toMap());
        return i1;
      }



      Future<List<Map>> selectAllTache(String username, tache) async
{
 
  var dbb=await db;
 
  return await dbb.query("taches",where: "user=? and type=?",whereArgs:[username,tache]);


}






 Future<int> updateTache(Tache newTache) async 
 {
    final database = await db;
    var res = await database.update("taches", newTache.toMap(),
        where: "dd=? and df=? and nom=?",whereArgs:[newTache.dd,newTache.df,newTache.nom]
        
        );
    return res;
  }


   Future<int> delete(Tache tache) async {
     
    final database = await db;
    return await 
    database.delete("taches", where: "dd=? and df=? and nom=? and type=? and user=? and etat=?"  , 
    whereArgs: [tache.dd,tache.df,tache.nom,tache.type,tache.user,tache.etat]);
  }







  Future<int> updateImageUser(User newUser) async {
    final database = await db;
    var res = await database.update("users", newUser.toMap(),
        where: "username=?",whereArgs:[newUser.username]
        
        );
    return res;
  }






  Future<List<Map>> selectExpiredTache(String username) async
{
  var dbb=await db;
  return await dbb.query("taches",where: "user=?",whereArgs:[username]);
}







Future selectImage(String username) async
{
  var dbb=await db;
  return await dbb.query("users",where: "username=?",whereArgs:[username]);
}



Future<int> getCountTaksRestants(String username) async {
    var dtb = await db;
    List<Map> maps = await dtb.query("taches",where: "user=? and etat!=?",whereArgs:[username,"accomplie"]);
    List<Map> taches = [];
    if (maps.length > 0) {
       for (var item in maps ) 
       {
         var  now_string=DateTime.now().toString();
          var now=now_string.substring(0,10);
          DateTime date_now=DateTime.parse(now);
          var  date_string =item["dd"].substring(0,10);
          DateTime date=DateTime.parse(date_string);
          var  date_stringf =item["df"].substring(0,10);
          DateTime datef=DateTime.parse(date_stringf);
          var  etat =item["etat"];
          var etat_acc="accomplie";
        
          if((date.isBefore(date_now)|| date==date_now) && (datef.isAfter(DateTime.now()) ||datef==date_now) )

           taches.add(item);
      }
     }
    return taches.length;
  }




Future<int> getCountGroubBy(String username,String type) async {
    var dtb = await db;
    List<Map> maps = await dtb.query("taches",where: "user=? and etat!=? and type=?",whereArgs:[username,"accomplie",type]);
    List<Map> taches = [];
    if (maps.length > 0) {
       for (var item in maps ) 
       {
         var  now_string=DateTime.now().toString();
          var now=now_string.substring(0,10);
          DateTime date_now=DateTime.parse(now);
          var  date_string =item["dd"].substring(0,10);
          DateTime date=DateTime.parse(date_string);
          var  date_stringf =item["df"].substring(0,10);
          DateTime datef=DateTime.parse(date_stringf);
          var  etat =item["etat"];
          var etat_acc="accomplie";
        
          if((date.isBefore(date_now)|| date==date_now) && (datef.isAfter(DateTime.now()) ||datef==date_now) )

           taches.add(item);
      }
     }
    return taches.length;
  }

  Future<int> getAllCountGroubBy(String username,String type) async {
    var dtb = await db;
    List<Map> maps = await dtb.query("taches",where: "user=?  and type=?",whereArgs:[username,type]);
    List<Map> taches = [];
    if (maps.length > 0) {
       for (var item in maps ) 
       {
         var  now_string=DateTime.now().toString();
          var now=now_string.substring(0,10);
          DateTime date_now=DateTime.parse(now);
          var  date_string =item["dd"].substring(0,10);
          DateTime date=DateTime.parse(date_string);
          var  date_stringf =item["df"].substring(0,10);
          DateTime datef=DateTime.parse(date_stringf);
          var  etat =item["etat"];
          var etat_acc="accomplie";
        
          if((date.isBefore(date_now)|| date==date_now) && (datef.isAfter(DateTime.now()) ||datef==date_now) )

           taches.add(item);
      }
     }
    return taches.length;
  }



  Future<List<Tache>> listeTache(String username) async 
  {
    var dtb = await db;
    List<Map> maps = await dtb.query("taches",where: "user=?",whereArgs:[username]);
    List<Tache> taches = [];
    if (maps.length > 0) 
    {
       for (var item in maps ) 
       {
          Tache tache=new Tache(item["type"], item["nom"],item["user"] , item["dd"], item["df"], item["etat"]);
           taches.add(tache);
       } 
     }
    return taches;
  }



    
}









