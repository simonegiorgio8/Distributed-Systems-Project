import 'dart:io';

import 'package:flutter/material.dart';
import 'storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cached_network_image/cached_network_image.dart';

class cerca extends StatefulWidget {
  final List<String>? urls;

  const cerca({Key? key,
    required this.urls,
  }) : super(key: key);

  @override
  State<cerca> createState() => _cercaState();
}

class _cercaState extends State<cerca> {
  final Storage storage= Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CERCA'),
      ),
      body: Center(
        child:Column(
          children: [
            FutureBuilder(
                future: storage.listFiles(),
                builder: (BuildContext context,
                    AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData){
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          //shrinkWrap: true,
                          itemCount: snapshot.data!.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ElevatedButton(
                              onPressed: () {},
                              child: Text(snapshot.data!.items[index].name),
                            );
                          }),
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  return Container();
                }),
            FutureBuilder(
                future: storage.downloadURL('image_picker9035347372224091191.jpg'),
                builder: (BuildContext context,
                    AsyncSnapshot<String> snapshot) {

                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData){
                    return Container(
                        width:300,
                        height: 250,
                        child: Image.network(snapshot.data!, fit: BoxFit.cover, ));
                  }
                  if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  return Container();
                }),

            FutureBuilder(
                future: storage.listFiles(),
                builder: (BuildContext context,
                    AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData){
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          //shrinkWrap: true,
                          itemCount: snapshot.data!.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                width:300,
                                height: 250,
                                //child: Image.network(snapshot.data!.items[index].getDownloadURL(), fit: BoxFit.cover,)
                              //child: Image.network(snapshot.data!.items[index].getDownloadURL(), fit: BoxFit.cover,)                            );
                            );
                          }),
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  return Container();
                }),
          ],
        ),
      ),
    );
  }


}
