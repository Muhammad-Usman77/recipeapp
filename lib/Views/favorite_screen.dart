import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:reci/Provider/favorite_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteItems = provider.favorites;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Favorites"),
        ),
        body: favoriteItems.isEmpty
            ? const Center(
                child: Text(
                  "No Favorites yet",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  final favorite = favoriteItems[index];
                  return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("Complete-Flutter-App")
                          .doc(favorite)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                            child: Text("Error loading data"),
                          );
                        }
                        var favoriteItem = snapshot.data!;
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  favoriteItem['image']))),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          favoriteItem['name'],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        // Icon(
                                        //   Iconsax.flash_1,
                                        //   color: Colors.grey,
                                        // ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Iconsax.flash_1,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              "${favoriteItem['cal']} Cal",
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
                                              "${favoriteItem['time']} Min",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: 50,
                                right: 35,
                                child: GestureDetector(
                                  onTap: () {
                                    // setState(() {

                                    // });
                                    provider.toggle(favoriteItem);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ))
                          ],
                        );
                      });
                }));
  }
}
