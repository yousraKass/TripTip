import 'package:flutter/material.dart';
import 'package:triptip/views/widgets/offer_card.dart';
import 'package:triptip/views/widgets/search_bar_widget.dart';
import 'package:triptip/views/widgets/BottomNaviagtionBarClient.dart';
import 'package:triptip/views/widgets/BottomNavigationBarAgency.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/screens//offer_model.dart';
import 'package:triptip/views/screens/shared/SignUpAsScreen.dart';
import 'filter_page.dart';
import 'OfferScreen.dart';
import 'search_page.dart';
import 'results_page';




class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? selectedSuggestion;
 
  final List<String> suggestions = [
    'Free Food', 'In-Hotel habitat', 'Bus Travel',
    'Easy Omra', 'By Plane travel', 'Only women',
    'Short Trip', 'Long travel', 'kachafa trip',
    '4-5 stars hotel'
  ];

  void handleSuggestionClick(String suggestion) {
  setState(() {
    selectedSuggestion = suggestion;
  });
  print('Selected Suggestion: $suggestion');
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ResultsPage()),
  );
}


  void openFilterPage() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 80,
          leading: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              'Search Page',
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 34),
            Row(
              children: [
                Expanded(
                  child: SearchBarWidget(),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.25),
                        offset: const Offset(0, 6),
                        blurRadius: 8,
                        spreadRadius: -1,
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [Color(0xFF264653), Color(0xFF18C0C1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: openFilterPage,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Divider(color: Colors.grey.withOpacity(0.5)),
            const SizedBox(height: 10),
            const Text(
              'Suggestions:',
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: suggestions.map((suggestion) {
                return GestureDetector(
                  onTap: () => handleSuggestionClick(suggestion),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: Colors.grey, width: 0.1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      suggestion,
                      style: const TextStyle(
                        fontFamily: FontFamily.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
     bottomNavigationBar:role == SignUpAs.Client ? BottomNavigationBarExampleClient() : BottomNavigationBarExampleAgency(),
  

    );
  }
}




