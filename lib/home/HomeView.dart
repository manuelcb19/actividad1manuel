
import 'package:actividad1manuel/componentes/CustomDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FbClases/CustomUsuario.dart';
import '../componentes/CustomTextField.dart';

class HomeView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView>{

  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController nombreController = TextEditingController();
  TextEditingController edadController = TextEditingController();

  String datosUsuarios = " dddd";
  String edadUsuario= " ";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conseguirUsuario();

  }

  void conseguirUsuario() async {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<CustomUsuario> enlace = db.collection("Usuarios").doc(uid).withConverter(fromFirestore: CustomUsuario.fromFirestore,
      toFirestore: (CustomUsuario usuario, _) => usuario.toFirestore(),);

    CustomUsuario usuario;

    DocumentSnapshot<CustomUsuario> docSnap = await enlace.get();
    usuario = docSnap.data()!;

   datosUsuarios = usuario.nombre;
   edadUsuario = usuario.edad.toString();


  }

  void onClickAceptar()
  {


      setState(() {
        datosUsuarios = nombreController.text;
        edadUsuario = edadController.text;
      });

    print("casa");
    print(datosUsuarios);
    print(edadUsuario.toString());
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
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Container(
                height: 50,
                color: Colors.amber[600],
                child: Center(child: Text(datosUsuarios)),
              ),
              Container(
                height: 50,
                color: Colors.amber[500],
                child: Center(child: Text(edadUsuario)),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    TextButton(onPressed: onClickAceptar, child: Text("Consultar Datos"),),
                  ]
              )
            ],
          ),
        )
    );
  }
}