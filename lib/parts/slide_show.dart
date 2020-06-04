import 'package:flutter/material.dart';
import 'dart:async';

class Slide extends StatefulWidget {
  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  //SliderTimeControl
  //initStateでタイマーを起動する
  //startTimeを超えていればタイマー起動、endTimeまでの差分の時間を表示することで残り時間をカウントする

  int _counter = 10;
  Timer _timer;
  static var nowTime = DateTime.now(); //現在の時間
  static var _startTime = DateTime(2020, 5, 31, 17, 00); //イベントスタートの時間
  static var _endTime = DateTime(2020, 5, 31, 21, 30); //イベント終了の時間
  static var duration = _endTime.difference(nowTime); //現在からイベント終了までの差分(残り時間)
  int durationInMinutes = duration.inMinutes; //残り時間を「分」で表す

  var isAfter = nowTime.isAfter(_startTime); //現在がイベントスタート時間を過ぎているかどうか
  int slideNumber = 0;

  PageController pageController;


  @override
  void initState() {
    _startTimer();
    pageController = PageController(initialPage: slideNumber, viewportFraction: 0.9);
    super.initState();


    print('$durationInMinutes minutes left');
  }

  int _startTimer() {

    _counter = durationInMinutes;
    if (_timer != null) {
      _timer.cancel();
    }


    _timer =  Timer.periodic(Duration(minutes: 1), (_) {



      setState(() {
        if (_counter > 0 && isAfter == true) {
          _counter--;
        }
        else {
          _timer.cancel();
        }

        if(_counter <= 5){
          pageController.jumpToPage(3);

        } else if (_counter <= 25){
          pageController.jumpToPage(2);

        }else if (_counter <= 27){
          pageController.jumpToPage(1);

        }else if (_counter < 28){
          pageController.jumpToPage(0); //TODO slideNumber = 0　のパターンもある
        }
        print('Counter is now $_counter');


      });
    }

    );

    if(_counter <= 5){
      slideNumber = 3;

    } else if (_counter <= 25){
      slideNumber =2;

    }else if (_counter <= 27){
      slideNumber = 1;

    }else if (_counter < 28){
      slideNumber = 0;
    }
    return slideNumber;
  }


  List<String> images = [
    'assets/スクリーンショット 2020-05-07 午後0.17.35.png',
    'assets/スクリーンショット 2020-05-07 午後3.10.57.png',
    'assets/スクリーンショット 2020-05-07 午後3.11.05.png',
    'assets/スクリーンショット 2020-05-07 午後0.17.59.png',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: pageController,
          itemCount: images.length,
          itemBuilder: (context, position) {
            return imageSlider(position);
          }),
    );
  }

  imageSlider(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return SizedBox(
          height: Curves.easeInOut.transform(value) * 200,
          width: Curves.easeInOut.transform(value) * 300,
          child: widget,
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),

        child:Image.asset(images[index], fit: BoxFit.cover),


      ),
    );
  }
}


