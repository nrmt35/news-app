import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/home/news_screen.dart';
import 'package:news_app/ui/my_news_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPage = 0;

  void selectPage(int index) {
    setState(() => _selectedPage = index);
  }

  List<Widget> pages = [const NewsScreen(), const MyNewsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        currentIndex: _selectedPage,
        onTap: selectPage,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.list_alt_rounded),
            icon: Icon(Icons.list_alt_rounded),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark),
            label: 'Закладки',
          ),
        ],
      ),
    );
  }
}
