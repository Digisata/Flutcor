// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class TokenModel {
  TokenModel({
    @required this.accessToken,
    @required this.scope,
    @required this.tokenType,
    @required this.expiresIn,
  });

  final String accessToken;
  final String scope;
  final String tokenType;
  final int expiresIn;

  TokenModel copyWith({
    String accessToken,
    String scope,
    String tokenType,
    int expiresIn,
  }) =>
      TokenModel(
        accessToken: accessToken ?? this.accessToken,
        scope: scope ?? this.scope,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
      );

  factory TokenModel.fromJson(String str) =>
      TokenModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TokenModel.fromMap(Map<String, dynamic> json) => TokenModel(
        accessToken: json["access_token"],
        scope: json["scope"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "scope": scope,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}
