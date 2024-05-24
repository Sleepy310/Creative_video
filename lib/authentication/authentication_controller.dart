import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_vidio/authentication/login_screen.dart';
import 'package:creative_vidio/authentication/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'user.dart' as userModel;
import 'package:creative_vidio/Home/home_screen.dart';

class AuthenticationController extends GetxController{
  static AuthenticationController instanceAuth = Get.find();
  late Rx<User?> _currentUser;

  void createAccountForNewUser(String userName, String userEmail, String userPassword) async {

  try{
    //   Create User
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: userEmail.trim(),
      password: userPassword.trim(),
    );
    //   End Create User

    //   Save User Data
    userModel.User user = userModel.User(
      name: userName,
      email: userEmail,
      uid: credential.user!.uid,
    );

    await FirebaseFirestore
        .instance.collection("users")
        .doc(credential.user!.uid)
        .set(user.toJson());

    Get.snackbar("Account Create Succesfully", "You can login to your new account now");
    //   End Save User Data
  }
  catch(error){
    Get.snackbar("Account Create Unsuccessful", "Error accoured while creating account.Try Again");
    Get.to(() => SignUpScreen());
  }

  }

  void loginUserNow (String userEmail, String userPassword) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail.trim(),
          password: userPassword.trim()
      );
      Get.snackbar("Login Succesfully", "Welcome to creative vidio");
    }
    catch(error){
      Get.snackbar("Login Unsuccessful", "Error accoured while login into the account.Try Again");
      Get.to(() => const LoginScreen());
    }

  }

  goToScreen(User? currentUser){
    if(currentUser == null){
      Get.offAll(() => const LoginScreen());
    }else
      {
        Get.offAll(() => const StartHomeScreen());
      }
  }

  @override
  void onReady(){
    super.onReady();

    _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_currentUser, goToScreen);
  }
}
