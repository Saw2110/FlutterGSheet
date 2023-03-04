import 'pref_text.dart';
import 'share_preference.dart';

class GetAllPref {
  static contactNumber() async {
    return await SharedPref.getData(
      key: PrefText.userContact,
      dValue: "-",
      type: "String",
    );
  }
}
