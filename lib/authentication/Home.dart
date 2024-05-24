import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:creative_vidio/authentication/login_screen.dart';
import 'package:creative_vidio/authentication/sign_up.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              const SizedBox(
                height: 60,
              ),

              Text("Welcome To",
                style: GoogleFonts.anekTelugu(
                  fontSize: 44,
                  color: Colors.black,
                  fontWeight: FontWeight.bold

                )
              ),

              Image.asset(
                "images/Logo.png",
                width: 250,
              ),

              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Creative ",
                    style: GoogleFonts.anekTelugu(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Vidio ",
                    style: GoogleFonts.anekTelugu(
                      color: Colors.red,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 70,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  SignUpScreen()),
                    ); // Action when button pressed
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.black), // Border berwarna hitam
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50)), // Bentuk border
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black, // Warna teks hitam
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 2, // Tinggi garis
                    color: Colors.black, // Warna garis hitam
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Or",
                    style: TextStyle(
                      color: Colors.black, // Warna teks hitam
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 100,
                    height: 2, // Tinggi garis
                    color: Colors.black, // Warna garis hitam
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  LoginScreen()),
                    ); // Action when button pressed
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.black), // Border berwarna hitam
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50)), // Bentuk border
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black, // Warna teks hitam
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
