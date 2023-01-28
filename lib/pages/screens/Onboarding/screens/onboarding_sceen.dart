import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/models/onboarding_model.dart';
import 'package:e_wallet_mobile_app/pages/screens/Onboarding/widgets/build_dot_indicator.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/main_auth_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/home/screens/localization_services.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_elevated_button.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:e_wallet_mobile_app/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
            child: Text(
              "${currentIndex + 1}/${onboardingModel.length}",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          actions: [

            TextButton(
              onPressed: () => Get.off(() => MainAuthScreen()),
              child: Text(
                "${AppLocalization.of(context).translate("skip")}",
                style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 500,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: onboardingModel.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Container(height:300,child: Lottie.asset(onboardingModel[index].imagePath)),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              Text(
                                onboardingModel[index].title,
                                style:
                                    Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                onboardingModel[index].subTitle,
                                style:
                                    Theme.of(context).textTheme.headline3!.copyWith(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildDotIndicator(position: 0, currentIndex: currentIndex),
                  BuildDotIndicator(position: 1, currentIndex: currentIndex),
                  BuildDotIndicator(position: 2, currentIndex: currentIndex),
                ],
              ),
              SizedBox(height: 20),
              if (currentIndex == 2)
                Container(
                  width: 300,
                  child: CustomElevatedButton(
                    onPressed: () => Get.off(() => MainAuthScreen()),
                    color: k_blue,
                    label: '${AppLocalization.of(context).translate("start")}',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

}
