import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/config/util/shared_obects_controllers.dart';
import 'package:king_jobs/screens/jobs/user_jobs/user_apply_to_job/user_tile.dart';
import 'package:king_jobs/widgets/appbar.dart';
import 'package:king_jobs/widgets/loading_overlay.dart';

class UsersOpenToWork extends StatelessWidget {
  const UsersOpenToWork({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Appbar.appbarForJobs(
          title: Controllers.categoryController.categorySelected.value,
          context: context,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '${Controllers.countryController.countrySelected.value} ${Controllers.categoryController.categorySelected.value} ${Controllers.jobController.jobSelected.value}',
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'NotoKufiArabic',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/category_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: MediaQuery.of(context).size.height / 4.5),
            child: Obx(() {
              if (Controllers.userController.isLoading.value) {
                return const LoadingWidget();
              } else {
                return Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: MediaQuery.of(context).size.height / 60,
                        bottom: MediaQuery.of(context).size.height / 20),
                    child: Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 22,
                                right: MediaQuery.of(context).size.width / 22,
                                top: MediaQuery.of(context).size.height / 16,
                                bottom:
                                    MediaQuery.of(context).size.height / 18),
                            child: Obx(
                              () => RefreshIndicator(
                                color: thirdColor,
                                onRefresh: _buildRefersh,
                                child: StaggeredGridView.countBuilder(
                                  padding: EdgeInsets.zero,
                                  mainAxisSpacing: 9,
                                  crossAxisSpacing: 20,
                                  crossAxisCount: 1,
                                  itemCount: Controllers.userController.users
                                      .where((user) => user.jobId == 2)
                                      .toList()
                                      .length,
                                  // Controllers.userController
                                  //     .usersForSpecificJob.length,
                                  itemBuilder: (context, index) {
                                    print(
                                        'users are ${Controllers.userController.users.where((user) => user.jobId == 2)}');
                                    return UserTile(
                                      user: Controllers.userController
                                          .usersForSpecificJob[index],
                                      index: index,
                                    );
                                  },
                                  staggeredTileBuilder: (index) =>
                                      const StaggeredTile.fit(1),
                                ),
                              ),
                            ))));
              }
            }),
          ),
        ),
      ),
    );
  }

  Future<void> _buildRefersh() async {
    await Controllers.userController.fetchAllUsersFromRemoteData();
  }
}
