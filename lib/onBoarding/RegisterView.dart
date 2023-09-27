
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/customTextField.dart';

class RegisterView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController usuarioController = TextEditingController();
  TextEditingController passwordMyController = TextEditingController();
  TextEditingController passwordconfirmationMyController = TextEditingController();
  //SnackBar snackBar = SnackBar(content: Text("wololoooooo"),);

  void onClickCancelar(){

    Navigator.of(_context).pushNamed("/loginview");

  }

  void showMyDialog(String mensaje) async {
    return showDialog<void>(
      context: _context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(mensaje),
                Text(mensaje),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void onClickAceptar() async {


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
          showMyDialog("contraseña menor a 6 caracteres");
          print('The password provided is too weak.');

        } else if (e.code == 'email-already-in-use') {
          showMyDialog("el emaul ya existe");
          print('The account already exists for that email.');

        }

        Navigator.of(_context).pushNamed("/menuview");
      }
      catch (e) {
        print(e);
      }
    }
    else
    {
      showMyDialog("la contraseña no son iguales");
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