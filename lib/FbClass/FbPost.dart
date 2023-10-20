import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost{


  final String titulo;
  final String cuerpo;

  FbPost ({
    required this.titulo,
    required this.cuerpo
  });

  factory FbPost.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbPost(
        titulo: data?['Titulo'],
        cuerpo: data?['Cuerpo']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "Titulo": titulo,
      if (cuerpo != null) "Cuerpo": cuerpo
    };
  }
}