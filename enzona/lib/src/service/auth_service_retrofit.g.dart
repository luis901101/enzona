// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service_retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AuthServiceRetrofit implements AuthServiceRetrofit {
  _AuthServiceRetrofit(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<String>> authenticate(
      {required authorization, required grantType, required scope}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'grant_type': grantType, 'scope': scope};
    final _result = await _dio.fetch<String>(
        _setStreamType<HttpResponse<String>>(Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': authorization},
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, '',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
