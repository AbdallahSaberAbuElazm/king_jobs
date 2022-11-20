import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/config/util/hive_boxes.dart';
import 'package:king_jobs/models/onboarding_contents.dart';
import 'package:king_jobs/screens/splash/define_user/define_user_screen.dart';
import 'package:king_jobs/screens/splash/onboarding/size_config.dart';
import 'package:king_jobs/widgets/go_elevated_btn.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF000000),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 5,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      // backgroundColor: scaffoldBackground,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  itemCount: contents.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.7,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  contents[i].image,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          height: (height >= 840) ? 60 : 30,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'NotoKufiArabic',
                            fontSize: 17,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 28),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              contents.length,
                              (int index) => _buildDots(index: index),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 28),
                          child: GoElevatedBtn(
                              onPressed: () {
                                if (_currentPage + 1 == contents.length) {
                                  Get.off(() => const DefineUserScreen());
                                  HiveBoxes.changeShowHome(firstOpen: true);
                                } else {
                                  _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                }
                              },
                              title: 'التالي',
                              btnColor: secondColor,
                              textColor: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            _controller.jumpToPage(2);
                          },
                          style: TextButton.styleFrom(
                            elevation: 0,
                            textStyle: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          child: const Text(
                            "تخطي",
                            style: TextStyle(
                                color: Color.fromARGB(167, 0, 0, 0),
                                fontSize: 17,
                                fontFamily: 'NotoKufiArabic'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
