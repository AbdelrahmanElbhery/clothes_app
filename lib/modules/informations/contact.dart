import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bottomnav.dart';
import '../../components/component.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/states.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> title = [
      'للتواصل',
      'البريد الالكترونى',
      'ساعات العمل',
      'العنوان',
    ];
    List<String> title2 = [
      '+20112 083 0411',
      'abdelrahmanelbhery22@gmail.com',
      'يوميا من 12:00م الي 01:00ص ما عدا الجمعة اجازة',
      'المحلة الكبرى الدوران',
    ];
    List<IconData> icons = [
      Icons.phone,
      Icons.mail,
      Icons.av_timer_outlined,
      Icons.location_on
    ];

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0,
            elevation: 3,
            leading: IconButton(
                onPressed: () {
                  navigateandfinish(context: context, widget: BottomNav());
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            title: Text(
              'تواصل معنا',
              style: TextStyle(
                  color: Colors.black.withOpacity(.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          makePhoneCall();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.width * .19,
                          child: Card(
                            color: Colors.greenAccent,
                            child: Icon(Icons.phone),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launchfacebook();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.width * .19,
                          child: Card(
                            color: HexColor('#2879FE'),
                            child: Icon(Icons.facebook),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await launchUrl(
                              Uri.parse('http://m.me/boody.elbhery'),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.width * .19,
                          child: Card(
                            color: HexColor('#8B6AFD'),
                            child: Icon(MdiIcons.facebookMessenger),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await launchUrl(
                              Uri.parse('https://wa.me/201120830411'),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.width * .19,
                          child: Card(
                            color: Colors.green,
                            child: Icon(MdiIcons.whatsapp),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await launchUrl(
                              Uri.parse(
                                  'mailto:abdelrahmanelbhery22@gmail.com?subject=start &body=begin'),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.width * .19,
                          child: Card(
                            color: Colors.white38,
                            child: Icon(MdiIcons.gmail),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          article(title[index], title2[index], icons[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 13,
                          ),
                      itemCount: 4),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .3,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .25,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      InkWell(
                        onTap: () {
                          launchgps();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .23,
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/map.jpg')),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  size: 20,
                                  Icons.cancel_outlined,
                                  color: Colors.blue,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'المحلة الكبرى , الدوران',
                                style: TextStyle(
                                    fontSize: 14, color: HexColor('#959DAD')),
                              ),
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * .04,
                          width: MediaQuery.of(context).size.width * .45,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget article(String title, String title2, IconData icon) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      title2,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  icon,
                  color: HexColor('#4A4B4D'),
                  size: 35,
                )
              ],
            ),
          ),
        ),
      );

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '+201120830411',
    );
    await launchUrl(launchUri);
  }

  Future<void> launchfacebook() async {
    final Uri url = Uri.parse('https://www.facebook.com/boody.elbhery');
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchgps() async {
    final Uri url = Uri.parse('https://goo.gl/maps/bbxV9ZWt4YZ3ogdC6');
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> messenger() async {
    final Uri url = Uri.parse("http://m.me/boody.elbhery");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
