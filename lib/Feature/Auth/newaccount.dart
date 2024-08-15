import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:tourism/Feature/Auth/login.dart';
import 'package:tourism/HomeDetails/bottom_navigation_bar.dart';
import 'package:tourism/Network/ApiResponse.dart';
import 'package:tourism/Network/Status.dart';
import 'package:tourism/Network/endpointapi.dart';
import 'package:tourism/Network/networkapiservice.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();
  NetworkApiService api = NetworkApiService();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Image.asset(
          'assets/logo.png', // Replace with your logo asset path    
          height: 40,
          color: Color.fromARGB(255, 35, 54, 70),
          // Adjust the height as needed     
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create a New Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Please enter your details and join us now to be part of Travel app',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: null, // Replace with a default image or null
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 35, 54, 70), // Navy blue color
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _birthdayController,
                      decoration: InputDecoration(
                        labelText: 'Birthday (YYYY/MM/DD)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || !RegExp(r'^\d{4}/\d{2}/\d{2}$').hasMatch(value)) {
                          return 'Please enter your birthday in the format YYYY/MM/DD';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _genderController,
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your gender';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 35, 54, 70), // Navy blue color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Rounded corners
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

                 ApiResponse? r = await api.registerUserPersonalInfos(
                        _firstNameController.text, _lastNameController.text , _birthdayController.text, _genderController.text, _emailController.text, ApiEndPoints().registration);

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
                        builder: (context) => CustomBottomNavigationBar(),
                      ),
                    );
                    return;
                  }
                },
                       // onPressed: () {
                         // if (_formKey.currentState!.validate()) {
                            // TODO: Handle form submission
                          //  print('Form submitted');
                         // }
                        
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white, // White text color
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
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
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            " Sign in",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 35, 54, 70)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

