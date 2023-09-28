
import 'package:actividad1manuel/componentes/CustomDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/CustomTextField.dart';

class RegisterView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController usuarioController = TextEditingController();
  TextEditingController passwordMyController = TextEditingController();
  TextEditingController passwordconfirmationMyController = TextEditingController();
  //SnackBar snackBar = SnackBar(content: Text("wololoooooo"),);

  void onClickCancelar(){

    Navigator.of(_context).pushNamed("/loginview");

  }

  void onClickAceptar() async {


    switch(usuarioController.text.isEmpty || passwordMyController.text.isEmpty || passwordconfirmationMyController.text.isEmpty){

      case true:

        CustomDialog.show(_context, "Algun campo de los existente se encuentra vacio, por favor, rellenalo");
        break;

      case false:

        if(passwordMyController.text == passwordconfirmationMyController.text)
        {
          try {

            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: usuarioController.text,
              password: passwordMyController.text,
            );
          }
          on FirebaseAuthException catch (e) {

            if (e.code == 'weak-password') {

              CustomDialog.show(_context, "contraseña menor a 6 caracteres");


            } else if (e.code == 'email-already-in-use') {

              CustomDialog.show(_context, "el email ya existe");


            }

            Navigator.of(_context).pushNamed("/menuview");
          }
          catch (e) {
            print(e);
          }
        }

        else
          {
            CustomDialog.show(_context, "Las contraseñas no son iguales");
          }

        break;
    }
    //ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Text texto=Text("Hola Mundo desde Kyty");
    //return texto;
    _context=context;

    Column columna = Column(children: [
      Text("Bienvenido a Kyty Register",style: TextStyle(fontSize: 25)),


      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
          child:  customTextField(contenido: "introduzca su usuario", tecUsername: usuarioController)
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
          child:  customTextField(contenido: "introduzca su usuario", tecUsername: passwordMyController)
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
          child:  customTextField(contenido: "introduzca su usuario", tecUsername: passwordconfirmationMyController)
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onClickAceptar, child: Text("Aceptar"),),
          TextButton( onPressed: onClickCancelar, child: Text("Cancelar"),)

        ],)

    ],);



    AppBar appBar = AppBar(
      title: const Text('Register'),
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