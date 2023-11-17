import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tag_vocale/FirebaseApi.dart';
import 'package:tag_vocale/foto_selected.dart';
import 'package:tag_vocale/page/image_page.dart';
import 'storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'FirebaseFile.dart';

class cerca extends StatefulWidget {
  //final List<String>? urls;

  const cerca({Key? key,
              //required this.urls,
  }) : super(key: key);

  @override
  State<cerca> createState() => _cercaState();
}

class _cercaState extends State<cerca> {
  final Storage storage= Storage();
  
  late Future<List<FirebaseFile>> futureFiles;
  
  @override
  void initState(){
    super.initState();
    futureFiles = FirebaseApi.listAll('immagini/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CERCA'),
      ),
      body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError){
                  return Center(child: Text('ERRORE!'));
                }else {
                  final files = snapshot.data!;
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //buildHeader(files.length),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                            itemCount: files.length,
                            itemBuilder: (context, index){
                              final file =files[index];
                              
                              return buildFile(context, file);
                            }
                        ),
                      ),
                    ],
                  );
                }
            }
          },
      )
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file)=> ListTile(
    leading: Image.network(
      file.url,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    ),
    title: Text(
      file.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.blue,
      ),
    ),
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ImagePage(file: file),
    )),
  );


}
