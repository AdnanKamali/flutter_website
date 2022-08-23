import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/viewModel/token_view_model.dart';

import '../../size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final tokenViewModel = Provider.of<TokenViewModel>(context);
    return Scaffold(
      body: Container(
        child: _ui(tokenViewModel),
        // main background color
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.deepOrange.withOpacity(0.1),
            kPrimaryColor.withOpacity(0.1),
            Colors.deepOrange.withOpacity(0.1),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
      ),
    );
  }

  Widget _ui(TokenViewModel tokenViewModel) {
    if (tokenViewModel.loading) {
      return Center(
        child: Text("Is Loading"),
      );
    }
    return Body();
  }
}

/* Use This For Background Image*/

// Container(
//         child: Body(),
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage(
//                     UrlManager.images.url + "/" + "background_img.webp"),
//                 fit: BoxFit.cover)),
//       ),