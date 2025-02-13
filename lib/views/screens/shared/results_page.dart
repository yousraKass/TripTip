import 'package:flutter/material.dart';
import '/views/widgets/offer_card.dart';
import '/views/widgets/search_bar_widget.dart';
import '/views/widgets/BottomNaviagtionBarClient.dart';
import '/views/widgets/BottomNavigationBarAgency.dart';
import '/views/themes/colors.dart';
import '/views/screens/shared/SignUpAsScreen.dart';
import 'filter_page.dart';
import '/views/themes/fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/Search/search_cubit.dart';
import '../../../blocs/Search/search_state.dart';





class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});
  
  static const pageRoute = '/ResultsPage';

  void _openFilterPage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
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
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              title: const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'Search Results',
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
                      child: SearchBarWidget(
                        initialValue: state.searchQuery,
                        onChanged: (query) {
                          context.read<SearchCubit>().updateSearchQuery(query);
                        },
                        onSubmitted: (_) {
                          context.read<SearchCubit>().searchOffers();
                        },
                      ),
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
                        onPressed: () => _openFilterPage(context),
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
                        value: state.rankBy,
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
                          context.read<SearchCubit>().updateRankBy(value);
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
                  child: Builder(
                    builder: (context) {
                      if (state.status == SearchStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state.status == SearchStatus.failure) {
                        return Center(
                          child: Text(
                            state.error ?? 'An error occurred',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (state.searchResults.isEmpty) {
                        return const Center(
                          child: Text('No results found'),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: OfferCard(offer: state.searchResults[index]),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: role == SignUpAs.Client
              ? const BottomNavigationBarExampleClient()
              : const BottomNavigationBarExampleAgency(),
        );
      },
    );
  }
}
                          