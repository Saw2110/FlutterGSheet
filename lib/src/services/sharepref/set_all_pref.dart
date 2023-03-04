import 'pref_text.dart';
import 'share_preference.dart';

class SetAllPref {
  static contactNumber({required String value}) async {
    return await SharedPref.setData(
      key: PrefText.userContact,
      dValue: value,
      type: "String",
    );
  }
}
