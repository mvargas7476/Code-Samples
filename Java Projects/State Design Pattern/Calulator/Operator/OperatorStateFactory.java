package Calulator.Operator;

/**
 *
 * @author Robert Diepenbrock
 */
public class OperatorStateFactory {
    // Creates known operators based on the entered key.
    public static OperatorState opKeyStroke( char keyStroke ) {
        
        switch ( keyStroke ) {
            case '\u0000' :  // Null Char Value
                return new OperatorInitial();
            case '+' :
                return new OperatorPlus();
            case '*' :
                return new OperatorMultply();
            case '-' :
                return new OperatorMinus();
            case '=' :  // Back to Square one
                return new OperatorInitial();
        }
        // Handle error here (unreconized operator)
        throw new UnsupportedOperationException("Unknown Operator \'" + keyStroke +"\' received ");
    }
}
