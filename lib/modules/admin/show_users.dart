import 'package:clothes_shop/modules/admin/admin_home.dart';
import 'package:clothes_shop/modules/admin/cubit/cubit.dart';
import 'package:clothes_shop/modules/admin/cubit/states.dart';
import 'package:clothes_shop/modules/admin/user_favourites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_page/search_page.dart';

import '../../components/component.dart';
import '../../models/usermodel.dart';

class ShowUsers extends StatelessWidget {
  const ShowUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateandfinish(context: context, widget: AdminHome());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            title: Text(
              'Users',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                onPressed: () => showSearch(
                  context: context,
                  delegate: SearchPage<UserModel>(
                    items: AdminCubit.get(context).usersmodel,
                    searchLabel: 'Search people',
                    suggestion: Center(
                      child: Text('Filter people by name, phone or email'),
                    ),
                    failure: Center(
                      child: Text('No person found :('),
                    ),
                    filter: (users) => [
                      users.name,
                      users.phone,
                      users.email,
                    ],
                    builder: (users) => ListTile(
                      onTap: () {
                        AdminCubit.get(context).getFavid(users.uid);
                        AdminCubit.get(context).getFav(users.uid);
                        navigate_to(
                            context: context,
                            widget: UserFavourites(username: users.name));
                      },
                      title: Text(users.name!),
                      subtitle: Text(users.phone!),
                      trailing: Text('${users.email!}'),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
                itemBuilder: (context, index) => usersview(
                    context, AdminCubit.get(context).usersmodel[index]),
                separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                itemCount: AdminCubit.get(context).usersmodel.length),
          ),
        );
      },
    );
  }

  Widget usersview(context, UserModel model) => InkWell(
        onTap: () {
          AdminCubit.get(context).getFavid(model.uid);
          AdminCubit.get(context).getFav(model.uid);
          navigate_to(
              context: context, widget: UserFavourites(username: model.name));
        },
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .15,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 8,
            child: Column(
              children: [
                Text(
                  model.name!,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .005,
                ),
                Text(
                  model.phone!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .005,
                ),
                Text(model.email!, style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          ),
        ),
      );
}
