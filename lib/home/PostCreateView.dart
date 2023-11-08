
import 'dart:io';

import 'package:actividad1manuel/FbClass/FbPostId.dart';
import 'package:actividad1manuel/singletone/FirebaseAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:actividad1manuel/componentes/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../ClasesPropias/CustomUsuario.dart';
import '../FbClass/FbPost.dart';
import '../Singletone/DataHolder.dart';
import 'package:image_picker/image_picker.dart';




class PostCreateView extends StatefulWidget{
  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecTitulo=TextEditingController();
  TextEditingController tecPost=TextEditingController();
  late CustomUsuario usuario;
  DataHolder conexion= DataHolder();


  String id=".";
  String nombreUsuario = ".";

  ImagePicker _picker = ImagePicker();
  File _imagePreview=File("");

 @override
  void initState() {
    super.initState();
    conseguirUsuario();

     // Llama al método para cargar el usuario al iniciar la pantalla.
  }

  void onGalleyClicked() async{

    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        _imagePreview=File(image.path);
      });
    }
}

void onCameraClicked() async{

    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image!=null){
      setState(() {
        _imagePreview=File(image.path);
      });
}

    }

  void subirImagen() async {
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final rutaAFicheroEnNube = storageRef.child("imgs/mountains.jpg");

    try {
      await rutaAFicheroEnNube.putFile(_imagePreview);
    } on FirebaseException catch (e) {
      // ...
    }
    print("SE HA SUBIDO LA IMAGEN");
  }

  void conseguirUsuario() async {

    usuario = await conexion.fbadmin.conseguirUsuario();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child:  customTextField(contenido: "introduzca el titulo del post", tecUsername: tecTitulo,oscuro: false,),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: customTextField(contenido: "introduzca el posts", tecUsername: tecPost,oscuro: false,),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: customTextField(contenido: nombreUsuario, tecUsername: tecPost,oscuro: false,),
          ),

          Image.network(""),
          TextButton(onPressed: onGalleyClicked, child: Text("CargarImagen"),),
          TextButton(onPressed: onCameraClicked, child: Text("selecionar imagen camara"),),
          TextButton(onPressed: conseguirUsuario, child: Text("CargarUsuarios"),),
          TextButton(onPressed: subirImagen, child: Text("Camara")),
          TextButton(onPressed: () {
            FbPostId postNuevo=new FbPostId(post: tecPost.text, usuario: nombreUsuario, titulo: tecTitulo.text, sUrlImg: "gggggg", id: id);

            CollectionReference<FbPostId> postsRef = db.collection("PruebaPostUsuario")
                .withConverter(
              fromFirestore: FbPostId.fromFirestore,
              toFirestore: (FbPostId post, _) => post.toFirestore(),
            );
            Image.file(_imagePreview,width: 400,height: 400,);
            Row(
            children: [
            TextButton(onPressed: onGalleyClicked, child: Text("Galeria")),
            TextButton(onPressed: onCameraClicked, child: Text("Camara")),

            ],
            );
            postsRef.add(postNuevo);
          }, child: Text("Postear"))
        ],

      ),
    );

  }
}