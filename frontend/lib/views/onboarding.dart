import 'package:flutter/material.dart';
import 'package:frontend/views/login_try.dart';
import 'package:frontend/widgets/common/elevated_button_widget.dart';
import 'package:frontend/widgets/onboarding_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:frontend/utils/text_strings.dart';
import 'package:frontend/features/authentication/model/onboarding_model.dart';
import "package:smooth_page_indicator/smooth_page_indicator.dart";
 
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();

  int currentPage = 0;

  onPageChangedCallback(int activePageIndex) {
      setState(() {
        currentPage = activePageIndex;
      });

      if (currentPage > 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final pages= [
      //Widget for page 1
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onBoardingImage1,
          title: onBoardingTitle1,
          subTitle: onBoardingSubTitle1,
          counterText: onBoardingCounter1,
          height: deviceSize.height,
          bgColor: onBoardingColorPage1,
          width: deviceSize.width
        ),
      ),

      //Widget for Page 2
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onBoardingImage2,
          title: onBoardingTitle2,
          subTitle: onBoardingSubTitle2,
          counterText: onBoardingCounter2,
          height: deviceSize.height,
          bgColor: onBoardingColorPage2,
          width: deviceSize.width
        ),
      ),

      //Widget for Page 3
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onBoardingImage3,
          title: onBoardingTitle3,
          subTitle: onBoardingSubTitle3,
          counterText: onBoardingCounter3,
          height: deviceSize.height,
          bgColor: onBoardingColorPage3,
          width: deviceSize.width
        ),
      ),

      //Widget for Page 4
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onBoardingImage4,
          title: onBoardingTitle4,
          subTitle: onBoardingSubTitle4,
          counterText: onBoardingCounter4,
          height: deviceSize.height,
          bgColor: onBoardingColorPage4,
          width: deviceSize.width
        ),
      ),
    ];


    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children : [
          LiquidSwipe(
            pages: pages,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
            liquidController: controller,
            onPageChangeCallback: onPageChangedCallback,
          ),

          if (currentPage != 3)
            Positioned(
              bottom: 70,

              child: OutlinedButton(
                onPressed: (){ 
                  int nextPage = controller.currentPage +1;
                  controller.animateToPage(page: nextPage);
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.black26),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  foregroundColor: Colors.white,
                ), 
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: darkColor, 
                    shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),

            if (currentPage != 3)
              Positioned(
                bottom: 20,
                child: TextButton(
                  onPressed: (){
                    controller.jumpToPage(page: 3);
                  }, 
                  child: const Text("Skip", style: TextStyle(color:Colors.grey)),
                ),
              ),
    

            if (currentPage == 3)
              Positioned(
                bottom: 100,
                child: SizedBox(
                  width: 300,
                  child: ElevatedButtonWidget(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    buttonName: getStarted,
                  ),
                ),
              ),
          

            Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentPage,
                count: 4,
                effect: const WormEffect(
                  activeDotColor: Color(0xff272727),
                  dotHeight: 5.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

