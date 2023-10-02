


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

  late BuildContext _context;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
  }

  void checkSession() async{
    await Future.delayed(Duration(seconds: 3));
    if (FirebaseAuth.instance.currentUser != null) {

      Navigator.of(_context).popAndPushNamed("/menuview");
    }
    else{
      Navigator.of(_context).popAndPushNamed("/loginview");
    }

  }

  @override
  Widget build(BuildContext context) {
    _context = context;

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



