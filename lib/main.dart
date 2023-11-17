import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'foto_selected.dart';
import 'cerca.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const ImagePickerApp(),
    );
  }
}

class ImagePickerApp extends StatefulWidget {
  const ImagePickerApp({Key? key}) : super(key: key);

  @override
  State<ImagePickerApp> createState() => _ImagePickerAppState();
}

class _ImagePickerAppState extends State<ImagePickerApp> {
  File? _image;

  Future getImage(ImageSource source) async{
    try{
      final image =await ImagePicker().pickImage(source: source); //pickImage è del pacchetto image_picker
      if (image == null) return;

      final imageTemporary= File(image.path);
      final imagePermanent = await saveFilePermanently(image.path);

      setState(() {
        this._image = imagePermanent;
      });

      Navigator.of(this.context).push(MaterialPageRoute(
          builder: (context) => fotoSelected(image: _image),
      ));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e ');
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory =await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path); //il secondo è il nuovo path
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
          child: Column(
            children: [
            SizedBox(height: 60,),
              Image.network('https://i.ibb.co/XZLPXwc/Senza-titolo-1.jpg'),
          //    _image != null ? Image.file(_image!, width: 250, height: 250, fit: BoxFit.cover ) : Image.network('https://picsum.photos/250?image=9'),
            SizedBox(height: 60,),
            CustomButton(
                title: 'Scegli dalla Galleria',
                icon: Icons.image_outlined,
                onClick: () => getImage(ImageSource.gallery),
            ),
            SizedBox(height: 30,
            ),
            CustomButton(
                title: 'Fotocamera',
                icon: Icons.camera,
                onClick: () => getImage(ImageSource.camera),
            ),
              SizedBox(height: 30,),
              ButtonRicerca(
                title: 'RICERCA VOCALE',
                icon: Icons.mic,
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

  Widget ButtonRicerca({
    required String title,
    required IconData icon,
    //required VoidCallback onClick,
  })  {
    return Container(
      width: 280,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(this.context).push(MaterialPageRoute(
            builder: (context) => cerca(),
          ));
        },
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
