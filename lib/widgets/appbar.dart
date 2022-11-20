import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/widgets/logo_widget.dart';

class Appbar {
  static PreferredSizeWidget appbarWithLogo(
      {required BuildContext context,
      required Widget childWidget,
      required Color imageColor}) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height / 8,
      title: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 49),
        child: LogoWidget(imageColor: imageColor),
      ),
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size(40, 40),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: childWidget,
        ),
      ),
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 49, right: 3),
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                  color: secondColor,
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: const Icon(
                Icons.format_align_right_outlined,
                color: Colors.white,
                size: 18, // Changing Drawer Icon Size
              ),
            ),
          ),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      }),
    );
  }

  static PreferredSizeWidget appbarForJobs(
      {required String title,
      required BuildContext context,
      required Widget child}) {
    return AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 8,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 45),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'NotoKufiArabic',
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(40, 40),
          child: Padding(
            padding: const EdgeInsets.only(left: 23, right: 15),
            child: child,
          ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Get.back(),
            icon: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 45, right: 3),
              child: Container(
                padding: const EdgeInsets.all(4),
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: secondColor,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                child: Image.asset("assets/images/arrow_back.png"),
              ),
            ),
          );
        }));

    // ),
  }
}
