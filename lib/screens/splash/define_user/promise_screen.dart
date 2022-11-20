import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/screens/country/country_screen.dart';
import 'package:king_jobs/widgets/go_elevated_btn.dart';
import 'package:king_jobs/widgets/logo_widget.dart';

class PromiseScreen extends StatefulWidget {
  const PromiseScreen({super.key});

  @override
  State<PromiseScreen> createState() => _PromiseScreenState();
}

class _PromiseScreenState extends State<PromiseScreen> {
  bool _checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 13,
              left: 12,
              right: 12,
              bottom: MediaQuery.of(context).size.height / 30,
            ),
            child: ListView(padding: EdgeInsets.zero, children: [
              const Center(
                child: LogoWidget(
                  imageColor: secondColor,
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 70),
                  child: Text('تعهــــــــــــــــــــــد',
                      style: Theme.of(context).textTheme.headline1),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 130),
                  child: Text('قال تعالي',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 130, bottom: 10),
                child: Text(
                    'وَأَوْفُوا بِعَهْدِ اللَّهِ إِذَا عَاهَدتُّمْ وَلَا تَنقُضُوا الْأَيْمَانَ بَعْدَ تَوْكِيدِهَا وَقَدْ جَعَلْتُمُ اللَّهَ عَلَيْكُمْ كَفِيلًا',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                      activeColor: secondColor,
                      hoverColor: secondColor,
                      focusColor: secondColor,
                      value: _checkValue,
                      onChanged: (value) {
                        setState(() {
                          _checkValue = value!;
                        });
                      }),

                  // child: Text(
                  //   'اتعهد أمام الله اني في حالة طلبة موظف من هذا التطبيق للعمل معي أو مع شخص آخر بأنني ادفع عمولة للتطبيق عبر التواصل معهم أو تحويل المبلغ علي الحساب الموضح في التطبيق والله علي ما أقوله شهيد والعمولة كالتالي:\n -الطلب من داخل مجلس التعاون الخيجي 200ريال سعودي أو ما يوازيه من العملة الخليجية عموله لكل موظف.\n -الطلب من داخل بقيمة الدول 20دولار عموله لكل موظف او مايوازيه من عملة البلد التي تم طلب فيها الموظف.\n-وقد تعهدت الشركة بنسبة 10% من نسبة الأرباح لصالح الايتام في الدول الفقيرة.\n-واتساب: 502149139-00971   558499005-00966   774618392-00967',
                  //   style: TextStyle(
                  //     color: secondColor,
                  //     fontSize: 14,
                  //     fontFamily: 'NotoKufiArabic',
                  //   ),
                  // ),
                  FutureBuilder(
                    future: Future.delayed(const Duration(milliseconds: 50))
                        .then((value) {
                      return rootBundle
                          .loadString('assets/texts/promise_data.md');
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Flexible(
                            child: Text(snapshot.data.toString(),
                                style: Theme.of(context).textTheme.bodyText2));
                        //     child: Markdown(
                        //   data: snapshot.data.toString(),
                        // ));

                      }
                      return const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: secondColor),
                      );
                    },
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GoElevatedBtn(
                        onPressed: () {
                          if (_checkValue == true) {
                            Get.off(() => HomePage());
                          }
                        },
                        title: 'استمرار',
                        btnColor: secondColor,
                        textColor: Colors.white),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
