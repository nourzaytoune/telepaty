import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, String>> _favoriteImages = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteImages();
  }

  Future<void> _loadFavoriteImages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteImagePaths = prefs.getStringList('favoriteImages') ?? [];
    setState(() {
      _favoriteImages = favoriteImagePaths
          .map((path) => _getImageInfo(path))
          .where((info) => info != null)
          .cast<Map<String, String>>()
          .toList();
    });
  }

  Map<String, String>? _getImageInfo(String path) {
    // This method should match the image path to its corresponding title and caption
    for (var category in categoryImages.values) {
      for (var imageInfo in category) {
        if (imageInfo['path'] == path) {
          return imageInfo;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Images'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _favoriteImages.length,
        itemBuilder: (context, index) {
          final imageInfo = _favoriteImages[index];
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
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.all(8.0),
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
              ],
            ),
          );
        },
      ),
    );
  }
}

// Sample data for categoryImages to be included in the FavoriteScreen file for complete functionality
const Map<String, List<Map<String, String>>> categoryImages = {
  'Nature': [
    {
      'path': 'assets/view.jpeg',
      'title': 'Beautiful View',
      'caption': 'A breathtaking view of nature.'
    },
    {
      'path': 'assets/view2.jpeg',
      'title': 'Mountain View',
      'caption': 'A stunning view of the mountains.'
    },
    {
      'path': 'assets/view3.jpeg',
      'title': 'Lake View',
      'caption': 'A serene view of the lake.'
    },
    {
      'path': 'assets/nature.jpeg',
      'title': 'Forest Path',
      'caption': 'A peaceful path through the forest.'
    },
    {
      'path': 'assets/nature4.jpeg',
      'title': 'Sunset',
      'caption': 'A beautiful sunset in nature.'
    },
    {
      'path': 'assets/nature5.jpeg',
      'title': 'River View',
      'caption': 'A calming river view.'
    },
    {
      'path': 'assets/nature6.jpeg',
      'title': 'Valley',
      'caption': 'A stunning valley view.'
    },
  ],
  'Beach': [
    {
      'path': 'assets/beach.jpeg',
      'title': 'Sandy Beach',
      'caption': 'A relaxing sandy beach.'
    },
    {
      'path': 'assets/beach2.jpeg',
      'title': 'Clear Water',
      'caption': 'Crystal clear water at the beach.'
    },
    {
      'path': 'assets/beach3.jpeg',
      'title': 'Beach Sunset',
      'caption': 'A beautiful sunset at the beach.'
    },
    {
      'path': 'assets/beach4.jpeg',
      'title': 'Palm Trees',
      'caption': 'Palm trees by the beach.'
    },
    {
      'path': 'assets/beach5.jpeg',
      'title': 'Beach Chairs',
      'caption': 'Comfortable beach chairs.'
    },
    {
      'path': 'assets/beach6.jpeg',
      'title': 'Waves',
      'caption': 'Waves crashing on the shore.'
    },
    {
      'path': 'assets/beach7.jpeg',
      'title': 'Seaside',
      'caption': 'A scenic seaside view.'
    },
  ],

  // Add more categories and images here
};
