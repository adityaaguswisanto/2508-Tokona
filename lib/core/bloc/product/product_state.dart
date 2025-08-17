import 'package:tokona/packages/packages.dart';

enum ProductResponse { loading, success, failure, offline }

final class ProductState extends Equatable {
  final ProductResponse status;
  final List<ProductData> listProductData;
  final bool hasReachedMax;
  final int page;
  final int pageSize;
  final String errorMessage;
  final int errorCode;

  const ProductState({
    this.status = ProductResponse.loading,
    this.listProductData = const <ProductData>[],
    this.hasReachedMax = false,
    this.page = 1,
    this.pageSize = 20,
    this.errorMessage = "",
    this.errorCode = 0,
  });

  ProductState copyWith({
    ProductResponse? status,
    List<ProductData>? listProductData,
    bool? hasReachedMax,
    int? page,
    int? pageSize,
    String? errorMessage,
    int? errorCode,
  }) {
    return ProductState(
      status: status ?? this.status,
      listProductData: listProductData ?? this.listProductData,
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
    listProductData,
    hasReachedMax,
    page,
    pageSize,
    errorMessage,
    errorCode,
  ];
}
