import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/views/widgets/offer_card_favorite.dart';
import 'package:triptip/data/repo/offer/offer_model.dart';
import 'package:triptip/views/widgets/BottomNaviagtionBarClient.dart';

class FavoritePage extends StatefulWidget {
  static const pageRoute = '/favoriteScreenClient';
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: _buildOffersList(),
      bottomNavigationBar: const BottomNavigationBarExampleClient(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset(
          'assets/icons/back.png',
          width: 50,
          height: 50,
        ),
        onPressed: () => {
          Navigator.pop(context),
        },
      ),
      centerTitle: true,
      title: const Text(
        'Saved Offers',
        style: TextStyle(
          fontFamily: FontFamily.bold,
          color: AppColors.black,
          fontSize: 20,
        ),
      ),
      backgroundColor: AppColors.white,
    );
  }
  // for all offers
  Widget _buildOffersList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dummyOffers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          //child: FavoriteOffer(offer: dummyOffers[index]),
        );
      },
    );
  }
}