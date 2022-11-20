import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/config/util/api/api_url.dart';
import 'package:king_jobs/config/util/shared_obects_controllers.dart';
import 'package:king_jobs/controllers/user_controller.dart';
import 'package:king_jobs/models/category.dart';
import 'package:king_jobs/models/job.dart';
import 'package:king_jobs/screens/jobs/job_screen.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final int index;
  final List<Job> jobs;

  const CategoryTile(
      {super.key,
      required this.category,
      required this.index,
      required this.jobs});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () {
            Controllers.categoryController.updateSelectedItem(
                index: index, category: category.categoryName);
            Controllers.jobController
                .getSpecificJobsForCategoryWithListOfJobs(jobs: jobs);
            Get.find<UserController>();
            // Controllers.jobController.getSpecificCategoryForCategory(
            //     categoryId: category.categoryId);
            // Controllers.jobController
            //     .fetchAllJobsFromRemoteData(categoryId: category.categoryId);
            Get.to(() => JobScreen(category: category))!.then((value) =>
                Controllers.categoryController.updateSelectedItem(
                    index: -1, category: category.categoryName));
          },
          child: Obx(() => SizedBox(
                height: MediaQuery.of(context).size.height / 5.23,
                child: Card(
                  semanticContainer: true,
                  elevation: 3,
                  color: (Controllers.categoryController.seletedItem.value ==
                          index)
                      ? const Color.fromRGBO(78, 120, 151, 1)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 50,
                        right: MediaQuery.of(context).size.width / 24,
                        left: MediaQuery.of(context).size.width / 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.height / 19,
                          height: MediaQuery.of(context).size.height / 19,
                          child: (Controllers
                                      .categoryController.seletedItem.value ==
                                  index)
                              ? CachedNetworkImage(
                                  imageUrl:
                                      ApiUrl.STORAGE_URL + category.imageUrl,
                                  fit: BoxFit.cover,
                                  color: Colors.white,
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      ApiUrl.STORAGE_URL + category.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(
                            child: Text(
                          category.categoryName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: (Controllers
                                        .categoryController.seletedItem.value !=
                                    index)
                                ? secondColor
                                : Colors.white,
                            fontFamily: 'NotoKufiArabic',
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                        )),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 50,
                            ),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 18,
                                height: MediaQuery.of(context).size.width / 18,
                                decoration: BoxDecoration(
                                    color: secondColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    jobs.length.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ));
  }
}
