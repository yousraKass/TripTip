
import 'package:flutter/material.dart';
import 'package:triptip/views/widgets/offer_card.dart';
import 'package:triptip/views/widgets/search_bar_widget.dart';
import 'package:triptip/views/widgets/BottomNaviagtionBarClient.dart';
import 'package:triptip/views/widgets/BottomNavigationBarAgency.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/data/repo/offer/offer_model.dart';
import 'package:triptip/views/screens/agency/SettingsScreenAgency.dart';
import 'package:triptip/views/screens/client/SettingsScreenClient.dart';
import 'package:triptip/views/screens/client/notifications_client.dart';
import 'package:triptip/views/screens/agency/notifications_agency.dart';
import 'package:triptip/views/screens/shared/SignUpAsScreen.dart';
import 'OfferScreen.dart';
import 'search_page.dart';

import 'offers_page.dart';



class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  static const pageRoute = "/LandingPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo Section
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 22.0),
                        child: GestureDetector(
                          onTap: () {
                            // Optional: Add functionality for logo tap
                          },
                          child: Center(
                            child: Image.asset(
                              "assets/logo/New_logo.png",
                              width: 120, // Increased size
                              height: 120,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 115),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10.0), // Move icons down
                      //   child: Row(
                      //     children: [
                      //       IconButton(
                      //         icon: Image.asset(
                      //           "assets/icons/notifications.png",
                      //           width: 18,
                      //           height: 20,
                      //         ),
                      //         onPressed: () {
                      //           Navigator.push(
                      //             context,
                                
                      //          MaterialPageRoute(
                      //               builder: (context) => role == SignUpAs.Client ?
                      //                    NotificationsClient()
                      //                   : NotificationsAgency (),
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //       IconButton(
                      //         icon: Image.asset(
                      //           "assets/icons/settings.png",
                      //           width: 18,
                      //           height: 20,
                      //         ),
                      //         onPressed: () {
                      //           Navigator.push(
                      //             context,
                                
                      //             MaterialPageRoute(
                      //               builder: (context) => role == SignUpAs.Client ?
                      //                    SettingsScreenClient ()
                      //                   : SettingsScreenAgency (),
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 37),

                  // Search Bar Section with Transparent Overlay
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
                              color: Colors.white.withOpacity(0.5), // Transparent overlay
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 38),

                  // Chosen Offer Section
                  Container(
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
                              const Text(
                                "For only 10K Da!",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 18, 16, 16),
                                ),
                              ),
                              const Text(
                                "It is a too good deal, you will \ntravel with free food, \nplenty of free food",
                                style: TextStyle(
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
                                    MaterialPageRoute(builder: (context) => OfferDetailsPage()),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(Colors.black),
                                  padding: WidgetStateProperty.all(
                                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                  ),
                                  shape: WidgetStateProperty.all(
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
                  ),
                  const SizedBox(height: 40),

                  // Recommended Places Section with Gradient
                  gradientTitleSection("Top Popular Places To Visit"),
                  buildHorizontalList1(context),
                  const SizedBox(height: 30),
                  gradientTitleSection("What are you interested in?"),
                  buildHorizontalList2(context),
                  const SizedBox(height: 30),

                  // Recommended Offers Section
                  gradientTitleSection("Recommended Offers"),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dummyOffers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: OfferCard(
                          offer: dummyOffers[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

        

        ],
      ),
      bottomNavigationBar:role == SignUpAs.Client ? BottomNavigationBarExampleClient() : BottomNavigationBarExampleAgency(),
    );
  }

  // Gradient Title Section
  Widget gradientTitleSection(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.main,
            Colors.white,
          ],
          stops: [0.0, 0.3], // Gradient covers 30% width
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

  // Horizontal List for Places
  Widget buildHorizontalList1(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          buildPlaceCard(context, "assets/images/Annaba.png", "Algeria", "Annaba"),
          buildPlaceCard(context, "assets/images/Tunis.png", "Tunisia", "Tunis"),
          buildPlaceCard(context, "assets/images/Istanbul.png", "Turkey", "Istanbul"),
          buildPlaceCard(context, "assets/images/Jijel.png", "Algeria", "Jijel"),
          buildPlaceCard(context, "assets/images/sahara.png", "Algeria", "Sahara"),
        ],
      ),
    );
  }

  Widget buildHorizontalList2(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          buildInterestCard(context, "assets/images/cat01.png", "Shopping"),
          buildInterestCard(context, "assets/images/cat02.png", "Swimming"),
          buildInterestCard(context, "assets/images/cat03.png", "Mountains"),
          buildInterestCard(context, "assets/images/cat04.png", "Camping"),
        ],
      ),
    );
  }

  // Place Cards
  Widget buildPlaceCard(BuildContext context, String imagePath, String country, String city) {
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
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            Text(country, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(city),
          ],
        ),
      ),
    );
  }

  // Interest Cards
  Widget buildInterestCard(BuildContext context, String imagePath, String category) {
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
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            Text(category),
          ],
        ),
      ),
    );
  }
}

