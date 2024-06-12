import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Yandex ads'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();
    MobileAds.setUserConsent(true);
    MobileAds.setAgeRestrictedUser(true);
    MobileAds.initialize();
  }
BannerAdSize getAdSize(){
final screenWidth= MediaQuery.sizeOf(context).width.round();
return BannerAdSize.sticky(width: screenWidth);
}

  late BannerAd banner;
  var isBannerAlreadyCreated = false;

  _loadAd() async {
    banner = _createBanner();
    setState(() {
      isBannerAlreadyCreated = true;
    });
    //banner.loadAd(adRequest: const AdRequest());
  }

_createBanner(){
    return BannerAd(adUnitId: 'R-M-9298488-1', adSize: getAdSize(),
    adRequest: const AdRequest(),
    onAdLoaded: (){
      if(!mounted){
        banner.destroy();
        return;
      }
    }
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: isBannerAlreadyCreated? AdWidget(bannerAd: banner,) : null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadAd,
        tooltip: 'Load Ad',
        child: const Icon(Icons.image),
      ),
    );
  }
}
