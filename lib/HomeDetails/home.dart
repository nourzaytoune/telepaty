import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/HomeDetails/details.dart';
import 'package:tourism/HomeDetails/notification.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tourism/Network/networkapiservice.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory;
  int _selectedIndex = 0;
  late Future<List<String>> logosFuture;
  late NetworkApiService apiService;

  
  final List<String> categories = [
    'Nature',
    'Beach',
    'Gastronomy',
    'City and Culture',
    'Sun and Beach'
  ];

  String getCategoryImage(String category) {
    switch (category) {
      case 'Nature':
        return 'assets/view3.jpeg';
      case 'Beach':
        return 'assets/beach4.jpeg';
      case 'Gastronomy':
        return 'assets/beach2.jpeg';
      case 'City and Culture':
        return 'assets/city.jpeg';
      case 'Sun and Beach':
        return 'assets/beach3.jpeg';
      default:
        return 'assets/default_icon.png';
    }
  }
final Map<String, List<Map<String, dynamic>>> categoryImages = {
  'Nature': [
    {
      'path': 'assets/view.jpeg',
      'title': 'Beautiful View',
      'caption': 'A breathtaking view of nature.',
      'relatedImages': [
        'assets/related1.jpeg', // Add related images here
        'assets/related2.jpeg',
        'assets/related4.jpeg',
    
      ],
    },
    {
      'path': 'assets/view2.jpeg',
      'title': 'Mountain View',
      'caption': 'A stunning view of the mountains.',
      'relatedImages': [
        'assets/related1_nature.jpeg',
        'assets/related2_nature.jpeg',
        'assets/related4_nature.jpeg',
      ],
    },
    {
        'path': 'assets/view3.jpeg',
        'title': 'Lake View',
        'caption': 'A serene view of the lake.',
         'relatedImages': [
        'assets/related1_nature.jpeg',
        'assets/related2_nature.jpeg',
        'assets/related4_nature.jpeg',
        ],

      },
      {
        'path': 'assets/nature.jpeg',
        'title': 'Forest Path',
        'caption': 'A peaceful path through the forest.',
         'relatedImages': [
        'assets/related1_nature.jpeg',
        'assets/related2_nature.jpeg',
        'assets/related4_nature.jpeg',
        ],

      },
      {
        'path': 'assets/nature4.jpeg',
        'title': 'Sunset',
        'caption': 'A beautiful sunset in nature.',
            'relatedImages': [
        'assets/related1_nature.jpeg',
        'assets/related2_nature.jpeg',
        'assets/related4_nature.jpeg',
        ],
      },
      {
        'path': 'assets/nature5.jpeg',
        'title': 'River View',
        'caption': 'A calming river view.',
            'relatedImages': [
        'assets/related1_nature.jpeg',
        'assets/related2_nature.jpeg',
        'assets/related4_nature.jpeg',
        ],
      },
      {
        'path': 'assets/nature6.jpeg',
        'title': 'Valley',
        'caption': 'A stunning valley view.',
            'relatedImages': [
        'assets/related1_nature.jpeg',
        'assets/related2_nature.jpeg',
        'assets/related4_nature.jpeg',
        ],
      },


    // Add more images with relatedImages here
  ],
  'Beach': [
    {
      'path': 'assets/beach.jpeg',
      'title': 'Sandy Beach',
      'caption': 'A relaxing sandy beach.',
      'relatedImages': [
        'assets/related1_beach.jpeg',
        'assets/related2_beach.jpeg',
        'assets/related3_beach.jpeg',
      ],
    },
    {
      'path': 'assets/beach2.jpeg',
      'title': 'Clear Water',
      'caption': 'Crystal clear water at the beach.',
      'relatedImages': [
        'assets/related1_beach.jpeg',
        'assets/related4_beach.jpeg',
        'assets/related5_beach.jpeg',
      ],
    },
    // Add more images with relatedImages here
  ],
  // Add more categories and images here
};
  final Map<String, bool> favoriteImages = {};

  @override
  void initState() {
    super.initState();
    apiService = NetworkApiService();
    logosFuture = apiService.fetchLogos();
    selectedCategory =categories[0]; // Set the default category to the first one
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favoriteImages') ?? [];
    setState(() {
      for (var imagePath in favoriteList) {
        favoriteImages[imagePath] = true;
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle bottom navigation item taps here
  }

  Future<void> _toggleFavorite(String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favoriteImages') ?? [];
    setState(() {
      if (favoriteImages[imagePath] == true) {
        favoriteImages[imagePath] = false;
        favoriteList.remove(imagePath);
      } else {
        favoriteImages[imagePath] = true;
        favoriteList.add(imagePath);
      }
    });
    await prefs.setStringList('favoriteImages', favoriteList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Replace with the path to your logo
              width: 90,
              height: 40, // Adjust the width as needed
              color:
                  Color.fromARGB(255, 35, 54, 70), // Change the color to blue
            ),
            Spacer(), // Push the notifications button to the right
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
                // Handle notifications button press
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false, // Remove the back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildLogoList(),
             SizedBox( height: 16.0),
            _buildSearchBar(),
            SizedBox( height: 16.0), // Add space between search bar and categories
            _buildCategoryList(),
            SizedBox(height: 16.0), // Add space between categories and images
            if (selectedCategory != null) _buildImageGrid(),
          ],
        ),
      ),
    );
  }
Widget _buildLogoList() {
  return FutureBuilder<List<String>>(
    future: logosFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No logos available'));
      } else {
        final logos = snapshot.data!;
        return Container(
          height: 100.0, // Adjust the height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: logos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.network(
                  logos[index], // Logo URL
                  width: 80.0, // Adjust the width as needed
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        );
      }
    },
  );
}

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: 'Search Here....',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Container(
      height: 50.0, // Adjusted height to fit image and text
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = categories[index];
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(
                    255, 35, 54, 70), // Change color to navy blue
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Image.asset(
                    getCategoryImage(categories[index]),
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 8.0), // Space between image and text
                  Text(
                    categories[index],
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

 void _onImageTap(String tappedImagePath) {
  // Find the category that contains the tapped image
  final category = categoryImages.keys.firstWhere(
    (cat) => categoryImages[cat]!.any((image) => image['path'] == tappedImagePath),
  );
  
  // Find the image info for the tapped image
  final imageInfo = categoryImages[category]!.firstWhere((image) => image['path'] == tappedImagePath);
  
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailPage(
        imagePath: tappedImagePath,
        relatedImages: List<String>.from(imageInfo['relatedImages'] ?? []),
      ),
    ),
  );
}

Widget _buildImageGrid() {
  return Expanded(
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: categoryImages[selectedCategory]!.length,
      itemBuilder: (context, index) {
        final imageInfo = categoryImages[selectedCategory]![index];
        final isFavorite = favoriteImages[imageInfo['path']!] ?? false;
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0), // Rounded rectangle
          child: Stack(
            children: [
              Image.asset(
                imageInfo['path']!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: GestureDetector(
                  onTap: () async {
                    await _toggleFavorite(imageInfo['path']!);
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _onImageTap(imageInfo['path']!);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          imageInfo['title']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          imageInfo['caption']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
  }






