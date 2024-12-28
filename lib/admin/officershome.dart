import 'package:flutter/material.dart';

class OfficersManagement extends StatefulWidget {
  const OfficersManagement({super.key});

  @override
  State<OfficersManagement> createState() => _OfficersManagementState();
}

class _OfficersManagementState extends State<OfficersManagement> {
  final List<Map<String, String>> officers = [
    {'id': '1', 'name': 'Officer A', 'mobile': '1234567890', 'role': 'Admin'},
    {'id': '2', 'name': 'Officer B', 'mobile': '0987654321', 'role': 'Manager'},
    {'id': '3', 'name': 'Officer C', 'mobile': '2345678901', 'role': 'Supervisor'},
    {'id': '4', 'name': 'Officer D', 'mobile': '3456789012', 'role': 'Admin'},
    {'id': '5', 'name': 'Officer E', 'mobile': '4567890123', 'role': 'Manager'},
    {'id': '6', 'name': 'Officer F', 'mobile': '5678901234', 'role': 'Supervisor'},
  ];

 
 @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // AppBar without Drawer
        appBar: AppBar(
          title: Text('Officers Management'),
          backgroundColor: Colors.teal,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Dashboard') {
                  // Navigate to Dashboard
                } else if (value == 'Officers') {
                  // Stay on Officers page
                } else if (value == 'Profile') {
                  // Navigate to Profile
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'Dashboard',
                  child: Text('Dashboard'),
                ),
                PopupMenuItem<String>(
                  value: 'Officers',
                  child: Text('Officers'),
                ),
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
                // Search Field - More responsive
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

                // Responsive DataTable for Officers
                LayoutBuilder(
                  builder: (context, constraints) {
                    // For smaller screens, wrap the table in a single scroll view
                    if (constraints.maxWidth < 600) {
                      return Column(
                        children: officers.map((officer) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(officer['name'] ?? 'No Name'),
                              subtitle: Text('Mobile: ${officer['mobile']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Handle View Officer Details
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
                                      // Handle Delete Officer
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
                      // For larger screens, use DataTable
                      return DataTable(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        headingRowColor: MaterialStateProperty.all(Colors.teal[100]),
                        columnSpacing: 30,
                        columns: [
                          DataColumn(
                            label: Text(
                              'ID',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Mobile Number',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Role',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text('Actions'),
                          ),
                        ],
                        rows: List.generate(officers.length, (index) {
                          var officer = officers[index];
                          return DataRow(
                            cells: [
                              DataCell(Text(officer['id'] ?? '')),
                              DataCell(Text(officer['name'] ?? '')),
                              DataCell(Text(officer['mobile'] ?? '')),
                              DataCell(Text(officer['role'] ?? '')),
                              DataCell(
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Handle View Officer Details
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
                                        // Handle Delete Officer
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
                            ],
                          );
                        }),
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