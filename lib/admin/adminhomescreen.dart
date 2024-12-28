import 'package:flutter/material.dart';
import 'package:wads/admin/officershome.dart';
import 'package:wads/admin/profile.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final List<Map<String, String>> users = [
    {'id': '1', 'name': 'Karthika', 'mobile': '1234567890'},
    {'id': '2', 'name': 'Abinav Shaji', 'mobile': '0987654321'},
    {'id': '3', 'name': 'Abin Paulose', 'mobile': '2345678901'},
    {'id': '4', 'name': 'Neha', 'mobile': '3456789012'},
    {'id': '5', 'name': 'Ashik', 'mobile': '4567890123'},
    {'id': '6', 'name': 'Magdhalin', 'mobile': '5678901234'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Drawer
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Text(
                  'Admin Panel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text('Alerts', style: TextStyle(color: Colors.teal)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: Text('Users', style: TextStyle(color: Colors.teal)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminHome()),
                  ); // Close the drawer
                },
              ),
              ListTile(
                title: Text('Officers', style: TextStyle(color: Colors.teal)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OfficersManagement()),
                  ); // Close the drawer
                },
              ),
            ],
          ),
        ),

        // AppBar with Menu button
        appBar: AppBar(
          title: Text('User Management'),
          backgroundColor: Colors.teal,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                  if (value == 'Profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminProfileScreen()),
                  ); // Navigate to Profile
                }
              },
              itemBuilder: (BuildContext context) => [
                
                PopupMenuItem<String>(
                  value: 'Profile',
                  child: Text('Profile'),
                ),
              ],
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Search Field
                SizedBox(
                  width: double.infinity, // Make sure it adapts to the screen width
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search by Name or Mobile',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.teal, width: 1),
                      ),
                      filled: true,
                      fillColor: Colors.teal[50],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // List of Users in Cards with ListTile
                LayoutBuilder(
                  builder: (context, constraints) {
                    // For smaller screens, use ListTile inside Card
                    if (constraints.maxWidth < 600) {
                      return Column(
                        children: users.map((user) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(user['name'] ?? 'No Name'),
                              subtitle: Text('Mobile: ${user['mobile']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Handle View User Details
                                    },
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      // Handle Delete User
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      // For larger screens, you can still implement DataTable here if needed
                      return Column(
                        children: users.map((user) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(user['name'] ?? 'No Name'),
                              subtitle: Text('Mobile: ${user['mobile']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Handle View User Details
                                    },
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      // Handle Delete User
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
