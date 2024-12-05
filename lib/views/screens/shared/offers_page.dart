import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/views/widgets/offer_card.dart';
import 'package:triptip/data/repo/offer/offer_model.dart';
import 'package:triptip/views/widgets/BottomNavigationBar.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});
  static const pageRoute = '/OffersPage';

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: _buildOffersList(),
      bottomNavigationBar: const BottomNavigationBarExample(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset(
          'assets/icons/undo_icon.png',
          width: 50,
          height: 50,
        ),
        onPressed: () => {},
      ),
      centerTitle: true,
      title: const Text(
        'Offers',
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
          child: OfferCard(offer: dummyOffers[index]),
        );
      },
    );
  }
}
