// landing_page.dart
import 'package:flutter/material.dart';
import '/views/widgets/BottomNaviagtionBarClient.dart';
import '/views/widgets/BottomNavigationBarAgency.dart';
import '/views/themes/colors.dart';
import '/views/widgets/offer_card.dart';
import '/views/widgets/search_bar_widget.dart';
import '/views/screens/shared/SignUpAsScreen.dart';
import 'OfferScreen.dart';
import 'search_page.dart';
import 'offers_page.dart';
import '/blocs/Offer_bloc/offer_cubit.dart';
import '/blocs/Offer_bloc/offer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/models/OfferModel.dart';
import 'package:cached_network_image/cached_network_image.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  static const pageRoute = "/LandingPage";

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    context.read<OfferCubit>().fetchInitialData();
  }

//   Widget buildPlaceCard(BuildContext context, OfferModel offer) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => OffersPage()),
//       );
//     },
//     child: Container(
//       margin: const EdgeInsets.only(left: 16),
//       width: 100,
//       child: Column(
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 offer.image,  // Use Image.asset instead of Image.network
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     color: Colors.grey[300],
//                     child: const Icon(Icons.error),
//                   );
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(offer.countryName, style: const TextStyle(fontWeight: FontWeight.bold)),
//           Text(offer.cityName),
//         ],
//       ),
//     ),
//   );
// }
Widget buildPlaceCard(BuildContext context, OfferModel offer) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OffersPage()),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(left: 16),
      width: 100,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: offer.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.error),
                      SizedBox(height: 4),
                      Text(
                        'Image Error',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(offer.countryName, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(offer.cityName),
        ],
      ),
    ),
  );
}


Widget buildInterestCard(BuildContext context, OfferModel offer) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OffersPage()),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(left: 16),
      width: 100,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: offer.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.error),
                      SizedBox(height: 4),
                      Text(
                        'Image Error',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            offer.category ?? 'Unknown Category',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}


// Horizontal List for Places
Widget buildHorizontalList1(BuildContext context, List<OfferModel> places) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: places.length,
        itemBuilder: (context, index) {
          return buildPlaceCard(context, places[index]);
        },
      ),
    );
  }

  // Horizontal List for Interests
  Widget buildHorizontalList2(
      BuildContext context, List<OfferModel> interests) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: interests.length,
        itemBuilder: (context, index) {
          return buildInterestCard(context, interests[index]);
        },
      ),
    );
  }

  // Gradient Title Section
  Widget gradientTitleSection(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.main, Colors.white],
          stops: [0.0, 0.3],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }


  Widget buildTopOffer(BuildContext context, OfferModel offer) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/choosen_offer.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Today's Deal",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: const [
                      Shadow(offset: Offset(-1, -1), color: Colors.black),
                      Shadow(offset: Offset(1, -1), color: Colors.black),
                      Shadow(offset: Offset(-1, 1), color: Colors.black),
                      Shadow(offset: Offset(1, 1), color: Colors.black),
                    ],
                  ),
                ),
                Text(
                  "For only ${offer.price.toStringAsFixed(0)} Da!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 18, 16, 16),
                  ),
                ),
                Text(
                  offer.descriptionText ?? 'No description available',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 118, 114, 114),
                  ),
                ),
                const SizedBox(height: 13),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OfferDetailsPage(offerId: offer.id)),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    ),
                    shape: MaterialStateProperty.all(
                      const BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(width: 10),
                      Text(
                        "Explore that OFFER",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 22),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Image.asset(
              "assets/images/Old_people.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }



  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.main),
    );
  }

  Widget buildErrorWidget(String message, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<OfferCubit, OfferState>(
        builder: (context, state) {
          if (state is OfferInitialState || state is OfferLoadingState) {
            return buildLoadingIndicator();
          }

          if (state is OfferErrorState) {
            return buildErrorWidget(
              state.message,
              () => context.read<OfferCubit>().fetchInitialData(),
            );
          }

          if (state is OfferLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<OfferCubit>().fetchInitialData();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo Section
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0, left: 22.0),
                          child: Image.asset(
                            "assets/logo/New_logo.png",
                            width: 120,
                            height: 120,
                          ),
                        ),
                        const SizedBox(width: 115),
                      ],
                    ),
                    const SizedBox(height: 37),

                    // Search Bar Section
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Stack(
                          children: [
                            SearchBarWidget(),
                            Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 38),

                    // Today's Deal Section
                    if (state.topOffer != null)
                      buildTopOffer(context, state.topOffer!),

                    const SizedBox(height: 40),

                    // Places Section
                    if (state.places.isNotEmpty) ...[
                      gradientTitleSection("Top Popular Places To Visit"),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.places.length,
                          itemBuilder: (context, index) {
                            return buildPlaceCard(context, state.places[index]);
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 30),

                    // Categories Section
                    if (state.categories.isNotEmpty) ...[
                      gradientTitleSection("What are you interested in?"),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return buildInterestCard(
                                context, state.categories[index]);
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 30),

                    // Recommended Offers Section
                    if (state.offers.isNotEmpty) ...[
                      gradientTitleSection("Recommended Offers"),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.offers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: OfferCard(
                              offer: state.offers[index],
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: role == SignUpAs.Client
          ? BottomNavigationBarExampleClient()
          : BottomNavigationBarExampleAgency(),
    );
  }
}
