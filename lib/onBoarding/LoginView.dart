
import 'package:actividad1manuel/componentes/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../componentes/CustomDialog.dart';

class LoginView extends StatelessWidget {

  FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext _context;

  TextEditingController usuarioControlador = TextEditingController();
  TextEditingController usuarioPassword = TextEditingController();

  void onClickRegistrar(){
    Navigator.of(_context).pushNamed("/registerview");
  }

  void onClickAceptar() async {


    if (usuarioControlador.text.isEmpty || usuarioPassword.text.isEmpty) {

      CustomDialog.show(_context, "Existen algún campo vacío, por favor, compruébalo");
    }

    else {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: usuarioControlador.text,
            password: usuarioPassword.text
        );

        String uid=FirebaseAuth.instance.currentUser!.uid;
        DocumentSnapshot<Map<String, dynamic>> datos = await
            db.collection("Usuarios").doc(uid).get();

        if (datos.exists){
          Navigator.of(_context).popAndPushNamed("/homeview");

        }

        else{
          Navigator.of(_context).popAndPushNamed("/perfilview");
        }
      } on FirebaseAuthException catch (e) {

        CustomDialog.show(_context, "Usuario o contraseña incorrectos");

        if (e.code == 'user-not-found') {

          CustomDialog.show(_context, "El usuario no existe");

        } else if (e.code == 'wrong-password') {

          CustomDialog.show(_context, "contraseña incorrecta");

        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
          shadowColor: Colors.purple[600],
          backgroundColor: Colors.purple[600],
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
              Text("Bienvenido a Actividad 1", style: TextStyle(fontSize: 25)),

              Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  child:  customTextField(contenido: "introduzca su usuario", tecUsername: usuarioControlador, oscuro: false,)
              ),

              Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  child:  customTextField(contenido: "introduzca su Contraseña", tecUsername: usuarioPassword, oscuro: true,)
              ),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: onClickAceptar, child: Text("Aceptar"),),
                  TextButton( onPressed: onClickRegistrar, child: Text("Registrar"),),

                ],)

            ],
          ),)
    );
  }
}