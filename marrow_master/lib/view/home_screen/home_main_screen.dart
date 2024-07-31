import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'home_screen.dart';
import '../../controller/home_main_controller/history_controller/history_controller.dart';
import '../../controller/home_main_controller/home_screens_controller/home_controller.dart';
import 'history_screen/history_screen.dart';
import 'home_screen.dart';
import 'setting_screen.dart/setting_screen.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HistoryScreen(),
    SettingScreen()
  ];

  @override
  void initState() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistoryController>(() => HistoryController());

    super.initState();
  }

  List<Widget> _buildScreens() {
    return [HomeScreen(), HistoryScreen(), SettingScreen()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: const Color.fromARGB(255, 0, 0, 0),
                  hoverColor: Colors.white, // tab button hover color
                  haptic: true, // haptic feedback
                  tabBorderRadius: 7,
                  tabActiveBorder:
                      Border.all(color: const Color(0xff184C9A), width: 1),
                  tabBorder: Border.all(
                      color: Colors.white, width: 1), // tab button border

                  curve: Curves.easeOutExpo,
                  duration: const Duration(milliseconds: 900),
                  gap: 8,
                  color: Colors.grey[800],
                  activeColor: const Color(0xff184C9A),
                  iconSize: 24,
                  tabBackgroundColor: const Color(0xff184C9A).withOpacity(0.1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.history,
                      text: 'History',
                    ),
                    GButton(
                      icon: Icons.settings,
                      text: 'Settings',
                    )
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ))),
      ),
    );
  }
}
