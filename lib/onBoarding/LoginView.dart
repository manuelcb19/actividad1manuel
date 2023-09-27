


import 'package:actividad1manuel/componentes/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;

  TextEditingController usuarioControlador = TextEditingController();
  TextEditingController usuarioPassword = TextEditingController();

  void onClickRegistrar(){
    Navigator.of(_context).pushNamed("/registerview");
  }

  void onClickAceptar() async{


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
          //TextButton(onPressed: onClickAceptar, child: Text("Aceptar"),),
          TextButton( onPressed: onClickRegistrar, child: Text("REGISTRO"),),
          TextButton( onPressed: onClickAceptar, child: Text("REGISTRO"),)
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