import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../AppRoutes.dart';

class DatabaseOperationsFirebase {
  final db = FirebaseFirestore.instance;

  Future<void> createNewUserFirebase(String nome, String email, String CPF,
      String nascimento, String telefone) async {
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "nome": "$nome",
      "email": "$email",
      "CPF": "$CPF",
      "dataNascimento": "$nascimento",
      "telefone": "$telefone",
    };

    await db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future<void> editUserNameFirebase(String userId, String novoNome) async {
    var collection = FirebaseFirestore.instance.collection('users');

    collection.doc(userId).update({'nome': novoNome});
  }

  Future<List> listUsersFirebase() async {
    List<Object> listUsers = [];

    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        Map<String, dynamic> dicio_user = doc.data();
        dicio_user['id'] = doc.id;
        listUsers.add(dicio_user);
      }
    });

    return listUsers;
  }

  Future<void> deletePersonFirebase(String userId) async {
    db.collection("users").doc(userId).delete();
  }

  Future<void> createNewUserAcoount(
      context, String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential);
      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInEmailPass(
      context, String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.code}')));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.code}')));
      }
    }
  }
}
