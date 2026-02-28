import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/services/users_service.dart';
import '../../../users/presentation/widgets/search_bar.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  late Future<List<UserModel>> _usersFuture;
  final UsersService _usersService = UsersService();

  // ✅ For search filtering
  List<UserModel> _allUsers = [];
  List<UserModel> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _usersFuture = _usersService.fetchUsers();
  }

  // ✅ Search function
  void _searchUsers(String value) {
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        return user.name.toLowerCase().contains(value.toLowerCase()) ||
            (user.email ?? "").toLowerCase().contains(value.toLowerCase()) ||
            user.phoneNumber.contains(value) ||
            user.roleName.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        centerTitle: true,

        // ✅ Create New User button
        actions: [
          TextButton.icon(
            onPressed: () { // Navigate to create user screen
            },
            icon: const Icon(Icons.add, color: Colors.blue),
            label: const Text(
              "Create New User",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),

      body: FutureBuilder<List<UserModel>>(
        future: _usersFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final users = snapshot.data ?? [];

          if (users.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          // ✅ Store original + filtered list once
          if (_allUsers.isEmpty) {
            _allUsers = users;
            _filteredUsers = users;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// ✅ SEARCH BAR (separate widget)
                UserSearchBar(onSearch: _searchUsers),
                const SizedBox(height: 15),

                /// ✅ TABLE
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      columnSpacing: 20,
                      columns: const [
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Email")),
                        DataColumn(label: Text("Phone")),
                        DataColumn(label: Text("Role")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("Actions")),
                      ],
                      rows: _filteredUsers.map((user) {
                        return DataRow(
                          cells: [

                            DataCell(Text(user.name)),
                            DataCell(Text(user.email ?? "N/A")),
                            DataCell(Text(user.phoneNumber)),
                            DataCell(Text(user.roleName)),

                            DataCell(
                              Text(
                                user.isActive ? "Active" : "Inactive",
                                style: TextStyle(
                                  color: user.isActive
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            /// ✅ Edit + Delete buttons
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      // Edit user
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      // Delete user
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// ✅ FOOTER / INFO SECTION
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info, color: Colors.blue),
                      const SizedBox(width: 10),
                      Text(
                        "Total Users: ${_filteredUsers.length}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
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