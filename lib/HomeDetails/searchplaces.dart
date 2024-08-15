import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism/HomeDetails/details.dart';
import 'package:tourism/general/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Travel App'),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBar(),
                SizedBox(height: 20),
                Consumer<SearchProvider>(
                  builder: (context, provider, _) {
                    return provider.showAllCategories
                        ? AllCategoriesView(
                            categories: provider.getCategories(),
                            onCategorySelected: (category) {
                              provider.selectedCategory = category;
                              provider.showAllCategories = false;
                            },
                          )
                        : CategoryList();
                  },
                ),
              ],
            ),
          ),
        ),
       /* bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Bag',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
                radius: 16,
              ),
              label: 'Profile',
            ),
          ],
        ),*/
        





      ),
    );
  }

  List<String> getCategories(String category) {
    switch (category) {
      case 'Nature':
        return natureCategories;
      case 'Beach':
        return beachCategories;
      case 'Gastronomy':
        return gastronomyCategories;
      case 'City and Culture':
        return cityCultureCategories;
      case 'Sun and Beach':
        return sunBeachCategories;
      default:
        return [];
    }
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search places',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.getCategories().length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      String category = provider.getCategories()[index];
                      provider.selectedCategory = category;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryDetailPage(category: category),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            getCategoryImage(provider.getCategories()[index]),
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            provider.getCategories()[index],
                            style: TextStyle(
                              color: Color.fromARGB(255, 28, 45, 58),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                provider.showAllCategories = true;
              },
              child: Text(
                'See More',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
}

class AllCategoriesView extends StatelessWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;

  AllCategoriesView({required this.categories, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onCategorySelected(categories[index]);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: Color.fromARGB(255, 28, 45, 58),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
class CategoryDetailPage extends StatelessWidget {
  final String category;

  CategoryDetailPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Page'),
      ),
      body: CategorySection(
        title: category,
        categories: getCategories(category),
      ),
    );
  }

  List<String> getCategories(String category) {
    switch (category) {
      case 'Nature':
        return natureCategories;
      case 'Beach':
        return beachCategories;
      case 'Gastronomy':
        return gastronomyCategories;
      case 'City and Culture':
        return cityCultureCategories;
      case 'Sun and Beach':
        return sunBeachCategories;
      default:
        return [];
    }
  }
}


class CategorySection extends StatelessWidget {
  final String title;
  final List<String> categories;

  CategorySection({required this.title, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryItem(category: categories[index]);
            },
          ),
        ),
      ],
    );
  }
}
 class CategoryItem extends StatelessWidget {
  final String category;

  CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (category.contains('.jpeg') || category.contains('.png')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(imagePath: category, relatedImages: [],),
            ),
          );
        }
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            category.contains('.jpeg') || category.contains('.png')
                ? Container(
                    height: 95,
                    width: 130,
                    child: Image.asset(
                      category,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 80,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            SizedBox(height: 5),
            Text(
              'Subtitle or description',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
List<String> natureCategories = [
  'assets/beach.jpeg',
  'assets/nature.jpeg',
  'assets/beach2.jpeg',
];

List<String> beachCategories = [
  'Beach Place 1',
  'Beach Place 2',
];

List<String> gastronomyCategories = [
  'Gastronomy Place 1',
  'Gastronomy Place 2',
];

List<String> cityCultureCategories = [
  'City Place 1',
  'City Place 2',
];

List<String> sunBeachCategories = [
  'assets/sunbeach1.jpg',
  'assets/sunbeach2.jpg',
];
