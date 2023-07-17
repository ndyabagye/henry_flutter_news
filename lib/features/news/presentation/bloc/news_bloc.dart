import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:henry_flutter_news/core/failures.dart';
import 'package:henry_flutter_news/features/news/domain/entities/news.dart';
import 'package:henry_flutter_news/features/news/domain/params/news_params.dart';
import 'package:henry_flutter_news/features/news/domain/usecases/get_news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNews getNewsUsecase;

  NewsBloc({required this.getNewsUsecase}) : super(NewsInitial()) {
    on<GetNewsEvent>(_onGetNewsRequested);
  }

  _onGetNewsRequested(GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());

    final result = await getNewsUsecase.execute(parameters: event.parameters);
    emit(result.fold((l) => NewsLoadedWithError(message: _getErrorMessage(l)),
        (r) => NewsLoadedWithSuccess(news: r)));
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      default:
        return 'An unknown error has occured';
    }
  }
}
