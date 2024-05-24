import 'package:creative_vidio/authentication/Home.dart';
import 'package:creative_vidio/authentication/sign_up.dart';
import 'package:creative_vidio/authentication/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:creative_vidio/widgets/input_text_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
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
      body:
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [


                Text("Welcome Back",
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
                  height: 70,
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

              //   LoginButton
                ElevatedButton(
                  onPressed: (){
                    if(
                        emailtextEditingController.text.isNotEmpty &&
                        passwordtextEditingController.text.isNotEmpty
                    )
                    {
                      authenticationController.loginUserNow(
                        emailtextEditingController.text,
                        passwordtextEditingController.text
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
                    'Login',
                    style: GoogleFonts.anekTelugu(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              //   EndLoginButton
                const SizedBox(height: 10),
              //   NotHaveAccountText
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't Have an Account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black26
                    ),
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(() => SignUpScreen());
                      },
                      child: const Text("SignUp Now",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                      ),
                      ),
                    ),
                  ],
                )
              //   EndNotHaveAccountText
              ],
            ),
          ),
        )
    );
  }
}
