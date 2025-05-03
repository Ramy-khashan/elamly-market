import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/contact_method.dart';
import '../model/help_model.dart';

part 'help_state.dart';

class HelpCubit extends Cubit<HelpState> {
  HelpCubit() : super(HelpInitial());
  static HelpCubit get(context) => BlocProvider.of(context);
  List<HelpModel> helpItem = [
    HelpModel(
        title: 'Contact Over Call',
        leading: Icons.call,
        subTitle: 'Call our customer support',
        onTap: ()async {
          print("object");
          await Contact.callUs();
        }),
    HelpModel(
        title: 'Contact Over WhatsApp',
        leading: Icons.wechat,
        subTitle: 'Message our customer support',
        onTap: () async {
          await
          Contact.contactUsWhatsApp();
        }),
  ];
}
