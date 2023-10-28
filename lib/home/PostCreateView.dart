
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:actividad1manuel/componentes/CustomTextField.dart';
import 'package:flutter/material.dart';

import '../FbClass/FbPost.dart';
import '../Singletone/DataHolder.dart';




class PostCreateView extends StatelessWidget{
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecTitulo=TextEditingController();
  TextEditingController tecCuerpo=TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child:  customTextField(contenido: "introduzca su usuario", tecUsername: tecTitulo,oscuro: false,),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: customTextField(contenido: "introduzca su usuario", tecUsername: tecTitulo,oscuro: false,),
          ),
          Image.network(""),
          TextButton(onPressed: () {
            FbPost postNuevo=new FbPost(
                titulo: tecTitulo.text,
                cuerpo: tecCuerpo.text,
                sUrlImg: "");

            CollectionReference<FbPost> postsRef = db.collection("Posts")
                .withConverter(
              fromFirestore: FbPost.fromFirestore,
              toFirestore: (FbPost post, _) => post.toFirestore(),
            );

            postsRef.add(postNuevo);
          }, child: Text("Postear"))
        ],

      ),
    );

  }


}