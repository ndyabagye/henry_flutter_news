import 'dart:convert';
import 'dart:io';

import 'package:henry_flutter_news/core/constants.dart';
import 'package:henry_flutter_news/core/exceptions.dart';
import 'package:henry_flutter_news/features/news/data/models/news_model.dart';
import 'package:henry_flutter_news/features/news/domain/params/news_params.dart';

import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews({required NewsParams parameters});
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  final baseUrl = "https://newsapi.org/v2";

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<
      List<
          NewsModel>> getNews({required NewsParams parameters}) => _getDataFromUrl(
      path:
          "/top-headlines?country=${parameters.country}&category=${parameters.category}&apiKey=${Constants.apiKey}");

  Future<List<NewsModel>> _getDataFromUrl({required String path}) async {
    try {
      final response = await client.get(Uri.parse(baseUrl + path), headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      });
      switch (response.statusCode) {
        case 200:
          final results = (json.decode(response.body)['articles']);
          final news =
              (results as List).map((e) => NewsModel.fromJson(e)).toList();
          return news;
        case 400:
          throw const ServerException(message: "Bad request");
        case 410:
          throw const ServerException(message: "Unauthorized");
        case 500:
          throw const ServerException(message: "Internal Server error");
        default:
          throw const ServerException(message: "Unknown error");
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw e.toString();
    }
  }
}
