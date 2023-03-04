part of 'index_bloc.dart';

abstract class IndexState extends Equatable {
  const IndexState();

  @override
  List<Object> get props => [];
}

class IndexInitial extends IndexState {}

class IndexLoading extends IndexState {}

class IndexLoaded extends IndexState {
  final String message;
  const IndexLoaded({required this.message});
}

class IndexError extends IndexState {
  final String message;
  const IndexError({required this.message});
}
