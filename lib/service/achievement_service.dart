import 'package:shared_preferences/shared_preferences.dart';

class AchievementService {
  Future<void> addAchievement(String userId, String achievement) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> achievements = prefs.getStringList('achievements_$userId') ?? [];
    if (!achievements.contains(achievement)) {
      achievements.add(achievement);
      await prefs.setStringList('achievements_$userId', achievements);
    }
  }

  Future<List<String>> getAchievements(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('achievements_$userId') ?? [];
  }
}
