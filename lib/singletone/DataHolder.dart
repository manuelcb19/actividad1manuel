import 'package:actividad1manuel/ClasesPropias/CustomUsuario.dart';

import '../FbClass/FbPost.dart';

/*
class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();

  String sNombre="libreria DataHolder";
  late String sPostTitle;
  late FbPost selectedPost;

  DataHolder._internal() {
    sPostTitle="Titulo de Post";
  }


  factory DataHolder(){
    return _dataHolder;
  }
}*/
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