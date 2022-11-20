import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/config/util/hive_boxes.dart';
import 'package:king_jobs/config/util/shared_obects_controllers.dart';
import 'package:king_jobs/models/job.dart';
import 'package:king_jobs/screens/jobs/user_jobs/user_apply_to_job/users_open_to_work.dart';
import 'package:king_jobs/screens/jobs/user_jobs/user_open_to_work/apply_job.dart';

class JobTile extends StatelessWidget {
  final Job job;
  final int index;
  final int usersLength;

  JobTile(
      {super.key,
      required this.job,
      required this.index,
      required this.usersLength});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
          onTap: () {
            Controllers.jobController
                .updateSelectedItem(index: index, job: job.jobTitle);
            if (HiveBoxes.getUserType() == false) {
              Get.to(() => ApplyJob(
                        jobId: job.jobId,
                      ))!
                  .then((value) => Controllers.jobController
                      .updateSelectedItem(index: -1, job: job.jobTitle));
            } else {
              Controllers.userController
                  .getSpecificUserForJob(jobId: job.jobId);
              Get.to(() => const UsersOpenToWork())!.then((value) => Controllers
                  .jobController
                  .updateSelectedItem(index: -1, job: job.jobTitle));
            }
          },
          child: Obx(
            () => SizedBox(
              height: MediaQuery.of(context).size.height / 7.5,
              child: Card(
                elevation: 3,
                color: (Controllers.jobController.seletedItem.value == index)
                    ? const Color.fromRGBO(183, 133, 104, 1)
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 70,
                          bottom: MediaQuery.of(context).size.height / 70,
                          right: MediaQuery.of(context).size.width / 36,
                          left: MediaQuery.of(context).size.width / 20),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width / 5.7,
                          height: MediaQuery.of(context).size.height / 11,
                          child: CachedNetworkImage(
                            imageUrl: job.imageUrl,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                        child: Text(
                      job.jobTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 50,
                            left: MediaQuery.of(context).size.width / 20),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 15,
                            height: MediaQuery.of(context).size.height / 24,
                            decoration: BoxDecoration(
                                color: secondColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                usersLength.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
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
    );
  }
}
