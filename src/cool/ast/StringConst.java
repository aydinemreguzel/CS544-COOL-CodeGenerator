package cool.ast;

public class StringConst extends Expr {
    public final String value;

    public StringConst(String value) {
        this.value = value;
    }

    @Override
    public <R> R accept(Visitor<R> visitor) {
        return visitor.visitStringConst(this);
    }

    public String unescaped() {
        return unescape(value);
    }

    public static String unescape(String value) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < value.length(); i++) {
            switch (value.charAt(i)) {
                case '\b': builder.append("\\08"); break;
                case '\t': builder.append("\\09"); break;
                case '\n': builder.append("\\0A"); break;
                case '\f': builder.append("\\0C"); break;
                case '\"': builder.append("\\22"); break;
                case '\\': builder.append("\\5C"); break;
                default:  builder.append(value.charAt(i)); break;
            }
        }
        return builder.toString();
    }
}
