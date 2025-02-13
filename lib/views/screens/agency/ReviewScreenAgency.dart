import 'package:flutter/material.dart';
import 'package:triptip/data/repo/offer/OfferText.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/views/widgets/ReviewItem.dart'; // Assuming this widget exists
import 'package:triptip/data/repo/review_agency/ReviewText.dart';
import 'package:triptip/views/widgets/BottomNavigationBarAgency.dart';


class ReviewScreenAgency extends StatefulWidget {
  static const pageRoute = '/ReviewPage';

  const ReviewScreenAgency({super.key});
  @override
  _ReviewScreenAgencyState createState() => _ReviewScreenAgencyState();
}

class _ReviewScreenAgencyState extends State<ReviewScreenAgency> {
  late Future<List<Review>> _reviewsFuture;

  @override
  void initState() {
    super.initState();
    _reviewsFuture = getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: _buildBackButton(),
      ),
      body: FutureBuilder<List<Review>>(
        future: _reviewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Review> reviews = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReviewsHeader(reviews.length),
                  const SizedBox(height: 10),
                  const Divider(color: Color.fromARGB(234, 224, 224, 224), thickness: 3.0),
                  _buildReviewsList(reviews),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No reviews available.'));
          }
        },
      ),
      bottomNavigationBar:BottomNavigationBarExampleAgency(),
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
            // Navigate to all reviews if needed
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
    return Column(
      children: List.generate(
        reviews.length,
        (index) => Column(
          children: [
            ReviewItem(
              user: reviews[index].user,  // Pass user object to ReviewItem
              time: reviews[index].time,
              review: reviews[index].review,
            ),
            if (index < reviews.length - 1)
              const Divider(
                color: Color.fromARGB(234, 224, 224, 224),
                thickness: 3.0,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 30,
      left: 20,
      child: IconButton(
        icon: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/icons/back.png',
            height: 30,
            width: 30,
            color: AppColors.fourth,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

