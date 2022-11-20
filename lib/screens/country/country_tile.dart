import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/util/api/api_url.dart';
import 'package:king_jobs/config/util/shared_obects_controllers.dart';
import 'package:king_jobs/controllers/job_controller.dart';
import 'package:king_jobs/models/country.dart';
import 'package:king_jobs/screens/category/category_screen.dart';

class CountryTile extends StatelessWidget {
  final Country country;
  final int index;

  const CountryTile({super.key, required this.country, required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              Controllers.countryController.updateSelectedItem(
                  index: index, country: country.countryNameAr);
              Get.find<JobController>();
              // Controllers.categoryController
              //     .getSpecificCategoryForCountry(countryId: country.countryId);
              Get.to(() => const CategoryScreen())!.then((value) =>
                  Controllers.countryController.updateSelectedItem(
                      index: 10000, country: country.countryNameAr));
            },
            child: Obx(
              () => Card(
                elevation: 3,
                color:
                    (Controllers.countryController.selectedItem.value == index)
                        ? const Color.fromRGBO(183, 133, 104, 1)
                        : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 17,
                      child: CachedNetworkImage(
                        imageUrl: ApiUrl.STORAGE_URL + country.imageUrl,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            )),
        SizedBox(
            child: Text(
          'المواطنين والمقيمين في ${country.countryNameAr}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        )),
      ],
    );
  }
}
