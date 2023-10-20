import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget{

  final String sText;

  const CustomDrawer({super.key,
    required this.sText,});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(sText),
            onTap: () {
            },
          ),
          ListTile(
            title: Text(sText),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }






}