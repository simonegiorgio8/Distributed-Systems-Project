import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'storage_service.dart';


class fotoSelected extends StatefulWidget {
  final File? image;

  const fotoSelected({Key? key,
                      required this.image,
  }) : super(key: key);

  @override
  State<fotoSelected> createState() => _fotoSelectedState();
}

class _fotoSelectedState extends State<fotoSelected> {

  final Storage storage= Storage();

  Future setTag() async{

  try{
    final String tag='mare';

    final imm= widget.image;
    if(imm==null) return null;

    //final pth= File(imm.path);
    final pth= imm.path;
    final fileName= basename(imm.path);

    print(pth);
    print(fileName);

    storage
        .uploadFile(pth, fileName)
        .then((value) => print('Done'));

  } catch (e){
    print('errore nel salvataggio:  $e ');
  }
  }

  Future delTag() async{

    try{
      final String tag='mare';

      final imm= widget.image;
      if(imm==null) return null;

      //final pth= File(imm.path);
      final pth= imm.path;
      final fileName= basename(imm.path);

      print(pth);
      print(fileName);

      storage
          .deleteFile(pth, fileName)
          .then((value) => print('Done'));

    } catch (e){
      print('errore nel salvataggio:  $e ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected'),
      ),
      body: Center(
          child: Column(
            children: [
              SizedBox(height: 60,),
              Image.file(widget.image!, width: 250, height: 250, fit: BoxFit.cover ),
              SizedBox(height: 60,),
              CustomButton(
                title: 'Aggiungi Tag',
                icon: Icons.image_outlined,
                onClick: () async {
                  await setTag();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Tag Aggiunto'),
                    )
                  );
                },
              ),
              SizedBox(height: 30,
              ),
              CustomButton(
                title: 'Rimuovi Tag',
                icon: Icons.camera,
                onClick: () async {
                  await delTag();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tag Rimosso'),
                      )
                  );
                },
              ),
            ],)
      ),
    );
  }


  Widget CustomButton({
    required String title,
    required IconData icon,
    required VoidCallback onClick,
  })  {
    return Container(
      width: 280,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 20,),
            Text(title)
          ],
        ),
      ),
    );
  }

}
