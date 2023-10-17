import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCellView extends StatelessWidget{

  final String sTexto;
  final int iCodigoColor;
  final double dFuenteTamanyo;

  const CustomCellView({super.key,
    required this.sTexto,
    required this.iCodigoColor,
    required this.dFuenteTamanyo});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.amber[iCodigoColor],
        child: Row(
          children: [
            Image.asset("resources/imagenInicial.png",width: 30,
                height: 45),
            Text(sTexto)
          ],
        )

    );
  }



}