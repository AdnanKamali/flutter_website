import 'package:flutter/cupertino.dart';
import 'package:shop_app/utils/widgets/images_changer/dots.dart';
import 'package:shop_app/utils/widgets/images_changer/next_pervios_button.dart';

class ImageChanger extends StatefulWidget {
  const ImageChanger({Key? key}) : super(key: key);

  @override
  State<ImageChanger> createState() => _ImageChangerState();
}

class _ImageChangerState extends State<ImageChanger> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NextProvios(),
        DotsBanner(),
      ],
    );
  }
}
