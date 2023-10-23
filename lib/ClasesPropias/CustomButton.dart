import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {


  Function(int indice)? onBotonesClicked;
  Function(String nombre)? onPressed=null;

  CustomButton({Key? key,required this.onBotonesClicked
  }) : super(key: key);

  void fNombre1(String nombre){
    print("DAM1 --->>>"+nombre);
  }

  void fNombre2(String nombre){
    print("DAM2 --->>>"+nombre);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => onBotonesClicked!(0), child: Icon(Icons.list,color: Colors.pink,)),
          TextButton(onPressed: () => onBotonesClicked!(1), child: Icon(Icons.grid_view,color: Colors.pink,)),
          IconButton(onPressed: () => onBotonesClicked!(2), icon: Image.asset("resources/imageninicial.png"))
        ]
    );
  }
}