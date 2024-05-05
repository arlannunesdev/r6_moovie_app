import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


@immutable
abstract class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object> get props => [];
}

class LoadingSucessEvent extends MovieEvent {
}

class FetchMoviesEvent extends MovieEvent {}

class NetworkErrorEvent extends Error {}
