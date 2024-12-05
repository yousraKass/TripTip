import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart'; 
import 'package:triptip/views/themes/fonts.dart';   

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
Map<String, List<String>> selectedItems = {}; 
  Map<String, String> selectedStar = {}; 
  int selectedStars = 0; 
  double minPrice = 20000;
  double maxPrice = 100000;
  RangeValues selectedPriceRange = const RangeValues(20000, 100000);
  final List<String> categoryNames = [
    'Swimming',
    'Shopping',
    'Dining',
    'Adventure',
  ];


  @override
  Widget build(BuildContext context) {
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
            initialChildSize: 0.4,
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
                        Center(
                          child: Container(
                            width: 60,
                            height: 6,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const Text(
                          'Filter by',
                          style: TextStyle(
                            fontFamily: FontFamily.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Divider(color: Colors.grey),
                        
                        _buildCategorySection(),
                        const Divider(color: Colors.grey),

                          _buildPlaceFilters(),
                        const Divider(color: Colors.grey), 

                        _buildFeatures(),
                        const Divider(color: Colors.grey),
                        
                        _buildTravelOptions(),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 15),
                        _buildPriceRange(),
                        const SizedBox(height: 10),

                        const Divider(color: Colors.grey),
                       const SizedBox(height: 10), 
                        _buildOfferRating(),
                        
                        const SizedBox(height: 23),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                          
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                fontFamily: FontFamily.medium,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
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
  }

   Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Categories:', style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18)),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryNames.length,
            itemBuilder: (context, index) {
              String category = categoryNames[index];
              bool isSelected = selectedItems['Categories']?.contains(category) ?? false;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedItems.putIfAbsent('Categories', () => []);
                    if (isSelected) {
                      selectedItems['Categories']?.remove(category);
                    } else {
                      selectedItems['Categories']?.add(category);
                    }
                  });
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? AppColors.primaryColor : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset('assets/images/cat0${index + 1}.png', fit: BoxFit.cover),
                      ),
                      Text(category, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  
  Widget _buildPlaceFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Places:', style: _sectionTitleStyle()),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    selectedItems['Country'] = [value];
                  });
                },
                decoration: _inputDecoration('Enter the Country'),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    selectedItems['City'] = [value];
                  });
                },
                decoration: _inputDecoration('Enter the City'),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Features:', style: _sectionTitleStyle()),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _featureChip('Free Food'),
            _featureChip('In-Hotel Habitat'),
            _featureChip('Bus Travel'),
            _featureChip('Easy Omra'),
            _featureChip('By Plane Travel'),
            _featureChip('Only Women'),
            _featureChip('Short Trip'),
            _featureChip('Long Travel'),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _featureChip(String label) {
    bool isSelected = selectedItems['Features']?.contains(label) ?? false;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedItems.putIfAbsent('Features', () => []);
          if (isSelected) {
            selectedItems['Features']?.remove(label);
          } else {
            selectedItems['Features']?.add(label);
          }
        });
      },
      selectedColor: AppColors.primaryColor.withOpacity(0.3),
    );
  }

  Widget _buildTravelOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Travel by:', style: _sectionTitleStyle()),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _travelOption(Icons.flight, 'Plane'),
            _travelOption(Icons.directions_bus, 'Bus'),
            _travelOption(Icons.directions_car, 'My own car'),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _travelOption(IconData icon, String label) {
    bool isSelected = selectedItems['Travel Option']?.contains(label) ?? false;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItems['Travel Option'] = [label]; 
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: isSelected ? AppColors.primaryColor : Colors.grey),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Price Range:', style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18)),
        RangeSlider(
          values: selectedPriceRange,
          min: 20000,
          max: 1000000,
          divisions: 50,
          activeColor: AppColors.primaryColor,
          labels: RangeLabels(
            '\$${selectedPriceRange.start.round()}',
            '\$${selectedPriceRange.end.round()}',
          ),
          onChanged: (values) {
            setState(() {
              selectedPriceRange = values;
            });
          },
        ),
        Text(
          'Selected Range: \$${selectedPriceRange.start.round()} - \$${selectedPriceRange.end.round()}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }


    Widget _buildOfferRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Offer Rating:', style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18)),
        const SizedBox(width: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < selectedStars ? Icons.star : Icons.star_border,
                color:  AppColors.primaryColor,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  selectedStars = index + 1;
                  selectedStar['Offer Rating'] = selectedStars.toString();

                });
              },
            );
          }),
        ),
      ],
    );
  }
  
  TextStyle _sectionTitleStyle() {
    return const TextStyle(
      fontFamily: FontFamily.medium,
      fontSize: 18,
      color: Colors.black,
    );
  }
}

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    );
  }


























































// import 'package:flutter/material.dart';
// import '../views/themes/colors.dart';
// import '../views/themes/fonts.dart';

// class FilterPage extends StatefulWidget {
//   const FilterPage({super.key});

//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
//   Map<String, List<String>> selectedItems = {};
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
//                             margin: const EdgeInsets.only(bottom: 20),
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
//                         _buildPriceRange(),
//                         const Divider(color: Colors.grey),
//                         _buildOfferRating(),
//                         const SizedBox(height: 20),
//                         Center(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.primaryColor,
//                               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
//         const Text('Categories:', style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18)),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 120,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: categoryNames.length,
//             itemBuilder: (context, index) {
//               String category = categoryNames[index];
//               bool isSelected = selectedItems['Categories']?.contains(category) ?? false;
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
//                       color: isSelected ? AppColors.primaryColor : Colors.transparent,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: Image.asset('assets/cat0${index + 1}.png', fit: BoxFit.cover),
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

//   Widget _buildPriceRange() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Price Range:', style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18)),
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
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         const Text('Offer Rating:', style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18)),
//         const SizedBox(width: 10),
//         Row(
//           children: List.generate(5, (index) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedStars = index + 1;
//                 });
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(right: 5),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: AppColors.primaryColor,
//                     width: 2,
//                   ),
//                 ),
//                 child: Icon(
//                   index < selectedStars ? Icons.star : Icons.star_border,
//                   color: AppColors.primaryColor,
//                   size: 30,
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }























// import 'package:flutter/material.dart';
// import '../views/themes/colors.dart';  // Ensure correct path
// import '../views/themes/fonts.dart';   // Ensure correct path

// class FilterPage extends StatefulWidget {
//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {

//   Map<String, String> selectedItems = {};  // To store the selected items for each category
//   int selectedStars = 0; // For star ratings

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent, // Transparent background for the overlay effect
//       body: Stack(
//         children: [
//           GestureDetector(
//             // Close the filter when tapping outside the sheet
//             onTap: () => Navigator.pop(context),
//             child: Container(
//               color: Colors.black.withOpacity(0.4), // Semi-transparent background
//             ),
//           ),
//           DraggableScrollableSheet(
//             initialChildSize: 0.4,   // Default height (40% of screen)
//             minChildSize: 0.4,       // Minimum height (40% of screen)
//             maxChildSize: 1.0,       // Maximum height (full screen)
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
//                   controller: scrollController,  // Attach the controller
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Drag indicator
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
//                         const Divider(color: Colors.grey), // Line beside "Filter by"
                        
//                         // Category Images
//                         _buildCategorySection(),
//                         const Divider(color: Colors.grey), // Line beside "Filter by"
                        
//                         // Place Filters
//                         _buildPlaceFilters(),
//                         const Divider(color: Colors.grey), // Line beside "Filter by"
                        
//                         // Features
//                         _buildFeatures(),
//                         const Divider(color: Colors.grey), // Line beside "Filter by"
                        
//                         // Travel Options
//                         _buildTravelOptions(),
//                         const Divider(color: Colors.grey), // Line beside "Filter by"
                        
//                         // Price Range
//                         _buildPriceRange(),
//                         const Divider(color: Colors.grey), // Line beside "Filter by"
                        
//                         // Offer Rating
//                         _buildOfferRating(),
                        
//                         const SizedBox(height: 20),
//                         // Apply Button
//                         Center(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               // You can use selectedItems to filter the database here
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.primaryColor,
//                               padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             child: Text(
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
//         Text('Categories:', style: _sectionTitleStyle()),
//         SizedBox(height: 10),
//         SizedBox(
//           height: 100,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 4,
//             itemBuilder: (context, index) {
//               String category = 'Category ${index + 1}';
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedItems['Category'] = category;
//                   });
//                 },
//                 child: Container(
//                   width: 80,
//                   margin: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: selectedItems['Category'] == category
//                           ? AppColors.primaryColor
//                           : Colors.transparent,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     children: [
//                       Image.asset('assets/mob${index + 1}.jpg', fit: BoxFit.cover),
//                       Text(category),
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
//                     selectedItems['Country'] = value;
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
//                     selectedItems['City'] = value;
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

//   Widget _buildTravelOptions() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Travel by:', style: _sectionTitleStyle()),
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

//   Widget _buildPriceRange() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Price Range:', style: _sectionTitleStyle()),
//         Slider(
//           value: 50000,
//           min: 20000,
//           max: 1000000,
//           onChanged: (value) {
//             setState(() {
//               selectedItems['Price Range'] = value.toString();
//             });
//           },
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget _buildOfferRating() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Offer rating:', style: _sectionTitleStyle()),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(5, (index) {
//             return IconButton(
//               icon: Icon(
//                 index < selectedStars ? Icons.star : Icons.star_border,
//                 color: Colors.amber,
//                 size: 30,
//               ),
//               onPressed: () {
//                 setState(() {
//                   selectedStars = index + 1;
//                   selectedItems['Offer Rating'] = selectedStars.toString();
//                 });
//               },
//             );
//           }),
//         ),
//       ],
//     );
//   }

//   TextStyle _sectionTitleStyle() {
//     return const TextStyle(
//       fontFamily: FontFamily.medium,
//       fontSize: 18,
//       color: Colors.black,
//     );
//   }

//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       filled: true,
//       fillColor: Colors.grey[200],
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   Widget _featureChip(String label) {
//     return ChoiceChip(
//       label: Text(label),
//       selected: selectedItems['Features'] == label,
//       onSelected: (selected) {
//         setState(() {
//           selectedItems['Features'] = label;
//         });
//       },
//     );
//   }

//   Widget _travelOption(IconData icon, String label) {
//     return Column(
//       children: [
//         IconButton(
//           icon: Icon(icon, size: 40),
//           onPressed: () {
//             setState(() {
//               selectedItems['Travel Option'] = label;
//             });
//           },
//         ),
//         Text(label),
//       ],
//     );
//   }
// }