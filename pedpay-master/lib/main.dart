import 'package:flutter/material.dart';
import 'theme.dart';
import 'home_page.dart';
import 'marketplace_page.dart';
import 'plant_page.dart';

void main() {
  runApp(const PedPeApp());
}

class PedPeApp extends StatelessWidget {
  const PedPeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PedPe - Blue Carbon Registry',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScaffold(),
        '/plant': (context) => const PlantPage(),
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [const HomePage(), const MarketplacePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Marketplace'),
        ],
      ),
      // This button will take you to your Camera page!
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/plant'),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}