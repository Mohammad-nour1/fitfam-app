
import '../model/home_model.dart';

class HomeController {
  Future<HomeData> fetchHomeData() async {
   
    await Future.delayed(const Duration(seconds: 2));

    return HomeData(
      userName: "أحمد",
      currentChallenge: "تحدي 5000 خطوة",
      progress: 0.5,
      familyActivity: [
        FamilyMember(name: "خالد", steps: 3200),
        FamilyMember(name: "عادل", steps: 4100),
      ],
    );
  }
}
