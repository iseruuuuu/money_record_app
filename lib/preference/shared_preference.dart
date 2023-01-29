// Package imports:
import 'package:enum_to_string/enum_to_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKey {
  categoryList,
}

class Preference {
  final preference = SharedPreferences.getInstance();

  Future<List<String>> getListString(PreferenceKey key) async {
    final pref = await preference;
    final value = pref.getStringList(EnumToString.convertToString(key)) ?? [];
    return value;
  }

  Future<void> setListString(PreferenceKey key, List<String> value) async {
    final pref = await preference;
    await pref.setStringList(EnumToString.convertToString(key), value);
  }

  Future<String> getString(String key) async {
    final pref = await preference;
    final value = pref.getString(key) ?? '';
    return value;
  }

  Future<void> setString(String key,String value) async {
    final pref = await preference;
    await pref.setString(key, value);
  }
}
