import 'package:creative_vidio/Home/upload_vidio/upload_vidio_screen.dart';
import 'package:creative_vidio/global.dart';
import 'package:flutter/material.dart';
import 'package:creative_vidio/home/following/followings_Screen.dart';
import 'package:creative_vidio/home/for_you/For_You_Screen.dart';
import 'package:creative_vidio/home/profile/profile_screen.dart';
import 'package:creative_vidio/home/search/Search_Screen.dart';
import 'package:creative_vidio/home/upload_vidio/upload_custom_icon.dart';
import 'package:creative_vidio/home/upload_vidio/upload_screen.dart';


class StartHomeScreen extends StatefulWidget {
  const StartHomeScreen({Key? key}) : super(key: key);

  @override
  State<StartHomeScreen> createState() => _StartHomeScreenState();
}

class _StartHomeScreenState extends State<StartHomeScreen> {
  int screenIndex = 0;
  List screenList = [
    const ForYouScreen(),
    const SearchScreen(),
    const UploadScreen(),
    const FollowingsVideoScreen(),
    ProfileScreen(visitUserID: currentUserID,),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 139, 131, 194),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white12,
        currentIndex: screenIndex,
        onTap: (int index) {
          if (index == 2) {
            displayDialogBox(context);
          } else {
            setState(() {
              screenIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30,),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30,),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: UploadCustomIcon(),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_sharp, size: 30,),
            label: "Following",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30,),
            label: "Me",
          ),
        ],
      ),
      body: screenList[screenIndex],
    );
  }}

