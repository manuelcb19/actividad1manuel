
import 'dart:html';

import 'package:actividad1manuel/FbClass/FbPostId.dart';
import 'package:actividad1manuel/singletone/FirebaseAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:actividad1manuel/componentes/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  ImagePicker _picker = ImagePicker();

  String id=".";
  String nombreUsuario = ".";
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
          TextButton(onPressed: conseguirUsuario, child: Text("selecionar imagen camara"),),
          TextButton(onPressed: conseguirUsuario, child: Text("CargarUsuarios"),),
          TextButton(onPressed: () {
            FbPostId postNuevo=new FbPostId(post: tecPost.text, usuario: nombreUsuario, titulo: tecTitulo.text, sUrlImg: "", id: id);

            CollectionReference<FbPostId> postsRef = db.collection("PruebaPostUsuario")
                .withConverter(
              fromFirestore: FbPostId.fromFirestore,
              toFirestore: (FbPostId post, _) => post.toFirestore(),
            );

            postsRef.add(postNuevo);
          }, child: Text("Postear"))
        ],

      ),
    );

  }
}