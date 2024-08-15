import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final Color primaryColor = Color.fromARGB(255, 35, 54, 70);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text('See What\'s Up',
            style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(vertical: 26),
            child: Text(
              'Notifications!',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  NotificationTile(
                    imageUrl: 'assets/beach4.jpeg',
                    message: ' Central Park',
                    sender: 'NYC Guide',
                    dateTime: 'July 18, 2024 - 10:00 AM',
                  ),
                  NotificationTile(
                    imageUrl: 'assets/nature.jpeg',
                    message: 'Eiffel Tower',
                    sender: 'Paris Tour',
                    dateTime: 'July 17, 2024 - 8:30 PM',
                  ),
                  NotificationTile(
                    imageUrl: 'assets/city.jpeg',
                    message: ' Great Wall of China',
                    sender: 'China Explore',
                    dateTime: 'July 16, 2024 - 2:15 PM',
                  ),
                  NotificationTile(
                    imageUrl: 'assets/view.jpeg',
                    message: ' Sydney Opera House',
                    sender: 'Australia Tour',
                    dateTime: 'July 15, 2024 - 5:45 PM',
                  ),
                  NotificationTile(
                    imageUrl: 'assets/beach7.jpeg',
                    message: 'Beautiful beach: Waikiki Beach',
                    sender: 'Hawaii Travel',
                    dateTime: 'July 14, 2024 - 11:00 AM',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String imageUrl;
  final String message;
  final String sender;
  final String dateTime;

  const NotificationTile({
    Key? key,
    required this.imageUrl,
    required this.message,
    required this.sender,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(imageUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.place, size: 12, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sender,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Text(
                      dateTime,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

