import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    @required this.currentPosition,
    @required this.duration,
    @required this.seekTo,
  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  Duration _visibleValue;
  bool listenOnlyUserInterraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          durationToString(widget.currentPosition),
          style: TextStyle(color: Colors.white, fontSize: size.height * 0.014),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.green,
              inactiveTrackColor: Colors.white,
              trackShape: RectangularSliderTrackShape(),
              trackHeight: 3.0,
              thumbColor: Colors.greenAccent,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.0),
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 8.0),
            ),
            child: Slider(
              //height: size.height * 0.007,
              //label: '${durationToString(widget.currentPosition).toString()}',
              min: 0,
              max: widget.duration.inMilliseconds.toDouble() ==
                      percent * widget.duration.inMilliseconds.toDouble()
                  ? percent * widget.duration.inMilliseconds.toDouble()
                  : widget.duration.inMilliseconds.toDouble(),
              value: widget.duration.inMilliseconds.toDouble() >=
                      percent * widget.duration.inMilliseconds.toDouble()
                  ? percent * widget.duration.inMilliseconds.toDouble()
                  : 0.0,
              /*style: SliderStyle(
                    disableDepth: true,
                    depth: 0.5,
                    //disableDepth: true,
                    variant: Colors.green,
                    accent: Colors.green[900]),*/
              onChangeEnd: (newValue) {
                setState(() {
                  listenOnlyUserInterraction = false;
                  widget.seekTo(_visibleValue);
                });
              },
              onChangeStart: (_) {
                setState(() {
                  listenOnlyUserInterraction = true;
                });
              },
              onChanged: (newValue) {
                setState(() {
                  final to = Duration(milliseconds: newValue.floor());
                  _visibleValue = to;
                });
              },
            ),
          ),
        ),
        Text(durationToString(widget.duration),
            style:
                TextStyle(color: Colors.white, fontSize: size.height * 0.014)),
      ],
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  String twoDigitSeconds =
      twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return "$twoDigitMinutes:$twoDigitSeconds";
}
