import '/data/repo/review_agency/ReviewText.dart';

class AgencyTexts {
  static const contactUs = 'How to contact us';
  static const phoneTitle = 'Tel';
  static const emailTitle = 'Email';
  static const addressTitle = 'Address';
  static const socialTitle = 'Others';
  static const aboutUsTitle = 'About US';
  static const offersTitle = 'Our offers';
}

class AgencyInformations {
  Future<AgencyData> getAgencyData() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    return AgencyData(
      backGroundAgency: 'assets/images/agencybackground.png',
      profilePictureAgency: 'assets/images/agencypfp.png',
      agencyTitle: 'Trip Tip',
      phoneNumber: '0552556758',
      agencyEmail: 'triptip@gmail.com',
      agencyAddress: 'Sidiabdllah, Rue 05',
      aboutUs:
          'Welcome to TripTip, your trusted partner in creating unforgettable travel experiences. At TripTip, we specialize in curating personalized journeys that cater to your unique preferences and ensure relaxation.',
      reviews: await getReviews(),
    );
  }

  // New method to update agency profile
  Future<bool> updateAgencyProfile({
    String? agencyTitle,
    String? phoneNumber,
    String? agencyEmail,
    String? agencyAddress,
    String? aboutUs,
  }) async {
    try {
      // Simulate network call
      await Future.delayed(const Duration(seconds: 1));
      
      // This might involve making an API call to your backend
      print('Profile Update Attempted');
      print('New Title: $agencyTitle');
      print('New Phone: $phoneNumber');
      print('New Email: $agencyEmail');
      print('New Address: $agencyAddress');
      print('New About: $aboutUs');
      
      return true;
    } catch (e) {
      print('Profile update failed: $e');
      return false;
    }
  }
}

class AgencyData {
  final String backGroundAgency;
  final String profilePictureAgency;
  final String agencyTitle;
  final String phoneNumber;
  final String agencyEmail;
  final String agencyAddress;
  final String aboutUs;
  final List<Review> reviews;

  AgencyData({
    required this.backGroundAgency,
    required this.profilePictureAgency,
    required this.agencyTitle,
    required this.phoneNumber,
    required this.agencyEmail,
    required this.agencyAddress,
    required this.aboutUs,
    required this.reviews
  });
}

class images {
  static const backGroundImage = 'assets/images/backgroundimage.jpeg';
  static const List<String> offerImageUrls = [
    'assets/images/offer1.png',
    'assets/images/offer2.png',
    'assets/images/offer3.png',
    'assets/images/offer4.png',
  ];
}