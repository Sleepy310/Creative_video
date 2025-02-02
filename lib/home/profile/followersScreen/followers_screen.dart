import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:creative_vidio/home/profile/profile_controller.dart';

import '../profile_screen.dart';


class FollowersScreen extends StatefulWidget
{
  String visitedProfileUserID;

  FollowersScreen({required this.visitedProfileUserID,});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}



class _FollowersScreenState extends State<FollowersScreen>
{
  List<String> followersKeysList = [];
  List followersUsersDataList = [];
  ProfileController controllerProfile = Get.put(ProfileController());

  getFollowersListKeys() async
  {
    var followingDocument = await FirebaseFirestore.instance
        .collection("users").doc(widget.visitedProfileUserID)
        .collection("followers")
        .get();

    for(int i=0; i<followingDocument.docs.length; i++)
    {
      followersKeysList.add(followingDocument.docs[i].id);
    }

    getFollowersKeysDataFromUsersCollection(followersKeysList);
  }

  getFollowersKeysDataFromUsersCollection(List<String> listOfFollowingKeys) async
  {
    var allUsersDocument = await FirebaseFirestore.instance.collection("users").get();

    for (int i = 0; i < allUsersDocument.docs.length; i++)
    {
      for(int j = 0; j < listOfFollowingKeys.length; j++)
      {
        if(((allUsersDocument.docs[i].data() as dynamic)["uid"]) == listOfFollowingKeys[j])
        {
          followersUsersDataList.add((allUsersDocument.docs[i].data()));
        }
      }
    }

    setState(() {
      followersUsersDataList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFollowersListKeys();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            Text(
              controllerProfile.userMap["userName"],
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 2,),

            Text(
              "Followers " + controllerProfile.userMap["totalFollowers"],
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: followersUsersDataList.isEmpty
          ? const Center(
        child: Icon(
          Icons.person_off_sharp,
          color: Colors.black,
          size: 60,
        ),
      )
          : ListView.builder(
        itemCount: followersUsersDataList.length,
        itemBuilder: (context, index)
        {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
            child: Card(
              child: InkWell(
                onTap: ()
                {
                  Get.to(ProfileScreen(
                    visitUserID: followersUsersDataList[index]["uid"],
                  ));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(followersUsersDataList[index]["image"].toString()),
                  ),
                  title: Text(
                    followersUsersDataList[index]["name"].toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    followersUsersDataList[index]["email"].toString(),
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: ()
                    {
                      Get.to(ProfileScreen(
                        visitUserID: followersUsersDataList[index]["uid"],
                      ));
                    },
                    icon: const Icon(
                      Icons.navigate_next_outlined,
                      size: 24,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
