import 'dart:async';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'sidebar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;
  final List<String> images = [
    "images/slider0.webp",
    "images/slider1.webp",
    "images/slider2.webp",
    "images/home3.jpg",
  ];

  int activePage = 0;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    startAutoSlide();
    super.initState();
  }

  void startAutoSlide() {
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        setState(() {
          activePage = (activePage + 1) % images.length;
        });
        _pageController.animateToPage(
          activePage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  List<Widget> buildIndicators() {
    return List<Widget>.generate(images.length, (index) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: activePage == index ? Colors.teal : Colors.grey,
        ),
      );
    });
  }

  Widget buildSliderImage(String image, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: isActive ? 8 : 16, vertical: isActive ? 12 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const NavDrawer(),
      appBar: AppBar(
        toolbarHeight: 80,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartList()),
              );
            },
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'M',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            Image.asset(
              '../images/watch_logo.jpg',
              width: 60,
              height: 60,
            ),
            const Text(
              'R',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Slider Section
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    activePage = index;
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) {
                  bool isActive = index == activePage;
                  return buildSliderImage(images[index], isActive);
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildIndicators(),
            ),

            const SizedBox(height: 30),
            // Featured Brands Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Featured Brands',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'From the biggest design brands to the best of luxury and hidden gems.',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      ...List.generate(
                        4,
                            (index) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            '../images/brand${index + 1}.jpg',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
