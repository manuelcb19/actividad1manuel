import 'package:actividad1manuel/ClasesPropias/CustomUsuario.dart';
import 'package:actividad1manuel/componentes/CustomDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/CustomTextField.dart';

class HomeView extends StatelessWidget{

  late BuildContext _context;
  TextEditingController bdUsuarioNombre = TextEditingController();
  TextEditingController bdUsuarioEdad = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  void onClickAceptar() async {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<CustomUsuario> enlace = db.collection("Usuarios").doc(uid).withConverter(fromFirestore: CustomUsuario.fromFirestore,
      toFirestore: (CustomUsuario usuario, _) => usuario.toFirestore(),);

    CustomUsuario usuario;

    DocumentSnapshot<CustomUsuario> docSnap = await enlace.get();
    usuario = docSnap.data()!;

    print("!!!!!!!!!!!!!!!!!!!!!!!"+usuario.nombre);
    print("!!!!!!!!!!!!!!!!!!!!!!!"+usuario.edad.toString());

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
                  child:  customTextField(contenido: "Este es el menu", tecUsername: bdUsuarioNombre,oscuro: false,)
              ),

              Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  child:  customTextField(contenido: "Este es el menu", tecUsername: bdUsuarioEdad, oscuro: false,)
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    TextButton(onPressed: onClickAceptar, child: Text("Consultar Datos"),),

                  ]
              )
            ],
          ),)
    );

  }


}