import 'package:flutter/material.dart';
import 'package:libra/booklist_page.dart';
import 'package:libra/FavoritesPage.dart';
import 'package:libra/ProfilePage.dart';
import 'package:libra/SearchPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    BooklistPage(),
    FavoritesPage(),
    SearchPage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: _pages[_currentIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Booklist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          // Header Image with "Discovery" Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  'https://images.pexels.com/photos/1480335/pexels-photo-1480335.jpeg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discovery',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Explore new books and genres',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search books...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // Books Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Books',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 2, 2, 2),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                BookCard(imageUrl: 'https://images.pexels.com/photos/1480337/pexels-photo-1480337.jpeg', name: 'Book 1', author: 'Author 1'),
                BookCard(imageUrl: 'https://images.pexels.com/photos/1480335/pexels-photo-1480335.jpeg', name: 'Book 2', author: 'Author 2'),
                BookCard(imageUrl: 'https://images.pexels.com/photos/1480338/pexels-photo-1480338.jpeg', name: 'Book 3', author: 'Author 3'),
              ],
            ),
          ),
          // Categories Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 24, 24, 24),
                  ),
                ),
              ],
            ),
          ),
         Column(
  children: [
    // First Row with two containers (with padding)
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0), // Padding around each container
          child: CategoryCard(name: 'Novel'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0), // Padding around each container
          child: CategoryCard(name: 'Biography'),
        ),
      ],
    ),
    // Second Row with two containers (with padding)
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0), // Padding around each container
          child: CategoryCard(name: 'Science'),
        ),
        SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.all(8.0), // Padding around each container
          child: CategoryCard(name: 'History'),
        ),
        SizedBox(width: 8),
      ],
    ),
  ],
),
          // Rented Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rented',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                BookCard(imageUrl:  'https://images.pexels.com/photos/1480335/pexels-photo-1480335.jpeg', name: 'Rented Book 1', author: 'Author 4'),
                BookCard(imageUrl: 'https://images.pexels.com/photos/1480336/pexels-photo-1480336.jpeg', name: 'Rented Book 2', author: 'Author 5'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String author;

  const BookCard({super.key, required this.imageUrl, required this.name, required this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 150,
      child: Column(
        children: [
          // Book Image
          Image.network(
            imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          // Book Name and Author
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            author,
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          // Rating Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: index < 4 ? Colors.yellow : Colors.grey, // Show 4 stars as filled
                size: 20,
              );
            }),
          ),
          SizedBox(height: 8),
          // Love Icon (Heart)
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Add functionality for the love icon, like changing state or marking as liked
              print('Liked $name');
            },
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;

  const CategoryCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 224, 228, 233),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        name,
        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Placeholder pages for Booklist, Favorites, Search, and Profile
