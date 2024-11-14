part of 'reports_cubit.dart';

sealed class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

final class ReportsInitial extends ReportsState {}
final class SetReportEvent extends ReportsState {}
final class SetReportSuccessEvent extends ReportsState {}
final class FaileldSetReportEvent extends ReportsState {}
