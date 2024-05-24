import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_vidio/home/upload_vidio/video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ControllerForYou extends GetxController
{
  final Rx<List<Video>> forYouVideosList = Rx<List<Video>>([]);
  List<Video> get ForYouAllVideosList => forYouVideosList.value;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    forYouVideosList.bindStream(
      FirebaseFirestore.instance
          .collection("videos")
          .orderBy("totalComments", descending: true)
          .snapshots()
          .map((QuerySnapshot snapshotQuery)
      {
        List<Video> videoList = [];

        for(var eachVideo in snapshotQuery.docs)
          {
            videoList.add(
              Video.fromDocumentSnapshot(eachVideo)
            );
          }

        return videoList;
      })
    );
  }

  likeOrUnlikeVideo(String videoID) async {
    var currentUserID = FirebaseAuth.instance.currentUser!.uid.toString();

    DocumentSnapshot snapshotDoc = await FirebaseFirestore.instance
        .collection("videos")
        .doc(videoID)
        .get();

    //if already Liked
    if((snapshotDoc.data() as dynamic)["likesList"].contains(currentUserID))
    {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoID)
          .update(
          {
            "likesList": FieldValue.arrayRemove([currentUserID]),
          });
    }
    //if NOT-Liked
    else
    {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoID)
          .update(
          {
            "likesList": FieldValue.arrayUnion([currentUserID]),
          });
    }
  }

}


