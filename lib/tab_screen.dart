// Komponen Paket
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Setingan TabMenu
class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('SMK Negeri 4 - Mobile Apps'),
        ),
        body: TabBarView(
          children: [
            BerandaTab(),
            UsersTab(),
            ProfilTab(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Beranda'),
            Tab(icon: Icon(Icons.person), text: 'Users'),
            Tab(icon: Icon(Icons.person), text: 'Profil'),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
      ),
    );
  }
}

// Layout untuk Tab Beranda
class BerandaTab extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.school,
      'label': 'Education',
      'color': const Color.fromARGB(255, 189, 156, 245)
    },
    {'icon': Icons.book, 'label': 'Library', 'color': Colors.teal},
    {'icon': Icons.event, 'label': 'Events', 'color': Colors.orange},
    {
      'icon': Icons.notifications,
      'label': 'Alerts',
      'color': Color.fromARGB(255, 245, 104, 94)
    },
    {'icon': Icons.assignment, 'label': 'Assignments', 'color': Colors.blue},
    {'icon': Icons.chat, 'label': 'Messages', 'color': Colors.green},
    {'icon': Icons.settings, 'label': 'Settings', 'color': Colors.pink},
    {'icon': Icons.help, 'label': 'Support', 'color': Colors.amber},
    {'icon': Icons.map, 'label': 'Campus Map', 'color': Colors.indigo},
    {'icon': Icons.calendar_today, 'label': 'Calendar', 'color': Colors.cyan},
    {'icon': Icons.contact_phone, 'label': 'Contact Us', 'color': Colors.lime},
    {'icon': Icons.info, 'label': 'Information', 'color': Colors.brown},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of items per row
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return GestureDetector(
            onTap: () {
              // Handle tap on the menu icon
              print('${item['label']} tapped');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60.0, // Width of the box
                  height: 60.0, // Height of the box
                  decoration: BoxDecoration(
                    color: item['color'], // Background color of the box
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  child: Center(
                    child: Icon(
                      item['icon'],
                      size: 30.0, // Icon size
                      color: Colors.white, // Icon color
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  item['label'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Layout untuk Tab User
class UsersTab extends StatelessWidget {
  Future<List<User>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatarUrl),
                      radius: 30,
                    ),
                    title: Text(
                      user.firstName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      user.email,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

// Layout untuk Tab Profil
class ProfilTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFTh7S6_Gre2BP-5MJJVwCLw5uWNl9V4Gp6g&s',
              ),
              backgroundColor: Colors.blueAccent,
            ),
            SizedBox(height: 20),
            Text(
              'Siti Salwa Salsabil',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'sitisalwasalsabil@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.blueAccent),
                    title: Text('Nama Lengkap'),
                    subtitle: Text('Siti Salwa Salsabil'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.cake, color: Colors.blueAccent),
                    title: Text('Tanggal Lahir'),
                    subtitle: Text('31 Oktober 2006'),
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
class User {
  final String firstName;
  final String email;
  final String avatarUrl;

  User({
    required this.firstName,
    required this.email,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      email: json['email'],
      avatarUrl: json['avatar'],
    );
  }
}
