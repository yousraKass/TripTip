import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/main.dart';
import 'package:triptip/views/widgets/Preference_widget.dart';

const widgetInRow = 2;

class MyPreferencesPage extends StatefulWidget {
  static const pageRoute = "client_preferences_page";
  @override
  _MyPreferencesPageState createState() => _MyPreferencesPageState();
}

class _MyPreferencesPageState extends State<MyPreferencesPage> {
  // List of interests
  late Future<List> interests;
  late List localInterests;

  @override
  void initState() {
    //interests = preferences.GetUserPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'My preferences',
          style: navbarTitle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "I am interested in: ",
              style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List>(
                future: interests,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    localInterests = snapshot.data!;
                    return getGrid(context, localInterests);
                  } else {
                    return Center(child: Text("No interests available."));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                // just move to the next page
                Navigator.pushNamed(context, "next_page_route");
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.main,
              ),
              child: Text("Skip"),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle Back button press
                // move to the next page and save user preferences
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.main,
                // Customize color
              ),
              child: Text(
                "Save",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getGrid(BuildContext context, List interests) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: interests.length,
      itemBuilder: (context, index) {
        final interest = interests[index];
        return GestureDetector(
          onTap: () {
            // only toggle data locally
            interest['selected'] = !interest['selected'];
            setState(() {});
          },
          child: PreferenceCell(context, interest, "preferences"),
        );
      },
    );
  }
}
