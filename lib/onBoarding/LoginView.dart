
import 'package:actividad1manuel/componentes/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../componentes/CustomDialog.dart';

class LoginView extends StatelessWidget {

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
        Navigator.of(_context).pushNamed("/registerview");

      } on FirebaseAuthException catch (e) {

        CustomDialog.show(_context, "Usuario no encontrado");

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
    Column columna = Column(children: [
      Text("Bienvenido a Actividad 1", style: TextStyle(fontSize: 25)),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
        child:  customTextField(contenido: "introduzca su usuario", tecUsername: usuarioControlador)
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
          child:  customTextField(contenido: "introduzca su Contraseña", tecUsername: usuarioPassword)
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onClickAceptar, child: Text("Aceptar"),),
          TextButton( onPressed: onClickRegistrar, child: Text("Registrar"),),

        ],)

     ],
    );

    AppBar appBar = AppBar(
    title: const Text('Login'),
    centerTitle: true,
    shadowColor: Colors.pink,
    backgroundColor: Colors.greenAccent,
    );

    Scaffold scaf=Scaffold(body: columna,
    //backgroundColor: Colors.deepOrange,
    appBar: appBar,);
    return scaf;
  }
}