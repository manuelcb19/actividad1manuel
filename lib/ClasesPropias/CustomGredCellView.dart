import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGredCellView extends StatelessWidget{

  final String sText;
  final int iColorCode;
  final double dFontSize;

  const CustomGredCellView({super.key,
    required this.sText,
    required this.iColorCode,
    required this.dFontSize});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.3,
                image: NetworkImage("https://media.tenor.com/zBc1XhcbTSoAAAAC/nyan-cat-rainbow.gif"),
                fit: BoxFit.cover
            )
        ),
        color: Colors.amber[iColorCode],
        child: Column(
          children: [
            Image.asset("/home/alumno1/StudioProjects/actividad/resources/logoInicio.png",width: 70,
                height: 70),
            Text(sText,style: TextStyle(fontSize: dFontSize)),
            TextButton(onPressed: null, child: Text("+",style: TextStyle(fontSize: dFontSize)))
          ],
        )

    );
  }



}