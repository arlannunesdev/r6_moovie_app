import 'package:flutter/material.dart';
import 'package:r6_moovie_app/resources/app_colors.dart';
import 'package:r6_moovie_app/resources/app_strings.dart';
import 'package:r6_moovie_app/resources/app_values.dart';

import '../../pages/favorites_screen.dart';

class NavBarMain extends StatelessWidget {
  const NavBarMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 60),
          ListTile(
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: AppSize.s30,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              AppStrings.myProfile,
              style: TextStyle(
                fontSize: AppSize.s30,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              AppStrings.downloads,
              style: TextStyle(
                fontSize: AppSize.s30,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
          ListTile(
            title: const Text(
              AppStrings.populars,
              style: TextStyle(
                fontSize: AppSize.s30,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              AppStrings.myFavorites,
              style: TextStyle(
                fontSize: AppSize.s30,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
