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
                image: NetworkImage("https://media1.giphy.com/media/Q5RjtPsU4Ds5ByAVI9/giphy.gif?cid=6c09b952oceo79bkg7hzpbm007jfk9tcj4b6b262q2rn6azn&ep=v1_gifs_search&rid=giphy.gif&ct=g"),
                fit: BoxFit.cover
            )
        ),
        color: Colors.amber[iColorCode],
        child: Column(
          children: [
            Image.asset("resources/imagenInicial.png",width: 70,
                height: 70),
            Text(sText,style: TextStyle(fontSize: dFontSize)),
            TextButton(onPressed: null, child: Text("+",style: TextStyle(fontSize: dFontSize)))
          ],
        )

    );
  }



}