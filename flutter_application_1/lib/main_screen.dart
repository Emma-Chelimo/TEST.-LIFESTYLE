import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/library_screen.dart';
import 'package:flutter_application_1/profile_screen.dart';
import 'package:flutter_application_1/search_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int _songCount = 0;
  late BannerAd _bannerAd;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ad ID
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  void _showInterstitialAd() {
    if (_songCount % 5 == 0 && _songCount != 0) {
      InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test ad ID
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            ad.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      // Mini player at the bottom
      persistentFooterButtons: [
        Container(
          color: Color(0xFF1E1E1E),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  'https://i.scdn.co/image/ab67616d00004851c96f7c7b077c224975b4c5ce',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Blinding Lights', style: TextStyle(color: Colors.white)),
                    Text('The Weeknd', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.purpleAccent),
                onPressed: () {
                  setState(() {
                    _songCount++;
                    _showInterstitialAd();
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BannerAd {
  BannerAd({
    required String adUnitId,
    required Size size,
    required AdRequest request,
    required BannerAdListener listener,
  });

  void load() {
    // Simulate ad loading
  }

  void dispose() {
    // Simulate ad disposal
  }
}

class BannerAdListener {
  final void Function(BannerAd ad) onAdLoaded;
  final void Function(BannerAd ad, LoadAdError error) onAdFailedToLoad;

  BannerAdListener({
    required this.onAdLoaded,
    required this.onAdFailedToLoad,
  });
}

class LoadAdError {
  final String message;

  LoadAdError(this.message);
}

class AdRequest {
  AdRequest();
}

class AdSize {
  static const Size banner = Size(320, 50);
}

// Mock InterstitialAd and related classes for testing purposes
class InterstitialAd {
  static void load({
    required String adUnitId,
    required AdRequest request,
    required InterstitialAdLoadCallback adLoadCallback,
  }) {
    // Simulate successful ad load after a delay
    Future.delayed(Duration(milliseconds: 100), () {
      adLoadCallback.onAdLoaded(InterstitialAd());
    });
  }

  void show() {
    // Simulate showing the ad
    print('InterstitialAd shown');
  }
}

class InterstitialAdLoadCallback {
  final void Function(InterstitialAd ad) onAdLoaded;
  final void Function(LoadAdError error) onAdFailedToLoad;

  InterstitialAdLoadCallback({
    required this.onAdLoaded,
    required this.onAdFailedToLoad,
  });
}