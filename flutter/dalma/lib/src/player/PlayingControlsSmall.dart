import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PlayingControlsSmall extends StatelessWidget {
  final bool isPlaying;
  final LoopMode loopMode;
  final Function() onPlay;
  final Function() onStop;
  final Function() toggleLoop;

  PlayingControlsSmall({
    @required this.isPlaying,
    @required this.loopMode,
    this.toggleLoop,
    @required this.onPlay,
    this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        /*NeumorphicRadio(
          style: NeumorphicRadioStyle(
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: EdgeInsets.all(12),
          value: LoopMode.playlist,
          groupValue: this.loopMode,
          child: Icon(
            Icons.loop,
            size: 18,
          ),
          onChanged: (newValue) {
            toggleLoop();
          },
        ),
        SizedBox(
          width: 12,
        ),*/
        NeumorphicButton(
          style: NeumorphicStyle(
              color: Colors.white,
              boxShape: NeumorphicBoxShape.circle(),
              disableDepth: true),
          padding: EdgeInsets.all(size.height * 0.005),
          onPressed: this.onPlay,
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: size.height * 0.026,
          ),
        ),
        if (onStop != null)
          NeumorphicButton(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            padding: EdgeInsets.all(16),
            onPressed: this.onPlay,
            child: Icon(
              Icons.stop,
              size: 32,
            ),
          ),
      ],
    );
  }
}
