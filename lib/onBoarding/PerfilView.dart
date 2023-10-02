

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../componentes/CustomTextField.dart';

class PerfilView extends StatelessWidget {

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEdad=TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;


  void onClickAceptar() {
    final usuario = <String, dynamic>{
      "nombre": tecNombre.text,
      "edad": int.parse(tecEdad.text),
    };

    db.collection("Usuarios").add(usuario);

   // String uidUsuario= FirebaseAuth.instance.currentUser!.uid;
   // db.collection("Usuarios").doc(uidUsuario).set(usuario);

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          centerTitle: true,
          shadowColor: Colors.pink,
          backgroundColor: Colors.deepOrange,
        ),
        body:
        ConstrainedBox(constraints: BoxConstraints(
          minWidth: 500,
          minHeight: 700,
          maxWidth: 1000,
          maxHeight: 900,
        ),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  child:  customTextField(contenido: "introduzca su usuario", tecUsername: tecNombre,oscuro: false,)
              ),

              Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  child:  customTextField(contenido: "introduzca su edad", tecUsername: tecEdad, oscuro: false,)
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                         TextButton(onPressed: onClickAceptar, child: Text("Aceptar"),),
                          //TextButton( onPressed: onClickCancelar, child: Text("Cancelar"),)

                  ]
              )
            ],
          ),)
    );

  }




}