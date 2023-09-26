import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell currentChild;
  const CustomBottomNavigation({super.key, required this.currentChild});

  void onItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/categories');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentChild.currentIndex,
      onTap: (value) => currentChild.goBranch(value),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.thumbs_up_down_outlined), label: 'Populares'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favoritos')
      ],
    );
  }
}
