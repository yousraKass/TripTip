abstract class AbstractPreferenes {
  Future<List> GetUserPreferences();
  Future<bool> TogglePreference(int index); // to be modified, only show it to him in the frontend and then when he leaves the page changes are saved
}