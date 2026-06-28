import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'espace_sportif_model.dart';

class EspaceSportifService {
  // Mettre à true pour basculer sur Firestore une fois le projet Firebase configuré sur la console
  static bool useFirebase = false;

  static final List<EspaceSportif> _localDb = [
    EspaceSportif(
      id: '1',
      name: 'Terrain de Football Municipal',
      type: 'Terrain de football',
      description: 'Terrain de football moderne en gazon synthétique avec éclairage nocturne et vestiaires. Parfait pour les matchs et entraînements.',
      location: '123 Avenue des Sports, Paris 75015',
      price: 25.0,
      photoUrl: 'https://images.unsplash.com/photo-1659059398425-f0214a2fe0da?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjUwNjg0ODV8&ixlib=rb-4.1.0&q=80&w=1080',
    ),
    EspaceSportif(
      id: '2',
      name: 'Piscine Olympique Municipale',
      type: 'Piscine',
      description: 'Bassin olympique chauffé de 50 mètres avec couloirs de nage et espace de détente.',
      location: '45 Rue de la Natation, Lyon 69002',
      price: 15.0,
      photoUrl: 'https://images.unsplash.com/photo-1645076112494-1a1f714ae735?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjUwNjg3MTJ8&ixlib=rb-4.1.0&q=80&w=1080',
    ),
  ];

  static final StreamController<List<EspaceSportif>> _localStreamController =
      StreamController<List<EspaceSportif>>.broadcast();

  static void _notifyLocalChange() {
    _localStreamController.add(List.unmodifiable(_localDb));
  }

  static final CollectionReference _firestoreCollection =
      FirebaseFirestore.instance.collection('espaces_sportifs');

  // Flux d'écoute en temps réel
  static Stream<List<EspaceSportif>> watchEspaces() {
    if (useFirebase) {
      return _firestoreCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return EspaceSportif.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      });
    } else {
      // Déclencher une mise à jour asynchrone initiale pour les abonnés récents
      Timer.run(() => _notifyLocalChange());
      return _localStreamController.stream;
    }
  }

  // Ajouter un espace sportif
  static Future<void> addEspace(EspaceSportif espace) async {
    if (useFirebase) {
      await _firestoreCollection.add(espace.toMap());
    } else {
      final newEspace = espace.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      _localDb.add(newEspace);
      _notifyLocalChange();
    }
  }

  // Modifier un espace sportif
  static Future<void> updateEspace(EspaceSportif espace) async {
    if (useFirebase) {
      await _firestoreCollection.doc(espace.id).update(espace.toMap());
    } else {
      final index = _localDb.indexWhere((e) => e.id == espace.id);
      if (index != -1) {
        _localDb[index] = espace;
        _notifyLocalChange();
      }
    }
  }

  // Supprimer un espace sportif
  static Future<void> deleteEspace(String id) async {
    if (useFirebase) {
      await _firestoreCollection.doc(id).delete();
    } else {
      _localDb.removeWhere((e) => e.id == id);
      _notifyLocalChange();
    }
  }
}
