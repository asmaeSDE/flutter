class User
{

  final String uid;
  final String nom; 
  final String prenom;
  final String email;
  final String cine;
  final String url;
  final bool access;
  

User({this.uid,this.nom,this.prenom,this.email,this.cine,this.url,this.access});


User.fromData(Map<String,dynamic> data)
:uid = data['uid'], nom =data['nom'], prenom=data['prenom'] ,email=data['email'], cine =data['cine'] , url =data['image'] , access=data['access'];


Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nom': nom,
      'prenom':prenom,
      'email': email,
      'cine': cine,
      'image' :url,
      'access' :access,
    };
  }

}

