import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RialtoUser {
  final FirebaseUser firebaseUser;

  RialtoUser({this.firebaseUser});

  Future<DocumentSnapshot> getDocument() async {
    var snapshot = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: firebaseUser.email)
        .limit(1)
        .snapshots()
        .first;
    return snapshot.documents[0];
  }
}
