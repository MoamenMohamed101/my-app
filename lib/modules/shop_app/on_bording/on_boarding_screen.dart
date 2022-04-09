import 'package:first_app/modules/shop_app/shop_app_login/shop_app_login.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/network/remote/cash_helper.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding {
  String? image;
  String? titel;
  String? body;
  OnBoarding(this.image, this.titel, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoarding> boarding = [
    OnBoarding(
        'assets/images/download_1.jpg', 'Screen Titel 1', 'Screen Body 1'),
    OnBoarding(
        'assets/images/download_1.jpg', 'Screen Titel 2', 'Screen Body 2'),
    OnBoarding(
        'assets/images/download_1.jpg', 'Screen Titel 3', 'Screen Body 3'),
  ];

  var controller = PageController();
  bool islast = false;
  void onsubmit() {
    CashHelper.savedata(key: 'onBoarding', value: true)!.then((value) {
      if (value == true) {
        NavigateAndFinsh(
          context: context,
          widget: ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: onsubmit,
            child: const Text(
              'Skip',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    print('last');
                    setState(() {
                      islast = true;
                    });
                  } else {
                    print('not last');
                    setState(() {
                      islast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: controller,
                itemBuilder: (context, index) =>
                    BuildBordingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 16,
                      expansionFactor: 3,
                      dotWidth: 16,
                      spacing: 8,
                      activeDotColor: primryswatsh),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      onsubmit();
                    } else {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_outlined),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  BuildBordingItem(OnBoarding model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          Text(
            '${model.titel}',
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${model.body}',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
}
