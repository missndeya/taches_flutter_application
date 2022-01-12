

class Tache 
{
   String type ;
    String nom ; 
    String user ; 
    String dd ;
    String df ; 
    String etat;   
  
  Tache(this.type,this.nom,this. user,this.dd,this.df,this.etat);
 
  Map<String,dynamic> toMap() 
  {
    Map<String,dynamic> map =Map<String,dynamic>();
    map["type"]=type;
    map["nom"]=nom;
    map["user"]=user;
    map["dd"]=dd;
    map["df"]=df;
    map["etat"]=etat;

    return map;
    
  }  
  Tache.fromMap(dynamic obj)
  {
      type=obj[type];
      nom=obj[nom];
      user=obj[user];
      dd=obj[dd];
      df=obj[df];
      etat=obj[etat];
  }

}