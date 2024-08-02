import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_banking/ui/exchange_screen.dart';
import 'package:online_banking/ui/my_card_screen.dart';
import 'package:online_banking/ui/sotry_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int currenindex = 0;
List screens = [MyCardScreen(), ExchangeScreen(), SotryScreen()];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          currenindex = value;
          setState(() {});
        },
        selectedItemColor: Colors.amber.shade700,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.amber.shade200,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.money_rounded), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.money_dollar_circle,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.money_euro_circle,
              ),
              label: ''),
        ],
      ),
      body: screens[currenindex],
    );
  }
}
