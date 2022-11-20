import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/styles/color.dart';
import 'package:king_jobs/config/util/api/upload_file.dart';
import 'package:king_jobs/config/util/shared_obects_controllers.dart';
import 'package:king_jobs/config/util/util.dart';
import 'package:king_jobs/models/user_service.dart';
import 'package:king_jobs/widgets/appbar.dart';
import 'package:king_jobs/widgets/custom_drop_down_menu.dart';
import 'package:king_jobs/widgets/custom_text_area.dart';
import 'package:king_jobs/widgets/custom_text_form_field.dart';
import 'package:king_jobs/widgets/go_elevated_btn.dart';
import 'package:king_jobs/widgets/international_phone_number.dart';
import 'package:king_jobs/widgets/password_form_field.dart';

class ApplyJob extends StatefulWidget {
  final int jobId;
  const ApplyJob({super.key, required this.jobId});

  @override
  State<ApplyJob> createState() => _ApplyJobState();
}

class _ApplyJobState extends State<ApplyJob> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _editPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _phoneExtController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _yearsExpController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cvController = TextEditingController();
  final TextEditingController _couponController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        Util.timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _editPasswordController.dispose();
    _phoneNumberController.dispose();
    _phoneExtController.dispose();
    _genderController.dispose();
    _jobController.dispose();
    _yearsExpController.dispose();
    _descriptionController.dispose();
    _cvController.dispose();
    _couponController.dispose();
    _imageController.dispose();
    super.dispose();
  }

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
                fontSize: 13.5,
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: MediaQuery.of(context).size.height / 90,
                      bottom: MediaQuery.of(context).size.height / 30,
                    ),
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
                              // bottom:
                              //     MediaQuery.of(context).size.height / 80
                            ),
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      UploadFile.getImage(
                                          context: context,
                                          controller: _imageController);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          11,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8.7,
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          right: MediaQuery.of(
                                                      context)
                                                  .size
                                                  .width /
                                              4,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/upload_picture.png"),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  CustomTextFormField(
                                    title: 'الاسم بالكامل',
                                    controller: _userNameController,
                                    isEnabled: true,
                                  ),
                                  CustomTextFormField(
                                    title: 'ايميل',
                                    controller: _emailController,
                                    isEnabled: true,
                                  ),
                                  InternationPhoneNumber(
                                    controller: _phoneExtController,
                                  ),
                                  PasswordFormField(
                                      controller: _passwordController,
                                      title: 'كلمة السر'),
                                  PasswordFormField(
                                      controller: _editPasswordController,
                                      title: 'تأكيد كلمة السر'),
                                  CustomDropdownMenu(
                                      title: 'الجنس',
                                      controller: _genderController),
                                  CustomTextFormField(
                                    title: 'نوع الوظيفة',
                                    controller: _jobController,
                                    isEnabled: true,
                                  ),
                                  CustomTextFormField(
                                    title: 'عدد سنوات الخبرة',
                                    controller: _yearsExpController,
                                    isEnabled: true,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      UploadFile.getFile(
                                          context: context,
                                          controller: _cvController);
                                    },
                                    child: CustomTextFormField(
                                      title: 'إرفاق السيرة الذاتية',
                                      controller: _cvController,
                                      isEnabled: false,
                                    ),
                                  ),
                                  CustomTextArea(
                                    title: 'الوصف',
                                    controller: _descriptionController,
                                  ),
                                  CustomTextFormField(
                                    title: 'ادخل كوبون الخصم',
                                    controller: _couponController,
                                    isEnabled: true,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                80),
                                    child: const Text(
                                        '* لإستكمال إجرادات الطلب يرجي الدفع بإحدي الطرق التالية:',
                                        style: TextStyle(
                                          color: secondColor,
                                          fontSize: 12,
                                          fontFamily: 'NotoKufiArabic',
                                        )),
                                  ),
                                  InkWell(
                                    child: Text(
                                        'التحويل البنكي - بوابة الدفع الإلكتروني',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                34,
                                        bottom:
                                            MediaQuery.of(context).size.height /
                                                60,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GoElevatedBtn(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (_passwordController
                                                          .text ==
                                                      _editPasswordController
                                                          .text) {
                                                    UserService user =
                                                        UserService(
                                                      firstName:
                                                          _userNameController
                                                              .text,
                                                      email:
                                                          _emailController.text,
                                                      gender: _genderController
                                                          .text,
                                                      phoneNumber:
                                                          _phoneNumberController
                                                              .text,
                                                      phoneExt:
                                                          _phoneExtController
                                                              .text,
                                                      job: _jobController.text,
                                                      yearsExp:
                                                          _yearsExpController
                                                              .text,
                                                      cv: _cvController.text,
                                                      image:
                                                          _imageController.text,
                                                      jobId: widget.jobId,
                                                      description:
                                                          _descriptionController
                                                              .text,
                                                      coupon: _couponController
                                                          .text,
                                                    );
                                                  }
                                                }
                                              },
                                              title: 'ارسال',
                                              btnColor: thirdColor,
                                              textColor: Colors.white),
                                        ],
                                      ))
                                ],
                              ),
                            ))));
              }
            }),
          ),
        ),
      ),
    );
  }
}
