import 'package:tokona/packages/packages.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetCurrentProduct getCurrentProduct;

  ProductBloc(this.getCurrentProduct) : super(const ProductState()) {
    on<ProductGetted>(
      (event, emit) async {
        if (state.hasReachedMax) return;
        final result = await getCurrentProduct.get(
          event.merchantId,
          event.search,
          state.page,
          state.pageSize,
        );
        result.fold(
          (failure) {
            emit(
              state.copyWith(
                status: failure.statusCode == 500
                    ? ProductResponse.offline
                    : ProductResponse.failure,
                errorMessage: failure.message,
                errorCode: failure.statusCode,
              ),
            );
          },
          (merchant) {
            final listProductData = merchant.data ?? [];
            emit(
              state.copyWith(
                status: ProductResponse.success,
                listProductData: List.of(
                  state.listProductData,
                )..addAll(listProductData),
                page: state.page + 1,
                hasReachedMax: listProductData.length < state.pageSize,
              ),
            );
          },
        );
      },
      transformer: Droppables.throttle(),
    );
    on<ProductRefreshed>((event, emit) async {
      emit(
        state.copyWith(
          status: ProductResponse.loading,
          listProductData: [],
          page: 1,
          hasReachedMax: false,
          errorMessage: null,
          errorCode: null,
        ),
      );
      final result = await getCurrentProduct.get(
        event.merchantId,
        event.search,
        1,
        state.pageSize,
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: failure.statusCode == 500
                  ? ProductResponse.offline
                  : ProductResponse.failure,
              errorMessage: failure.message,
              errorCode: failure.statusCode,
            ),
          );
        },
        (merchant) {
          final listProductData = merchant.data ?? [];
          emit(
            state.copyWith(
              status: ProductResponse.success,
              listProductData: listProductData,
              page: 1,
              hasReachedMax: listProductData.length > 5
                  ? listProductData.isEmpty
                  : true,
            ),
          );
        },
      );
    });
    on<ProductPutted>((event, emit) async {
      emit(
        state.copyWith(
          status: ProductResponse.loading,
        ),
      );
      final result = await getCurrentProduct.put(
        event.id,
        event.available,
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: failure.statusCode == 500
                  ? ProductResponse.offline
                  : ProductResponse.failure,
              errorMessage: failure.message,
              errorCode: failure.statusCode,
            ),
          );
        },
        (message) {
          emit(
            state.copyWith(
              status: ProductResponse.success,
            ),
          );
        },
      );
    });
  }
}
