import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuantityIncrementDecremint extends StatelessWidget {
  final int currentNumber;
  final Function() onAdd;
  final Function() onRemove;
  const QuantityIncrementDecremint(
      {super.key,
      required this.currentNumber,
      required this.onAdd,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 2, color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onRemove,
            icon: Icon(Iconsax.minus),
          ),
          SizedBox(
            width: 10,
          ),
          Text("$currentNumber"),
          SizedBox(
            width: 10,
          ),
          IconButton(onPressed: onAdd, icon: Icon(Iconsax.add)),
        ],
      ),
    );
  }
}
