import 'package:tokona/packages/packages.dart';

enum MerchantResponse { loading, success, failure, offline }

final class MerchantState extends Equatable {
  final MerchantResponse status;
  final List<MerchantData> listMerchantData;
  final bool hasReachedMax;
  final int page;
  final int pageSize;
  final String errorMessage;
  final int errorCode;

  const MerchantState({
    this.status = MerchantResponse.loading,
    this.listMerchantData = const <MerchantData>[],
    this.hasReachedMax = false,
    this.page = 1,
    this.pageSize = 20,
    this.errorMessage = "",
    this.errorCode = 0,
  });

  MerchantState copyWith({
    MerchantResponse? status,
    List<MerchantData>? listMerchantData,
    bool? hasReachedMax,
    int? page,
    int? pageSize,
    String? errorMessage,
    int? errorCode,
  }) {
    return MerchantState(
      status: status ?? this.status,
      listMerchantData: listMerchantData ?? this.listMerchantData,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object> get props => [
    status,
    listMerchantData,
    hasReachedMax,
    page,
    pageSize,
    errorMessage,
    errorCode,
  ];
}
