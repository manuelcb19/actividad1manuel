



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView>{

  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
  }

  void checkSession() async{
    await Future.delayed(Duration(seconds: 3));
    if (FirebaseAuth.instance.currentUser != null) {
      String uid=FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> datos=await db.collection("Usuarios").doc(uid).get();
      if(datos.exists){

        Navigator.of(context).popAndPushNamed("/homeview");
      }
      else{
        Navigator.of(context).popAndPushNamed("/perfilview");
      }

    }
    else{
      Navigator.of(context).popAndPushNamed("/loginview");
    }

  }


  @override
  Widget build(BuildContext context) {

    Column column=Column(
      children: [
        Image.asset("resources/logo_kyty.png",width: 300,
            height: 450),
        CircularProgressIndicator()
      ],
    );

    return column;
  }


}