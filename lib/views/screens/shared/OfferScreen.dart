import 'dart:async';
import 'package:flutter/material.dart';
import '/views/screens/client/ReviewScreenClient.dart';
import '/views/themes/fonts.dart';
import '/views/themes/colors.dart';
import '/data/repo/offer/OfferText.dart';
import '/views/widgets/BottomNavigationBarAgency.dart';
import '/views/widgets/BottomNaviagtionBarClient.dart';
import '/views/widgets/ReviewItem.dart';
import '/data/repo/review_agency/ReviewText.dart';
import '/views/screens/shared/SignUpAsScreen.dart';


// Modified OfferScreen.dart
class OfferDetailsPage extends StatefulWidget {
  static const pageRoute = '/OfferDetails';

  const OfferDetailsPage({super.key});
  @override
  _OfferDetailsPageState createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  
  bool isFavorite = false;
  final OfferService _offerService = OfferService();
  late Future<OfferData> _offerDataFuture;

  @override
  void initState() {
    super.initState();
    _offerDataFuture = _offerService.getOfferDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<OfferData>(
        future: _offerDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading offer details'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final offerData = snapshot.data!;

          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePaths.backGroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(offerData),
                    _buildDetailsSection(offerData),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar:role == SignUpAs.Client ? BottomNavigationBarExampleClient() : BottomNavigationBarExampleAgency(),
    );
  }

  Widget _buildHeader(OfferData offerData) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePaths.backGroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          _buildBackButton(),
          _buildFavoriteButton(),
          _buildTitleAndSubtitle(offerData),
        ],
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
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/icons/back.png',
            height: 30,
            width: 30,
            color: AppColors.main,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 30,
      right: 20,
      child: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(3),
          child: SizedBox(
            height: 35,
            width: 35,
            child: Image.asset(
              isFavorite
                  ? 'assets/icons/filledfavorite.png'
                  : 'assets/icons/emptyfavorite.png',
              color: AppColors.main,
              fit: BoxFit.contain,
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
      ),
    );
  }

  Widget _buildTitleAndSubtitle(OfferData offerData) {
    return Positioned(
      top: 120,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            offerData.cityName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            offerData.countryName,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: FontFamily.medium,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      offerData.rating,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(OfferData offerData) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OfferDetailsSection(offerData: offerData),
          ReviewSection(
              reviews: offerData.reviews,
              descriptionText: offerData.descriptionText),
        ],
      ),
    );
  }
}

class OfferDetailsSection extends StatelessWidget {
  final OfferData offerData;

  const OfferDetailsSection({super.key, required this.offerData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildInformationList(),
          const SizedBox(height: 10),
          _buildTitle(),
          const SizedBox(height: 10),
          _buildImageList(),
        ],
      ),
    );
  }

  Widget _buildInformationList() {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Information(
            title: AppTexts.priceTitle,
            description: offerData.priceDescription,
            icon: 'assets/icons/money.png',
          ),
          const SizedBox(width: 20),
          Information(
            title: AppTexts.startDateTitle,
            description: offerData.startDate,
            icon: 'assets/icons/time.png',
          ),
          const SizedBox(width: 20),
          Information(
            title: AppTexts.endDateTitle,
            description: offerData.endDate,
            icon: 'assets/icons/time.png',
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppTexts().offerDetailsTitle,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: FontFamily.bold,
      ),
    );
  }

  Widget _buildImageList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offerData.images.length,
        itemBuilder: (context, index) {
          return OfferImage(imageUrl: offerData.images[index]);
        },
      ),
    );
  }
}

class ReviewSection extends StatefulWidget {
  final List<Review> reviews;
  final String descriptionText;

    const ReviewSection({super.key, 
    required this.reviews,
    required this.descriptionText,
  });

  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabs(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child:
              _selectedIndex == 0 ? _buildDescriptionTab(widget.descriptionText) : _buildReviewsTab(),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          const SizedBox(width: 20),
          _buildTab(AppTexts.descriptionTab, 0),
          const SizedBox(width: 30),
          _buildTab(AppTexts.reviewTab, 1),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Text(
        text,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.black : Colors.grey,
          fontSize: 16,
          fontWeight:
              _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildDescriptionTab(String description) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ExpandableDescription(description: description),
            ),
            const SizedBox(height: 30),
          ],
        ),
        
        Positioned(
          bottom: -5,
          right: 5,
          child: _buildWhatsAppButton(),
        ),
      ],
    );
    
  }

  Widget _buildWhatsAppButton() {
    return IconButton(
      icon: Container(
        decoration: BoxDecoration(
          color: AppColors.second,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Image.asset(
          'assets/icons/whatsapp.png',
          width: 60,
          height: 60,
          color: AppColors.white,
        ),
      ),
      onPressed: () {
        // Implement WhatsApp functionality
      },
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReviewSummary(),
        const SizedBox(height: 20),
        _buildReviewsHeader(widget.reviews.length),
        const Divider(color: Color.fromARGB(234, 224, 224, 224), thickness: 3.0),
        const SizedBox(height: 10),
        _buildReviewsList(widget.reviews),
        const ReviewInputSection(),
      ],
    );
  }

  Widget _buildReviewSummary() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRatingSummary(),
          const SizedBox(height: 15),
          _buildRatingBars(),
        ],
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '4.7', // This should come from your data
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.reviewSummary,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: index < 4 ? AppColors.main : Colors.teal.shade100,
                  size: 16,
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingBars() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRatingBar('5', Offertext.ratingValues[0]),
        _buildRatingBar('4', Offertext.ratingValues[1]),
        _buildRatingBar('3', Offertext.ratingValues[2]),
        _buildRatingBar('2', Offertext.ratingValues[3]),
        _buildRatingBar('1', Offertext.ratingValues[4]),
      ],
    );
  }

  Widget _buildRatingBar(String label, double value) {
    return Row(
      children: [
        Text(label),
        const Icon(Icons.star, color: AppColors.main, size: 16),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey[300],
              color: AppColors.main,
              minHeight: 10,
            ),
          ),
        ),
      ],
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
            Navigator.pushNamed(context, ReviewScreenClient.pageRoute);
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
    final limitedReviews = reviews.take(3).toList();

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
            if (index < limitedReviews.length - 1)
              const Divider(
                color: Color.fromARGB(234, 224, 224, 224),
                thickness: 3.0,
              ),
          ],
        ),
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

class Information extends StatelessWidget {
  final String title;
  final String icon;
  final String description;

  const Information({super.key, 
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Image.asset(icon, height: 30, width: 30),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: FontFamily.bold,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(description),
          ],
        ),
      ],
    );
  }
}

class OfferImage extends StatelessWidget {
  final String imageUrl;

  const OfferImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ExpandableDescription extends StatefulWidget {
  @override
  _ExpandableDescriptionState createState() => _ExpandableDescriptionState();
  final String description;
  const ExpandableDescription({super.key, required this.description});
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isExpanded
              ? widget.description
              : _getShortenedText(widget.description),
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? AppTexts.readLess : AppTexts.readMore,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  String _getShortenedText(String text) {
    const int maxLines = 4;
    final RegExp regex = RegExp(r'(.{1,80}\s|.{1,80}$)', multiLine: true);
    final List<String> lines =
        regex.allMatches(text).map((m) => m.group(0)!).toList();
    return lines.length > maxLines
        ? '${lines.take(maxLines).join(' ')}...'
        : text;
  }
}
