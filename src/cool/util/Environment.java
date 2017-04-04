package cool.util;

import cool.ast.Feature;
import cool.ast.Field;
import cool.ast.Klass;
import cool.ast.Method;

import java.util.HashMap;
import java.util.*;


/**
 * Environment is used both during type checking and code generation.
 *
 * For type checking, we need to store Types in the objectMap.
 * Hence, use {@code Type} for {@code V} when type-checking.
 *
 * For code generation, we need to store IRValues in the objectMap.
 * Hence, use {@code IRValue} for {@code V} when generating code.
 */
public class Environment<V> {
    private final Klass root;
    private final HashMap<String, Klass> classMap;
    private final HashMap<Klass, Integer> classTags;
    private final HashMap<Klass, List<Field>> fieldMap;
    private final HashMap<Klass, List<Method>> methodMap;
    private final Dictionary<V> objectMap;
    private Klass currentClass;
    private int classTag = 5; // Object: 0, Int: 1, Bool: 2, String: 3, IO: 4, Others: 5+

    public Environment(Klass root) {
        this.root = root;
        classMap = new HashMap<>();
        classTags = new HashMap<>();
        fieldMap = new HashMap<>();
        methodMap = new HashMap<>();
        objectMap = new Dictionary<>();
        setup();
    }

    private void setup() {
        setupClasses(root);
        setupClassTags(root);
        setupFields(root);
        setupMethods(root);
    }

    private void setupClasses(Klass klass) {
        classMap.put(klass.name, klass);
        klass.children.forEach(c -> setupClasses(c));
    }

    private void setupClassTags(Klass klass) {
        // TODO: Fill in the classTags map as follows:
        // Object's tag is 0, Int is 1, Bool is 2, String is 3, IO is 4.
        // All other classes are tagged according to pre-oder traversal.
        // This means, the tag of a parent is lower than all of its descendants.
    }

    private void setupFields(Klass klass) {
        populateFields(klass);
        klass.children.forEach(c -> setupFields(c));
    }

    private void populateFields(Klass klass) {
        if (klass == root) {
            fieldMap.put(klass, new LinkedList<>());
            return;
        }

        List<Field> fields = new LinkedList(getFields(klass.parent));
        fields.addAll(getOwnFields(klass));
        fieldMap.put(klass, fields);
    }

    /**
     * Returns the fields declared in klass. This does NOT include inherited fields.
     */
    public List<Field> getOwnFields(Klass klass) {
        List<Field> ownFields = new LinkedList<>();
        for (Feature feature : klass.features)
            if (feature instanceof Field)
                ownFields.add((Field) feature);
        return ownFields;
    }

    /**
     * Returns all the fields (inherited or not) of 'klass'.
     * The fields are ordered according to top-down traversal
     * in the inheritance path.
     */
    public List<Field> getFields(Klass klass) {
        if (!fieldMap.containsKey(klass))
            populateFields(klass);
        return fieldMap.get(klass);
    }

    private void setupMethods(Klass klass) {
        populateMethods(klass);
        klass.children.forEach(c -> setupMethods(c));
    }

    private void populateMethods(Klass klass) {
        if (klass == root) {
            List<Method> ownMethods = getOwnMethods(klass);
            methodMap.put(klass, ownMethods);
            return;
        }

        List<Method> inheritedMethods = new LinkedList(getMethods(klass.parent));
        List<Method> ownMethods = getOwnMethods(klass);

        // For each method defined in klass, check whether a definition comes from a parent.
        // If so, replace that definition to keep the order of methods unchanged.
        ListIterator<Method> ownMethodIterator = ownMethods.listIterator();
        while (ownMethodIterator.hasNext()) {
            Method ownMethod = ownMethodIterator.next();

            ListIterator<Method> inheritedMethodIterator = inheritedMethods.listIterator();
            while (inheritedMethodIterator.hasNext()) {
                Method parentMethod = inheritedMethodIterator.next();
                if (parentMethod.name.equals(ownMethod.name)) {
                    inheritedMethodIterator.set(ownMethod); // Overriding the method definition
                    ownMethodIterator.remove();
                    break;
                }
            }
        }
        // Any method that remains in ownMethods is a new method that does not exist in a parent
        inheritedMethods.addAll(ownMethods);
        methodMap.put(klass, inheritedMethods);
    }

    private List<Method> getOwnMethods(Klass klass) {
        List<Method> methods = new LinkedList<>();
        for (Feature feature : klass.features)
            if (feature instanceof Method)
                methods.add((Method) feature);
        return methods;
    }

    /**
     * Returns all the methods (inherited or not) of 'klass'.
     * The methods are ordered according to top-down traversal
     * in the inheritance path.
     */
    public List<Method> getMethods(Klass klass) {
        if (!methodMap.containsKey(klass))
            populateMethods(klass);
        return methodMap.get(klass);
    }

    public boolean hasClass(String name) {
        return classMap.containsKey(name);
    }

    public Klass getClass(String className) {
        if (!hasClass(className))
            throw new Error("Class " + className + " does not exist.");
        return classMap.get(className);
    }

    /**
     * Look up a variable name in the object map.
     * Returns null for names that do not exist.
     */
    public V lookup(String name) {
        return objectMap.lookup(name);
    }

    /**
     * Look up a field name in the fields of the "current class".
     */
    public Field lookupField(String fieldName) {
        // TODO: Look up and return the Field named 'fieldName' of the 'currentClass'
        // Fields from parents come first in the list. So, the search is backwards.

        throw new Error("Field " + fieldName + " not found in class " + currentClass.name + ".");
    }

    /**
     * Look up a method name in the methods of the given class definition.
     */
    public Method lookupMethod(Klass klass, String methodName) {
        for (Method method : getMethods(klass)) {
            if (methodName.equals(method.name))
                return method;
        }
        throw new Error("Method " + methodName + " not found in class " + klass.name + ".");
    }

    /**
     * Introduce a new binding for a local variable.
     * Use this method for method parameters and let-bindings.
     */
    public void push(String name, V value) {
        objectMap.push(name, value);
    }

    /**
     * Remove the last binding.
     */
    public void pop() {
        objectMap.pop();
    }

    /**
     * Return the class in which we are currently operating.
     */
    public Klass getCurrentClass() {
        return currentClass;
    }

    /**
     * Set the class in which we are currently operating.
     */
    public void setCurrentClass(Klass klass) {
        this.currentClass = klass;
    }

    /**
     * Return the definition of the Object class -- the root of the inheritance tree.
     */
    public Klass getRoot() {
        return root;
    }

    public int getNumClasses() {
        return classMap.size();
    }

    /**
     * Return the class tag. Object is 0.
     * Other classes are enumerated according to pre-order traversal
     * of the inheritance tree.
     * Int: 1, Bool: 2, String: 3, IO: 4, User-defined classes: 5+
     */
    public int getClassTag(Klass klass) {
        return classTags.get(klass);
    }

    public int getClassTag(String className) {
        return classTags.get(getClass(className));
    }

    /**
     * Returns the list of parents of klass in top-down order,
     * from Object to the immediate parent.
     */
    public LinkedList<Klass> getParents(Klass klass) {
        // TODO: Implement this method
        return new LinkedList<>();
    }

    public LinkedList<Klass> getParents(String className) {
        return getParents(getClass(className));
    }

    /**
     * Returns true if 'klass' is a builtin class.
     */
    public boolean isBuiltin(Klass klass) {
        return  isBuiltin(klass.name);
    }

    public boolean isBuiltin(String className) {
        return  "Object".equals(className) ||
                "Int".equals(className) ||
                "Bool".equals(className) ||
                "String".equals(className) ||
                "IO".equals(className);
    }
}