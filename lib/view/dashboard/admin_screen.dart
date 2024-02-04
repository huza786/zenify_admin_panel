import 'package:flutter/material.dart';
import 'package:zenify_admin_panel/view/dashboard/components/navigation_rail.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ZENIFY PANEL',
        ),
      ),
      body: const CustomNavigationRail(),
    );
  }
}
