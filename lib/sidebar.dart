import 'package:flutter/material.dart';
import 'men.dart';
import 'women.dart';
import 'kids.dart';
import 'smart.dart';
import 'wishlist.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.teal),
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem(
                  title: 'WOMEN',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Women()),
                  ),
                ),
                _buildNavItem(
                  title: 'MEN',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Men()),
                  ),
                ),
                _buildNavItem(
                  title: 'KIDS',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Kids()),
                  ),
                ),
                _buildNavItem(
                  title: 'SMART',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Smart()),
                  ),
                ),
                _buildNavItem(
                  title: 'WISHLIST',
                  leading: const Icon(Icons.star),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Wishlist()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Navigation Item Widget
  Widget _buildNavItem({required String title, Icon? leading, required VoidCallback onTap}) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
