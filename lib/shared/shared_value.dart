part of 'shared.dart';

String? apiKey = dotenv.env['MOVIE_API_KEY'];
String? imageBaseURL = 'https://image.tmdb.org/t/p/';

PageEvent? prevPageEvent;
File? imageFileToUpload;
