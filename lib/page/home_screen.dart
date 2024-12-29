import 'package:flutter/material.dart';
import 'package:sippify/colors.dart';
import 'package:sippify/models/coffee_model.dart';
import 'package:sippify/page/coffee_detai_screen.dart';

class CoffeeAppHome extends StatefulWidget {
  const CoffeeAppHome({super.key});

  @override
  State<CoffeeAppHome> createState() => _CoffeeAppHomeState();
}

class _CoffeeAppHomeState extends State<CoffeeAppHome> {
  int selectedIndex = 0;
  final Set<int> favoriteCoffees = {};

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        buildHeader(),
        const SizedBox(height: 35),
        buildCategorySelection(),
        const SizedBox(height: 20),
        buildCoffeeGrid(),
      ],
    );
  }

  Widget buildHeader() {
    return Stack(
      children: [
        Container(
          height: 280,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 17, 17, 17),
                Color.fromARGB(255, 49, 49, 49),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              const SizedBox(height: 60),
              buildLocationSelector(),
              const SizedBox(height: 25),
              buildSearchBar(),
              const SizedBox(height: 25),
              buildBanner(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLocationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Location",
          style: TextStyle(color: xsecondaryColor),
        ),
        Row(
          children: [
            const Text(
              "Seville, Spain",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: xsecondaryColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xff2a2a2a),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search coffee",
                      hintStyle: TextStyle(fontSize: 18, color: xsecondaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          height: 60,
          width: 55,
          decoration: BoxDecoration(
            color: xprimaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.tune, color: Colors.white),
        ),
      ],
    );
  }

  Widget buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        "assets/coffee-shop/banner.png",
        width: double.infinity,
        height: 140,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 140,
            color: Colors.grey,
            child: const Center(child: Text("Banner not available")),
          );
        },
      ),
    );
  }

  Widget buildCategorySelection() {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        itemCount: coffeeCategories.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 25 : 10,
                right: index == coffeeCategories.length - 1 ? 25 : 10,
              ),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? xprimaryColor
                    : xsecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              child: Text(
                coffeeCategories[index],
                style: TextStyle(
                  fontWeight: selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: 16,
                  color: selectedIndex == index ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCoffeeGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 270,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
      ),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listOfCoffee.length,
      itemBuilder: (context, index) {
        final coffee = listOfCoffee[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CoffeeDetaiScreen(coffee: coffee),
              ),
            );
          },
          child: CoffeeCard(
            coffee: coffee,
            isFavorite: favoriteCoffees.contains(index),
            onFavoriteToggle: () {
              setState(() {
                if (favoriteCoffees.contains(index)) {
                  favoriteCoffees.remove(index);
                } else {
                  favoriteCoffees.add(index);
                }
              });
            },
          ),
        );
      },
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final Coffee coffee;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const CoffeeCard({
    super.key,
    required this.coffee,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: coffee.image,
                  child: Image.asset(
                    coffee.image,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 160,
                        color: Colors.grey,
                        child: const Center(child: Text("Image not available")),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            coffee.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          Text(
            coffee.type,
            style: TextStyle(color: xsecondaryColor),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${coffee.price}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: xprimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
