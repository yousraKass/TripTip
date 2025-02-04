// import 'package:flutter/material.dart';
// import 'package:triptip/views/themes/colors.dart';
// import 'package:triptip/views/themes/fonts.dart';
// import 'package:triptip/views/widgets/offer_card_agency.dart';
// import '../../data/models/OfferModel.dart';
// import 'package:triptip/views/widgets/BottomNavigationBarAgency.dart';


// class OffersPageAgency extends StatefulWidget {
//   const OffersPageAgency({super.key});
//   static const pageRoute = '/OffersPageAgency';

//   @override
//   _OffersPageAgencyState createState() => _OffersPageAgencyState();
// }

// class _OffersPageAgencyState extends State<OffersPageAgency> {
//   List<OfferModel> offers = List.from(dummyOffers);

//   void _deleteOffer(OfferModel offer) {
//     setState(() {
//       offers.remove(offer);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: _buildAppBar(context),
//       body: _buildOffersList(),
//       bottomNavigationBar: const BottomNavigationBarExampleAgency(),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return AppBar(
//       leading: IconButton(
//         icon: Image.asset(
//           'assets/icons/undo_icon.png',
//           width: 50,
//           height: 50,
//         ),
//         onPressed: () => {
//           Navigator.pushNamed(context, '/OfferDetailsPage'),
//         },
//       ),
//       centerTitle: true,
//       title: const Text(
//         'Offers',
//         style: TextStyle(
//           fontFamily: FontFamily.bold,
//           color: AppColors.black,
//           fontSize: 20,
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 12.0),
//           child: IconButton(
//             icon: const Icon(
//               Icons.add,
//               color: AppColors.black,
//               size: 30,
//             ),
//             onPressed: () {
//               Navigator.pushNamed(context, '/AddOfferPage');
//             },
//           ),
//         ),
//       ],
//       backgroundColor: AppColors.white,
//     );
//   }

//   // for all offers
//  Widget _buildOffersList() {
//   return ListView.builder(
//     padding: const EdgeInsets.all(16),
//     itemCount: offers.length,
//     itemBuilder: (context, index) {
//       // Add null check and bounds checking
//       if (index < 0 || index >= offers.length) {
//         return const SizedBox.shrink(); // Return empty widget if index out of bounds
//       }
      
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 16),
//         child: OfferCardAgency(
//           offer: offers[index],
//           onDelete: () {
//             setState(() {
//               // Safely remove the item
//               if (index < offers.length) {
//                 offers.removeAt(index);
//               }
//             });
//           },
//         ),
//       );
//     },
//   );
// }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/views/widgets/offer_card_agency.dart';
import '../../../data/models/OfferModel.dart';
import '../../../data/repositories/OfferRepo.dart';
import '../../../blocs/Offer_bloc/offer_cubit.dart';
import '../../../blocs/Offer_bloc/offer_state.dart';
import 'package:triptip/views/widgets/BottomNavigationBarAgency.dart';


class OffersPageAgency extends StatelessWidget {
  const OffersPageAgency({Key? key}) : super(key: key);
  static const pageRoute = '/OffersPageAgency';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OfferCubit(
        offerRepo: RepositoryProvider.of<OfferRepo>(context),
      )..fetchOffers(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: _buildOffersList(),
        bottomNavigationBar: const BottomNavigationBarExampleAgency(),
      ),
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
        onPressed: () => Navigator.pushNamed(context, '/OfferDetailsPage'),
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

  Widget _buildOffersList() {
    return BlocBuilder<OfferCubit, OfferState>(
      builder: (context, state) {
        if (state is OfferLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OfferErrorState) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is OfferLoadedState) {
          final offers = state.offers;

          if (offers.isEmpty) {
            return const Center(child: Text('No offers available'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: OfferCardAgency(
                  offer: offers[index],
                  onDelete: () {
                    // Implement delete logic using Cubit 
                    // Note: Backend implementation might be needed
                    context.read<OfferCubit>().fetchOffers();
                  },
                ),
              );
            },
          );
        }

        return const Center(child: Text('Unexpected state'));
      },
    );
  }
}