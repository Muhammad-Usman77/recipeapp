import 'package:flutter/material.dart';
import 'package:reci/Utils/constants.dart';

class BannerToExplore extends StatelessWidget {
  const BannerToExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kBannerColor,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cook the best \n replaces at home",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Explore",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ))
              ],
            ),
          ),
          Positioned(
              top: 0,
              bottom: 0,
              right: -20,
              child: Image.network("https://pngimg.com/d/chef_PNG190.png"))
        ],
      ),
    );
  }
}
