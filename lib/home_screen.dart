import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:ui';
import 'dart:math';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioCache();

  //ADVERTISEMENT
  late InterstitialAd _interstitialAd;
  bool _interstitialLoaded = false;

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-7895476323381804/9913925567",
      request: const AdRequest(),

      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _interstitialLoaded = true;
            createInterstitialAd();
          },
          onAdFailedToLoad: (LoadAdError error) {
            _interstitialAd.dispose();
            _interstitialLoaded = false;
            createInterstitialAd();
          }
      ),
    );
  }

  void voicePlayer(String voiceName) {
    player.play(voiceName);
  }

  //RANDOM NUMBER FOR ADVERTISEMENT
  int createrNumber() {
    int min = 0;
    int max = 34;
    var randomNumber = Random();
    int newRandomNumber = min + randomNumber.nextInt(max - min);
    return newRandomNumber;
  }

  @override
  void initState() {
    super.initState();
    MobileAds.instance.initialize().then((InitializationStatus status) {
      MobileAds.instance.updateRequestConfiguration(RequestConfiguration(maxAdContentRating:"G",tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes )).then((value) {
        createInterstitialAd();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    int newNumberFirst = createrNumber();
    int newNumberSecond = createrNumber();
    int newNumberThird = createrNumber();

    List<String> Names = [
      'ASLAN',
      'ARI',
      'AT',
      'AYI',
      'BOĞA',
      'DOMUZ',
      'EŞEK',
      'FARE',
      'FİL',
      'FOK',
      'HOROZ',
      'İNEK',
      'KAPLAN',
      'KARGA',
      'KAZ',
      'KEÇİ',
      'KEDİ',
      'KOYUN',
      'KÖPEK',
      'KURBAĞA',
      'KURT',
      'KUŞ',
      'MAYMUN',
      'ÖRDEK',
      'PENGUEN',
      'SİNCAP',
      'SİNEK',
      'TAVŞAN',
      'TAVUK',
      'TİMSAH',
      'YARASA',
      'YILAN',
      'YUNUS',
      'ZÜRAFA'
    ];

    return Scaffold(
      backgroundColor: Colors.limeAccent,
      body: ListView.builder(
          itemCount: 34,
          itemBuilder: (context, index) {
            var containers = Names.map((name) => Padding(
                padding: const EdgeInsets.only(
                    left: 35.0, right: 35.0, top: 30, bottom: 30),
                child: Container(
                    child: buildAnimalVoice(
                        name,
                        index,
                        newNumberFirst,
                        newNumberSecond,
                        newNumberThird,
                        sizeScreen)))).toList();

            return containers[index];
          }),
    );
  }

  TextButton buildAnimalVoice(String name, var index, int newNumberFirst,
      int newNumberSecond, int newNumberThird, Size sizeScreen) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
        shadowColor: Colors.black87,
        side: const BorderSide(color: Colors.black54, width: 4),
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.amberAccent,
      ),
      onPressed: () {
        voicePlayer('$name.wav');
        if (newNumberFirst == index ||
            newNumberSecond == index ||
            newNumberThird == index) {
          createInterstitialAd();
          _interstitialAd.show();
        }
      },
      child: SafeArea(
        child: SizedBox(
          width: (sizeScreen.height > sizeScreen.width)
              ? sizeScreen.width * (0.55)
              : sizeScreen.width * (0.30),
          height: (sizeScreen.height > sizeScreen.width)
              ? sizeScreen.height * (0.35)
              : sizeScreen.height * (0.70),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(' $name',
                          style: const TextStyle(
                              fontFamily: 'AkayaTelivigala',
                              fontWeight: FontWeight.bold,
                              fontSize: 33,
                              color: Colors.black87)),
                      const Icon(
                        Icons.volume_up,
                        color: Colors.black87,
                        size: 45,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(flex: 6, child: Image.asset('assets/$name.png')),
            ],
          ),
        ),
      ),
    );
  }
}
