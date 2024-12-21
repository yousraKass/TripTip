import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';
import '/data/models/OfferModel.dart';

class OfferWidgetsUtils {
  // Responsive sizing constants
  static double getResponsiveImageHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.2; 
  }

  static double getResponsiveImageWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.45; 
  }

  static double getResponsiveThumbnailSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.06;
  }

  static double getResponsiveIconSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.045;
  }

  static double getResponsiveFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.032; 
  }

  static Widget buildImageSection(BuildContext context, OfferModel offer) {
    final imageHeight = getResponsiveImageHeight(context);
    final imageWidth = getResponsiveImageWidth(context);

    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(MediaQuery.of(context).size.width * 0.04),
      ),
      child: Image.asset(
        offer.image,
        height: imageHeight,
        width: imageWidth,
        fit: BoxFit.cover,
      ),
    );
  }

  static Widget buildThumbnails(BuildContext context, OfferModel offer) {
    final thumbnailSize = getResponsiveThumbnailSize(context);
    final containerHeight = thumbnailSize * 1.2;
    final containerWidth = thumbnailSize * 1.2;

    return SizedBox(
      height: containerHeight,
      width: containerWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: offer.thumbnails.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.005,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(thumbnailSize),
              child: Image.asset(
                offer.thumbnails[index],
                width: thumbnailSize,
                height: thumbnailSize,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget buildRating(BuildContext context, OfferModel offer) {
    final iconSize = getResponsiveIconSize(context);

    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < offer.rating ? Icons.star : Icons.star_border,
          color: index < offer.rating ? AppColors.main : AppColors.main,
          size: iconSize,
        );
      }),
    );
  }

  static Widget buildPrice(BuildContext context, OfferModel offer) {
    final fontSize = getResponsiveFontSize(context);

    return Text(
      '${offer.price} / ${offer.days} days',
      style: TextStyle(
        fontFamily: FontFamily.medium,
        fontSize: fontSize,
        color: AppColors.black,
      ),
    );
  }

  // Add orientation-specific layouts if needed
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Get safe area padding
  static EdgeInsets getSafePadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }
}

