// add_offer_page.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/data/models/OfferModel.dart';
import 'package:triptip/blocs/Offer_bloc/offer_cubit.dart';
import 'package:triptip/blocs/Offer_bloc/offer_state.dart';
import 'package:triptip/data/repositories/OfferRepo.dart';

class AddOfferPage extends StatelessWidget {
  final int agencyId;
    final OfferRepo offerRepo; 

  const AddOfferPage({super.key, required this.agencyId,required this.offerRepo});
  static const pageRoute = '/AddOfferPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (context) => OfferCubit(offerRepo: offerRepo),
      child: AddOfferForm(agencyId: agencyId),
    );
  }
}

class AddOfferForm extends StatelessWidget {
  final int agencyId;
  const AddOfferForm({super.key, required this.agencyId});

  @override
  Widget build(BuildContext context) {
    final offerCubit = context.read<OfferCubit>();
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController();
    final _destinationController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _priceController = TextEditingController();
    DateTime? fromDate = DateTime(2024, 2, 8);
    DateTime? toDate = DateTime(2024, 2, 22);
    File? mainImage;
    List<File> additionalImages = [];
    String transportAvailability = 'Available';
    String mealsAvailability = 'Available';
    String guideAvailability = 'Available';
    String hotelAvailability = 'Available';

    Future<void> _pickImage({bool isMainImage = true}) async {
      try {
        final XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
        );

        if (pickedFile != null) {
          if (isMainImage) {
            mainImage = File(pickedFile.path);
          } else {
            additionalImages.add(File(pickedFile.path));
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }

    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        final newOffer = OfferModel(
          id: DateTime.now().millisecondsSinceEpoch,
          image: mainImage!.path,
          cityName: _titleController.text,
          countryName: _destinationController.text,
          price: double.parse(_priceController.text),
          startDate: fromDate!.toIso8601String(),
          endDate: toDate!.toIso8601String(),
          descriptionText: _descriptionController.text,
          category: 'Default',
          thumbnails: additionalImages.map((file) => file.path).toList(),
          days: toDate!.difference(fromDate!).inDays,
          transport: transportAvailability,
          meals: mealsAvailability,
          guide: guideAvailability,
          hotel: hotelAvailability,
        );

        offerCubit.addOffer(newOffer, agencyId);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/undo_icon.png'),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'Add Offer',
          style: TextStyle(
            fontFamily: FontFamily.medium,
            color: AppColors.black,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: BlocConsumer<OfferCubit, OfferState>(
        listener: (context, state) {
          if (state is OfferErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is OfferAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Offer added successfully')),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Upload Section
                  GestureDetector(
                    onTap: () => _pickImage(isMainImage: true),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: mainImage != null
                            ? DecorationImage(
                                image: FileImage(mainImage!),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage('assets/images/offer_img.png'),
                                fit: BoxFit.cover,
                              ),
                      ),
                      child: mainImage == null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/Upload_icon.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Upload main Image',
                                    style: TextStyle(
                                      color: AppColors.main,
                                      fontFamily: FontFamily.regular,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Form Fields
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Offer Title',
                      hintText: 'Enter Offer title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      if (value.length < 10) {
                        return 'Title must be at least 10 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _destinationController,
                    decoration: const InputDecoration(
                      labelText: 'Destination',
                      hintText: 'Enter destination',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Destination is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Date Fields
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: fromDate ?? DateTime.now(),
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2025),
                            );
                            if (pickedDate != null) {
                              fromDate = pickedDate;
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.greyLight!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/date.png',
                                  width: 27,
                                  height: 27,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  fromDate != null
                                      ? "${fromDate!.day} / ${fromDate!.month} / ${fromDate!.year}"
                                      : 'Select date',
                                  style: TextStyle(
                                    fontFamily: FontFamily.regular,
                                    color: AppColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: toDate ?? DateTime.now(),
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2025),
                            );
                            if (pickedDate != null) {
                              toDate = pickedDate;
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.greyLight!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/date.png',
                                  width: 27,
                                  height: 27,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  toDate != null
                                      ? "${toDate!.day} / ${toDate!.month} / ${toDate!.year}"
                                      : 'Select date',
                                  style: TextStyle(
                                    fontFamily: FontFamily.regular,
                                    color: AppColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Price and Transport Fields
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            hintText: 'Enter price',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Price is required';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            if (double.parse(value) <= 0) {
                              return 'Price must be greater than 0';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: transportAvailability,
                          items: ['Available', 'Not Available']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            transportAvailability = newValue!;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Transport',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Guide and Meals Fields
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: guideAvailability,
                          items: ['Available', 'Not Available']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            guideAvailability = newValue!;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Guide',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: mealsAvailability,
                          items: ['Available', 'Not Available']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            mealsAvailability = newValue!;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Meals',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Hotel Field
                  DropdownButtonFormField<String>(
                    value: hotelAvailability,
                    items: ['Available', 'Not Available'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      hotelAvailability = newValue!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Hotel',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description Field
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Write a detailed description about the offer...',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      if (value.length < 20) {
                        return 'Description must be at least 20 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.main,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Add offer',
                        style: TextStyle(
                          color: AppColors.white,
                          fontFamily: FontFamily.medium,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

