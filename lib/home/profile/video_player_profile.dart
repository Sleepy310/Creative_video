import 'package:creative_vidio/home/comments/comments_screen.dart';
import 'package:creative_vidio/home/profile/video_controller_profile.dart';
import 'package:creative_vidio/widgets/custom_videos_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:creative_vidio/widgets/circular_image_animation.dart';

class VideoPlayerProfile extends StatefulWidget {
  String clickedVideoID;

  VideoPlayerProfile({required this.clickedVideoID,});

  @override
  State<VideoPlayerProfile> createState() => _VideoPlayerProfileState();
}

class _VideoPlayerProfileState extends State<VideoPlayerProfile> {
  final ControllerVidoes controllerVideosProfile = Get.put(ControllerVidoes());

  @override
  Widget build(BuildContext context) {
    controllerVideosProfile.setVideoID(widget.clickedVideoID.toString());

    return Scaffold(
      body: Obx(()
      {
        return PageView.builder(
          itemCount: controllerVideosProfile.clickedVideoFile.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index)
          {
            final clickedVideosInfo = controllerVideosProfile.clickedVideoFile[index];

            return Stack(
              children: [
                CustomVideoPlayer(
                  videoFileURL: clickedVideosInfo.videoURL.toString(),
                ),
                Column  (
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment:   CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 18),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  //   UserName
                                  Text(
                                    "@" + clickedVideosInfo.userName.toString(),
                                    style: GoogleFonts.anekTelugu(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 6,
                                  ),

                                  //   Description
                                  Text(
                                    clickedVideosInfo.descriptionTags.toString(),
                                    style: GoogleFonts.actor(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "images/icons-music.png",
                                        width: 20,
                                        color: Colors.white,
                                      ),
                                      Expanded(
                                          child: Text(
                                            "  "   + clickedVideosInfo.artistSongName.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.anonymousPro(
                                                fontSize: 15,
                                                color: Colors.white
                                            ),
                                          )
                                      )

                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 4
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //   Profile
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SizedBox(
                                    width: 62,
                                    height: 62,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 4,
                                          child: Container(
                                            width: 52,
                                            height: 52,
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(25),
                                              child: Image(
                                                image: NetworkImage(
                                                  clickedVideosInfo.userProfileImage.toString(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Like Button
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    children: [
                                      //   Likes
                                      IconButton(
                                        onPressed: ()
                                        {
                                          controllerVideosProfile.likeOrUnlikeVideo(clickedVideosInfo.videoID.toString());

                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: clickedVideosInfo.likesList!.contains(
                                              FirebaseAuth.instance.currentUser!.uid
                                          ) ? Colors.red : Colors.white,
                                        ),
                                      ),
                                      // Total Likes
                                      Text(
                                        clickedVideosInfo.likesList!.length.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                // Comment Button
                                Column(
                                  children: [
                                    //comment button
                                    IconButton(
                                      onPressed: ()
                                      {
                                        Get.to(CommentsScreen(
                                            videoID: clickedVideosInfo.videoID.toString()
                                        ));

                                      },
                                      icon: const Icon(
                                        Icons.add_comment,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),

                                    //total comments
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        clickedVideosInfo.totalComments.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //share button - total shares
                                Column(
                                  children: [
                                    //share button
                                    IconButton(
                                      onPressed: ()
                                      {

                                      },
                                      icon: const Icon(
                                        Icons.share,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),

                                    //total shares
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        clickedVideosInfo.totalShares.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //profile circular animation
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CircularImageAnimation(
                                    widgetAnimation: SizedBox(
                                      width: 62,
                                      height: 62,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            height: 52,
                                            width: 52,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  colors:
                                                  [
                                                    Colors.grey,
                                                    Colors.white,
                                                  ]
                                              ),
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(25),
                                              child: Image(
                                                image: NetworkImage(
                                                  clickedVideosInfo.userProfileImage.toString(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
