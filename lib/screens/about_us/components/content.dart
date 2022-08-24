import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/size_config.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final style = TextStyle(fontSize: getProportionateScreenWidth(17));
    return Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: GlassContainer(
              margin: isDesktop ? null : EdgeInsets.only(bottom: 15, top: 5),
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
                          style: style,
                        ),
                        Text(
                            "امروز روز سه شنبه به تاریخ خودمون است و نمیشه فرار کرد",
                            style: style),
                        Text(
                          "از اعمال روز سه شنبه در ایران میشه به شکل زیر ذکر کرد",
                          style: style,
                        ),
                        Text(
                          "سخت کوشی و تلاش همیشه جواب میده هیج وقت امید خودتون رو از دست ندید",
                          style: style,
                        ),
                        Text(
                          "با توکل به خدا و پشت کار زیاد ختما موفق خواهی شد",
                          style: style,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "شماره کارگاه",
                              style: style,
                            ),
                            Text(
                              " : ",
                              style: style,
                            ),
                            Text(
                              "+98 917 952 1465",
                              style: style,
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "شماره تماس",
                              style: style,
                            ),
                            Text(
                              " : ",
                              style: style,
                            ),
                            Text(
                              "+98 917 952 1465",
                              style: style,
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        ),
                      ]))),
        ));
  }
}
