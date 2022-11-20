import 'package:dartz/dartz.dart';
import 'package:get/state_manager.dart';
import 'package:king_jobs/config/error/failure.dart';
import 'package:king_jobs/config/strings/failure.dart';
import 'package:king_jobs/models/user_service.dart';
import 'package:king_jobs/repositories/user_repo/user_repository.dart';

class UserController extends GetxController {
  final users = <UserService>[].obs;
  var isLoading = true.obs;
  RxInt seletedItem = 10000.obs;
  final usersForSpecificJob = <UserService>[].obs;

  final UserRepositoryImpl userRepository;

  UserController({required this.userRepository});

  @override
  void onInit() {
    // fetchAllUsersFromFakeData();
    fetchAllUsersFromRemoteData();
    super.onInit();
  }

  Future<void> fetchAllUsersFromRemoteData() async {
    try {
      isLoading(true);
      var usersData = await userRepository.getAllUsers();
      print('user data is $usersData');
      _mapFailureOrUsers(usersData);
    } finally {
      isLoading(false);
    }
  }

  Future<void> registerUser({required Map<String, dynamic> userData}) async {
    try {
      await userRepository.addUser(userData: userData);
    } finally {}
  }

  _mapFailureOrUsers(Either<Failure, List<UserService>> either) {
    return either.fold((failure) {
      return mapFailureToMessage(failure);
    }, (posts) {
      return posts;
    });
  }

  // Future<void> fetchAllUsersFromFakeData() async {
  //   try {
  //     isLoading(true);
  //     var usersData = await UserFakeData().getAllUsers();
  //     if (usersData.isNotEmpty) {
  //       users.value = usersData;
  //       isLoading.value = true;
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  //return the length of users for specific job
  // getLengthOfSpecificUsersForJob({required int jobId}) {
  //   return users.where((user) => user.jobId == jobId).toList().length;
  // }

  // return the list jobs for category
  getSpecificUserForJob({required int jobId}) {
    usersForSpecificJob.value =
        users.where((user) => user.jobId == jobId).toList();
    print('job id is $jobId users data are : $usersForSpecificJob');
  }

  updateSelectedItem(int index) {
    seletedItem.value = index;
    update();
  }
}
