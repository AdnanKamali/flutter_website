import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: GlassContainer(
            transformAlignment: Alignment.center,
            width: 900,
            blur: 0.5,
            child: Card(
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                margin: EdgeInsets.symmetric(vertical: 100, horizontal: 60),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "سلام وقت بخیر خدمت دوستان و همراهان عزیز",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "امروز روز سه شنبه به تاریخ خودمون است و نمیشه فرار کرد",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "از اعمال روز سه شنبه در ایران میشه به شکل زیر ذکر کرد",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "سخت کوشی و تلاش همیشه جواب میده هیج وقت امید خودتون رو از دست ندید",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "با توکل به خدا و پشت کار زیاد ختما موفق خواهی شد",
                        style: TextStyle(fontSize: 24),
                      ),
                      // TODO: wrap two text in row, phone text direction left to right
                      Text(
                        "شماره کارگاه: +98 917 123 4567",
                        style: TextStyle(fontSize: 24),
                      ),

                      Text(
                        " +98 917 123 4567 :شماره تماس ",
                        style: TextStyle(fontSize: 24),
                      ),
                    ]))));
  }
}
