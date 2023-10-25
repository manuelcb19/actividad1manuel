import 'dart:io';

import 'package:actividad1manuel/ClasesPropias/CustomButton.dart';
import 'package:actividad1manuel/ClasesPropias/CustomDrawer.dart';
import 'package:actividad1manuel/ClasesPropias/CustomGredCellView.dart';
import 'package:actividad1manuel/ClasesPropias/CustomUsuario.dart';
import 'package:actividad1manuel/ClasesPropias/CustomCellView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../FbClass/FbPost.dart';
import '../onBoarding/LoginView.dart';

class HomeView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {


  TextEditingController bdUsuarioNombre = TextEditingController();
  TextEditingController bdUsuarioEdad = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  late CustomUsuario perfil;
  int _selectedIndex = 0;
  bool bIsList = false;

  final List<FbPost> posts = [];

  Map<String, dynamic> miDiccionario = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conseguirUsuario();
    descargarPosts();
  }

  void descargarPosts() async {
    CollectionReference<FbPost> ref = db.collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),);


    QuerySnapshot<FbPost> querySnapshot = await ref.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      });
    }
  }

  void conseguirUsuario() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<CustomUsuario> enlace = db.collection("Usuarios").doc(
        uid).withConverter(fromFirestore: CustomUsuario.fromFirestore,
      toFirestore: (CustomUsuario usuario, _) => usuario.toFirestore(),);

    CustomUsuario usuario;

    DocumentSnapshot<CustomUsuario> docSnap = await enlace.get();
    usuario = docSnap.data()!;

    print("Se ha cargado el usuario su nombre es " + usuario.nombre +
        " y su edad es: " + usuario.edad.toString());

    perfil = new CustomUsuario(nombre: usuario.nombre, edad: usuario.edad);

    print("Se ha cargado el perfil su nombre es " + perfil.nombre +
        " y su edad es: " + perfil.edad.toString());
  }

  void onBottonMenuPressed(int indice) {
    // TODO: implement onBottonMenuPressed

    setState(() {
      if (indice == 0) {
        bIsList = true;
      }
      else if (indice == 1) {
        bIsList = false;
      }
      else if (indice == 2) {
        exit(0);
      }
    });

    void onClickAceptar() {
      setState(() {
        miDiccionario = {
          'Nombre': perfil.nombre,
          'Edad': perfil.edad,
        };
      });
    }
  }

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
          appBar: AppBar(title: Text("Libreria"),),
          body: Center(
            child: celdasOLista(bIsList),
          ),
          bottomNavigationBar: CustomButton(
              onBotonesClicked: this.onBottonMenuPressed),

          drawer: CustomDrawer(onItemTap: fHomeViewDrawerOnTap,)
      );
    }

    /*@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Libreria(Nombre provisional no final)"),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: posts.length,
                itemBuilder: creadorDeItemMatriz,
              ),
            ),
            TextButton(
              onPressed: onClickAceptar, child: Text("Consultar perfil"),),
          ],
        ),

        drawer: CustomDrawer(sText: "opcion",)
    );
  }
*/
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
        valores += p + " : " + valor.toString() + " ";
      }
      return valores;
    }

  void fHomeViewDrawerOnTap(int indice){
    print("---->>>> "+indice.toString());
    if(indice==0){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) =>  LoginView()),
        ModalRoute.withName('/loginview'),
      );
    }
    else if(indice==1){
      exit(0);
    }
  }

    Widget? creadorDeItemLista(BuildContext context, int index) {
      return CustomCellView(sTexto: recorrerDiccionario(miDiccionario) + " " +
          posts[index].titulo,
          iCodigoColor: 50,
          dFuenteTamanyo: 20);
    }


    Widget? creadorDeItemMatriz(BuildContext context, int index) {
      return CustomGredCellView(
        sText: recorrerDiccionario(miDiccionario) + " " + posts[index].titulo,
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

    Widget celdasOLista(bool isList) {
      if (isList) {
        return ListView.separated(
          padding: EdgeInsets.all(8),
          itemCount: posts.length,
          itemBuilder: creadorDeItemLista,
          separatorBuilder: creadorDeSeparadorLista,
        );
      } else {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5),
            itemCount: posts.length,
            itemBuilder: creadorDeItemMatriz
        );
      }
    }
  }
