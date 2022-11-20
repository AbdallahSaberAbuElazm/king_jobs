import 'package:get/get.dart';
import 'package:king_jobs/controllers/category_controller.dart';
import 'package:king_jobs/controllers/country_controller.dart';
import 'package:king_jobs/controllers/job_controller.dart';
import 'package:king_jobs/controllers/user_controller.dart';

class Controllers {
  static final CountryController countryController = Get.find();
  static final CategoryController categoryController = Get.find();
  static final JobController jobController = Get.find();
  static final UserController userController = Get.find();
}
