import 'package:flutter/material.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/config/util/shared_obects_controllers.dart';
import 'package:king_jobs/models/user_service.dart';

class UserTile extends StatelessWidget {
  final UserService user;
  final int index;
  const UserTile({super.key, required this.user, required this.index});

  final TextStyle _style1 = const TextStyle(
    color: secondColor,
    fontSize: 8,
    fontFamily: 'NotoKufiArabic',
  );
  final TextStyle _style2 = const TextStyle(
    color: secondColor,
    fontSize: 8,
    fontWeight: FontWeight.w600,
    fontFamily: 'NotoKufiArabic',
  );
  final TextStyle _style3 = const TextStyle(
    color: Colors.white,
    fontSize: 8.5,
    fontWeight: FontWeight.w600,
    fontFamily: 'NotoKufiArabic',
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 6,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/user_card.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(18)),
                width: MediaQuery.of(context).size.width / 6.7,
                height: MediaQuery.of(context).size.height / 8.5,
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 26,
                    bottom: MediaQuery.of(context).size.width / 26),
                child: Image.asset(
                  'assets/images/user.png',
                  // fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7, bottom: 9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.firstName,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    _rowUserData(title: 'ايميل:', description: user.email),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _rowUserData(
                                title: 'الجنس:', description: user.gender),
                            _rowUserData(
                                title: 'الوظيفة:',
                                description: Controllers.jobController
                                    .getSpecificJob(jobId: user.jobId)
                                    .first
                                    .jobTitle),
                          ],
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _rowUserData(
                                title: 'رقم الجوال:',
                                description: user.phoneNumber),
                            _rowUserData(
                                title: 'سنوات الخبرة:',
                                description: user.yearsExp),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(10, -21),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 11,
                    height: MediaQuery.of(context).size.height / 13,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: secondColor),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'تحميل',
                            style: _style3,
                          ),
                          Text(
                            'cv',
                            style: _style3,
                          ),
                        ]),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _rowUserData({required String title, required String description}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: _style2,
        ),
        Text(description, style: _style1),
      ],
    );
  }
}
