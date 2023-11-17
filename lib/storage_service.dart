import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';


class Storage{
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final FirebaseFirestore firestoreRef= FirebaseFirestore.instance;
  String collectionName = "immagini";

  
  Future<void> uploadFile(
      String filePath,
      String fileName,
      ) async{
    File file = File(filePath); //converto filepath in fileobj

    try{
      await storage.ref('immagini/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {print(e);}
  }

  Future<void> deleteFile(
      String filePath,
      String fileName,
      ) async{
    File file = File(filePath); //converto filepath in fileobj

    try{
      await storage.ref('immagini/$fileName').delete();
    } on firebase_core.FirebaseException catch (e) {print(e);}
  }



  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results= await storage.ref('immagini').listAll();
    results.items.forEach((firebase_storage.Reference ref){
      print('Found file: $ref');
    });
    return results;
  }

  Future<String> downloadURL(String imageName) async{
    String downloadURL= await storage.ref('immagini/$imageName').getDownloadURL();

    return downloadURL;
  }




}

