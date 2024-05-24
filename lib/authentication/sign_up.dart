import 'package:creative_vidio/authentication/authentication_controller.dart';
import 'package:creative_vidio/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:creative_vidio/authentication/Home.dart';
import 'package:creative_vidio/widgets/input_text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
  TextEditingController usernametextEditingController = TextEditingController();

  var authenticationController = AuthenticationController.instanceAuth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Icon back berwarna hitam
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            ); // Kembali ke layar sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              Text("Create New Account",
                  style: GoogleFonts.anekTelugu(
                      fontSize: 34,
                      color: Colors.black,
                      fontWeight: FontWeight.bold

                  )
              ),

              Image.asset(
                "images/Logo.png",
                width: 250,
              ),

              const SizedBox(
                height: 50,
              ),

              // UserName
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InputTextWidget(
                  textEditingController: usernametextEditingController,
                  lableString: "Username",
                  iconData: Icons.person,
                  isObscure: false,
                ),
              ),
              // End UserName

              const SizedBox(
                height: 15,
              ),

              // Email
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InputTextWidget(
                  textEditingController: emailtextEditingController,
                  lableString: "Email",
                  iconData: Icons.email_rounded,
                  isObscure: false,
                ),
              ),
              // End Email

              const SizedBox(
                height: 15,
              ),
              
              // Password
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InputTextWidget(
                  textEditingController: passwordtextEditingController,
                  lableString: "Password",
                  iconData: Icons.lock_rounded,
                  isObscure: true,
                ),
              ),
              // End Password
              const SizedBox(height: 20),
            //   SignUpButton
              ElevatedButton(
                onPressed: (){
                  if
                  (
                      usernametextEditingController.text.isNotEmpty &&
                      emailtextEditingController.text.isNotEmpty &&
                      passwordtextEditingController.text.isNotEmpty

                  )
                  {
                    authenticationController.createAccountForNewUser(
                        usernametextEditingController.text,
                        emailtextEditingController.text,
                        passwordtextEditingController.text,
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
                  'Sign Up',
                  style: GoogleFonts.anekTelugu(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            //   End SignUpButton
              const SizedBox(height: 10),
            //   AlreadyHaveAnAccount
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Have an Account? ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black26
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(() => LoginScreen());
                    },
                    child: const Text("Login Now",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              )
            //   End AlreadyHaveAnAccount
            ],
          ),
        ),
      ),
    );
  }
}
