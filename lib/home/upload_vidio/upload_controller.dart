import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_vidio/Home/home_screen.dart';
import 'package:creative_vidio/Home/upload_vidio/video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadController extends GetxController{

  //   Compress video
  compressVideoFile(String videoFilePath) async {
    final compressedVideoFilePath = await VideoCompress.compressVideo(videoFilePath, quality: VideoQuality.MediumQuality);

    return compressedVideoFilePath!.file;
  }
  // End Compress Video

  // Upload Video to Database
  uploadCompressedVideoFileToFirebaseStorage(String videoID, String videoFilePath) async {
    UploadTask videoUploadTask = FirebaseStorage.instance.ref()
        .child("All Videos")
        .child(videoID)
        .putFile(await compressVideoFile(videoFilePath));

    TaskSnapshot snapshot = await videoUploadTask;

    String downlaodUrlVideo = await snapshot.ref.getDownloadURL();
    return downlaodUrlVideo;
  }
  // End Upload Video to Database

  // Thumbnail
  getThumbnailImage(String videoFilePath) async {
    final thumbnailImage = await VideoCompress.getFileThumbnail(videoFilePath);

    return thumbnailImage;
  }
  // End Thumbnail

  // Upload Thumbnail to Database
  uploadThumbnailFileToFirebaseStorage(String videoID, String videoFilePath) async {
    UploadTask thumbnailUploadTask = FirebaseStorage.instance.ref()
        .child("All Thumbnails")
        .child(videoID)
        .putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot snapshot = await thumbnailUploadTask;

    String downlaodUrlThumbnail = await snapshot.ref.getDownloadURL();
    return downlaodUrlThumbnail;
  }
  // End Upload Thumbnail to Database

  // Save Video Info to FireStorage
  saveVideoInformationToFireStorage
      (
      String artisSongName,
      String descriptionTags,
      String videoFilePath,
      BuildContext context,
      ) async
  {
    try{
      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      String videoID = DateTime.now().millisecondsSinceEpoch.toString();

      String videoDowloadURL = await uploadCompressedVideoFileToFirebaseStorage(videoID, videoFilePath);

      String thumbnailDowloadURL = await uploadThumbnailFileToFirebaseStorage(videoID, videoFilePath);

      Video videoObject = Video(
        userID: FirebaseAuth.instance.currentUser!.uid,
        userName: (userDocumentSnapshot.data() as Map<String, dynamic>)["name"],
        userProfileImage: (userDocumentSnapshot.data() as Map<String, dynamic>)["image"],
        videoID: videoID,
        totalComments: 0,
        totalShares: 0,
        likesList: [],
        artistSongName: artisSongName,
        descriptionTags: descriptionTags,
        videoURL: videoDowloadURL,
        thumbnailURL: thumbnailDowloadURL,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,
      );
      await FirebaseFirestore.instance.collection("videos").doc(videoID).set(videoObject.toJson());

      Get.to(const StartHomeScreen());
      
      Get.snackbar("Upload Successfully", "Your video already uploaded successfully");
    }
    catch(errorMsg) {
      Get.snackbar("Upload Unsuccessful", "Error occurred while uploading your video, Try again.");
    }
  }
  // End Save Video Info to FireStorage

}