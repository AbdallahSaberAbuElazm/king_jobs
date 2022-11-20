import 'package:hive/hive.dart';

class HiveBoxes {
  static final _userType = Hive.box<bool>('companyOnwer');
  static final _showHome = Hive.box<bool>('firstOpen');
  static final _cachedCountries = Hive.box<String>('cachedCountries');
  static final _cachedCategories = Hive.box<String>('cachedCategories');
  static final _cachedJobs = Hive.box<String>('cachedJobs');
  static final _cachedUser = Hive.box<String>('cachedUser');

  static changeUserType({required bool type}) {
    _userType.put('companyOnwer', type);
  }

  static changeShowHome({required bool firstOpen}) {
    _showHome.put('firstOpen', firstOpen);
  }

  static setCachedUser({required String user}) {
    _cachedUser.put('cachedUser', user);
  }

  static setCachedCountries({required String countries}) {
    _cachedCountries.put('cachedCountries', countries);
  }

  static setCachedCategories({required String categories}) {
    _cachedCategories.put('cachedCategories', categories);
  }

  static setCachedJobs({required String jobs}) {
    _cachedJobs.put('cachedJobs', jobs);
  }

  static bool? getUserType() => _userType.get('companyOnwer');
  static bool? getShowHome() => _showHome.get('firstOpen');

  static String? getCachedCountries() =>
      _cachedCountries.get('cachedCountries');
  static String? getCachedCategories() =>
      _cachedCategories.get('cachedCategories');
  static String? getCachedJobs() => _cachedJobs.get('cachedJobs');
  static String? getCachedUser() => _cachedJobs.get('cachedUser');
}
