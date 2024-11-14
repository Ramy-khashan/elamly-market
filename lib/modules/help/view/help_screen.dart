import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/help_cubit.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelpCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Help"),
        ),
        body: BlocBuilder<HelpCubit, HelpState>(
          builder: (context, state) {
            final controller = HelpCubit.get(context);
            return ListView.builder(
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(controller.helpItem[index].title),
                  subtitle: Text(controller.helpItem[index].subTitle),
                  leading: Icon(controller.helpItem[index].leading),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: controller.helpItem[index].onTap,
                ),
              ),
              itemCount: controller.helpItem.length,
            );
          },
        ),
      ),
    );
  }
}
