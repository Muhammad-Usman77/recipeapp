import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:reci/Utils/constants.dart';
import 'package:reci/Views/view_all_item.dart';
import 'package:reci/Widget/banner.dart';
import 'package:reci/Widget/food_item_display.dart';
import 'package:reci/Widget/my_icon_button.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  String Category = "All";
  final CollectionReference categoriesItems =
      FirebaseFirestore.instance.collection("App-Category");
  // for category
  final CollectionReference categoriesIt =
      FirebaseFirestore.instance.collection("App-Category");
  // for all itesm display
  Query get fileteredRecipes =>
      FirebaseFirestore.instance.collection("Complete-Flutter-App").where(
            'category',
            isEqualTo: Category,
          );
  Query get allRecipes =>
      FirebaseFirestore.instance.collection("Complete-Flutter-App");
  Query get selectedRecipes =>
      Category == "All" ? allRecipes : fileteredRecipes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    headerParts(),
                    mySearchBar(),
                    //banner
                    const BannerToExplore(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    selectedCategory(),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    //quick access
                    Row(
                      children: [
                        const Text(
                          "Quick & Easy",
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ViewAllItem()));
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                color: kBannerColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder(
                        stream: selectedRecipes.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final List<DocumentSnapshot> recipes =
                                snapshot.data?.docs ?? [];
                            return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: recipes
                                      .map((e) =>
                                          FoodItemDisplay(documentSnapshot: e))
                                      .toList(),
                                ));
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
        stream: categoriesItems.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    streamSnapshot.data!.docs.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              Category =
                                  streamSnapshot.data!.docs[index]["name"];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Category ==
                                        streamSnapshot.data!.docs[index]["name"]
                                    ? kprimaryColor
                                    : Colors.white),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            margin: const EdgeInsets.only(right: 20),
                            child: Text(
                              streamSnapshot.data!.docs[index]["name"],
                              style: TextStyle(
                                  color: Category ==
                                          streamSnapshot.data!.docs[index]
                                              ["name"]
                                      ? Colors.white
                                      : Colors.grey.shade600),
                            ),
                          ),
                        )),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Padding mySearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            prefix: const Icon(Iconsax.search_normal),
            fillColor: Colors.white,
            border: InputBorder.none,
            hintText: "Search any recipe",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }

  Row headerParts() {
    return Row(
      children: [
        const Text(
          "What are you \n cooking today?",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        MyIconButton(icon: Icons.notifications, pressed: () {})
      ],
    );
  }
}
