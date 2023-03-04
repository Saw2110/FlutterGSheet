
class ConvertFromListToMap {
  // this helper method helps convert to a list of Map
  static dynamic getListMap(List<dynamic> items) {
    if (items.isEmpty) {
      return null;
    }
    List<Map<String, dynamic>> dayItems = [];
    for (var element in items) {
      dayItems.add(element.toJson());
    }
    return dayItems[0];
  }
}
