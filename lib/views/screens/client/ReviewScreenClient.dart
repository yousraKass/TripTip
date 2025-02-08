import 'package:flutter/material.dart';
import 'package:triptip/data/repo/offer/OfferText.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/views/widgets/ReviewItem.dart'; // Assuming this widget exists
import 'package:triptip/data/repo/review_agency/ReviewText.dart';


class ReviewScreenClient extends StatefulWidget {
  static const pageRoute = '/ReviewPageClient';

  const ReviewScreenClient({super.key});
  @override
  _ReviewScreenClientState createState() => _ReviewScreenClientState();
}

class _ReviewScreenClientState extends State<ReviewScreenClient> {
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
                  const ReviewInputSection(),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No reviews available.'));
          }
        },
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
