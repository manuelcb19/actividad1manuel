import 'dart:js';

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

  late BuildContext context;
  TextEditingController tecPhone=TextEditingController();
  TextEditingController tecVerify=TextEditingController();
  String sVerificationCode="";
  bool blMostrarVerificacion=false;

  void enviarTelefonoPressed() async{
    String sTelefono=tecPhone.text;

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: sTelefono,
        verificationCompleted: verificacionCompletada,
        verificationFailed: verificacionFallida,
        codeSent: codigoEnviado,
        codeAutoRetrievalTimeout: tiempoDeEsperaAcabado);
  }

  void enviarVerifyPressed() async

  {
    String smsCode = tecVerify.text;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: sVerificationCode, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).popAndPushNamed("/homeview");
  }

  void verificacionCompletada(PhoneAuthCredential credencial) async{
    await FirebaseAuth.instance.signInWithCredential(credencial);

    Navigator.of(context).popAndPushNamed("/homeview");
  }

  void verificacionFallida(FirebaseAuthException excepcion){
    if (excepcion.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }
  void codigoEnviado(String codigo, int? resendToken) async{
    sVerificationCode=codigo;
    setState(() {
      blMostrarVerificacion=true;
    });


  }

  void tiempoDeEsperaAcabado(String mensaje)
  {



  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          customTextField(contenido: "introduzca su numero telefono", tecUsername: tecPhone, oscuro: false,),
          TextButton(onPressed: enviarTelefonoPressed, child: Text("Enviar")),
          if(blMostrarVerificacion)
            customTextField(contenido: "introduzca su identificacion", tecUsername: tecVerify, oscuro: false,),
          if(blMostrarVerificacion)
            TextButton(onPressed: enviarVerifyPressed, child: Text("Enviar"))
        ],

      ),

    );
  }


}