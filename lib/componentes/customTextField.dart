import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customTextField extends StatelessWidget
{

  TextEditingController tecUsername = TextEditingController();
  String contenido;

  customTextField({Key? key, required this.contenido, required this.tecUsername}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Row row = Row(
      children: [
        Flexible(child : TextFormField(
          controller: tecUsername,
          decoration: InputDecoration(
              border:  OutlineInputBorder(),
              hintText: contenido
          ),
        )
        )
      ],
    );
    return row;
  }

}