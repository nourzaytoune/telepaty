import 'package:flutter/material.dart';
import 'package:tourism/Feature/Auth/login.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingPage(
                image: 'assets/view.jpeg',
                title: 'People don\'t take trips, trips take people',
                subtitle: 'To get the best of your adventure you just need to leave and go where you like, we are waiting for you.',
                onBackPressed: () {
                  if (_currentPage > 0) {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
              ),
              OnboardingPage(
                image: 'assets/view2.jpeg',
                title: 'Life is short and the world is wide',
                subtitle: 'To get the best of your adventure you just need to leave and go where you like, we are waiting for you.',
                onBackPressed: () {
                  if (_currentPage > 0) {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
              ),
              OnboardingPage(
                image: 'assets/view3.jpeg',
                title: 'Get ready for your lifetime journey',
                subtitle: 'To get the best of your adventure you just need to leave and go where you like, we are waiting for you.',
                onBackPressed: () {
                  if (_currentPage > 0) {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
              ),
            ],
          ),
          Positioned(
            top: 55,
            right: 16,
            child: TextButton(
              onPressed: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage() ),
                  );
              },
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 35, 54, 70),),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _currentPage == 2
                   ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          'Get Started',
                          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 35, 54, 70),),
                        ),
                      )
                    :  Row(
            children: [
              Text('Next'),
              SizedBox(width: 8),
                    GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 35, 54, 70),
                          ),
                          child: Icon(Icons.arrow_forward, size: 24),
                        ),
                      ),
                     ],
                    ),
              ],
          ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == i? Colors.white : Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onBackPressed;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                //bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(120.0),
              ),
              child: Image.asset(
                image,
                width: MediaQuery.of(context).size.width * 1,
                height: 550,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: onBackPressed,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            subtitle,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}








/*class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return OnBoardingScreen(
                index: index,
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 20 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.blue
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingScreen extends StatelessWidget {
  final int index;

  const OnBoardingScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/view.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            index == 0
                ? 'People don\'t take trips, trips take people'
                : index == 1
                    ? 'life is short and the world is wide'
                    : 'Get ready for your lifetime journey',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'To get the best of your adventure you just need to leave and go where you like, we are waiting for you.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              if (index < 2) {
                // Move to the next page
                // This will automatically update the current page index
                // and show the next onboarding screen
              } else {
                // This is the last onboarding screen, so navigate to the login page
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(index < 2 ? 'Next' : 'Get Started'),
          ),
        ],
      ),
    );
  }
}*/
