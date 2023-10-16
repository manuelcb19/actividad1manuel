
import 'package:actividad1manuel/imageninicial/SplashView.dart';
import 'package:flutter/material.dart';

import 'onBoarding/LoginView.dart';
import 'home/HomeView.dart';
import 'onBoarding/PerfilView.dart';
import 'onBoarding/RegisterView.dart';

class Actividad1 extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp=MaterialApp(title: "KyTy Miau!",
      routes: {
        '/loginview':(context) => LoginView(),
        '/registerview':(context) => RegisterView(),
        '/homeview':(context) => HomeView(),
        '/splashview':(context) => SplashView(),
        '/perfilview':(context) => PerfilView(),
    },

      initialRoute: '/homeview',
    );

    return materialApp;
  }

}