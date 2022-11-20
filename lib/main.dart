import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:king_jobs/config/styles/app_theme.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/controllers/category_controller.dart';
import 'package:king_jobs/controllers/country_controller.dart';
import 'package:king_jobs/controllers/job_controller.dart';
import 'package:king_jobs/controllers/user_controller.dart';
import 'package:king_jobs/screens/splash/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await initHiveBoxes();
  getControllers();
  configLoading();
  await di.init();
  runApp(const KingJobs());
}

Future initHiveBoxes() async {
  await Hive.openBox<bool>('companyOnwer');
  await Hive.openBox<bool>('firstOpen');
  await Hive.openBox<String>('cachedCountries');
  await Hive.openBox<String>('cachedCategories');
  await Hive.openBox<String>('cachedJobs');
  await Hive.openBox<String>('cachedUser');
}

getControllers() {
  Get.lazyPut<CountryController>(
      () => CountryController(countryRepository: di.sl()),
      fenix: true);
  Get.lazyPut<CategoryController>(
      () => CategoryController(categoryRepository: di.sl()),
      fenix: true);
  Get.lazyPut<JobController>(() => JobController(jobRepository: di.sl()),
      fenix: true);
  Get.lazyPut<UserController>(() => UserController(userRepository: di.sl()),
      fenix: true);
}

void configLoading() {
  EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000)
        ..indicatorType = EasyLoadingIndicatorType.fadingCircle
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..progressColor = Colors.white
        ..backgroundColor = thirdColor
        ..indicatorColor = Colors.white
        ..textColor = Colors.white
        ..maskColor = Colors.transparent
        ..userInteractions = true
        ..dismissOnTap = false
      // ..customAnimation = CustomAnimation()
      ;
}

class KingJobs extends StatelessWidget {
  const KingJobs({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetMaterialApp(
          theme: theme(),
          debugShowCheckedModeBanner: false,
          title: 'King Jobs',
          home: const SplashScreen()),
    );
  }
}
