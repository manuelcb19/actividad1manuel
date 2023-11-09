

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../componentes/CustomTextField.dart';

class PerfilView extends StatelessWidget {

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEdad=TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;


  void onClickAceptar() async {
    final usuario = <String, dynamic>{
      "nombre": tecNombre.text,
      "edad": int.parse(tecEdad.text),
      
    };

   String uidUsuario= FirebaseAuth.instance.currentUser!.uid;
   db.collection("Usuarios").doc(uidUsuario).set(usuario);

  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          centerTitle: true,
          shadowColor: Colors.orangeAccent,
          backgroundColor: Colors.orangeAccent,
        ),
        backgroundColor: Colors.amber[200],
        body:
        Center(
          child: ConstrainedBox(constraints: BoxConstraints(
            minWidth: 500,
            minHeight: 700,
            maxWidth: 1000,
            maxHeight: 900,
          ),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                    child:  customTextField( tecUsername: tecNombre,oscuro: false, sHint: "Introduzca su usuario",)
                ),

                Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                    child:  customTextField( tecUsername: tecEdad, oscuro: false,sHint: "Introduzca su edad",)
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                           TextButton(onPressed: onClickAceptar, child: Text("Aceptar"),),
                            //TextButton( onPressed: onClickCancelar, child: Text("Cancelar"),)

                    ]
                )
              ],
            ),),
        )
    );

  }




}