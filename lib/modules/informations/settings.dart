import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../components/component.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/states.dart';
import 'about_us.dart';
import 'contact.dart';

class SettingsAbout extends StatelessWidget {
  const SettingsAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'المقالات',
      'اتصل بنا',
      'من نحن',
      'تسجيل الخروج',
    ];
    List<IconData> icons = [
      Icons.article,
      MdiIcons.phone,
      MdiIcons.information,
      MdiIcons.exitToApp
    ];

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (contetx, state) {},
      builder: (contetx, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/clothes_logo.png'))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Clothes Shop',
                    style: TextStyle(
                        color: HexColor('#49155B'),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  setings(context, 'اتصل بنا', MdiIcons.phone, () {
                    navigate_to(context: context, widget: ContactUs());
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  setings(context, 'من نحن', MdiIcons.information, () {
                    navigate_to(context: context, widget: AboutScreen());
                  }),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget setings(context, String title, IconData icon, var func) => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .08,
            width: MediaQuery.of(context).size.width * .9,
          ),
          InkWell(
            onTap: func,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              height: MediaQuery.of(context).size.height * .07,
              width: MediaQuery.of(context).size.width * .85,
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: HexColor('#D8D8D8'),
              child: Icon(
                icon,
                color: HexColor('#4A4B4D'),
              ),
            ),
          )
        ],
      );
}
