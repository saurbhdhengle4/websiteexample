import 'package:flutter/material.dart';
import 'package:website_link2/widgets/bottom_bar.dart';
import 'package:website_link2/widgets/carousel.dart';
import 'package:website_link2/widgets/featured_heading.dart';
import 'package:website_link2/widgets/featured_tiles.dart';
import 'package:website_link2/widgets/floating_quick_access_bar.dart';
import 'package:website_link2/widgets/main_heading.dart';
import 'package:website_link2/widgets/menu_drawer.dart';
import 'package:website_link2/widgets/top_bar_contents.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      //https://api.flutter.dev/flutter/widgets/PreferredSize-class.html
      appBar: screenSize.width < 800
          ? AppBar(
              backgroundColor: Colors.white.withOpacity(_opacity),
              iconTheme: const IconThemeData(color: Colors.blue),
              elevation: 0,
              title: const Text(
                'Author',
                style: TextStyle(
                  color: Color(0xFF077bd7),
                  fontSize: 26,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
            )
          : PreferredSize(
              child: TopBarContents(_opacity),
              preferredSize: Size(screenSize.width, 78),
            ),
      drawer:
          const MenuDrawer(), //defult a drawer automatic goan  for incress a size
      body: SingleChildScrollView(
        controller: _scrollController, //opacity not a tranprent use this
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: SizedBox(
                    height: screenSize.height * 0.65,
                    width: screenSize.width,
                    child: Image.asset(
                      'assets/images/background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    FloatingQuickAccessBar(screenSize: screenSize),
                    FeaturedHeading(screenSize: screenSize),
                    FeaturedTiles(screenSize: screenSize),
                    MainHeading(screenSize: screenSize),
                    MainCarousel(),
                    SizedBox(height: screenSize.height / 10),
                    const BottomBar(),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
