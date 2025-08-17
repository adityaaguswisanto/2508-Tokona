import 'package:tokona/packages/packages.dart';

class PromoBloc extends Bloc<PromoEvent, PromoState> {
  final GetCurrentPromo getCurrentPromo;

  PromoBloc(this.getCurrentPromo) : super(const PromoState()) {
    on<PromoGetted>(
      (event, emit) async {
        if (state.hasReachedMax) return;
        final result = await getCurrentPromo.get(
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
                    ? PromoResponse.offline
                    : PromoResponse.failure,
                errorMessage: failure.message,
                errorCode: failure.statusCode,
              ),
            );
          },
          (merchant) {
            final listPromoData = merchant.data ?? [];
            emit(
              state.copyWith(
                status: PromoResponse.success,
                listPromoData: List.of(
                  state.listPromoData,
                )..addAll(listPromoData),
                page: state.page + 1,
                hasReachedMax: listPromoData.length < state.pageSize,
              ),
            );
          },
        );
      },
      transformer: Droppables.throttle(),
    );
    on<PromoRefreshed>((event, emit) async {
      emit(
        state.copyWith(
          status: PromoResponse.loading,
          listPromoData: [],
          page: 1,
          hasReachedMax: false,
          errorMessage: null,
          errorCode: null,
        ),
      );
      final result = await getCurrentPromo.get(
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
                  ? PromoResponse.offline
                  : PromoResponse.failure,
              errorMessage: failure.message,
              errorCode: failure.statusCode,
            ),
          );
        },
        (merchant) {
          final listPromoData = merchant.data ?? [];
          emit(
            state.copyWith(
              status: PromoResponse.success,
              listPromoData: listPromoData,
              page: 1,
              hasReachedMax: listPromoData.length > 5
                  ? listPromoData.isEmpty
                  : true,
            ),
          );
        },
      );
    });
    on<PromoSubmitted>((event, emit) async {
      emit(
        state.copyWith(
          status: PromoResponse.loading,
        ),
      );
      final result = await getCurrentPromo.post(
        event.merchantId,
        event.productId,
        event.price,
        event.discount,
        event.endDate,
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: failure.statusCode == 500
                  ? PromoResponse.offline
                  : PromoResponse.failure,
              errorMessage: failure.message,
              errorCode: failure.statusCode,
            ),
          );
        },
        (message) {
          emit(
            state.copyWith(
              status: PromoResponse.success,
            ),
          );
        },
      );
    });
  }
}
