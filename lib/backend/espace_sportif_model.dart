class EspaceSportif {
  final String id;
  final String name;
  final String type;
  final String description;
  final String location;
  final double price;
  final String photoUrl;

  EspaceSportif({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.location,
    required this.price,
    required this.photoUrl,
  });

  // Copie avec modification
  EspaceSportif copyWith({
    String? id,
    String? name,
    String? type,
    String? description,
    String? location,
    double? price,
    String? photoUrl,
  }) {
    return EspaceSportif(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      location: location ?? this.location,
      price: price ?? this.price,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  // Convertir en Map pour Firestore / JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'location': location,
      'price': price,
      'photoUrl': photoUrl,
    };
  }

  // Créer un objet à partir d'un Map (Firestore ou local)
  factory EspaceSportif.fromMap(Map<String, dynamic> map, String documentId) {
    return EspaceSportif(
      id: documentId,
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      photoUrl: map['photoUrl'] ?? '',
    );
  }
}
