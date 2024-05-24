import 'dart:io';

import 'package:creative_vidio/Home/upload_vidio/upload_controller.dart';
import 'package:creative_vidio/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class UploadForm extends StatefulWidget {

  final File vidioFile;
  final String vidioPath;

  UploadForm({required this.vidioFile, required this.vidioPath, });

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  UploadController uploadVideoController = Get.put(UploadController());
  VideoPlayerController? playerController;
  TextEditingController artistSongTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();



  @override
  void initState() {
    super.initState();

    setState(() {
      playerController = VideoPlayerController.file(widget.vidioFile);
    });

    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    playerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizeVidio
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              child: VideoPlayer(playerController!),
            ),
            // End SizeVidio
            // Jarak
            const SizedBox(
              height: 30,
            ),
          //   End Jarak
          Container(
            // artistSong
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: InputTextWidget(
              textEditingController: artistSongTextEditingController,
              lableString: "Artist - Song",
              iconData: Icons.music_video_rounded,
              isObscure: false,
            ),
          ),
          //   End artistSong
            // Jarak
            const SizedBox(
              height: 10,
            ),
            //   End Jarak
            // Description
            Container(

              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: InputTextWidget(
                textEditingController: descriptionTextEditingController,
                lableString: "Description - Tags",
                iconData: Icons.queue_music_rounded,
                isObscure: false,
              ),
            ),
            //   End Description
            const SizedBox(
              height: 15,
            ),
            //   UploadNow Button
            ElevatedButton(
              onPressed: (){
                  if(
                      artistSongTextEditingController.text.isNotEmpty &&
                      descriptionTextEditingController.text.isNotEmpty
                  ){
                    uploadVideoController.saveVideoInformationToFireStorage(
                        artistSongTextEditingController.text,
                        descriptionTextEditingController.text,
                        widget.vidioPath,
                        context,

                    );

                  }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 139, 131, 194), // Background color of the button
                minimumSize: const Size(400, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              child: Text(
                'Upload Now',
                style: GoogleFonts.anekTelugu(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            //   End UploadNow Button
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }


}
