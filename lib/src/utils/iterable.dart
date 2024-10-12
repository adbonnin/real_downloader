extension DifferenceIterableExtension<T> on Iterable<T> {
  void difference<K>(
    Iterable<T> next,
    K Function(T element) keyOf, {
    void Function(T next)? onAdded,
    void Function(T prev)? onRemoved,
    void Function(T prev, T next)? onEqual,
    void Function(T prev, T next)? onUpdated,
  }) {
    final nextByKey = next.map((v) => MapEntry(keyOf(v), v)).toMap();

    for (final value in this) {
      final key = keyOf(value);

      if (nextByKey.containsKey(key)) {
        final nextValue = nextByKey.remove(key) as T;

        if (value == nextValue) {
          onEqual?.call(value, nextValue);
        } //
        else {
          onUpdated?.call(value, nextValue);
        }
      } //
      else {
        onRemoved?.call(value);
      }
    }

    for (final entry in nextByKey.entries) {
      onAdded?.call(entry.value);
    }
  }
}

extension IterableIterableExtensions<T> on Iterable<Iterable<T>> {
  Iterable<T> flatten() {
    return expand((e) => e);
  }
}

extension MapEntryIterableExtension<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() {
    return Map.fromEntries(this);
  }
}
