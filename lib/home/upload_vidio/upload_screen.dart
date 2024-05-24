import 'dart:io';
import 'package:creative_vidio/Home/upload_vidio/upload_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  getVideoFile(ImageSource sourceImg) async {
    final vidioFile = await ImagePicker(). pickVideo(source: sourceImg);

    if(vidioFile != null){
      Get.to(
        UploadForm(
          vidioFile : File(vidioFile.path),
          vidioPath: vidioFile.path,
        ),
      );
    }



  }
  void displayDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          children: [
            // FromGalery
            SimpleDialogOption(
              onPressed: () {
                getVideoFile(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Icon(Icons.image),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Get Vidio From Gallery",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // End FromGalery
            // FromCamera
            SimpleDialogOption(
              onPressed: () {
                getVideoFile(ImageSource.camera);
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Icon(Icons.camera_alt),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Make Video With Camera",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // End FromCamera
            // Cancel
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Icon(Icons.cancel_rounded),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            ),
            //   End Cancel

          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "UploadScreen",
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
    );
  }
}
