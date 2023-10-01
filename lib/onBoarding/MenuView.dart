import 'package:actividad1manuel/componentes/CustomDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/CustomTextField.dart';

class MenuView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    AppBar appBar = AppBar(
      title: const Text('Login'),
      centerTitle: true,
      shadowColor: Colors.pink,
      backgroundColor: Colors.greenAccent,
    );

    Scaffold scaf=Scaffold(
      //backgroundColor: Colors.deepOrange,
      appBar: appBar,);
    return scaf;
  }


}