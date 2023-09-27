
import 'package:flutter/material.dart';

import 'onBoarding/LoginView.dart';
import 'onBoarding/RegisterView.dart';

class Actividad1 extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp=MaterialApp(title: "KyTy Miau!",
      routes: {
        '/loginview':(context) => LoginView(),
        '/registerview':(context) => RegisterView(),
      },
      initialRoute: '/loginview',
    );

    return materialApp;
  }

}