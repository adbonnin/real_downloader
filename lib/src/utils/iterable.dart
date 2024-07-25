extension IterableIterableExtensions<E> on Iterable<Iterable<E>> {
  Iterable<E> flatten() {
    return expand((e) => e);
  }
}

extension MapEntryIterableExtension<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() {
    return Map.fromEntries(this);
  }
}
