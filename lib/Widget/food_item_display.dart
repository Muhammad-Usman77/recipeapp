import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:reci/Provider/favorite_provider.dart';
import 'package:reci/Views/recipe_detail_screen.dart';

class FoodItemDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const FoodItemDisplay({super.key, required this.documentSnapshot});
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RecipeDetailScreen(
                      documentSnapshot: documentSnapshot,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 230,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: documentSnapshot['image'],
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(documentSnapshot['image']))),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  documentSnapshot['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    const Icon(
                      Iconsax.flash_1,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      "${documentSnapshot['cal']} Cal",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const Text(
                      " . ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Icon(
                      Iconsax.clock,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      "${documentSnapshot['time']} Min",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
            Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: InkWell(
                    onTap: () {
                      provider.toggle(documentSnapshot);
                    },
                    child: Icon(
                      provider.isExist(documentSnapshot)
                          ? Iconsax.heart5
                          : Iconsax.heart,
                      color: provider.isExist(documentSnapshot)
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
