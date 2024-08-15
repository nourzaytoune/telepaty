import 'package:flutter/material.dart';
import 'package:tourism/Feature/Auth/newpassword.dart';
import 'package:tourism/HomeDetails/bottom_navigation_bar.dart';
import 'package:tourism/Network/ApiResponse.dart';
import 'package:tourism/Network/Status.dart';
import 'package:tourism/Network/endpointapi.dart';
import 'package:tourism/Network/networkapiservice.dart';

class OtpVerificationPage extends StatefulWidget {
  late final String phoneNumber;
  OtpVerificationPage({required this.phoneNumber});

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  late List<TextEditingController> otpControllers;
  late List<FocusNode> focusNodes;
  NetworkApiService api = NetworkApiService();

  @override
  void initState() {
    super.initState();
    otpControllers = List.generate(4, (index) => TextEditingController());
    focusNodes = List.generate(4, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateNewPasswordPage()),
            );
            // Handle back button press
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'OTP Verification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "We've sent a one time password (OTP) to the email. Please enter it to complete verification",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 60,
                  child: TextField(
                    controller: otpControllers[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context)
                            .requestFocus(focusNodes[index + 1]);
                      }
                      if (value.isEmpty && index > 0) {
                        FocusScope.of(context)
                            .requestFocus(focusNodes[index - 1]);
                      }
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text('Resend code in'),
                  SizedBox(height: 5),
                  Text(
                    '00:25',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 35, 54, 70), // Navy blue color
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

                  ApiResponse? r = await api.verify(
                     widget.phoneNumber, "0", "", "1111", ApiEndPoints().verify);

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
                child: Text(
                  'verify',
                  style: TextStyle(
                    color: Colors.white, // White text color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
