import 'package:actividad1manuel/ClasesPropias/CustomGredCellView.dart';
import 'package:actividad1manuel/ClasesPropias/CustomUsuario.dart';
import 'package:actividad1manuel/ClasesPropias/CustomCellView.dart';
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
  
  late CustomUsuario perfil;

  Map<String, dynamic> miDiccionario = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conseguirUsuario();
  }

  void conseguirUsuario() async {

      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference<CustomUsuario> enlace = db.collection("Usuarios").doc(
          uid).withConverter(fromFirestore: CustomUsuario.fromFirestore,
        toFirestore: (CustomUsuario usuario, _) => usuario.toFirestore(),);

      CustomUsuario usuario;

      DocumentSnapshot<CustomUsuario> docSnap = await enlace.get();
      usuario = docSnap.data()!;
      print("Se ha cargado el usuario su nombre es "+usuario.nombre+" y su edad es: "+ usuario.edad.toString());

      perfil = new CustomUsuario(nombre: usuario.nombre, edad: usuario.edad);

      print("Se ha cargado el perfil su nombre es "+perfil.nombre+" y su edad es: "+ perfil.edad.toString());

      setState(() {
        miDiccionario = {
          'Nombre': usuario.nombre,
          'Edad': usuario.edad,
        };
      });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Libreria(Nombre provisional no final)"),),
      body: Center(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
            ),
            itemCount: 3,
            itemBuilder: creadorDeItemMatriz
        ),
      ),

    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("KYTY"),),
      body: ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: 3,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      ),
    );
  }
*/
  String recorrerDiccionario(Map diccionario) {
    String valores = '';

    for (String p in diccionario.keys) {
      dynamic valor = diccionario[p];
      valores += p+ " : " + valor.toString() + " ";
    }
    return valores;
  }

  Widget? creadorDeItemLista(BuildContext context, int index){
    return CustomCellView(sTexto: recorrerDiccionario(miDiccionario),
        iCodigoColor: 50,
        dFuenteTamanyo: 20);
  }



  Widget? creadorDeItemMatriz(BuildContext context, int index){
    return CustomGredCellView(sText: recorrerDiccionario(miDiccionario),
      dFontSize: 20,
      iColorCode: 0,
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return Column(
      children: [
        Divider(),
      ],
    );
  }
}