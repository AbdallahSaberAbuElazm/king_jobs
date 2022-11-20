import 'package:dartz/dartz.dart';
import 'package:get/state_manager.dart';
import 'package:king_jobs/config/error/failure.dart';
import 'package:king_jobs/config/strings/failure.dart';
import 'package:king_jobs/models/country.dart';
import 'package:king_jobs/repositories/country_repo/country_repository.dart';

class CountryController extends GetxController {
  final countries = <Country>[].obs;
  var failureTxt = ''.obs;
  var isLoading = true.obs;
  RxInt selectedItem = 10000.obs;
  var countrySelected = ''.obs;
  final CountryRepository countryRepository;
  CountryController({required this.countryRepository});
  @override
  void onInit() {
    fetchAllCountriesFromRemoteData();
    super.onInit();
  }

  // Future<Either<String, List<Country>>>
  fetchAllCountriesFromRemoteData() async {
    try {
      isLoading(true);
      var countriesData = await countryRepository.getAllCountries();
      _mapFailureOrCountries(countriesData);
    } finally {
      isLoading(false);
    }
  }

  _mapFailureOrCountries(Either<Failure, List<Country>> either) {
    return either.fold((failure) {
      failureTxt.value = mapFailureToMessage(failure);
    }, (countriesData) {
      failureTxt.value = '';
      countries.value = countriesData;
    });
  }
  // Future<void> fetchAllCountriesFromFakeData() async {
  //   try {
  //     isLoading(true);
  //     var countriesData = await CountryFakeData().getAllCountries();
  //     if (countriesData.isNotEmpty) {
  //       countries.value = countriesData;
  //       isLoading.value = true;
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  updateSelectedItem({required int index, required String country}) {
    selectedItem.value = index;
    countrySelected.value = country;
    update();
  }
}
