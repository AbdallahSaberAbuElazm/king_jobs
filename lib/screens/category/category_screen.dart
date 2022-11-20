import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/config/util/shared_obects_controllers.dart';
import 'package:king_jobs/screens/category/category_tile.dart';
import 'package:king_jobs/widgets/appbar.dart';
import 'package:king_jobs/widgets/loading_overlay.dart';
import 'package:king_jobs/widgets/navigation_drawer.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: Appbar.appbarWithLogo(
              context: context,
              imageColor: Colors.white,
              childWidget: Row(
                children: [
                  Text(
                    Controllers.countryController.countrySelected.value,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'NotoKufiArabic',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          drawer: const NavigationDrawer(),
          drawerScrimColor: Colors.grey.withOpacity(0.54),
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
                  left: 23,
                  right: 23,
                  top: MediaQuery.of(context).size.height / 4.5),
              child: Obx(() {
                if (Controllers.categoryController.isLoading.value) {
                  return const LoadingWidget();
                } else {
                  return RefreshIndicator(
                    color: thirdColor,
                    onRefresh: _buildRefersh,
                    child: StaggeredGridView.countBuilder(
                      padding: EdgeInsets.zero,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      crossAxisCount: 2,
                      itemCount:
                          Controllers.categoryController.categories.length,
                      itemBuilder: (context, index) {
                        if (Controllers.categoryController.categories.isEmpty) {
                          return Center(
                            child: Text(
                              'لا يوجد نتائج لحتي الأن',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          );
                        } else {
                          return CategoryTile(
                              category: Controllers
                                  .categoryController.categories[index],
                              index: index,
                              jobs: Controllers.jobController
                                  .getSpecificJobsForCategoryWithCategoryId(
                                      categoryId: Controllers.categoryController
                                          .categories[index].categoryId));
                          // .getLengthOfSpecificJobsForCategory(
                          //     categoryId: Controllers.categoryController
                          //         .categories[index].categoryId)
                          // );
                        }
                      },
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(1),
                    ),
                  );
                }
              }),
            ),
          ),
        ));
  }

  Future<void> _buildRefersh() async {
    await Controllers.categoryController.fetchAllCategoriesFromRemoteData();
  }
}
