part of 'shared.dart';

String? apiKey = dotenv.env['MOVIE_API_KEY'];
String? imageBaseUrl = 'https://image.tmdb.org/t/p/';

PageEvent? prevPageEvent;
File? imageFileToUpload;
