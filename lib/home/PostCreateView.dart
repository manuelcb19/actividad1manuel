
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

  String imgUrl="";

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


  void conseguirUsuario() async {

    usuario = await conexion.fbadmin.conseguirUsuario();

  }

  void subirPost() async {
    //-----------------------INICIO DE SUBIR IMAGEN--------
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    String rutaEnNube=
        "posts/"+FirebaseAuth.instance.currentUser!.uid+"/imgs/"+
            DateTime.now().millisecondsSinceEpoch.toString()+".jpg";
    print("RUTA DONDE VA A GUARDARSE LA IMAGEN: "+rutaEnNube);

    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);
    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");
    try {
      await rutaAFicheroEnNube.putFile(_imagePreview,metadata);

    } on FirebaseException catch (e) {
      print("ERROR AL SUBIR IMAGEN: "+e.toString());
      // ...
    }

    print("SE HA SUBIDO LA IMAGEN");

    imgUrl=await rutaAFicheroEnNube.getDownloadURL();

    print("URL DE DESCARGA: "+imgUrl);
  }

  void subirElPost()
  {

    print(imgUrl);

    FbPostId postNuevo=new FbPostId(post: tecPost.text, usuario: usuario.nombre, titulo: tecTitulo.text, sUrlImg: imgUrl, id: conexion.fbadmin.uid);

    CollectionReference<FbPostId> postsRef = db.collection("PostUsuario")
        .withConverter(
      fromFirestore: FbPostId.fromFirestore,
      toFirestore: (FbPostId post, _) => post.toFirestore(),
    );
    postsRef.add(postNuevo);
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
          //Image.network(""),
          TextButton(onPressed: onGalleyClicked, child: Text("CargarImagen"),),
          TextButton(onPressed: onCameraClicked, child: Text("selecionar imagen camara"),),
          TextButton(onPressed: conseguirUsuario, child: Text("CargarUsuarios"),),
          TextButton(onPressed: subirPost, child: Text("Camara")),
          TextButton(onPressed: subirElPost, child: Text("SubirPostCompleto")),
          TextButton(onPressed: () {
            Image.file(_imagePreview,width: 400,height: 400,);
            Row(
            children: [
            TextButton(onPressed: onGalleyClicked, child: Text("Galeria")),
            TextButton(onPressed: onCameraClicked, child: Text("Camara")),
            ],
            );
          }, child: Text("No se lo que hace")),

        ],

      ),
    );





  }
}