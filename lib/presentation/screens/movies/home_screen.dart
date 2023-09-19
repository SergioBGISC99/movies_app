import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hola mundo'),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
