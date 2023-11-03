import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/CustomTextField.dart';

class PhoneLogin extends StatefulWidget
{



  @override
  State<PhoneLogin> createState() => _PhoneLoginState();

}

class _PhoneLoginState extends State<PhoneLogin> {

  TextEditingController tecphone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();

  void enviarTelefonoPressed()
  {
    String sTelefono = tecphone.text;
    FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: verificacionCompletada,
        verificationFailed: verificacionFallida,
        codeSent: codigoenviado,
        codeAutoRetrievalTimeout: fueraDeTiempo);

  }

  void enviarVerifyPressed()

  {


  }

  void verificacionCompletada(PhoneAuthCredential credencial)

  {



  }

  void verificacionFallida(FirebaseAuthException excepcion ){

  }
  void codigoenviado(String codigo, int? resendToken ){

  }

  void fueraDeTiempo(String mensaje)
  {

  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
       children: [
         TextButton(onPressed: null, child: Text("enviar")),
         TextButton(onPressed: null, child: Text("enviar")),
         customTextField(contenido: "introduzca su numero telefono", tecUsername: tecphone, oscuro: false,),
         TextButton(onPressed: enviarTelefonoPressed, child: Text("enviar")),
         customTextField(contenido: "introduzca su identificacion", tecUsername: tecVerify, oscuro: false,),
         TextButton(onPressed: enviarVerifyPressed, child: Text("enviar")),

       ],
      )
    );
  }
}