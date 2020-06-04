import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:ui' as ui;
import 'iFrame_screenquery.dart';

class IFrame extends StatefulWidget {
  const IFrame({Key key}) : super(key: key);

  @override
  _IFrameState createState() => _IFrameState();
}

class _IFrameState extends State<IFrame> {
  Widget _iFrameWidget;

  final IFrameElement _iFrameElement = IFrameElement();
  final _screenQueries = ScreenQueries.instance;

  @override
  void initState() {
    super.initState();

    _iFrameElement.height = '500';
    _iFrameElement.width = '500';

    _iFrameElement.src = 'https://ejje.weblio.jp/';
//    https://www.youtube.com/embed/KqTG85G1JQ0
    _iFrameElement.style.border = 'none';

//     ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
          (int viewId) => _iFrameElement,
    );

    _iFrameWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  Widget build(BuildContext context) {
    final _width = _screenQueries.customWidthPercent(context, 1.0);
    final _height = _screenQueries.customHeightPercent(context, 0.9);

    return Scaffold(
      body: SizedBox(
        height: _height,
        width: _width,
        child: _iFrameWidget,
      ),
    );
  }
}
