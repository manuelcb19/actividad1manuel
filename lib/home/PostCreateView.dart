
import 'package:actividad1manuel/FbClass/FbPostId.dart';
import 'package:actividad1manuel/singletone/FirebaseAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:actividad1manuel/componentes/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../ClasesPropias/CustomUsuario.dart';
import '../FbClass/FbPost.dart';
import '../Singletone/DataHolder.dart';




class PostCreateView extends StatefulWidget{
  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecTitulo=TextEditingController();
  TextEditingController tecPost=TextEditingController();
  FirebaseAdmin conexion = FirebaseAdmin();
  late CustomUsuario usuario;
  DataHolder gggg= DataHolder();

  String id=".";
  String nombreUsuario = ".";

  @override
  void initState() async {
    super.initState();
    usuario = await conexion.conseguirUsuario();
     // Llama al método para cargar el usuario al iniciar la pantalla.
  }

  void conseguirUsuario() async {

    CustomUsuario? pruebaUsuario = await conexion.conseguirUsuario();

    nombreUsuario = pruebaUsuario.nombre;

    print(nombreUsuario + " " + pruebaUsuario.edad.toString());

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