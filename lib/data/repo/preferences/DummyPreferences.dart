
import 'AbstractPreferences.dart';

class Dummypreferences extends AbstractPreferenes{
  final List<Map<String, dynamic>> interests = [
    {'label': 'musims', 'image': 'assets/images/golang.png', 'selected': false},
    {'label': 'Snow wether', 'image': 'assets/images/golang.png', 'selected': true},
    {'label': 'Swimming', 'image': 'assets/images/golang.png', 'selected': false},
    {'label': 'mountain', 'image': 'assets/images/golang.png', 'selected': false},
    {'label': 'Traditional cultures', 'image': 'assets/images/golang.png', 'selected': false},
    {'label': 'Sahara', 'image': 'assets/images/golang.png', 'selected': true},
    {'label': 'City Lights', 'image': 'assets/images/golang.png', 'selected': false},
    {'label': 'Beach Party', 'image': 'assets/images/golang.png', 'selected': true},
  ];


  Future<List<Map<String,dynamic>>> GetUserPreferences() async {
    // await Future.delayed(Duration(seconds: 2));
    return interests;

  }

  Future<bool> TogglePreference(int index) async{
    // await Future.delayed(Duration(seconds: 2));

    interests[index]["selected"] = !interests[index]["selected"] ;
    return true;
  }
}