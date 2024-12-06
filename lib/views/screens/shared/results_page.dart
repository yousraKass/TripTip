import 'package:flutter/material.dart';
import 'package:triptip/views/widgets/offer_card.dart';
import 'package:triptip/views/widgets/search_bar_widget.dart';
import 'package:triptip/views/widgets/BottomNaviagtionBarClient.dart';
import 'package:triptip/views/widgets/BottomNavigationBarAgency.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/data/repo/offer/offer_model.dart';
import 'package:triptip/views/screens/shared/SignUpAsScreen.dart';
import 'filter_page.dart';
import 'package:triptip/views/themes/fonts.dart';



class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});
  static const pageRoute = '/ResultsPage';

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  String? selectedRankBy; // Store the selected rank by option

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
              'Sreach Page',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Results',
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.25),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        spreadRadius: -1,
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: selectedRankBy,
                    underline: const SizedBox(),
                    hint: const Text('Rank By'),
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    style: const TextStyle(
                      fontFamily: FontFamily.regular,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    dropdownColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        selectedRankBy = value; // Hold the selected value
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'Price',
                        child: Text('Price'),
                      ),
                      DropdownMenuItem(
                        value: 'Popularity',
                        child: Text('Popularity'),
                      ),
                      DropdownMenuItem(
                        value: 'Rating',
                        child: Text('Rating'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: dummyOffers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: OfferCard(offer: dummyOffers[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
     bottomNavigationBar:role == SignUpAs.Client ? BottomNavigationBarExampleClient() : BottomNavigationBarExampleAgency(),
    );
  }
}
