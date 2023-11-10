import 'dart:io';

import 'package:actividad1manuel/ClasesPropias/CustomButton.dart';
import 'package:actividad1manuel/ClasesPropias/CustomDrawer.dart';
import 'package:actividad1manuel/ClasesPropias/CustomGredCellView.dart';
import 'package:actividad1manuel/ClasesPropias/CustomUsuario.dart';
import 'package:actividad1manuel/ClasesPropias/CustomCellView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../FbClass/FbPost.dart';
import '../FbClass/FbPostId.dart';
import '../Singletone/DataHolder.dart';
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

  DataHolder dataHolder = DataHolder();
  late CustomUsuario perfil;
  int _selectedIndex = 0;
  bool bIsList = false;

  final List<FbPost> posts = [];
  final List<FbPostId> postsId = [];
  final List<CustomUsuario> listaUsuarios = [];


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
  void uploadImageToFirebase(File imageFile) async {
    if (imageFile != null) {
      // Obtiene la referencia de Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('user_profile_images/${DateTime.now()}.png');

      // Sube la imagen
      UploadTask uploadTask = storageReference.putFile(imageFile);

      // Monitorea el progreso de la carga
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print('Progreso: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
      });

      // Espera a que se complete la carga
      await uploadTask.whenComplete(() {
        print('Carga completada');
      });

      // Obtiene la URL de la imagen después de cargarla
      String downloadURL = await storageReference.getDownloadURL();

      // Guarda esta URL en tu base de datos si es necesario.
    }
  }



  void conseguirUsuario() async {


    perfil = await dataHolder.fbadmin.conseguirUsuario();


  }

  void onItemListClicked(int index){
    DataHolder().selectedPost=posts[index];
    //DataHolder().Usuario=perfil;
    Navigator.of(context).pushNamed("/usuarioview");

  }


  void onBottonMenuPressed(int indice) {
    setState(() {
      switch(indice)
      {
        case 0:
          bIsList = true;
          break;
        case 1:
          bIsList = false;
          break;
        case 2:
          exit(0);
        case 3:
          Navigator.of(context).pushNamed("/usuarioview");
          break;
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
          appBar: AppBar(title: Text("Libreria"),
        shadowColor: Colors.orangeAccent, // Color de sombra del AppBar
        backgroundColor: Colors.orangeAccent,),
        backgroundColor: Colors.amber[200],// Color de fondo del AppBar
        body: Center(

          child: celdasOLista(bIsList),
        ),
        bottomNavigationBar: CustomButton(onBotonesClicked: this.onBottonMenuPressed),
        drawer: CustomDrawer(onItemTap: fHomeViewDrawerOnTap,),
        floatingActionButton:FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/postcreateview");
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
        /**/
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
          dFuenteTamanyo: 20,
          iPosicion: index,
          onItemListClickedFun:onItemListClicked);
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
