import 'package:actividad1manuel/ClasesPropias/CustomUsuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAdmin{

  FirebaseFirestore db = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  String conseguiruid(){

    return uid;
  }

  Future<CustomUsuario> conseguirUsuario() async {


    String uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);

    DocumentReference<CustomUsuario> enlace = db.collection("Usuarios").doc(
        uid).withConverter(fromFirestore: CustomUsuario.fromFirestore,
      toFirestore: (CustomUsuario usuario, _) => usuario.toFirestore(),);

    CustomUsuario usuario;

    DocumentSnapshot<CustomUsuario> docSnap = await enlace.get();
    usuario = docSnap.data()!;

    return usuario;

  }

}