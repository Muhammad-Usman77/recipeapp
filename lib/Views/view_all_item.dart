import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:reci/Utils/constants.dart';
import 'package:reci/Widget/food_item_display.dart';
import 'package:reci/Widget/my_icon_button.dart';

class ViewAllItem extends StatefulWidget {
  const ViewAllItem({super.key});

  @override
  State<ViewAllItem> createState() => _ViewAllItemState();
}

class _ViewAllItemState extends State<ViewAllItem> {
  final CollectionReference completeApp =
      FirebaseFirestore.instance.collection("Complete-Flutter-App");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          const SizedBox(
            width: 15,
          ),
          MyIconButton(
            icon: Icons.arrow_back_ios_new,
            pressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Text(
            "Quick & Easy",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          MyIconButton(
            icon: Icons.notifications,
            pressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            StreamBuilder(
                stream: completeApp.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> stSnapshot) {
                  if (stSnapshot.hasData) {
                    return GridView.builder(
                        itemCount: stSnapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.72),
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              stSnapshot.data!.docs[index];
                          return Column(
                            children: [
                              FoodItemDisplay(
                                  documentSnapshot: documentSnapshot),
                              Row(
                                children: [
                                  const Icon(
                                    Iconsax.star1,
                                    color: Colors.amberAccent,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    documentSnapshot['rating'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text("/5"),
                                  Text(
                                    "${documentSnapshot['review'.toString()]} Review",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          );
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
