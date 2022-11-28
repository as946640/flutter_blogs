import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LinkIcon extends StatefulWidget {
  late bool islink;
  LinkIcon({Key? key, required this.islink}) : super(key: key);

  @override
  State<LinkIcon> createState() => _LinkIconState();
}

class _LinkIconState extends State<LinkIcon> with TickerProviderStateMixin {
  late AnimationController lotineControll;

  Widget _buildLink() {
    if (!widget.islink) {
      return const Icon(
        IconData(0xe647, fontFamily: 'home'),
      );
    } else {
      return Lottie.asset(
        'assets/lottie/link.json',
        repeat: false,
        controller: lotineControll,
        onLoaded: (composition) {
          lotineControll.duration = composition.duration;
          lotineControll.forward();
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    lotineControll = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.islink = true;
          lotineControll.forward();
        });
      },
      child: SizedBox(
        width: 50,
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Offstage(
              offstage: widget.islink,
              child: const Icon(
                IconData(0xe647, fontFamily: 'home'),
              ),
            ),
            Offstage(
              offstage: !widget.islink,
              child: Lottie.asset(
                'assets/lottie/link.json',
                repeat: false,
                controller: lotineControll,
                onLoaded: (composition) {
                  lotineControll.duration = composition.duration;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    lotineControll.dispose();
    super.dispose();
  }
}
