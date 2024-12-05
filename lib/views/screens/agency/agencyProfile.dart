import 'package:flutter/material.dart';
import 'package:triptip/data/repo/agency_profile/AgencyText.dart';
import 'package:triptip/data/repo/offer/OfferText.dart';
import 'package:triptip/views/screens/agency/SettingsScreenAgency.dart';
import 'package:triptip/views/screens/agency/ReviewScreenAgency.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/data/repo/review_agency/ReviewText.dart';
import 'package:triptip/views/widgets/ReviewItem.dart';
import 'EditAgencyProfile.dart';
import 'package:triptip/views/widgets/BottomNavigationBarAgency.dart';


class AgencyScreen extends StatefulWidget {
  static const pageRoute = '/AgencyProfile';

  const AgencyScreen({super.key});
  @override
  _AgencyScreenState createState() => _AgencyScreenState();
}

class _AgencyScreenState extends State<AgencyScreen> {
  final AgencyInformations agencyInformations = AgencyInformations();
  late Future<AgencyData> agencyDataFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future for agency data
    agencyDataFuture = agencyInformations.getAgencyData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: FutureBuilder<AgencyData>(
        future: agencyInformations.getAgencyData(), // Fetch agency data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error loading data')); // Error message
          } else if (snapshot.hasData) {
            final agencyData = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(agencyData),
                  _buildContactUs(agencyData),
                  _buildAboutUS(agencyData),
                  _buildOffers(),
                  _buildReviewsTab(agencyData),
                ],
              ),
            );
            // Build the header with data
          } else {
            return const Center(
                child: Text('No data available')); // Fallback for no data
          }
        },
      ),
      bottomNavigationBar:BottomNavigationBarExampleAgency(),
    );
  }

  Widget _buildHeader(AgencyData agencyData) {
    return Stack(
      children: [
        Stack(
          children: [
            // Shadow effect
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 283, // Slightly larger for shadow placement
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.grey.withOpacity(0.5), // Shadow color
                      Colors.transparent, // Fade out the shadow
                    ],
                  ),
                ),
              ),
            ),

            // Background Image
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(agencyData.backGroundAgency),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [Positioned(
                        top: 30,
                        right: 20,
                        child: IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(3),
                            child: SizedBox(
                              height: 28,
                              width: 28,
                              child: Image.asset(
                                'assets/icons/settings.png',
                                color: AppColors.black,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, SettingsScreenAgency.pageRoute);
                          },
                        ),
                      ),],
                ),
              ),
            ),
          ],
        ),

        // Logo and Title
        Positioned(
          top: 170,
          left: 60,
          //right: 20,
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    agencyData.profilePictureAgency), // Dynamic profile picture
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
        _buildTitle(agencyData),
      ],
    );
  }

  Widget _buildTitle(AgencyData agencyData) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(60, 290, 0, 0),
        child: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  agencyData.agencyTitle,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontFamily: FontFamily.medium,
                    fontSize: 27,
                    //fontWeight: FontWeight.,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                    icon: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        'assets/icons/editer.png',
                        height: 30,
                        width: 30,
                        color: AppColors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, EditAgencyProfileScreen.pageRoute);
                    }),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10), // Adjust the left padding as needed
              child: Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < 4 ? AppColors.main : Colors.teal.shade100,
                    size: 17,
                  );
                }),
              ),
            ),
          ],
        ));
  }

  Widget _buildContactUs(AgencyData agencyData) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align the content to the left
      children: [
        const Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the divider horizontally
          children: [
            SizedBox(
              width: 310, // Adjust the width as needed
              child: Divider(
                color: Color.fromARGB(234, 224, 224, 224),
                thickness: 2.0,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),
        const Text(
          '             ${AgencyTexts.contactUs}',
          style: TextStyle(
            fontFamily: FontFamily.bold,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        //SizedBox(height: 10),
        // Content inside padding
        Container(
          padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Contact(
                title: AgencyTexts.phoneTitle,
                icon: 'assets/icons/Phone.png',
                description: agencyData.phoneNumber,
              ),
              Contact(
                title: AgencyTexts.emailTitle,
                icon: 'assets/icons/gmail.png',
                description: agencyData.agencyEmail,
              ),
              Contact(
                title: AgencyTexts.addressTitle,
                icon: 'assets/icons/location.png',
                description: agencyData.agencyAddress,
              ),
              Row(
                children: [
                  Image.asset('assets/icons/reseau.png', height: 30, width: 30),
                  const SizedBox(width: 10),
                  const Text(
                    '${AgencyTexts.socialTitle}:',
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Image.asset('assets/icons/instagram.png',
                      height: 35, width: 35),
                ],
              ),
            ],
          ),
        ),

        //const Divider(color: Color.fromARGB(234, 224, 224, 224), thickness: 3.0),
      ],
    );
  }

  Widget _buildAboutUS(AgencyData agencyData) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 25, 10, 25),
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey, // Set the border color
          width: 0.2, // Set the border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            //spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AgencyTexts.aboutUsTitle,
            style: TextStyle(
              fontFamily: FontFamily.bold,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            agencyData.aboutUs,
            style: const TextStyle(
                fontFamily: FontFamily.bold, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildOffers() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AgencyTexts.offersTitle, // Use title from AgencyTexts
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150, // Height for horizontal scrolling
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.offerImageUrls.length, // Total offer images
              itemBuilder: (context, index) {
                final imageUrl = images.offerImageUrls[index]; // Image path
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 150, // Width for each item
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imageUrl,
                          height: 100,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Offer ${index + 1}', // Dynamic title (e.g., Offer 1)
                        style: const TextStyle(
                          fontFamily: FontFamily.medium,
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsHeader(int reviewCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          AppTexts.reviewsTitle,
          style: TextStyle(
            color: AppColors.black,
            fontFamily: FontFamily.medium,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          ' ($reviewCount)',
          style: const TextStyle(
            color: AppColors.black,
            fontFamily: FontFamily.medium,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, ReviewScreenAgency.pageRoute);
          },
          child: const Text(
            AppTexts.viewAll,
            style: TextStyle(
              color: AppColors.second,
              fontFamily: FontFamily.medium,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsList(List<Review> reviews) {
    // Limit the reviews to the first 3 items
    final limitedReviews = reviews.take(4).toList();

    return Column(
      children: List.generate(
        limitedReviews.length,
        (index) => Column(
          children: [
            ReviewItem(
              user: limitedReviews[index]
                  .user, // Pass the user object from Review
              time: limitedReviews[index].time,
              review: limitedReviews[index].review,
            ),
            
              const Divider(
                color: Color.fromARGB(234, 224, 224, 224),
                thickness: 3.0,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsTab(AgencyData agencyData) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReviewsHeader(agencyData.reviews.length),
            const Divider(
                color: Color.fromARGB(234, 224, 224, 224), thickness: 3.0),
            const SizedBox(height: 10),
            _buildReviewsList(agencyData.reviews),
            const ReviewInputSection(),
          ],
        ));
  }
  
}

class Contact extends StatelessWidget {
  final String title;
  final String icon;
  final String description;

  const Contact({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(icon, height: 30, width: 30),
        const SizedBox(width: 10),
        Text(
          '$title:',
          style: const TextStyle(
            fontFamily: FontFamily.bold,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 40),
        Text(description),
      ],
    );
  }
}

class ReviewInputSection extends StatefulWidget {
  const ReviewInputSection({super.key});

  @override
  _ReviewInputSectionState createState() => _ReviewInputSectionState();
}

class _ReviewInputSectionState extends State<ReviewInputSection> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 50),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: AppTexts.writeReviewPlaceholder,
              labelStyle: TextStyle(color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.teal.withOpacity(0.8),
                  width: 1.5,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: IconButton(
                icon: Image.asset(
                  'assets/icons/send.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: _submitReview,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _submitReview() {
    if (_controller.text.isNotEmpty) {
      // Implement review submission logic
      print('Submitting review: ${_controller.text}');
      _controller.clear();
    }
  }
}

// Custom Clipper for the Header Curve
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80); // Start lower for a steeper curve

    // First wave segment
    path.quadraticBezierTo(
      size.width * 0.3, size.height - 165, // Control point
      size.width * 0.6, size.height - 75, // End point
    );

    // Second wave segment
    path.quadraticBezierTo(
      size.width * 0.85, size.height - 20, // Control point
      size.width, size.height - 50, // End point
    );

    // Connect to top-right corner
    path.lineTo(size.width, 0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip unless the shape changes
  }
}
