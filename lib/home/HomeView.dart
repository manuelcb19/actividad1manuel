import 'package:actividad1manuel/ClasesPropias/CustomUsuario.dart';
import 'package:actividad1manuel/componentes/CustomDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/CustomTextField.dart';

class HomeView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView>{

  TextEditingController bdUsuarioNombre = TextEditingController();
  TextEditingController bdUsuarioEdad = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

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

    print("!!!!!!!!!!!!!!!!!!!!!!!"+usuario.nombre);
    print("!!!!!!!!!!!!!!!!!!!!!!!"+usuario.edad.toString());

  }

  void onClickAceptar()
  {




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
                child: const Center(child: Text('Entry A')),
              ),
              Container(
                height: 50,
                color: Colors.amber[500],
                child: const Center(child: Text('Entry B')),
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