import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home/core/constant/imageassets.dart';
import 'package:smart_home/core/constant/routes.dart';
import 'package:smart_home/core/services/services.dart';
import 'package:smart_home/data/model/composent.model.dart';

class HomeController extends GetxController {
  late DatabaseReference ref;
  final pinController = TextEditingController();
  ComposentModel ledComposent = ComposentModel(
    title: "Led",
    subtitle: "Led Controller",
    isActivated: true,
    lottie: AppImageAsset.lottieLed,
  );
  ComposentModel temComposent = ComposentModel(
    title: "Temperature",
    subtitle: "Living Room",
    isActivated: true,
    icon: AppImageAsset.temperature,
    value: "25°C",
  );
  ComposentModel humComposent = ComposentModel(
    title: "Humidity",
    subtitle: "Living Room",
    isActivated: true,
    icon: AppImageAsset.humidity,
    value: "25%",
  );
  ComposentModel fanComposent = ComposentModel(
    title: "Fan",
    subtitle: "Fan Controller",
    isActivated: true,
    lottie: AppImageAsset.lottieFan,
  );
  ComposentModel pumpComposent = ComposentModel(
    title: "Pump",
    subtitle: "Pump Controller",
    isActivated: true,
    lottie: AppImageAsset.lottiePump,
  );
  ComposentModel solComposent = ComposentModel(
    title: "Soil",
    subtitle: "Soil Controller",
    isActivated: true,
    icon: AppImageAsset.humidity,
    value: "25%",
  );
  ComposentModel doorComposent = ComposentModel(
    title: "Door",
    subtitle: "Door Controller",
    isActivated: true,
    lottie: AppImageAsset.lottieDoor,
  );
  ComposentModel roomComposent = ComposentModel(
    title: "Room",
    subtitle: "Room Controller",
    value: "No One Here",
    isActivated: false,
    icon: AppImageAsset.room,
  );
  ComposentModel earthQuakeComposent = ComposentModel(
    title: "Earthquake",
    subtitle: "Earthquake Controller",
    value: "No Earthquake",
    isActivated: false,
    icon: AppImageAsset.earthquake,
  );
  ComposentModel fireComposent = ComposentModel(
    title: "Capteurs de flamme",
    subtitle: "Incendie en cours",
    value: "Incendie en cours",
    isActivated: false,
    lottie: AppImageAsset.lottieFire,
  );

  // listen to arrosage changes
  void listenToArrosage() {
    ref.child("arrosage").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      solComposent.value = "${data['sol']}%";
      pumpComposent.isActivated = data['pompe'];

      update();
    });
  }

  // listen to chabmre changes
  void listenToChambre() {
    ref.child("chambre").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      roomComposent.isActivated = data['status'];
      roomComposent.value = data['status'] ? "Someone Here" : "No One Here";
      update();
    });
  }

  // listen to dht changes
  void listenToDht() {
    ref.child("dht").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      temComposent.value = "${data['temp']}";
      humComposent.value = "${data['humid']}";
      fanComposent.isActivated = data['ventil'];

      update();
    });
  }

  // listen to led changes
  void listenToLed() {
    ref.child("led").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      ledComposent.isActivated = data['status'];
      update();
    });
  }

  // listen to porte changes
  void listenToPorte() {
    ref.child("porte").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      doorComposent.isActivated = data['status'];
      update();
    });
  }

  // listen to vibration changes
  void listenToVibration() {
    ref.child("vibration").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);

      earthQuakeComposent.isActivated = data['status'];
      earthQuakeComposent.value =
          data['status'] ? "Earthquake" : "No Earthquake";
      update();
    });
  }

  // liste to fire changes
  void listenToFire() {
    ref.child("flamme").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      fireComposent.isActivated = data['status'];
      fireComposent.subtitle =
          data['status'] ? "Incendie en cours" : "Pas d'incendie";
      fireComposent.value =
          data['status'] ? "Incendie en cours" : "Pas d'incendie";
      update();
    });
  }

  Future<void> switchFire() async {
    await ref.child("flamme").update({"status": !fireComposent.isActivated!});
  }

  Future<void> switchDoor() async {
    await ref.child("porte").update({"status": !doorComposent.isActivated!});
  }

  Future<bool> validateDoorPin(String pin) async {
    final snapshot = await ref.child("porte").get();
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    return data['pin'] == pin;
  }

  Future<void> switchLed() async {
    await ref.child("led").update({"status": !ledComposent.isActivated!});
  }

  Future<void> switchFan() async {
    await ref.child("dht").update({"ventil": !fanComposent.isActivated!});
  }

  Future<void> switchPump() async {
    await ref.child("arrosage").update({"pompe": !pumpComposent.isActivated!});
  }

  @override
  void onInit() {
    ref = FirebaseDatabase.instance.ref();
    listenToArrosage();
    listenToChambre();
    listenToDht();
    listenToLed();
    listenToPorte();
    listenToVibration();
    listenToFire();
    super.onInit();
  }

  Future signOut() async {
    await Get.find<MyServices>().sharedPreferences.setBool("isLogged", false);
    await Get.offAllNamed(AppRoutes.login);
  }
}
