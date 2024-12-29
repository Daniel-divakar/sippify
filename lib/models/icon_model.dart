import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sippify/page/home_screen.dart';

/// Menu list with added labels and support for dynamic badges.
final menu = [
  {
    'icon': Iconsax.home5,
    'label': 'Home',
    'destination': const CoffeeAppHome(),
    'badge': 0, // No badge for home
  },
  {
    'icon': Iconsax.heart,
    'label': 'Favorites',
    'destination': const Center(child: Text('Favorites')),
    'badge': 5, // Example: 5 favorite items
  },
  {
    'icon': Iconsax.shopping_bag,
    'label': 'Shopping',
    'destination': const Center(child: Text('Shopping')),
    'badge': 2, // Example: 2 items in the cart
  },
  {
    'icon': Iconsax.notification,
    'label': 'Notifications',
    'destination': const Center(child: Text('Notifications')),
    'badge': 7, // Example: 7 unread notifications
  },
];


