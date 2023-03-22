import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_demo/models/person.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bolc_obsever.dart';
import 'my_app.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

main() async {
  Bloc.observer = MyBlocObserver();

  // Initialize hive
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  // Opening the box
  await Hive.openBox('peopleBox');

  // Initialize Google Map
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  runApp(MyApp());
}
