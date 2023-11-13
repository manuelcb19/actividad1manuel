import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCellView extends StatelessWidget {

  final String sTexto;
  final int iCodigoColor;
  final double dFuenteTamanyo;
  final int iPosicion;
  final String imagen;
  final Function(int indice) onItemListClickedFun;

  const CustomCellView({super.key,

    required this.sTexto,
    required this.iCodigoColor,
    required this.dFuenteTamanyo,
    required this.iPosicion,
    required this.imagen,
    required this.onItemListClickedFun});


/*
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
          height: 600,
          width: 600,
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 0.3,
                  //image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/kitymanuel-489a1.appspot.com/o/posts%2FZmKoioLe8UhTQaa00kQQwOaJlAE3%2Fimgs%2F1699621916168.jpg?alt=media&token=5e18f2e7-ca54-4c81-95e2-b4a35b7f23a3.jpg"),
                  image: NetworkImage(imagen),
                  fit: BoxFit.contain
              )
          ),
          child: Row(
            children: [
              Text(sTexto, style: TextStyle(fontSize: dFuenteTamanyo)),
              TextButton(onPressed: null,
                  child: Text("+", style: TextStyle(fontSize: dFuenteTamanyo)))
            ],
          )

      ),
      onTap: () {
        onItemListClickedFun(iPosicion);
        //print("tapped on container " + iPosicion.toString());
      },
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      margin: EdgeInsets.symmetric(horizontal: 400), // Ajusta el margen del contenedor exterior
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          onItemListClickedFun(iPosicion);
          //print("tapped on container " + iPosicion.toString());
        },
        child: Container(
          height: 160, // Ajusta el tamaño del contenedor interno
          width: 160, // Ajusta el tamaño del contenedor interno
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.3,
              image: NetworkImage(imagen),
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
                  style: TextStyle(fontSize: dFuenteTamanyo, color: Colors.black),
                ),
              ),
              Positioned(
                bottom: 20, // Ajusta la posición vertical del botón
                right: 20, // Ajusta la posición horizontal del botón
                child: TextButton(
                  onPressed: null,
                  child: Text("+", style: TextStyle(fontSize: dFuenteTamanyo, color: Colors.white)),
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
}