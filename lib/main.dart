import 'package:aula_firebase/AppRoutes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Inicialização de toda a pré-estrutura necessára para o funcionamento de apps de terceiros (nesse caso o Firebase)

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: AppRoutes.loginPage,
    routes: AppRoutes.define(),
  ));
}
