import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/core/components/toast_app.dart';
import 'package:elamlymarket/core/utils/storage_key.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitial());
  static ReportsCubit get(context) => BlocProvider.of(context);
  final reporterName = TextEditingController();
  final reportPhone = TextEditingController();
  final report = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  setReport() async {
    if (formKey.currentState!.validate()) {
      String? email =
          await const FlutterSecureStorage().read(key: StorageKey.email);
      String? phone =
          await const FlutterSecureStorage().read(key: StorageKey.phone);
      String? fullName =
          await const FlutterSecureStorage().read(key: StorageKey.name);
      String? userId =
          await const FlutterSecureStorage().read(key: StorageKey.userDocId);
      String? token = await FlutterSecureStorage().read(key: StorageKey.token);

      isLoading = true;
      emit(SetReportEvent());
      await FirebaseFirestore.instance.collection("reports").add({
        "report_name": reporterName.text.trim(),
        "report": report.text.trim(),
        "report_phone": reportPhone.text.trim(),
        "email": email,
        "full_name": fullName,
        "phone": phone,
        "user_id": userId,
        "notification_token": token
      }).then((value) {
        isLoading = false;
        report.clear();
        reportPhone.clear();
        reporterName.clear();
        emit(SetReportSuccessEvent());
        toastApp(message: "Set report Successfully");
      }).onError((error, stackTrace) {
        isLoading = false;
        emit(FaileldSetReportEvent());
        toastApp(message: "Failed to set report");
      });
    }
  }
}
