




























// offer_details_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/views/screens/client/ReviewScreenClient.dart';
import '/views/themes/fonts.dart';
import '/views/themes/colors.dart';
import '/views/widgets/BottomNavigationBarAgency.dart';
import '/views/widgets/BottomNaviagtionBarClient.dart';
import '/views/screens/shared/SignUpAsScreen.dart';
import '/blocs/Offer_bloc/offer_cubit.dart';
import '/blocs/Offer_bloc/offer_state.dart';
import '/data/models/OfferModel.dart';
import '/data/repo/offer/OfferText.dart';
import '/data/repositories/OfferRepo.dart';
import 'package:expandable_text/expandable_text.dart';

// review_state.dart
abstract class ReviewState {
  final int selectedTab;
  const ReviewState(this.selectedTab);
}

class ReviewInitial extends ReviewState {
  ReviewInitial() : super(0);
}

class ReviewTabChanged extends ReviewState {
  ReviewTabChanged(int selectedTab) : super(selectedTab);
}

// review_cubit.dart


class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  void changeTab(int index) {
    emit(ReviewTabChanged(index));
  }
}

class OfferDetailsPage extends StatelessWidget {
  static const pageRoute = '/OfferDetails';
  final int offerId;

  const OfferDetailsPage({super.key, required this.offerId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OfferCubit(offerRepo: OfferRepo())..fetchOfferById(1),
        ),
        BlocProvider(
          create: (context) => ReviewCubit(),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<OfferCubit, OfferState>(
          builder: (context, state) {
            if (state is OfferLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OfferErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is OfferLoadedState) {
              final offer = state.offers.firstWhere((offer) => offer.id == offerId);
              return _buildOfferDetails(offer, context);
            }
            return const Center(child: Text('No data available'));
          },
        ),
        bottomNavigationBar: role == SignUpAs.Client 
          ? const BottomNavigationBarExampleClient() 
          : const BottomNavigationBarExampleAgency(),
      ),
    );
  }

  Widget _buildOfferDetails(OfferModel offer, BuildContext context) {
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
              _buildHeader(offer, context),
              _buildDetailsSection(offer),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(OfferModel offer, BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imagePaths.backGroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          _buildBackButton(context),
          _buildFavoriteButton(),
          _buildTitleAndSubtitle(offer),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
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
              'assets/icons/emptyfavorite.png',
              color: AppColors.main,
              fit: BoxFit.contain,
            ),
          ),
        ),
        onPressed: () {
          // Implement favorite functionality
        },
      ),
    );
  }

  Widget _buildTitleAndSubtitle(OfferModel offer) {
    return Positioned(
      top: 120,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            offer.cityName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            offer.countryName,
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
                      offer.rating.toString(),
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

  Widget _buildDetailsSection(OfferModel offer) {
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
          OfferDetailsSection(offer: offer),
          ReviewSection(
            rating: offer.rating ?? 0.0,
            descriptionText: offer.descriptionText ?? '',
          ),
        ],
      ),
    );
  }
}

class OfferDetailsSection extends StatelessWidget {
  final OfferModel offer;

  const OfferDetailsSection({super.key, required this.offer});

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
          const SizedBox(height: 20),
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
            description: offer.price.toString(),
            icon: 'assets/icons/money.png',
          ),
          const SizedBox(width: 20),
          Information(
            title: AppTexts.startDateTitle,
            description: offer.startDate,
            icon: 'assets/icons/time.png',
          ),
          const SizedBox(width: 20),
          Information(
            title: AppTexts.endDateTitle,
            description: offer.endDate,
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
        itemCount: offer.thumbnails?.length ?? 0,
        itemBuilder: (context, index) {
          return OfferImage(imageUrl: offer.thumbnails![index]);
        },
      ),
    );
  }

 
}

class ReviewSection extends StatelessWidget {
  final double rating;
  final String descriptionText;

  const ReviewSection({
    super.key,
    required this.rating,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabs(context, state.selectedTab),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: state.selectedTab == 0 
                ? _buildDescriptionTab(descriptionText)
                : _buildReviewsTab(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabs(BuildContext context, int selectedIndex) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          const SizedBox(width: 20),
          _buildTab(context, AppTexts.descriptionTab, 0, selectedIndex),
          const SizedBox(width: 30),
          _buildTab(context, AppTexts.reviewTab, 1, selectedIndex),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String text, int index, int selectedIndex) {
    return InkWell(
      onTap: () => context.read<ReviewCubit>().changeTab(index),
      child: Text(
        text,
        style: TextStyle(
          color: selectedIndex == index ? Colors.black : Colors.grey,
          fontSize: 16,
          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
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
        // Positioned(
        //   bottom: -7,
        //   right: 7,
        //   child: _buildWhatsAppButton(),
        // ),
      ],
    );
  }

  // Widget _buildWhatsAppButton() {
  //   return IconButton(
  //     icon: Container(
  //       decoration: BoxDecoration(
  //         color: AppColors.second,
  //         shape: BoxShape.circle,
  //         boxShadow: [
  //           BoxShadow(
  //             color: AppColors.black.withOpacity(0.2),
  //             blurRadius: 8,
  //             offset: const Offset(0, 4),
  //           ),
  //         ],
  //       ),
  //       child: Image.asset(
  //         'assets/icons/whatsapp.png',
  //         width: 60,
  //         height: 60,
  //         color: AppColors.white,
  //       ),
  //     ),
  //     onPressed: () {
  //       // Implement WhatsApp functionality
  //     },
  //   );
  // }

  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReviewSummary(),
        const SizedBox(height: 20),
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
          '4.7',
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
        _buildRatingBar('5', 0.8),
        _buildRatingBar('4', 0.6),
        _buildRatingBar('3', 0.4),
        _buildRatingBar('2', 0.2),
        _buildRatingBar('1', 0.1),
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

  Widget _buildReviewsHeader(BuildContext context, int reviewCount) {
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
}

class Information extends StatelessWidget {
  final String title;
  final String icon;
  final String description;

  const Information({
    super.key,
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
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class ExpandableDescription extends StatelessWidget {
  final String description;

  const ExpandableDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      description,
      expandText: 'show more',
      collapseText: 'show less',
      maxLines: 5, // Number of lines to show before expanding
      linkColor: AppColors.main, // Color of the "show more" and "show less" text
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }
}