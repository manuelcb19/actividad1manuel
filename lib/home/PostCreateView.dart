
import 'package:actividad1manuel/FbClass/FbPostId.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:actividad1manuel/componentes/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../ClasesPropias/CustomUsuario.dart';
import '../FbClass/FbPost.dart';
import '../Singletone/DataHolder.dart';




class PostCreateView extends StatelessWidget{
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecTitulo=TextEditingController();
  TextEditingController tecPost=TextEditingController();
  late String id;
  late String nombreUsuario;

  void conseguirUsuario() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<CustomUsuario> enlace = db.collection("Usuarios").doc(
        uid).withConverter(fromFirestore: CustomUsuario.fromFirestore,
      toFirestore: (CustomUsuario usuario, _) => usuario.toFirestore(),);

    CustomUsuario usuario;

    DocumentSnapshot<CustomUsuario> docSnap = await enlace.get();
    usuario = docSnap.data()!;

    nombreUsuario = usuario.nombre;

    id = uid;
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