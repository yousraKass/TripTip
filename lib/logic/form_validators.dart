String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  }
  // Basic email validation pattern
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Password is required';
  }
  if (password.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  // Optional: Add further checks, e.g., for at least one number or special character
  return null;
}

String? validateAgencyName(String? name) {
  if (name == null || name.isEmpty) {
    return 'Agency name is required';
  }
  if (name.length < 3) {
    return 'Agency name must be at least 3 characters long';
  }
  return null;
}

String? validateLocation(String? location) {
  if (location == null || location.isEmpty) {
    return 'Location is required';
  }
  if (location.length < 2) {
    return 'Location must be at least 2 characters long';
  }
  return null;
}
String? validateLocationInt(int? location) {
  if (location == null ) {
    return 'Location is required';
  }
  if (location < 0 || location > 58) {
    return 'Location is invalid';
  }
  return null;
}

int? TransferNametoNumber(String? location) {
  
  final List<String> wilayas = [
    "Adrar", "Chlef", "Laghouat", "Oum El Bouaghi", "Batna", "Béjaïa", "Biskra", "Béchar", 
    "Blida", "Bouira", "Tamanrasset", "Tébessa", "Tlemcen", "Tiaret", "Tizi Ouzou", 
    "Alger", "Djelfa", "Jijel", "Sétif", "Saïda", "Skikda", "Sidi Bel Abbès", "Annaba", 
    "Guelma", "Constantine", "Médéa", "Mostaganem", "M'Sila", "Mascara", "Ouargla", 
    "Oran", "El Bayadh", "Illizi", "Bordj Bou Arréridj", "Boumerdès", "El Tarf", "Tindouf", 
    "Tissemsilt", "El Oued", "Khenchela", "Souk Ahras", "Tipaza", "Mila", "Aïn Defla", 
    "Naâma", "Aïn Témouchent", "Ghardaïa", "Relizane", "Timimoun", "Bordj Badji Mokhtar", 
    "Ouled Djellal", "Béni Abbès", "In Salah", "In Guezzam", "Touggourt", "Djanet", 
    "El M'Ghair", "El Meniaa"
  ];

  if (location == null || location.isEmpty) {
    return null; // Invalid input
  }


  final int index = wilayas.indexWhere((wilaya) => wilaya.toLowerCase() == location.toLowerCase());
  
  // If not found, return null
  if (index == -1) {
    return null;
  }

 
  return index + 1;
}

String? validateName(String? name) {
  if (name == null || name.isEmpty) {
    return 'Name is required';
  }
  if (name.length < 2) {
    return 'Name must be at least 2 characters long';
  }
  return null;
}

String? validateDate(String? date) {
  if (date == null || date.isEmpty) {
    return 'Date is required';
  }
  // Validate date format (example: yyyy-mm-dd)
  // if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(date)) {
  //   return 'Please enter a valid date in yyyy-mm-dd format';
  // }
  return null;
}

String? validatePhoneNumber(String? phoneNumber) {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    return 'Phone number is required';
  }
  // Algerian phone numbers are 10 digits long and start with 0
  if (!RegExp(r'^0[5-7][0-9]{8}$').hasMatch(phoneNumber)) {
    return 'Please enter a valid Algerian phone number (e.g., 05XXXXXXXX, 06XXXXXXXX, 07XXXXXXXX)';
  }
  return null;
}
