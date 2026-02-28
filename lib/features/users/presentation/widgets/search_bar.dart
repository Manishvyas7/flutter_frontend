import 'package:flutter/material.dart';

class UserSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const UserSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  State<UserSearchBar> createState() => _UserSearchBarState();
}

class _UserSearchBarState extends State<UserSearchBar> {

  final TextEditingController _controller = TextEditingController();

  void _clearSearch() {
    _controller.clear();
    widget.onSearch(""); // reset filter
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [

          const Icon(Icons.search, color: Colors.grey),

          const SizedBox(width: 8),

          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                widget.onSearch(value);
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: "Search users...",
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),

          /// ✅ Clear button
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: _clearSearch,
            ),
        ],
      ),
    );
  }
}