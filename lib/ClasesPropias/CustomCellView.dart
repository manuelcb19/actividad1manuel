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



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
          color: Colors.amber[iCodigoColor],
          child: Row(
            children: [
              Image.asset(imagen, width: 70,
                  height: 70),
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
}