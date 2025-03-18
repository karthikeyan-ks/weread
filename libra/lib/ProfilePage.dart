import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: null,
          
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?t=st=1728885828~exp=1728889428~hmac=693544990f14dc0b8b4e42906ca9885824b54a3c2bdd85e196d5aee128bef53c&w=740',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe', // User name (you can replace with dynamic data)
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'john.doe@example.com', // User email (replace with dynamic data)
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildSectionTitle('Account'),
              _buildMenuItem('Books', Icons.book, onTap: () {
                Navigator.pushNamed(context, '/bookList');
              }),
              _buildMenuItem('Favourites', Icons.favorite, onTap: () {
                Navigator.pushNamed(context, '/favouriteList');
              }),
              _buildMenuItem('Rented Books', Icons.library_books, onTap: () {
                Navigator.pushNamed(context, '/rentedList');
              }),
              _buildMenuItem('Nearby Libraries', Icons.location_on, onTap: () {
                Navigator.pushNamed(context, '/nearbyLibrary');
              }),
              _buildMenuItem('People with Similar Interests', Icons.people, onTap: () {
                Navigator.pushNamed(context, '/matchPeople');
              }),
              SizedBox(height: 16),
              _buildSectionTitle('General'),
              _buildMenuItem('Settings', Icons.settings, onTap: () {
                Navigator.pushNamed(context, '/settings');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, {VoidCallback? onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, size: 24, color: Colors.black),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => ProfilePage(),
      '/bookList': (context) => BookListPage(),
      '/favouriteList': (context) => FavouriteListPage(),
      '/rentedList': (context) => RentedListPage(),
      '/nearbyLibrary': (context) => NearbyLibraryPage(),
      '/matchPeople': (context) => MatchPeoplePage(),
      '/settings': (context) => SettingsPage(),
    },
  ));
}

// Example placeholder pages for navigation
class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Book List')));
  }
}

class FavouriteListPage extends StatelessWidget {
  const FavouriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Favourite List')));
  }
}

class RentedListPage extends StatelessWidget {
  const RentedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Rented List')));
  }
}

class NearbyLibraryPage extends StatelessWidget {
  const NearbyLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Nearby Libraries')));
  }
}

class MatchPeoplePage extends StatelessWidget {
  const MatchPeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('People with Similar Interests')));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Settings')));
  }
}
