
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ImageService {
  static final ImageService _instance = ImageService._internal();
  factory ImageService() => _instance;
  ImageService._internal();

  final Map<String, Uint8List> _memoryCache = {};

  Future<Uint8List?> fetchImage(String url) async {
    if (_memoryCache.containsKey(url)) return _memoryCache[url];

    try {
      final bytes = await compute(_fetchImageBytes, url);
      if (bytes != null) _memoryCache[url] = bytes;
      return bytes;
    } catch (_) {
      return null;
    }
  }

  // isolate-friendly method
  static Future<Uint8List?> _fetchImageBytes(String url) async {
    if(url.isEmpty) return null;
    try {
      final response = await Dio().get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      return Uint8List.fromList(response.data!);
    } catch (_) {
      return null;
    }
  }
}
