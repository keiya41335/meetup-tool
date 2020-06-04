import 'package:flutter/material.dart';
import 'dart:math' as math;

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

//SliderTimeControl
//initStateでタイマーを起動する
//startTimeを超えていればタイマー起動、endTimeまでの差分の時間を表示することで残り時間をカウントする
class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  static var nowTime = DateTime.now();
  static var _startTime = DateTime(2020, 6, 2, 17, 00);
  static var _endTime = DateTime(2020, 6, 4, 20, 00);
  static var duration = _endTime.difference(nowTime);
  int durationInSeconds = duration.inSeconds;
  var isAfter = nowTime.isAfter(_startTime);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void startTimer() {
    if (controller.isAnimating) {
      controller.stop(canceled: true);
    } else {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: durationInSeconds),
    );
    try {
      if (isAfter == true) {
        startTimer();
      }
    }catch(e){
      throw('Thanks for joining us! n\ The event will be commenced soon n\ Wait for it started');
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Align(
            alignment: FractionalOffset.center,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return CustomPaint(
                          painter: TimerPainter(
                            animation: controller,
                            backgroundColor: Colors.pinkAccent,
                            color: themeData.indicatorColor,
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.center,
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return Container(
                          child: Text(
                            timerString,
                            style: themeData.textTheme.headline2,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    //TODO: implment shouldRepaint
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
