import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/config/util/shared_obects_controllers.dart';
import 'package:king_jobs/screens/country/country_tile.dart';
import 'package:king_jobs/widgets/appbar.dart';
import 'package:king_jobs/widgets/loading_overlay.dart';
import 'package:king_jobs/widgets/navigation_drawer.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            drawerScrimColor: Colors.grey.withOpacity(0.54),
            appBar: Appbar.appbarWithLogo(
              context: context,
              imageColor: secondColor,
              childWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('العمالة', style: Theme.of(context).textTheme.headline2),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                        color: secondColor,
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 19, // Changing Drawer Icon Size
                    ),
                  ),
                ],
              ),
            ),
            drawer: const NavigationDrawer(),
            body: _buildBody(context: context)));
  }

  Widget _buildBody({required BuildContext context}) {
    return Container(
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
            left: 15, right: 15, top: MediaQuery.of(context).size.height / 4.5),
        child: Obx(() {
          if (Controllers.countryController.isLoading.value) {
            return const LoadingWidget();
          } else {
            return Obx(() {
              if (Controllers.countryController.failureTxt.value.isNotEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/unconnect_internet_icon.svg',
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 5,
                      allowDrawingOutsideViewBox: true,
                    ),
                    Text(
                      Controllers.countryController.failureTxt.value,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: thirdColor, width: 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            )),
                        onPressed: () {
                          _buildRefersh();
                        },
                        child: Text(
                          'اعادة المحاولة',
                          style: Theme.of(context).textTheme.bodyText2,
                        )),
                  ],
                );
              } else {
                return RefreshIndicator(
                  color: thirdColor,
                  onRefresh: _buildRefersh,
                  child: StaggeredGridView.countBuilder(
                    padding: EdgeInsets.zero,
                    mainAxisSpacing: MediaQuery.of(context).size.height / 30,
                    crossAxisSpacing: MediaQuery.of(context).size.height / 36,
                    crossAxisCount: 3,
                    itemCount: Controllers.countryController.countries.length,
                    itemBuilder: (context, index) {
                      if (Controllers.countryController.countries.isEmpty) {
                        return Center(
                          child: Text(
                            'لا يوجد نتائج لحتي الأن',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        );
                      } else {
                        return CountryTile(
                          country:
                              Controllers.countryController.countries[index],
                          index: index,
                        );
                      }
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  ),
                );
              }
            });
          }
        }),
      ),
    );
  }

  Future<void> _buildRefersh() async {
    await Controllers.countryController.fetchAllCountriesFromRemoteData();
  }
}
