
import 'package:test/expect.dart';

class GenericMatcher extends Matcher {

  bool Function(dynamic item, Map matchState)? onMatches;
  Description Function(Description description)? onDescribe;

  GenericMatcher({this.onMatches, this.onDescribe});

  @override
  bool matches(dynamic item, Map matchState) =>
      onMatches?.call(item, matchState) ?? false;

  @override
  Description describe(Description description) =>
      onDescribe?.call(description) ?? description;
}