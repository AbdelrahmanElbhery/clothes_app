import 'package:clothes_shop/components/component.dart';
import 'package:clothes_shop/modules/informations/settings.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 3,
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
          ],
        ),
        title: Text(
          'الاشعارات',
          style: TextStyle(
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.bold,
              fontSize: 25),
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                navigateandfinish(context: context, widget: SettingsAbout());
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => article(index % 2 != 0),
                separatorBuilder: (context, index) => SizedBox(
                      height: 13,
                    ),
                itemCount: 13),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget article(bool condition) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          color: condition ? Colors.grey[200] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'تخفيضات اليوم من سنتر ديفا بمنسابة الجمعة البيضاء',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 7,
                    ),
                  ],
                ),
                Text('3.5 am'),
              ],
            ),
          ),
        ),
      );
}
