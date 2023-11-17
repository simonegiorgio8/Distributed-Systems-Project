import 'package:flutter/material.dart';
import 'package:tag_vocale/FirebaseApi.dart';
import 'package:tag_vocale/FirebaseFile.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;

  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () async {
                await FirebaseApi.downloadFile(file.ref);

                final snackBar= SnackBar(
                  content: Text('Downloaded ${file.name}'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
          )
        ],
      ),
      body: Center(
          child: Column(
            children: [
              SizedBox(height: 60,),
              Image.network(file.url, width: 250, height: 250, fit: BoxFit.cover ),
              SizedBox(height: 60,),
              CustomButton(
                title: 'Aggiungi Tag',
                icon: Icons.image_outlined,
                onClick: () async {
                  //await setTag();
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
                  //await delTag();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tag Rimosso'),
                      )
                  );
                },
              ),
            ],)
      ),
      //body: Image.network(
      //  file.url,
      //  height: double.infinity,
      //  fit: BoxFit.cover,
      //),
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
