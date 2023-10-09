
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomUsuario
{
  final String nombre;
  final int edad;

  CustomUsuario({ required this.nombre, required this.edad});

  //El constructor factory es un constructor especial
  //que nos permite crear instancias especiales de una clase

  factory CustomUsuario.fromFirestore(

        DocumentSnapshot<Map<String, dynamic>> snapshot,

        SnapshotOptions? options,
      ) {
    // A Snapshot simplifies accessing and converting properties
    // in a JSON-like object, for example a JSON object returned from a REST-api service.

    final data = snapshot.data();

    return CustomUsuario(

      nombre: data?['nombre'],
      edad: data?['edad'],

    );
  }
  Map<String, dynamic> toFirestore() {
    return {

      if (nombre != null) "nombre": nombre,
      if (edad != null) "edad": edad,

    };
  }




}