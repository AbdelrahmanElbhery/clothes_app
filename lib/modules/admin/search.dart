import 'package:clothes_shop/models/usermodel.dart';
import 'package:clothes_shop/modules/admin/cubit/cubit.dart';
import 'package:clothes_shop/modules/admin/cubit/states.dart';
import 'package:clothes_shop/modules/admin/show_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_page/search_page.dart';

import '../../components/component.dart';

class SearchUsers extends StatelessWidget {
  const SearchUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateandfinish(context: context, widget: ShowUsers());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: Column(children: [
            FloatingActionButton(
              child: Icon(Icons.search),
              tooltip: 'Search people',
              onPressed: () => showSearch(
                context: context,
                delegate: SearchPage<UserModel>(
                  items: AdminCubit.get(context).usersmodel,
                  searchLabel: 'Search people',
                  suggestion: Center(
                    child: Text('Filter people by name, surname or age'),
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
                    title: Text(users.name!),
                    subtitle: Text(users.phone!),
                    trailing: Text('${users.email!}'),
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
