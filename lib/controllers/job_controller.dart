import 'package:dartz/dartz.dart';
import 'package:get/state_manager.dart';
import 'package:king_jobs/config/error/failure.dart';
import 'package:king_jobs/config/strings/failure.dart';
import 'package:king_jobs/models/job.dart';
import 'package:king_jobs/repositories/job_repo/job_repository.dart';

class JobController extends GetxController {
  final jobs = <Job>[].obs;
  final selectedJobs = <Job>[].obs;
  var failureTxt = ''.obs;
  var isLoading = true.obs;
  RxInt seletedItem = 10000.obs;
  var jobSelected = ''.obs;

  final JobRepository jobRepository;

  JobController({required this.jobRepository});

  @override
  void onInit() {
    // fetchAllJobsFromFakeData();
    fetchAllJobsFromRemoteData();
    super.onInit();
  }

  Future<void> fetchAllJobsFromRemoteData() async {
    try {
      isLoading(true);
      var jobsData = await jobRepository.getAllJobs();
      print('jobs are $jobsData');
      _mapFailureOrJobs(jobsData);
    } finally {
      isLoading(false);
    }
  }

  _mapFailureOrJobs(Either<Failure, List<Job>> either) {
    return either.fold((failure) {
      failureTxt.value = mapFailureToMessage(failure);
    }, (jobsData) {
      failureTxt.value = '';
      jobs.value = jobsData;
    });
  }

  // Future<void> fetchAllJobsFromFakeData() async {
  //   try {
  //     isLoading(true);
  //     var jobsData = await JobFakeData().getAllJobs();
  //     if (jobsData.isNotEmpty) {
  //       jobs.value = jobsData;
  //       isLoading.value = true;
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  //return the length of jobs for specific category
  // getLengthOfSpecificJobsForCategory({required int categoryId}) {
  //   return jobs.where((job) => job.categoryId == categoryId).toList().length;
  // }

  // return the list jobs for category
  getSpecificJobsForCategoryWithCategoryId({required int categoryId}) {
    return selectedJobs.value =
        jobs.where((job) => job.categoryId == categoryId).toList();
  }

  getSpecificJobsForCategoryWithListOfJobs({required List<Job> jobs}) {
    return selectedJobs.value = jobs;
  }

  //return job
  Iterable<Job> getSpecificJob({required int jobId}) {
    return jobs.where((job) => job.jobId == jobId);
  }

  // update selected item
  updateSelectedItem({required int index, required String job}) {
    seletedItem.value = index;
    jobSelected.value = job;
    update();
  }
}
