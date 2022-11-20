import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/config/util/api/api_url.dart';
import 'package:king_jobs/config/util/shared_obects_controllers.dart';
import 'package:king_jobs/models/category.dart';
import 'package:king_jobs/screens/jobs/job_tile.dart';
import 'package:king_jobs/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:king_jobs/widgets/loading_overlay.dart';

class JobScreen extends StatelessWidget {
  final Category category;
  const JobScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: Appbar.appbarForJobs(
              title:
                  '${Controllers.countryController.countrySelected.value} ${Controllers.categoryController.categorySelected.value}',
              context: context,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5.5,
                    height: MediaQuery.of(context).size.height / 11,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(242, 235, 229, 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'الإجمالي',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          Controllers.jobController.selectedJobs.length
                              .toString(),
                          style: Theme.of(context).textTheme.headline1,
                        )
                      ],
                    ),
                  )),
            ),

            // drawerScrimColor: secondColor,
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 23,
                        right: 23,
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Obx(() {
                      if (Controllers.jobController.isLoading.value) {
                        return const LoadingWidget();
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                  Controllers.categoryController
                                      .categorySelected.value,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.headline3),
                            ),
                            Expanded(
                                child: Obx(
                              () => RefreshIndicator(
                                color: thirdColor,
                                onRefresh: _buildRefersh,
                                child: StaggeredGridView.countBuilder(
                                  padding: EdgeInsets.zero,
                                  mainAxisSpacing: 7,
                                  crossAxisSpacing: 20,
                                  crossAxisCount: 1,
                                  itemCount: Controllers
                                      .jobController.selectedJobs.length,
                                  itemBuilder: (context, index) {
                                    return (Controllers
                                            .jobController.jobs.isEmpty)
                                        ? Center(
                                            child: Text(
                                              'لا يوجد نتائج لحتي الأن',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          )
                                        : JobTile(
                                            job: Controllers.jobController
                                                .selectedJobs[index],
                                            index: index,
                                            usersLength: Controllers
                                                .userController
                                                .usersForSpecificJob
                                                .length,
                                          );
                                  },
                                  staggeredTileBuilder: (index) =>
                                      const StaggeredTile.fit(1),
                                ),
                              ),
                            )),
                          ],
                        );
                      }
                    }),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(80)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          ApiUrl.STORAGE_URL + category.backgroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )));
  }

  Future<void> _buildRefersh() async {
    await Controllers.jobController.fetchAllJobsFromRemoteData();
  }
}
