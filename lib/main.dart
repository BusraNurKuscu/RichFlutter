import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rich/variklar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'kar_zarar.dart';
import 'models/rich-model.dart';

List<RichModel> richModel = <RichModel>[];
double girisYapilanTopamSabitKurTutar = 0.0;
double girisYapilanTopamDoviz = 0.0;
double girisYapilanTopamTLTutar = 0.0;
double sabitKur = 17.17;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rich',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Rich'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PersistentTabController _controller;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    getLocalData();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rich"),
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        hideNavigationBar: false,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _buildScreens() {
    return [KarZarar(), Varliklar()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chart_bar_fill),
        title: ("Kar/Zarar"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.plus),
        title: ("Varlıklar"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  getLocalData() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      var data = prefs.getString('data');
      if(data != null && data != ""){
        richModel =  RichModel.decode(data);
        richModel.forEach((element) { element.tutar = element.tutar ?? 0; });
      }else{
        richModel = <RichModel>[];
      }

      var mapTL = richModel
          .where((element) => element.varlikTipi == "TL")
          .map((e) => e.tutar).toList();

      if (mapTL.isNotEmpty) {
        girisYapilanTopamTLTutar =  mapTL.reduce((value, element) => (value ?? 0) + (element ?? 0))!;
      }

      var mapDoviz = richModel
          .where((element) => element.varlikTipi != "TL")
          .map((e) => (e.tutar ?? 0) * (e.birimMaliyet ?? 1)).toList();

      if (mapDoviz.isNotEmpty ) {
        girisYapilanTopamDoviz =  mapDoviz.reduce((value, element) => (value ?? 0) + ((element ?? 0)))!;
      }

      var mapDovizSabitKur = richModel
          .where((element) => element.varlikTipi != "TL")
          .map((e) => (e.tutar ?? 0) * sabitKur).toList();
      if (mapDovizSabitKur.isNotEmpty ) {
        girisYapilanTopamSabitKurTutar =  mapDovizSabitKur.reduce((value, element) => (value ?? 0) + ((element ?? 0)))!;
      }

    });
    }
}
