import 'package:elamlymarket/core/components/app_button.dart';
import 'package:elamlymarket/core/components/app_text_field.dart';
import 'package:elamlymarket/core/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/loading_item.dart';
import '../controller/reports_cubit.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Reports'),
          ),
          body: BlocBuilder<ReportsCubit, ReportsState>(
            builder: (context, state) {
              final controller = ReportsCubit.get(context);
              return Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            AppTextField(
                              horizontal: 5,
                              onValidate: (val) => Validate.notEmpty(val),
                              controller: controller.reporterName,
                              label: "Full Name",
                            ),  AppTextField(
                              horizontal: 5,
                              onValidate: (val) => Validate.validateEgyptPhoneNumber(val),
                              controller: controller.reportPhone,
                              label: "Phone to contact",
                            ),
                            AppTextField(
                              horizontal: 5,
                              onValidate: (val) => Validate.notEmpty(val),
                              maxLines: 8,
                              controller: controller.report,
                              label: "Report Massage",
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: controller.isLoading
                            ? LoadingItem()
                            : AppButton(
                              
                                onPressed: () {
                                  controller.setReport();
                                },
                                buttonText:  
                                    "Send Report",
                                
                          
                             
                              ),
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
