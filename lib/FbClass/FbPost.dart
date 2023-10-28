import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost{


  final String titulo;
  final String cuerpo;
  final String sUrlImg;

  FbPost ({
    required this.titulo,
    required this.cuerpo,
    required this.sUrlImg,
  });

  factory FbPost.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbPost(
        titulo: data?['Titulo'],
        cuerpo: data?['Cuerpo'],
        sUrlImg: data?['sUrlImg'] != null ? data!['sUrlImg'] : ""
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "Titulo": titulo,
      if (cuerpo != null) "Cuerpo": cuerpo
    };
  }
}