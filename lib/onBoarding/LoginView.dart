


import 'package:actividad1manuel/componentes/customTextField.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;

  TextEditingController usuarioControlador = TextEditingController();
  TextEditingController usuarioPassword = TextEditingController();
  TextEditingController usuarioPasswordVerificar = TextEditingController();

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
    // TODO: implement build
    Column columna = Column(children: [
      Text("Bienvenido a Actividad 1", style: TextStyle(fontSize: 25)),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
        child:  customTextField(contenido: "introduzca su usuario", tecUsername: usuarioControlador)
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
          child:  customTextField(contenido: "introduzca su Contraseña", tecUsername: usuarioPassword)
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
          child:  customTextField(contenido: "Repita su contraseña", tecUsername: usuarioPasswordVerificar)
      ),
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