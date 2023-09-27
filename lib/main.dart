import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Actividad1.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Actividad1 actividad1 = Actividad1();
  runApp(actividad1);


}