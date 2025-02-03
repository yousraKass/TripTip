import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/blocs/Offer_bloc/offer_cubit.dart';
import 'package:triptip/blocs/Offer_bloc/offer_state.dart';
import 'package:triptip/views/widgets/BottomNavigationBarAgency.dart';
import 'package:triptip/views/widgets/offer_card_agency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/data/models/OfferModel.dart';

class OffersPageAgency extends StatelessWidget {
  final int agencyId;

  const OffersPageAgency({super.key, required this.agencyId});
  static const pageRoute = '/OffersPageAgency';

  @override
  Widget build(BuildContext context) {
    // Fetch offers for the specific agency when the widget is built
    context.read<OfferCubit>().fetchOffersByAgencyId(agencyId);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: BlocBuilder<OfferCubit, OfferState>(
        builder: (context, state) {
          if (state is OfferLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OfferLoadedState) {
            return _buildOffersList(state.offers);
          } else if (state is OfferErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No offers available'));
          }
        },
      ),
      bottomNavigationBar: const BottomNavigationBarExampleAgency(),
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
        onPressed: () => {
          Navigator.pushNamed(context, '/OfferDetailsPage'),
        },
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: AppColors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/AddOfferPage');
            },
          ),
        ),
      ],
      backgroundColor: AppColors.white,
    );
  }

  Widget _buildOffersList(List<OfferModel> offers) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: offers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: OfferCardAgency(
            offer: offers[index],
            onDelete: () {
              // Handle delete logic here
              context.read<OfferCubit>().deleteOffer(offers[index].id);
            },
          ),
        );
      },
    );
  }
}
/* 
class OffersPageAgency extends StatefulWidget {
  const OffersPageAgency({super.key});
  static const pageRoute = '/OffersPageAgency';

  @override
  _OffersPageAgencyState createState() => _OffersPageAgencyState();
}

class _OffersPageAgencyState extends State<OffersPageAgency> {
  List<OfferModel> offers = List.from(dummyOffers);

  void _deleteOffer(OfferModel offer) {
    setState(() {
      offers.remove(offer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: _buildOffersList(),
      bottomNavigationBar: const BottomNavigationBarExampleAgency(),
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
        onPressed: () => {
          Navigator.pushNamed(context, '/OfferDetailsPage'),
        },
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: AppColors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/AddOfferPage');
            },
          ),
        ),
      ],
      backgroundColor: AppColors.white,
    );
  }

  // for all offers
 Widget _buildOffersList() {
  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: offers.length,
    itemBuilder: (context, index) {
      // Add null check and bounds checking
      if (index < 0 || index >= offers.length) {
        return const SizedBox.shrink(); // Return empty widget if index out of bounds
      }
      
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: OfferCardAgency(
        offer: offers[index],
        onDelete: () {
          setState(() {
         // Safely remove the item
             if (index < offers.length) {
               offers.removeAt(index);
            }
           });
         },
         ),
      );
    },
  );
}
}
 */