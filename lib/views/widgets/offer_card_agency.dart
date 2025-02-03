 import 'package:flutter/material.dart';
 import 'package:triptip/views/themes/colors.dart';
 import 'package:triptip/views/themes/fonts.dart';
 import 'package:triptip/data/repo/offer/offer_model.dart';
 import 'offer_widgets_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/data/models/OfferModel.dart';
import '/blocs/Offer_bloc/offer_cubit.dart';
import '/blocs/Offer_bloc/offer_state.dart';
import 'offer_widgets_shared.dart';


 class OfferCardAgency extends StatefulWidget {
  final OfferModel offer;
  final VoidCallback onDelete; 

  const OfferCardAgency({
    super.key,
    required this.offer,
    required this.onDelete,
  });


  @override
  _OfferCardAgencyState createState() => _OfferCardAgencyState();
}

class _OfferCardAgencyState extends State<OfferCardAgency> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    final double cardHeight = screenWidth < 600 ? 160 : 140;
    final double imageWidth = screenWidth < 600 ? 132 : 180; 
    final double titleSize = screenWidth < 600 ? 16 : 20;
    final double locationSize = screenWidth < 600 ? 12 : 14;

    return FocusableActionDetector(
      mouseCursor: SystemMouseCursors.click,
      onShowHoverHighlight: (hovering) {
        setState(() {
          isHovered = hovering;
        });
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          height: cardHeight,
          child: Card(
            color: Colors.white,
            elevation: isHovered ? 15 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: imageWidth,
                  height: double.infinity,
                  child: OfferWidgetsUtils.buildImageSection(context, widget.offer),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.offer.title,
                                    style: TextStyle(
                                      fontFamily: FontFamily.bold,
                                      fontSize: titleSize,
                                      color: AppColors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.offer.location,
                                    style: TextStyle(
                                      fontFamily: FontFamily.regular,
                                      fontSize: locationSize,
                                      color: AppColors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            _buildDeleteButton(),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: OfferWidgetsUtils.buildThumbnails(context, widget.offer),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OfferWidgetsUtils.buildRating(context, widget.offer),
                                const SizedBox(height: 2),
                                OfferWidgetsUtils.buildPrice(context, widget.offer),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


Widget _buildDeleteButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          
          (
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirm Delete'),
                content: const Text('Are you sure you want to delete this offer?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onDelete(); //Call the delete callback
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(2),
          child: Icon(
            Icons.delete_outline,
            color: Colors.red,
            size: 28,
          ),
        ),
      ),
    );
  }

}






class FavoriteOffer extends StatelessWidget {
  final OfferModel offer;
  
  const FavoriteOffer({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    final double cardHeight = screenWidth < 600 ? 160 : 140;
    final double imageWidth = screenWidth < 600 ? 132 : 180; 
    final double titleSize = screenWidth < 600 ? 16 : 20;
    final double locationSize = screenWidth < 600 ? 12 : 14;   

    return BlocBuilder<OfferCubit, OfferState>(
      builder: (context, state) {
        return MouseRegion(
          onEnter: (_) => context.read<OfferCubit>().setHovered(offer.cityName),
          onExit: (_) => context.read<OfferCubit>().clearHovered(),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SizedBox(
              height: cardHeight,
              child: Card(
                color: Colors.white,
                elevation: state is OfferLoadedState && 
                    state.hoveredCity == offer.cityName ? 15 : 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: imageWidth,
                      height: double.infinity,
                      child: OfferWidgetsUtils.buildImageSection(context, offer),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        offer.cityName,
                                        style: TextStyle(
                                          fontFamily: FontFamily.bold,
                                          fontSize: titleSize,
                                          color: AppColors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        offer.countryName,
                                        style: TextStyle(
                                          fontFamily: FontFamily.regular,
                                          fontSize: locationSize,
                                          color: AppColors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                _buildFavoriteButton(context),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: OfferWidgetsUtils.buildThumbnails(context, offer),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    OfferWidgetsUtils.buildRating(context, offer),
                                    const SizedBox(height: 2),
                                    OfferWidgetsUtils.buildPrice(context, offer),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<OfferCubit>().toggleFavorite(offer.cityName),
        child: const Padding(
          padding: EdgeInsets.all(2),
          child: Icon(
            Icons.favorite,
            color: AppColors.main,
            size: 28,
          ),
        ),
      ),
    );
  }
}