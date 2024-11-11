import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'main.dart';

void main() {
  runApp(const BloodDonationApp());
}

class BloodDonationApp extends StatelessWidget {
  const BloodDonationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Donation Info',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const BloodDonationInfoPages(),
    );
  }
}

class BloodDonationInfoPages extends StatefulWidget {
  const BloodDonationInfoPages({Key? key}) : super(key: key);

  @override
  _BloodDonationInfoPagesState createState() => _BloodDonationInfoPagesState();
}

class _BloodDonationInfoPagesState extends State<BloodDonationInfoPages> {
  final PageController _pageController = PageController();

  void _nextPage() {
    if (_pageController.page != 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Disable swipe
            children: [
              // Page 1 - Lottie Animation with Next Button
              Stack(
                children: [
                  Container(
                    color: Color(0xfffbf0fb),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/json/Animation.json', // Add your Lottie JSON file here
                            height: 250,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Donate Blood, Save Lives",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: TextButton(
                      onPressed: _nextPage,
                      child: const Text("Next"),
                    ),
                  ),
                ],
              ),

              // Page 2 - Information with Background Image and Next Button
              Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      'assets/images/bg1.jpg', // Add your background image here
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Why Donate Blood?",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Blood donation helps save lives and improves health. Each donation can save up to three lives!",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: TextButton(
                      onPressed: _nextPage,
                      child: const Text("Next"),
                    ),
                  ),
                ],
              ),

              // Page 3 - Information with Background Image and Finish Button
              Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      'assets/images/bg2.jpg', // Add your background image here
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Who Can Donate?",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Anyone in good health, aged 18-65, and meeting eligibility criteria can donate blood.",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                          return RegistrationForm();
                        }) );
                      },
                      child: const Text("Finish"),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Smooth Page Indicator
          Positioned(
            bottom: 20,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: WormEffect(
                activeDotColor: Colors.red,
                dotHeight: 10,
                dotWidth: 10,
                spacing: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
