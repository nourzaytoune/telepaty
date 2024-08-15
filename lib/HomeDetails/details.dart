import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String imagePath;
  final List<String> relatedImages;

  DetailPage({required this.imagePath, required this.relatedImages});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedImageIndex = 0;
late List<String> _imageUrls;

  @override
  void initState() {
    super.initState();
    _imageUrls = [widget.imagePath,...widget.relatedImages];
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(

                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    _imageUrls[_selectedImageIndex],
                //    widget.imagePath,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Row(
                    children: List.generate(_imageUrls.length,(index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImageIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedImageIndex == index
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              _imageUrls[index],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Picturesque Hon...',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$88.12',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '\$100.25',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        color: Colors.green,
                        child: Text(
                          '14% off',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Set in Manali, 5.2 km from Hidimba Devi Temple, Hotel Mountain face by Snow City Hotels offers Hidimba Devi Temple, Hotel Mountain face by Snow City Hotels offers Hidimba Devi Temple...',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Read More...'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Date of travel & guests',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('16 Feb - 17 Feb'),
                                Text('12:00 PM - 12:00 AM'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.people),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('1 Room'),
                                Text('1 Guests'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Book Now'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



