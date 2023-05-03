
import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/widgets/loader/custom_ticker.dart';

class CustomAnimationProvider extends ChangeNotifier {

  CustomAnimationProvider(){
    _myTickerProvider = MyTickerProvider();
    getCustomAnimation();
  }


  MyTickerProvider? _myTickerProvider;

  AnimationController? _animationController;
  Animation? _sizeAnimationOne;
  Animation? _sizeAnimationTwo;

  Animation? get sizeAnimationOne => _sizeAnimationOne;
  Animation? get sizeAnimationTwo => _sizeAnimationTwo;


  void getCustomAnimation(){
    _animationController = AnimationController(vsync: _myTickerProvider!,duration: const Duration(seconds: 1));
    final animation = CurvedAnimation(parent: _animationController!, curve: Curves.ease);
    _sizeAnimationOne = Tween(begin: 0.0,end: 80).animate(animation)..addListener(() {notifyListeners();});

    _animationController!.repeat();

  }


}