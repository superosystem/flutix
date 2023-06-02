import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieState get initialState => MovieInitial();

  MovieBloc() : super(MovieInitial()) {
    on<MovieEvent>((event, emit) async {
      if (event is FetchMovies) {
        List<Movie> movies = await MovieServices.getMovies(1);

        emit(MovieLoaded(
            movies: movies
                .where((element) =>
                    !element.title.toLowerCase().contains('365') &&
                    !element.title.toLowerCase().contains('bois'))
                .toList()));
      }
    });
  }
}
