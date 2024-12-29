import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:sippify/colors.dart';
import 'package:sippify/models/coffee_model.dart';

class CoffeeDetaiScreen extends StatefulWidget {
  final Coffee coffee;
  const CoffeeDetaiScreen({super.key, required this.coffee});

  @override
  State<CoffeeDetaiScreen> createState() => _CoffeeDetaiScreenState();
}

class _CoffeeDetaiScreenState extends State<CoffeeDetaiScreen> {
  String selectedIndex = 'M';
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: xbackgroundColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        children: [
          const SizedBox(height: 50),
          buildHeader(),
          const SizedBox(height: 25),
          buildCoffeeImage(),
          const SizedBox(height: 20),
          buildCoffeeDetails(),
          const SizedBox(height: 20),
          buildDescription(),
          const SizedBox(height: 30),
          buildSizeSelector(),
          const SizedBox(height: 40),
        ],
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 22),
          color: Colors.black,
        ),
        const Text(
          "Detail",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          child: Icon(
            isFavorite ? Iconsax.heart5 : Iconsax.heart,
            color: isFavorite ? Colors.red : Colors.black,
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget buildCoffeeImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Hero(
        tag: widget.coffee.image,
        child: Image.asset(
          widget.coffee.image,
          width: double.infinity,
          height: 270,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 270,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Text(
                "Image not available",
                style: TextStyle(color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCoffeeDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.coffee.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.coffee.type,
                  style: TextStyle(fontSize: 12, color: xsecondaryColor),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Image.asset(
                      "assets/coffee-shop/ic_star_filled.png",
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${widget.coffee.rate}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      " (${widget.coffee.review})",
                      style: TextStyle(fontSize: 12, color: xsecondaryColor),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                for (var icon in [
                  "assets/coffee-shop/bike.png",
                  "assets/coffee-shop/bean.png",
                  "assets/coffee-shop/milk.png"
                ])
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(icon, height: 25, width: 25),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Divider(color: Colors.black12, thickness: 1),
      ],
    );
  }

  Widget buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        ReadMoreText(
          widget.coffee.description,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: "Read More",
          trimExpandedText: "Read Less",
          style: TextStyle(fontSize: 15, color: xsecondaryColor),
          moreStyle: TextStyle(fontWeight: FontWeight.bold, color: xprimaryColor),
          lessStyle: TextStyle(fontWeight: FontWeight.bold, color: xprimaryColor),
        ),
      ],
    );
  }

  Widget buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Size",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['S', 'M', 'L'].map((size) {
            bool isSelected = selectedIndex == size;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = size;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isSelected ? xprimaryColor.withOpacity(0.1) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? xprimaryColor : Colors.black12,
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  size,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? xprimaryColor : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$${widget.coffee.price.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add functionality to handle order placement
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: xprimaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Order Now",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
