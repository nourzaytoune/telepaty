import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism/Feature/Auth/login.dart';
import 'package:tourism/HomeDetails/notification.dart';
import 'package:tourism/general/provider.dart';
import 'package:tourism/SettingsDetails/contactus.dart';
import 'package:tourism/SettingsDetails/favorite.dart';
import 'package:tourism/SettingsDetails/multilanguage.dart';
import 'package:tourism/SettingsDetails/profile.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle bottom navigation item taps here
  }

  Future<void> _deleteAccount() async {
    // Display confirmation dialog
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      // Implement your account deletion logic here
      // For example: await AuthService().deleteAccount();

      // Navigate to login page after deletion
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 35, 54, 70),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCard(
                        'Favorites',
                        '23 places',
                        Icons.favorite,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoriteScreen()),
                          );
                        },
                      ),
                      _buildCard('Loyalty', '22 Pts', Icons.card_giftcard),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('Settings'),
            _buildListTile(
              'Personal information',
              Icons.person,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            _buildListTile('Addresses', Icons.location_on),
            _buildListTile('Documents', Icons.file_copy),
            _buildListTile(
              'Notification',
              Icons.notifications,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
            ),
            _buildModeTile(context),
            SizedBox(height: 16.0),
            _buildSectionTitle('Support'),
            _buildListTile(
              'Contact Us', Icons.contact_phone,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsPage()),
                );
              },
            ),
            _buildListTile(
              'multilanguage',
              Icons.language,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LanguageSettingsScreen()),
                );
              },
            ),
            _buildListTile('Terms & conditions', Icons.description),
            _buildListTile('Privacy Policy', Icons.lock),
            SizedBox(height: 16.0),
            _buildListTile(
              'Logout',
              Icons.logout,
              onTap: () {
                // Implement your logout logic here
                // For example: AuthService().logout();
                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              hasArrow: false, // Set hasArrow to false
            ),
            _buildListTile(
              'Delete Account',
              Icons.delete_forever,
              hasArrow: false,
              onTap: _deleteAccount,
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, IconData icon,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        child: Container(
          width: 120.0,
          height: 80.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30.0, color: Colors.black),
              SizedBox(height: 8.0),
              Text(title, style: TextStyle(fontSize: 16.0)),
              Text(subtitle, style: TextStyle(fontSize: 12.0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon,
      {VoidCallback? onTap, bool hasArrow = true}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: hasArrow ? Icon(Icons.arrow_forward_ios) : null,
      onTap: onTap, // Use the passed onTap callback
    );
  }

  Widget _buildModeTile(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return ListTile(
      leading: Icon(Icons.brightness_4),
      title: Text('Mode'),
      trailing: Switch(
        value: themeNotifier.isDarkMode,
        onChanged: (value) {
          themeNotifier.toggleTheme();
        },
      ),
    );
  }
}










/*import 'package:flutter/material.dart';
import 'package:tourism/SettingsDetails/favorite.dart';
import 'package:tourism/SettingsDetails/multilanguage.dart';
import 'package:tourism/SettingsDetails/profile.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<SettingsScreen> {
  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle bottom navigation item taps here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 35, 54, 70),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                  ),
                  // SizedBox(height: 8.0),
                  // Text(
                  //  '',
                  //  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  //),
                  SizedBox(height: 16.0),
                Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _buildCard(
      'Favorites', 
      '23 places', 
      Icons.favorite,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoriteScreen()),
        );
      },
    ),
    _buildCard('Loyalty', '22 Pts', Icons.card_giftcard),
  ],
),


                ],
              
              ),
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('Settings'),
            _buildListTile(
              'Personal information',
              Icons.person,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            _buildListTile('Addresses', Icons.location_on),
            _buildListTile('Documents', Icons.file_copy),
            _buildListTile('Notification', Icons.notifications),
            SizedBox(height: 16.0),
            _buildSectionTitle('Support'),
            _buildListTile('Contact Us', Icons.contact_phone),
            _buildListTile('Give us a feedback', Icons.feedback),
           // _buildListTile('multilanguage', Icons.language),
            _buildListTile(
              'multilanguage',
              Icons.language,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageSettingsScreen(onLocaleChange: (Locale ) {  },)),
                );
              },
            ),
           // _buildListTile('Cancelation policy', Icons.cancel),
            _buildListTile('Mode', Icons.brightness_4 ),
            _buildListTile('Terms & conditions', Icons.description),
            _buildListTile('Privacy Policy', Icons.lock),
            SizedBox(height: 16.0),
            _buildListTile('Logout', Icons.logout),
            _buildListTile('Delete Account', Icons.delete_forever),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, IconData icon,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        child: Container(
          width: 120.0,
          height: 80.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30.0, color: Colors.black),
              SizedBox(height: 8.0),
              Text(title, style: TextStyle(fontSize: 16.0)),
              Text(subtitle, style: TextStyle(fontSize: 12.0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap, // Use the passed onTap callback
    );
  }
}*/
