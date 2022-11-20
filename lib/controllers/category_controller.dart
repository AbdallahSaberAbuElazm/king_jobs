import 'package:dartz/dartz.dart';
import 'package:get/state_manager.dart';
import 'package:king_jobs/config/error/failure.dart';
import 'package:king_jobs/config/strings/failure.dart';
import 'package:king_jobs/models/category.dart';
import 'package:king_jobs/repositories/category_repo/category_repository.dart';

class CategoryController extends GetxController {
  final categories = <Category>[].obs;
  var failureTxt = ''.obs;
  var isLoading = true.obs;
  RxInt seletedItem = 10000.obs;
  var categorySelected = ''.obs;

  final CategoryRepository categoryRepository;
  CategoryController({required this.categoryRepository});

  @override
  void onInit() {
    fetchAllCategoriesFromRemoteData();
    super.onInit();
  }

  Future<void> fetchAllCategoriesFromRemoteData() async {
    try {
      isLoading(true);
      var categoriesData = await categoryRepository.getAllCategories();
      _mapFailureOrCategories(categoriesData);
    } finally {
      isLoading(false);
    }
  }

  _mapFailureOrCategories(Either<Failure, List<Category>> either) {
    return either.fold((failure) {
      failureTxt.value = mapFailureToMessage(failure);
    }, (categoriesData) {
      failureTxt.value = '';
      categories.value = categoriesData;
    });
  }

  // Future<void> fetchAllCategoriesFromFakeData() async {
  //   try {
  //     isLoading(true);
  //     var categoriesData = await CategoryFakeData().getAllCategories();
  //     if (categoriesData.isNotEmpty) {
  //       categories.value = categoriesData;
  //       isLoading.value = true;
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // return the list category for country
  // getSpecificCategoryForCountry({required int countryId}) {
  //   return selectedCategories.value = categories
  //       .where((category) => category.countryId == countryId)
  //       .toList();
  // }

  updateSelectedItem({required int index, required String category}) {
    seletedItem.value = index;
    categorySelected.value = category;
    update();
  }
}
