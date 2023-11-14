import 'package:actividad1manuel/ClasesPropias/CustomUsuario.dart';
import 'package:actividad1manuel/Singletone/DataHolder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCellView extends StatefulWidget {

  final String sTexto;
  final int iCodigoColor;
  final double dFuenteTamanyo;
  final int iPosicion;
  final String imagen;
  final Function(int indice) onItemListClickedFun;
  final String uid;
  final String usuarioPost;


  const CustomCellView({super.key,

    required this.sTexto,
    required this.iCodigoColor,
    required this.dFuenteTamanyo,
    required this.iPosicion,
    required this.imagen,
    required this.uid,
    required this.usuarioPost,
    required this.onItemListClickedFun});

  @override
  State<CustomCellView> createState() => _CustomCellViewState();
}
    @override
    void initState() {
      // TODO: implement initState


    }


class _CustomCellViewState extends State<CustomCellView> {
  Future<String> usuarioNombre() async {

    DataHolder dataHolder = DataHolder();
    CustomUsuario usuario = await dataHolder.fbadmin.obtenerUsuarioPorUID(widget.uid);
    print(usuario.nombre);

    return usuario.nombre;
  }

  @override
  Widget build(BuildContext context) {
    DataHolder dataholder  = DataHolder();
    if(dataholder.fbadmin.esweb())
      {
        return Container(
          height: 800,
          margin: EdgeInsets.symmetric(horizontal: 400), // Ajusta el margen del contenedor exterior
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              widget.onItemListClickedFun(widget.iPosicion);
              //print("tapped on container " + iPosicion.toString());
            },
            child: Container(
              height: 160, // Ajusta el tamaño del contenedor interno
              width: 160, // Ajusta el tamaño del contenedor interno
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.3,
                  image: NetworkImage(widget.imagen),
                  fit: BoxFit.contain,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20, // Ajusta la posición vertical del texto
                    left: 20, // Ajusta la posición horizontal del texto
                    child: Text(widget.usuarioPost,
                      style: TextStyle(fontSize: widget.dFuenteTamanyo, color: Colors.black),
                    ),
                  ),
                  Positioned(
                    bottom: 20, // Ajusta la posición vertical del botón
                    right: 20, // Ajusta la posición horizontal del botón
                    child: TextButton(
                      onPressed: null,
                      child: Text("+", style: TextStyle(fontSize: widget.dFuenteTamanyo, color: Colors.white)),
                    ),
                  ),
                  Positioned(
                    bottom: -10, // Ajusta la posición vertical del área de comentarios
                    left: 10, // Ajusta la posición horizontal del área de comentarios
                    right: 20, // Ajusta la posición horizontal del área de comentarios
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Añadir un comentario...',
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              // Agrega tu lógica para manejar el envío del comentario
                            },
                            child: Text(
                              'Enviar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

    else
      {
        return InkWell(
          child: Container(
            height: 600,
            width: 600,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.3,
                image: NetworkImage(widget.imagen),
                fit: BoxFit.contain,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20, // Ajusta la posición vertical del texto
                  left: 20, // Ajusta la posición horizontal del texto
                  child: Text(
                    "usuario",
                    style: TextStyle(fontSize: widget.dFuenteTamanyo, color: Colors.black),
                  ),
                ),
                Positioned(
                  bottom: 20, // Ajusta la posición vertical del botón
                  right: 20, // Ajusta la posición horizontal del botón
                  child: TextButton(
                    onPressed: null,
                    child: Text("+", style: TextStyle(fontSize: widget.dFuenteTamanyo, color: Colors.white)),
                  ),
                ),
                Positioned(
                  bottom: -10, // Ajusta la posición vertical del área de comentarios
                  left: 10, // Ajusta la posición horizontal del área de comentarios
                  right: 20, // Ajusta la posición horizontal del área de comentarios
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Añadir un comentario...',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            // Agrega tu lógica para manejar el envío del comentario
                          },
                          child: Text(
                            'Enviar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            widget.onItemListClickedFun(widget.iPosicion);
            //print("tapped on container " + iPosicion.toString());
          },
        );
      }

  }
}