import 'package:actividad1manuel/ClasesPropias/CustomUsuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../FbClass/FbPost.dart';
import '../FbClass/FbPostId.dart';
import 'FirebaseAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbadmin=FirebaseAdmin();
  String sNombre="libreria DataHolder";
  late String sPostTitle;
  late FbPostId selectedPost;
  DataHolder._internal() {
    sPostTitle="Titulo de Post";

  }

  factory DataHolder(){
    return _dataHolder;

  }

  void conseguirUsuario() async {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<CustomUsuario> enlace = db.collection("Usuarios").doc(
        uid).withConverter(fromFirestore: CustomUsuario.fromFirestore,
      toFirestore: (CustomUsuario usuario, _) => usuario.toFirestore(),);

    CustomUsuario usuario;

    DocumentSnapshot<CustomUsuario> docSnap = await enlace.get();
    usuario = docSnap.data()!;

    usuario = usuario;

  }
/*
  void saveSelectedPostInCache() async{
    if(selectedPost!=null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('fbpost_titulo', selectedPost!.titulo);
      prefs.setString('fbpost_cuerpo', selectedPost!.cuerpo);
      prefs.setString('fbpost_surlimg', selectedPost!.sUrlImg);
    }

  }
*/
  void saveSelectedPostInCache() async{
    if(selectedPost!=null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('postsusuario_surlimg', selectedPost!.sUrlImg);
      prefs.setString('postsusuario_usuario', selectedPost!.usuario);
      prefs.setString('postsusuario_titulo', selectedPost!.titulo);
      prefs.setString('postsusuario_post', selectedPost!.post);
      prefs.setString('postsusuario_IdUsuario', selectedPost!.id);

    }

  }

  void insertPostEnFB(FbPostId postNuevo){
    CollectionReference<FbPostId> postsRef = db.collection("postsusuario")
        .withConverter(
      fromFirestore: FbPostId.fromFirestore,
      toFirestore: (FbPostId post, _) => post.toFirestore(),
    );

    postsRef.add(postNuevo);
  }

  Future<FbPostId?> loadPost() async{
    if(selectedPost!=null) return selectedPost;

    await Future.delayed(Duration(seconds: 10));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? postsusuario_titulo = prefs.getString('post_titulo');
    postsusuario_titulo ??= "";

    String? postsusuario_cuerpo = prefs.getString('post_cuerpo');
    if(postsusuario_cuerpo==null){
      postsusuario_cuerpo="";
    }
    String? postsusuario_surlimg = prefs.getString('post_surlimg');
    if(postsusuario_surlimg==null){
      postsusuario_surlimg="";
    }
    String? postsusuario_usuario = prefs.getString('post_usuario');
    if(postsusuario_usuario == null){
      postsusuario_usuario = "";
    }



    print("SHARED PREFERENCES!!!  ----->>>>> "+postsusuario_titulo);
    //selectedPost=FbPost(titulo: fbpost_titulo, cuerpo: fbpost_cuerpo, sUrlImg: fbpost_surlimg);
    selectedPost=new FbPostId(post: postsusuario_cuerpo, titulo: postsusuario_titulo, usuario: postsusuario_usuario,sUrlImg: postsusuario_surlimg, id: "1");
    return selectedPost;
  }

}
/*
class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();

  String sNombre = "libreria DataHolder";
  late String NombrePersona;
  late CustomUsuario Usuario;

  DataHolder._internal() {
    NombrePersona = "Titulo de Post";
  }

  factory DataHolder(){
    return _dataHolder;
  }
}
*/