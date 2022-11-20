import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/config/util/hive_boxes.dart';
import 'package:king_jobs/controllers/country_controller.dart';
import 'package:king_jobs/screens/country/country_screen.dart';
import 'package:king_jobs/screens/splash/define_user/promise_screen.dart';
import 'package:king_jobs/widgets/go_elevated_btn.dart';

class DefineUserScreen extends StatelessWidget {
  const DefineUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.4,
            decoration: const BoxDecoration(
              // border: Border.all(width: 0),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(80)),
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/define_user.png',
                ),
                fit: BoxFit.cover,
              ),
            )),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 20, bottom: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoElevatedBtn(
                  btnColor: secondColor,
                  textColor: Colors.white,
                  title: 'صاحب شركة',
                  onPressed: () {
                    Get.off(() => const PromiseScreen());

                    HiveBoxes.changeUserType(type: true);
                    Get.find<CountryController>();
                  }),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoElevatedBtn(
                btnColor: firstColor,
                textColor: fifthColor,
                title: 'طالب عمل',
                onPressed: () {
                  Get.off(
                    () => HomePage(),
                  );

                  HiveBoxes.changeUserType(type: false);
                  Get.find<CountryController>();
                }),
          ],
        ),
      ]),
    ));
  }
}
