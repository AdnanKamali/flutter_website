import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/user_view_model.dart';

import '../../../utils/resource_manager/widgets.dart';

class ProfilePic extends StatelessWidget {
  final String phoenNumber;
  final String fullName;
  const ProfilePic({
    Key? key,
    required this.phoenNumber,
    required this.fullName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final translate = DemoLocalizations.of(context).translate;
    final isDesktop = Responsive.isDesktop(context);
    return Column(
      children: [
        Text(
          phoenNumber,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(24), color: Colors.black87),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              fullName,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: Colors.grey),
            ),
            IconButton(
                onPressed: () async {
                  await sign_up(
                      context,
                      [
                        updateFullName(
                          userViewModel,
                          translate,
                        )
                      ],
                      getProportionateScreenHeight(500) - (isDesktop ? 0 : 80),
                      Text(translate("change name")));
                },
                icon: Icon(Icons.edit_outlined))
          ],
        ),
      ],
    );
  }
}

// extension StringExtention on String {
//   String toCapitaliza() =>
//       "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
// }
