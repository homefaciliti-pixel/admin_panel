// class StateModel {
//
//   /// unique id
//   final int id;
//
//   /// state name
//   final String name;
//
//   /// active/inactive
//   bool status;
//
//   StateModel({
//
//     required this.id,
//
//     required this.name,
//
//     required this.status,
//   });
//
//   /// copyWith
//   ///
//   /// update/edit ke kaam aayega
//
//   StateModel copyWith({
//
//     int? id,
//
//     String? name,
//
//     bool? status,
//   }) {
//
//     return StateModel(
//
//       id: id ?? this.id,
//
//       name: name ?? this.name,
//
//       status: status ?? this.status,
//     );
//   }
// }