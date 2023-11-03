import 'package:actividad1manuel/ClasesPropias/CustomUsuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../FbClass/FbPost.dart';
import 'FirebaseAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbadmin=FirebaseAdmin();
  String sNombre="libreria DataHolder";
  late String sPostTitle;
  late FbPost selectedPost;
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

  void saveSelectedPostInCache() async{
    if(selectedPost!=null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('fbpost_titulo', selectedPost!.titulo);
      prefs.setString('fbpost_cuerpo', selectedPost!.cuerpo);
      prefs.setString('fbpost_surlimg', selectedPost!.sUrlImg);
    }

  }

  void insertPostEnFB(FbPost postNuevo){
    CollectionReference<FbPost> postsRef = db.collection("Posts")
        .withConverter(
      fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),
    );

    postsRef.add(postNuevo);
  }

  Future<FbPost?> loadFbPost() async{
    if(selectedPost!=null) return selectedPost;

    await Future.delayed(Duration(seconds: 10));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fbpost_titulo = prefs.getString('fbpost_titulo');
    fbpost_titulo ??= "";
    String? fbpost_cuerpo = prefs.getString('fbpost_cuerpo');
    if(fbpost_cuerpo==null){
      fbpost_cuerpo="";
    }
    String? fbpost_surlimg = prefs.getString('fbpost_surlimg');
    if(fbpost_surlimg==null){
      fbpost_surlimg="";
    }
    print("SHARED PREFERENCES!!!  ----->>>>> "+fbpost_titulo);
    selectedPost=FbPost(titulo: fbpost_titulo, cuerpo: fbpost_cuerpo, sUrlImg: fbpost_surlimg);
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