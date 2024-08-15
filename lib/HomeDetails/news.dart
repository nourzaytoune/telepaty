import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  TextEditingController _controller = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('News'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Search Here....',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredNewsItems.length,
                itemBuilder: (context, index) {
                  return _buildNewsItem(context, _filteredNewsItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<NewsItem> get _filteredNewsItems {
    if (_searchQuery.isEmpty) {
      return _newsItems;
    } else {
      return _newsItems
          .where((item) => item.title.toLowerCase().contains(_searchQuery))
          .toList();
    }
  }

  Widget _buildNewsItem(BuildContext context, NewsItem item) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      item.image1,
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      item.image2,
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 20, color: Colors.black54),
                SizedBox(width: 8),
                Text(
                  item.date,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, size: 20, color: Colors.black54),
                SizedBox(width: 8),
                Text(
                  item.rank,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(width: 8),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.black54,
                ),
                SizedBox(width: 8),
                Icon(Icons.person, size: 20, color: Colors.black54),
                SizedBox(width: 8),
                Text(
                  item.author,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              item.description,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: Text(
                'Read More',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsItem {
  final String image1;
  final String image2;
  final String date;
  final String rank;
  final String author;
  final String title;
  final String description;

  NewsItem({
    required this.image1,
    required this.image2,
    required this.date,
    required this.rank,
    required this.author,
    required this.title,
    required this.description,
  });
}

List<NewsItem> _newsItems = [
  NewsItem(
    image1: 'assets/view.jpeg',
    image2: 'assets/view3.jpeg',
    date: '04 Nov, 2022',
    rank: 'Ranked',
    author: 'Karine Keuchkerian',
    title: 'Lebanon Tourism Ranks Among The Best In The World',
    description:
        '5 Lebanese sites earned spots in the 2022\'s World’s Best Tourism Sites.',
  ),
  NewsItem(
    image1: 'assets/view2.jpeg',
    image2: 'assets/view.jpeg',
    date: '05 Nov, 2022',
    rank: 'Popular',
    author: 'John Doe',
    title: 'New Tourist Attractions in Lebanon',
    description:
        'Lebanon introduces new tourist attractions that have become instant hits.',
  ),
];
