import 'package:flutter/material.dart';
import '/views/themes/colors.dart';
import '/views/themes/fonts.dart';
import '/views/widgets/offer_card.dart';
import '/views/widgets/BottomNaviagtionBarClient.dart';
import '/blocs/Offer_bloc/offer_cubit.dart';
import '/blocs/Offer_bloc/offer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// class OffersPage extends StatefulWidget {
//   const OffersPage({super.key});
//   static const pageRoute = '/OffersPage';

//   @override
//   _OffersPageState createState() => _OffersPageState();
// }

// class _OffersPageState extends State<OffersPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: _buildAppBar(context),
//       body: _buildOffersList(),
//       bottomNavigationBar: const BottomNavigationBarExampleClient(),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return AppBar(
//       leading: IconButton(
//         icon: Image.asset(
//           'assets/icons/back.png',
//           width: 50,
//           height: 50,
//         ),
//         onPressed: () => {
//           Navigator.pop(context),
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
//       backgroundColor: AppColors.white,
//     );
//   }
//   // for all offers
//   Widget _buildOffersList() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: dummyOffers.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 16),
//           child: Offe
//         );
//       },
//     );
//   }
// }

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});
  static const pageRoute = '/OffersPage';
  

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
        onPressed: () => Navigator.pop(context),
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

  Widget _buildOffersList() {
    return BlocBuilder<OfferCubit, OfferState>(
      builder: (context, state) {
        if (state is OfferInitialState) {
          // Trigger fetch on initial state
          context.read<OfferCubit>().fetchInitialData();
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state is OfferLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state is OfferErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${state.message}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                ElevatedButton(
                  onPressed: () => context.read<OfferCubit>().fetchOffers(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        
        if (state is OfferLoadedState) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.offers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: OfferCard(offer: state.offers[index]),
              );
            },
          );
        }
        
        return const SizedBox();
      },
    );
  }
}
