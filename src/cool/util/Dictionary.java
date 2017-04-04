package cool.util;

import java.util.LinkedList;

// A linked-list based implementation of a dictionary.
// Useful for representing local variables shadowing previous bindings.
// Used internally in the Environment class.
class Dictionary<V> {
    static class Entry<V> {
        final String name;
        final V value;

        Entry(String name, V value) {
            this.name = name;
            this.value = value;
        }
    }

    private final LinkedList<Entry<V>> entries;

    Dictionary() {
        this.entries = new LinkedList<>();
    }

    void push(String name, V value) {
        entries.push(new Entry(name, value));
    }

    void pop() {
        entries.pop();
    }

    public boolean contains(String name) {
        return entries.stream().anyMatch(e -> name.equals(e.name));
    }

    V lookup(String name) {
        for (Entry<V> entry : entries)
            if (name.equals(entry.name))
                return entry.value;
        return null;
    }

    public void clear() {
        entries.clear();
    }
}
