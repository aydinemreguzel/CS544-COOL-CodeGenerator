package cool.ast;

import cool.scanner.Token;

public enum BinaryOperator {
    ADD, SUBTRACT, MULTIPLY, DIVIDE,
    LESSTHAN, LESSTHANEQ, EQUALS;

    public static BinaryOperator opForToken(Token token) {
        switch (token.type) {
            case LESSTHAN:   return LESSTHAN;
            case LESSTHANEQ: return LESSTHANEQ;
            case EQ:         return EQUALS;
            case PLUS:       return ADD;
            case MINUS:      return SUBTRACT;
            case STAR:       return MULTIPLY;
            case SLASH:      return DIVIDE;
            default:         throw new Error("No operator exists for token " + token);
        }
    }

    public boolean isArithmeticOp() {
        switch (this) {
            case ADD:
            case SUBTRACT:
            case MULTIPLY:
            case DIVIDE:
                return true;
            default:
                return false;
        }
    }
}
