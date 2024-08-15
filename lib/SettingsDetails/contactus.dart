import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // navy background
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                       Color.fromARGB(255, 35, 54, 70),
                 Color.fromARGB(255, 75, 94, 110),
                      ],
                    ),
                  ),
                ),
                // Circle shapes
                Positioned(
                  top: 50,
                  left: 20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  right: 20,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(150),
                        bottomRight: Radius.circular(150),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Contact Us text
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF353E49),
                ),
              ),
            ),
            // Form container
            Container(
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Phone number
                  Row(
                    children: [
                      Icon(Icons.phone, color:Color.fromARGB(255, 35, 54, 70),),
                      SizedBox(width: 10),
                      Text(
                        '000-111-222-33',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF353E49),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Email
                  Row(
                    children: [
                      Icon(Icons.email, color:Color.fromARGB(255, 35, 54, 70),),
                      SizedBox(width: 10),
                      Text(
                        'abc12@gmail.co',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF353E49),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Address
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Color.fromARGB(255, 35, 54, 70),),
                      SizedBox(width: 10),
                      Text(
                        '417 Pin Oak Dr.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF353E49),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Text(
                        'New Philadelphia, OH 44663',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF353E49),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Form fields
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Send Message button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 35, 54, 70),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Send Message',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Bottom navy background
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                         Color.fromARGB(255, 35, 54, 70),
                 Color.fromARGB(255, 75, 94, 110),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}