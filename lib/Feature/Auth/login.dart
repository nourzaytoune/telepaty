import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// Add this import for sending HTTP requests
// Add this import to handle JSON encoding and decoding
import 'package:tourism/Feature/Auth/newaccount.dart';
import 'package:tourism/Feature/Auth/newpassword.dart';
import 'package:tourism/Feature/Auth/verification.dart';
import 'package:tourism/Network/ApiResponse.dart';
import 'package:tourism/Network/Status.dart';
import 'package:tourism/Network/endpointapi.dart';
import 'package:tourism/Network/networkapiservice.dart';
// Import your HomePage

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  String _phoneError = '';
  NetworkApiService api = NetworkApiService();

  Future<void> _signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        // Handle successful Google sign-in
        print('Google sign-in successful');
        // You can add your logic to create an account or log the user in
      }
    } catch (e) {
      // Handle Google sign-in error
      print('Google sign-in error: $e');
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // Handle successful Facebook sign-in
        print('Facebook sign-in successful');
        // You can add your logic to create an account or log the user in
      }
    } catch (e) {
      // Handle Facebook sign-in error
      print('Facebook sign-in error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo.png', // Replace with your logo asset path
                height: 90,
                color: Color.fromARGB(255, 35, 54, 70),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome Back',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Please enter your details'),
              SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                focusNode: _phoneFocusNode,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  errorText: _phoneError.isNotEmpty ? _phoneError : null,
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateNewPasswordPage()),
                    );
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                        color:
                            Color.fromARGB(255, 35, 54, 70)), // Navy blue color
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 35, 54, 70), // Navy blue color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => Container(
                          height: 80,
                          width: 80,
                          child:
                              Center(child: const CircularProgressIndicator())),
                    );

                    ApiResponse? r = await api.login(
                        _phoneController.text, "0", ApiEndPoints().login);

                    // Close loading
                    Navigator.of(context).pop();

                    // Enable the button after the asynchronous operation completes

                    if (r.status == null) {
                      // Show error
                      final snackBar = SnackBar(
                        content: Text('An Error Occurred: ${r.message}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }

                    if (r.status == Status.ERROR) {
                      // Show error
                      final snackBar = SnackBar(
                        content: Text('Failed: ${r.message}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      return;
                    }

                    if (r.status == Status.COMPLETED) {
                      print("99 1${r.status} ");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpVerificationPage(phoneNumber: _phoneController.text,),
                        ),
                      );
                      return;
                    }
                  },
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      color: Colors.white, // White text color
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 2)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'OR CONTINUE WITH',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 2)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onPressed: _signInWithGoogle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/google icon.png', // Replace with your local asset path
                            height: 30, // Adjust the height as needed
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Google',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onPressed: _signInWithFacebook,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/facebookicon.png', // Replace with your local asset path
                            height: 30, // Adjust the height as needed
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Facebook',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateAccountScreen()),
                  );
                },
                child: Text(
                  'Don’t have an account? Sign Up',
                  style: TextStyle(
                      color:
                          Color.fromARGB(255, 35, 54, 70)), // Navy blue color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
