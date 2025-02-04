// import 'package:flutter/material.dart';
// import 'package:triptip/views/themes/fonts.dart';
// import 'package:triptip/views/themes/colors.dart';

// import 'results_page.dart';

// class FilterPage extends StatefulWidget {
//   const FilterPage({super.key});
//   static const pageRoute = "/FilterPage";

//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
//   Map<String, List<String>> selectedItems = {};
//   Map<String, String> selectedStar = {};
//   int selectedStars = 0;
//   double minPrice = 20000;
//   double maxPrice = 100000;
//   RangeValues selectedPriceRange = const RangeValues(20000, 100000);
//   final List<String> categoryNames = [
//     'Swimming',
//     'Shopping',
//     'Dining',
//     'Adventure',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: Container(
//               color: Colors.black.withOpacity(0.4),
//             ),
//           ),
//           DraggableScrollableSheet(
//             initialChildSize: 0.4,
//             minChildSize: 0.4,
//             maxChildSize: 1.0,
//             builder: (context, scrollController) {
//               return Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Container(
//                             width: 60,
//                             height: 6,
//                             margin: EdgeInsets.only(bottom: 20),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         ),
//                         const Text(
//                           'Filter by',
//                           style: TextStyle(
//                             fontFamily: FontFamily.bold,
//                             fontSize: 20,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 15),
//                         const Divider(color: Colors.grey),
//                         _buildCategorySection(),
//                         const Divider(color: Colors.grey),
//                         _buildPlaceFilters(),
//                         const Divider(color: Colors.grey),
//                         _buildFeatures(),
//                         const Divider(color: Colors.grey),
//                         _buildTravelOptions(),
//                         const Divider(color: Colors.grey),
//                         const SizedBox(height: 15),
//                         _buildPriceRange(),
//                         const SizedBox(height: 10),
//                         const Divider(color: Colors.grey),
//                         const SizedBox(height: 10),
//                         _buildOfferRating(),
//                         const SizedBox(height: 23),
//                         Center(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const ResultsPage()),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.primaryColor,
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 40, vertical: 15),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             child: const Text(
//                               'Apply',
//                               style: TextStyle(
//                                 fontFamily: FontFamily.medium,
//                                 fontSize: 18,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategorySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Categories:',
//             style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18)),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 120,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: categoryNames.length,
//             itemBuilder: (context, index) {
//               String category = categoryNames[index];
//               bool isSelected =
//                   selectedItems['Categories']?.contains(category) ?? false;
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedItems.putIfAbsent('Categories', () => []);
//                     if (isSelected) {
//                       selectedItems['Categories']?.remove(category);
//                     } else {
//                       selectedItems['Categories']?.add(category);
//                     }
//                   });
//                 },
//                 child: Container(
//                   width: 100,
//                   margin: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: isSelected
//                           ? AppColors.primaryColor
//                           : Colors.transparent,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: Image.asset('assets/images/cat0${index + 1}.png',
//                             fit: BoxFit.cover),
//                       ),
//                       Text(category, style: const TextStyle(fontSize: 14)),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPlaceFilters() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Places:', style: _sectionTitleStyle()),
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     selectedItems['Country'] = [value];
//                   });
//                 },
//                 decoration: _inputDecoration('Enter the Country'),
//               ),
//             ),
//             SizedBox(width: 10),
//             Expanded(
//               child: TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     selectedItems['City'] = [value];
//                   });
//                 },
//                 decoration: _inputDecoration('Enter the City'),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget _buildFeatures() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Features:', style: _sectionTitleStyle()),
//         SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: [
//             _featureChip('Free Food'),
//             _featureChip('In-Hotel Habitat'),
//             _featureChip('Bus Travel'),
//             _featureChip('Easy Omra'),
//             _featureChip('By Plane Travel'),
//             _featureChip('Only Women'),
//             _featureChip('Short Trip'),
//             _featureChip('Long Travel'),
//           ],
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget _featureChip(String label) {
//     bool isSelected = selectedItems['Features']?.contains(label) ?? false;
//     return ChoiceChip(
//       label: Text(label),
//       selected: isSelected,
//       onSelected: (selected) {
//         setState(() {
//           selectedItems.putIfAbsent('Features', () => []);
//           if (isSelected) {
//             selectedItems['Features']?.remove(label);
//           } else {
//             selectedItems['Features']?.add(label);
//           }
//         });
//       },
//       selectedColor: AppColors.primaryColor.withOpacity(0.3),
//     );
//   }

//   Widget _buildTravelOptions() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Travel by:', style: _sectionTitleStyle()),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _travelOption(Icons.flight, 'Plane'),
//             _travelOption(Icons.directions_bus, 'Bus'),
//             _travelOption(Icons.directions_car, 'My own car'),
//           ],
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget _travelOption(IconData icon, String label) {
//     bool isSelected = selectedItems['Travel Option']?.contains(label) ?? false;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedItems['Travel Option'] = [label];
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? AppColors.primaryColor : Colors.transparent,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             Icon(icon,
//                 size: 40,
//                 color: isSelected ? AppColors.primaryColor : Colors.grey),
//             Text(label),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPriceRange() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Price Range:',
//             style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18)),
//         RangeSlider(
//           values: selectedPriceRange,
//           min: 20000,
//           max: 1000000,
//           divisions: 50,
//           activeColor: AppColors.primaryColor,
//           labels: RangeLabels(
//             '\$${selectedPriceRange.start.round()}',
//             '\$${selectedPriceRange.end.round()}',
//           ),
//           onChanged: (values) {
//             setState(() {
//               selectedPriceRange = values;
//             });
//           },
//         ),
//         Text(
//           'Selected Range: \$${selectedPriceRange.start.round()} - \$${selectedPriceRange.end.round()}',
//           style: const TextStyle(fontSize: 16),
//         ),
//       ],
//     );
//   }

//   Widget _buildOfferRating() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       const Text(
//         'Offer Rating:',
//         style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18),
//       ),
//       SizedBox(width: 20,),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(5, (index) {
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedStars = index + 1;
//                 selectedStar['Offer Rating'] = selectedStars.toString();
//               });
//             },
//             child: Icon(
//               index < selectedStars ? Icons.star : Icons.star_border,
//               color: AppColors.primaryColor,
//               size: 20,
//             ),
//           );
//         }).map((icon) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0), // Adjust spacing here
//             child: icon,
//           );
//         }).toList(),
//       ),
//     ],
//   );
// }


//   TextStyle _sectionTitleStyle() {
//     return const TextStyle(
//       fontFamily: FontFamily.medium,
//       fontSize: 18,
//       color: Colors.black,
//     );
//   }
// }

// InputDecoration _inputDecoration(String hint) {
//   return InputDecoration(
//     hintText: hint,
//     filled: true,
//     fillColor: Colors.grey[200],
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(20),
//       borderSide: BorderSide.none,
//     ),
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/blocs/filter/filter_cubit.dart';
import 'package:triptip/blocs/Search/search_cubit.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/views/themes/colors.dart';
import 'results_page.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});
  static const pageRoute = "/FilterPage";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit(),
      child: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.9,
                  minChildSize: 0.4,
                  maxChildSize: 1.0,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Drag Handle
                              Center(
                                child: Container(
                                  width: 60,
                                  height: 6,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),

                              // Title
                              const Text(
                                'Filter Offers',
                                style: TextStyle(
                                  fontFamily: FontFamily.bold,
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Divider(),

                              // Categories Section
                              _buildSectionTitle('Categories'),
                              _buildCategorySection(context, state),
                              const Divider(),

                              // Location Section
                              _buildSectionTitle('Location'),
                              _buildLocationSection(context, state),
                              const Divider(),

                              // Travel Features
                              _buildSectionTitle('Travel Features'),
                              _buildTravelFeatures(context, state),
                              const Divider(),

                              // Travel Method
                              _buildSectionTitle('Travel Method'),
                              _buildTravelMethod(context, state),
                              const Divider(),

                              // Price Range
                              _buildSectionTitle('Price Range'),
                              _buildPriceRange(context, state),
                              const Divider(),

                              // Rating
                              _buildSectionTitle('Offer Rating'),
                              _buildRatingSection(context, state),
                              const SizedBox(height: 20),

                              // Apply Filters Button
                              _buildApplyFiltersButton(context),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: FontFamily.bold,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, FilterState state) {
    final categories = [
      {'name': 'Swimming', 'icon': 'assets/icons/swimming.png'},
      {'name': 'Shopping', 'icon': 'assets/icons/shopping.png'},
      {'name': 'Dining', 'icon': 'assets/icons/dining.png'},
      {'name': 'Adventure', 'icon': 'assets/icons/adventure.png'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = state.selectedCategories.contains(category['name']);
          return GestureDetector(
            onTap: () {
              final updatedCategories = List<String>.from(state.selectedCategories);
              if (isSelected) {
                updatedCategories.remove(category['name']);
              } else {
                updatedCategories.add(category['name']!);
              }
              context.read<FilterCubit>().updateCategories(updatedCategories);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.white,
                border: Border.all(
                  color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Image.asset(category['icon']!, width: 50, height: 50),
                  const SizedBox(height: 5),
                  Text(
                    category['name']!,
                    style: TextStyle(
                      color: isSelected ? AppColors.primaryColor : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context, FilterState state) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Country',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) => context.read<FilterCubit>().updateCountry(value),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: 'City',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) => context.read<FilterCubit>().updateCity(value),
        ),
      ],
    );
  }

  Widget _buildTravelFeatures(BuildContext context, FilterState state) {
    final features = [
      'Free Food', 'Hotel Accommodation', 'Bus Travel', 
      'Easy Omra', 'Air Travel', 'Women Only', 
      'Short Trip', 'Long Travel'
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: features.map((feature) {
        final isSelected = state.selectedFeatures.contains(feature);
        return FilterChip(
          label: Text(feature),
          selected: isSelected,
          onSelected: (selected) {
            final updatedFeatures = List<String>.from(state.selectedFeatures);
            if (isSelected) {
              updatedFeatures.remove(feature);
            } else {
              updatedFeatures.add(feature);
            }
            context.read<FilterCubit>().updateFeatures(updatedFeatures);
          },
          selectedColor: AppColors.primaryColor.withOpacity(0.2),
        );
      }).toList(),
    );
  }

  Widget _buildTravelMethod(BuildContext context, FilterState state) {
    final travelMethods = [
      {'name': 'Plane', 'icon': Icons.airplanemode_active},
      {'name': 'Bus', 'icon': Icons.directions_bus},
      {'name': 'Car', 'icon': Icons.directions_car},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: travelMethods.map((method) {
        final isSelected = state.selectedTravelOption == method['name'];
        return GestureDetector(
          onTap: () => context.read<FilterCubit>().updateTravelOption(method['name'] as String),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.white,
              border: Border.all(
                color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Icon(
                  method['icon'] as IconData,
                  color: isSelected ? AppColors.primaryColor : Colors.grey,
                  size: 40,
                ),
                const SizedBox(height: 5),
                Text(
                  method['name'] as String,
                  style: TextStyle(
                    color: isSelected ? AppColors.primaryColor : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriceRange(BuildContext context, FilterState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RangeSlider(
          values: RangeValues(state.minPrice, state.maxPrice),
          min: 20000,
          max: 1000000,
          divisions: 50,
          labels: RangeLabels(
            '\$${state.minPrice.round()}', 
            '\$${state.maxPrice.round()}',
          ),
          activeColor: AppColors.primaryColor,
          onChanged: (RangeValues values) {
            context.read<FilterCubit>().updatePriceRange(values.start, values.end);
          },
        ),
        Text(
          'Range: \$${state.minPrice.round()} - \$${state.maxPrice.round()}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildRatingSection(BuildContext context, FilterState state) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => context.read<FilterCubit>().updateOfferRating(index + 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Icon(
              index < state.selectedStars ? Icons.star : Icons.star_border,
              color: AppColors.primaryColor,
              size: 30,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildApplyFiltersButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final filters = context.read<FilterCubit>().prepareFiltersForSearch();
          context.read<SearchCubit>().applyFilters(filters);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ResultsPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Apply Filters',
          style: TextStyle(
            fontFamily: FontFamily.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
