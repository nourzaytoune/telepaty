import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String _name = 'Adolf Cooper';
  String _phoneNumber = '+91 00000 00000';
  String _email = 'example@gmail.com';
  String _dateOfBirth = '11 Aug, 2002';
  File? _profileImage;
  bool _isEditing = false;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileImage = File('assets/view.jpeg');
    _nameController.text = _name;
    _phoneController.text = _phoneNumber;
    _emailController.text = _email;
    _dateController.text = _dateOfBirth;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          TextButton(
            child: Text(_isEditing ? 'Save' : 'Edit'),
            onPressed: () {
              if (_isEditing) {
                // Save changes and exit edit mode
                setState(() {
                  _name = _nameController.text;
                  _phoneNumber = _phoneController.text;
                  _email = _emailController.text;
                  _dateOfBirth = _dateController.text;
                  _isEditing = false;
                });
              } else {
                // Enter edit mode
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (_isEditing) {
                  // Change profile picture
                  _changeProfilePicture();
                }
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            _buildInfoRow(
              Icons.person,
              'Name',
              _nameController.text,
              _isEditing
                  ? TextField(
                      controller: _nameController,
                    )
                  : null,
            ),
            SizedBox(height: 20.0),
            Divider(),
            _buildInfoRow(
              Icons.phone,
              'Phone number',
              _phoneController.text,
              _isEditing
                  ? TextField(
                      controller: _phoneController,
                    )
                  : null,
            ),
            SizedBox(height: 20.0),
            Divider(),
            _buildInfoRow(
              Icons.email,
              'Email Id',
              _emailController.text,
              _isEditing
                  ? TextField(
                      controller: _emailController,
                    )
                  : null,
            ),
            SizedBox(height: 20.0),
            Divider(),
            _buildInfoRow(
              Icons.calendar_today,
              'Date of Birth',
              _dateController.text,
              _isEditing
                  ? TextField(
                      controller: _dateController,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String text,
    Widget? editWidget,
  ) {
    return Row(
      children: [
        Icon(icon, size: 24),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (editWidget != null)
                editWidget
              else
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _changeProfilePicture() async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Change Profile Picture'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Select from Gallery'),
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(source: ImageSource.gallery);

              if (pickedFile!= null) {
                setState(() {
                  _profileImage = File(pickedFile.path);
                });
              }
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Take a Picture'),
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(source: ImageSource.camera);

              if (pickedFile!= null) {
                setState(() {
                  _profileImage = File(pickedFile.path);
                });
              }
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Profile Picture'),
            onTap: () {
              setState(() {
                _profileImage = null;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ),
  );
}
}
