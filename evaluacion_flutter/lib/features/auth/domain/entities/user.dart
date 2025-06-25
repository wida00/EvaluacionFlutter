import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.email,
    this.name,
    this.token,
  });

  final String id;
  final String username;
  final String email;
  final String? name;
  final String? token;

  @override
  List<Object?> get props => [id, username, email, name, token];

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? name,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }
}
