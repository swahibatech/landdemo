import 'package:auctionwesbank/components/my_button.dart';
import 'package:auctionwesbank/pages/landlord/tedits/pages/home_page_land.dart';
import 'package:auctionwesbank/pages/tenant/topoedits/dashboard/homepagetenant.dart';
import 'package:flutter/material.dart';
import 'package:auctionwesbank/pages/guest/screens/home_screen.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50),
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
               MyButton(
                        onTap: _signIn,
                      ),

                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GuestScreen()),
                            );
                          },
                          child: Text(
                            'Or continue as guest',
                            style: TextStyle(color: Color.fromARGB(255, 141, 15, 238)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() {
    // Hardcoded credentials for testing
    const landlordEmail = 'landlord@mail.com';
    const landlordPassword = '12345';
    const tenantEmail = 'tenant@mail.com';
    const tenantPassword = '56789';

    // Check credentials and navigate accordingly
    if (_emailController.text == landlordEmail && _passwordController.text == landlordPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageLandy()),
      );
    } else if (_emailController.text == tenantEmail && _passwordController.text == tenantPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePageTenant()),
      );
    } else {
      // Handle incorrect credentials
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid email or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      obscureText: obscureText,
    );
  }
}


