import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:reci/Utils/constants.dart';
import 'package:reci/Views/favorite_screen.dart';
import 'package:reci/Views/my_home_screen.dart';

class ApMainScreen extends StatefulWidget {
  const ApMainScreen({super.key});

  @override
  State<ApMainScreen> createState() => _ApMainScreenState();
}

class _ApMainScreenState extends State<ApMainScreen> {
  int selectedIndex = 0;
  late List<Widget> page;
  @override
  void initState() {
    page = [
      MyHomeScreen(),
      FavoriteScreen(),
      naviBar(Iconsax.calendar),
      naviBar(Iconsax.setting_21),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconSize: 28,
          currentIndex: selectedIndex,
          selectedItemColor: kprimaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            color: kprimaryColor,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(selectedIndex == 0 ? Iconsax.home5 : Iconsax.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart),
              label: "Favourite",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 2 ? Iconsax.calendar5 : Iconsax.calendar),
              label: "Calender",
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(selectedIndex == 3 ? Iconsax.setting1 : Iconsax.setting),
              label: "Setting",
            ),
          ]),
      body: page[selectedIndex],
    );
  }

  naviBar(iconName) {
    return Center(
      child: Icon(
        iconName,
        size: 100,
        color: kprimaryColor,
      ),
    );
  }
}
