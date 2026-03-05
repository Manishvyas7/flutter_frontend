import 'package:flutter/material.dart';
import '../../data/services/users_service.dart';
import '../../data/services/roles_service.dart';
import '../../data/models/role_model.dart';

class CreateNewUser extends StatefulWidget {
  const CreateNewUser({super.key});

  @override
  State<CreateNewUser> createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UsersService _usersService = UsersService();
  final RolesService _rolesService = RolesService();

  bool _isActive = true;
  bool _obscurePassword = true;
  bool _isLoading = false;

  /// Roles from API
  List<RoleModel> _roles = [];
  RoleModel? _selectedRole;

  /// Load roles from API
  @override
  void initState() {
    super.initState();
    _loadRoles();
  }

  Future<void> _loadRoles() async {

    try {

      final roles = await _rolesService.fetchRoles();

      setState(() {
        _roles = roles;

        /// Default role = User
        _selectedRole = roles.firstWhere(
          (role) => role.name == "User",
          orElse: () => roles.first,
        );
      });

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load roles")),
      );

    }
  }

  /// SUBMIT FORM
  Future<void> _submitForm() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {

      final success = await _usersService.createUser(
        name: _nameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        roleId: _selectedRole!.id,
        password: _passwordController.text,
        isActive: _isActive,
      );

      if (success) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User created successfully")),
        );

        Navigator.pop(context);
      }

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );

    } finally {

      setState(() {
        _isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New User"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// NAME
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              /// EMAIL
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email";
                  }
                  if (!value.contains("@")) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              /// PHONE
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter phone number";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              /// PASSWORD
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// ACTIVE SWITCH
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Is Active",
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    value: _isActive,
                    onChanged: (value) {
                      setState(() {
                        _isActive = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// ROLE DROPDOWN FROM API
              DropdownButtonFormField<RoleModel>(

                value: _selectedRole,

                decoration: const InputDecoration(
                  labelText: "Select Role",
                  border: OutlineInputBorder(),
                ),

                items: _roles.map((role) {

                  return DropdownMenuItem<RoleModel>(
                    value: role,
                    child: Text(role.name),
                  );

                }).toList(),

                onChanged: (value) {

                  setState(() {
                    _selectedRole = value;
                  });

                },

                validator: (value) {
                  if (value == null) {
                    return "Please select role";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              /// SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),

                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Create User",
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}