class OnboardingContents {
  final String title;
  final String image;

  OnboardingContents({
    required this.title,
    required this.image,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: 'بحث سهل وسريع عن أحدث\n  الوظائف الشاغرة',
    image: "assets/images/onboarding1.png",
  ),
  OnboardingContents(
    title: "ابحث عن الوظائف الشاغرة في \n أفضل الشركات",
    image: "assets/images/onboarding2.png",
  ),
  OnboardingContents(
    title: "سهولة الوصول لاي وظيفة \n في البلدان العربية",
    image: "assets/images/onboarding3.png",
  ),
];
