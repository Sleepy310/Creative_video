import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_vidio/Home/profile/followersScreen/followers_screen.dart';
import 'package:creative_vidio/Home/profile/followingScreen/following_screen.dart';
import 'package:creative_vidio/home/profile/video_player_profile.dart';
import 'package:creative_vidio/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:creative_vidio/home/profile/profile_controller.dart';
import 'package:creative_vidio/settings/account_settings_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  String? visitUserID;

  ProfileScreen({this.visitUserID,});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen>
{
  ProfileController controllerProfile = Get.put(ProfileController());
  bool isFollowingUser = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    controllerProfile.updateCurrentUserID(widget.visitUserID.toString());

    getIsFollowingValue();
  }

  getIsFollowingValue(){
    FirebaseFirestore.instance
        .collection("users").doc(widget.visitUserID.toString())
        .collection("followers").doc(currentUserID)
        .get().then((value)
    {
      if(value.exists)
      {
        setState(() {
          isFollowingUser = true;
        });
      }
      else
      {
        setState(() {
          isFollowingUser = false;
        });
      }
    });
  }

  Future<void> launchUserSocialProfile(String socialLink) async {
    if(!await launchUrl(Uri.parse("https://" + socialLink)))
    {
      throw Exception("Could not launch" + socialLink);
    }
  }

  handleClickEvent(String choiceClicked)
  {
    switch (choiceClicked)
    {
      case "Settings":
        Get.to(const AccountSettingsScreen());
        break;

      case "Logout":
        FirebaseAuth.instance.signOut();
        Get.snackbar("Logged Out", "you are logged out from the app.");
        
        Future.delayed(const Duration(microseconds: 1000), (){
          SystemChannels.platform.invokeMethod("SystemNavigator.pop");
        });
        break;
    }
  }

  readClickedThumbnailInfo(String clickedThumbnailUrl) async
  {
    var allVideosDocs = await FirebaseFirestore.instance.collection("videos").get();

    for(int i=0; i<allVideosDocs.docs.length; i++)
    {
      if(((allVideosDocs.docs[i].data() as dynamic)["thumbnailURL"]) == clickedThumbnailUrl)
      {
        Get.to( ()=>
            VideoPlayerProfile(clickedVideoID: (allVideosDocs.docs[i].data() as dynamic)["videoID"]),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controllerProfile)
      {
        if(controllerProfile.userMap.isEmpty)
        {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              controllerProfile.userMap["userName"],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            actions: [
              widget.visitUserID.toString() == currentUserID ?
              PopupMenuButton<String>(
                onSelected: handleClickEvent,
                itemBuilder: (BuildContext context)
                {
                  return {
                    "Settings",
                    "Logout",
                  }.map((String choiceClicked)
                  {
                    return PopupMenuItem(
                      value: choiceClicked,
                      child: Text(choiceClicked,
                        style: const TextStyle(
                            color: Colors.white),
                      ),

                    );
                  }).toList();
                }, color: Colors.black,
              ) : Container(),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),

                  //user profile image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      controllerProfile.userMap["userImage"],
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  //followers - following - likes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      //followings
                      GestureDetector(
                        onTap: ()
                        {
                          Get.to( ()=>
                              FollowingScreen(visitedProfileUserID: widget.visitUserID.toString()));

                        },
                        child: Column(
                          children: [
                            Text(
                              controllerProfile.userMap["totalFollowings"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              "Following",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),

                      //space - margin
                      Container(
                        color: Colors.black54,
                        width: 1,
                        height: 15,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                      ),

                      //followers
                      GestureDetector(
                        onTap: ()
                        {
                          Get.to( ()=>
                              FollowersScreen(visitedProfileUserID: widget.visitUserID.toString()));

                        },
                        child: Column(
                          children: [
                            Text(
                              controllerProfile.userMap["totalFollowers"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              "Followers",
                              style: TextStyle(
                                fontSize: 12,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),

                      //space - margin
                      Container(
                        color: Colors.black54,
                        width: 1,
                        height: 15,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                      ),

                      //likes
                      GestureDetector(
                        onTap: ()
                        {

                        },
                        child: Column(
                          children: [
                            Text(
                              controllerProfile.userMap["totalLikes"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              "Likes",
                              style: TextStyle(
                                fontSize: 12,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  //user social links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      //facebook
                      GestureDetector(
                        onTap: ()
                        {
                          if(controllerProfile.userMap["userFacebook"] == "")
                          {
                            Get.snackbar("Facebook Profile", "This user has not connected his/her profile to facebook yet.");
                          }
                          else
                          {
                            launchUserSocialProfile(controllerProfile.userMap["userFacebook"]);
                          }
                        },
                        child: Image.asset(
                          "images/facebook.png",
                          width: 50,
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      //instagram
                      GestureDetector(
                        onTap: ()
                        {
                          if(controllerProfile.userMap["userInstagram"] == "")
                          {
                            Get.snackbar("Instagram Profile", "This user has not connected his/her profile to instagram yet.");
                          }
                          else
                          {
                            launchUserSocialProfile(controllerProfile.userMap["userInstagram"]);
                          }
                        },
                        child: Image.asset(
                          "images/instagram.png",
                          width: 50,
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      //twitter
                      GestureDetector(
                        onTap: ()
                        {
                          if(controllerProfile.userMap["userTwitter"] == "")
                          {
                            Get.snackbar("Twitter Profile", "This user has not connected his/her profile to twitter yet.");
                          }
                          else
                          {
                            launchUserSocialProfile(controllerProfile.userMap["userTwitter"]);
                          }
                        },
                        child: Image.asset(
                          "images/twitter.png",
                          width: 50,
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      //youtube
                      GestureDetector(
                        onTap: ()
                        {
                          if(controllerProfile.userMap["userYoutube"] == "")
                          {
                            Get.snackbar("Youtube Profile", "This user has not connected his/her profile to youtube yet.");
                          }
                          else
                          {
                            launchUserSocialProfile(controllerProfile.userMap["userYoutube"]);
                          }
                        },
                        child: Image.asset(
                          "images/youtube.png",
                          width: 50,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  //follow - unfollow - signout
                  ElevatedButton(
                    onPressed: ()
                    {
                      //if it is the user own profile - user view his/her own profile
                      //signout btn
                      if(widget.visitUserID.toString() == currentUserID) {
                        FirebaseAuth.instance.signOut();

                        Get.snackbar('Logged Out', 'you are logged out from the app.');

                        Future.delayed(const Duration(microseconds: 1000), (){
                          SystemChannels.platform.invokeMethod("SystemNavigator.pop");
                        });
                      }
                      //user view someone's else profile
                      //follow btn - unfollow btn
                      else {
                        //if currentUser is Already following other user
                        //unfollow btn
                        if(isFollowingUser == true)
                        {
                          setState(() {
                            isFollowingUser = false;
                          });
                        }
                        //if currentUser is NOT Already following other user
                        //follow btn
                        else
                        {
                          setState(() {
                            isFollowingUser = true;
                          });
                        }

                        controllerProfile.followUnFollowUser();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero, // Menghilangkan padding default
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0, // Menghilangkan bayangan pada ElevatedButton
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white, // Mengatur background color menjadi putih
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: widget.visitUserID.toString() == currentUserID
                              ? Colors.red
                              : isFollowingUser == true ? Colors.red : Colors.green,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 75), // Atur padding sesuai kebutuhan
                        child: Text(
                          widget.visitUserID.toString() == currentUserID
                              ? "Sign Out"
                              : isFollowingUser == true ? "Unfollow" : "Follow",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Menambahkan warna teks agar kontras dengan latar belakang putih
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //user's videos - thumbnails
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controllerProfile.userMap["thumbnailsList"].length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: .7,
                      crossAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index)
                    {
                      String eachThumbnailUrl = controllerProfile.userMap["thumbnailsList"][index];

                      return GestureDetector(
                        onTap: ()
                        {
                          readClickedThumbnailInfo(eachThumbnailUrl);

                        },
                        child: Image.network(
                          eachThumbnailUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
