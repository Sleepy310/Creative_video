import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? name;
  String? uid;
  String? image;
  String? email;
  String? facebook;
  String? youtube;
  String? twitter;
  String? instagram;

  User({
  this.name,
  this.uid,
  this.image,
  this.email,
  this.facebook,
  this.youtube,
  this.twitter,
  this.instagram,
});

  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "image": image,
    "email": email,
    "facebook": facebook,
    "youtube": youtube,
    "twitter": twitter,
    "instagram": instagram,
  };

  static User fromSnap(DocumentSnapshot snapshot){
    var dataSnapshot  = snapshot.data() as Map<String, dynamic>;

    return User(
      name: dataSnapshot["name"],
      uid: dataSnapshot["uid"],
      image: dataSnapshot["image"],
      email: dataSnapshot["email"],
      facebook: dataSnapshot["facebook"],
      youtube: dataSnapshot["youtube"],
      twitter: dataSnapshot["twitter"],
      instagram: dataSnapshot["instagram"],

    );
  }
}


