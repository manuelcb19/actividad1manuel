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
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../FbClass/FbPost.dart';
import '../FbClass/FbPostId.dart';
import '../Singletone/DataHolder.dart';
import '../onBoarding/LoginView.dart';

class HomeViewMovil extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeViewMovil> {


  TextEditingController bdUsuarioNombre = TextEditingController();
  TextEditingController bdUsuarioEdad = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  final _advancedDrawerController = AdvancedDrawerController();
  late CustomUsuario perfil;
  int _selectedIndex = 0;
  bool bIsList = false;

  final List<FbPostId> posts = [];
  //final List<FbPostId> postsId = [];
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

    CollectionReference<FbPostId> postsRef = db.collection("PostUsuario")
        .withConverter(
      fromFirestore: FbPostId.fromFirestore,
      toFirestore: (FbPostId post, _) => post.toFirestore(),);

    QuerySnapshot<FbPostId> querySnapshot = await postsRef.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      });
    }
    print("la lista tiene este " + posts.length.toString());
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
          descargarPosts();
          print("casa");
          if(posts.isEmpty)
            {
              print("la lista esta vacia");
            }
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

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Drawer Example'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),

        ),
        body: Center(
          child: celdasOLista(bIsList),
        ),
        bottomNavigationBar: CustomButton(onBotonesClicked: this.onBottonMenuPressed),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/postcreateview");
          },
          child: Icon(Icons.add),
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/flutter_logo.png',
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.favorite),
                  title: Text('Favourites'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


/*
    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
          appBar: AppBar(title: Text("Libreriaaaaaaaaaaa"),
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
*/
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
          posts[index].post,
          iCodigoColor: 50,
          dFuenteTamanyo: 20,
          iPosicion: index,
          imagen: posts[index].sUrlImg,
          uid: posts[index].id,
          usuarioPost: posts[index].usuario,
          onItemListClickedFun:onItemListClicked);
    }


    Widget? creadorDeItemMatriz(BuildContext context, int index) {
      return CustomGredCellView(
        sText: recorrerDiccionario(miDiccionario) + " " + posts[index].post,
        dFontSize: 20,
        imagen: posts[index].sUrlImg,
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
