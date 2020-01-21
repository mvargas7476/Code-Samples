public class OperatorStateFactory {
    
    public static OperatorState opKeyStroke( char c ) {
        
        switch ( c ) {
            case '\u0000' :  // Null Char Value
                return new OperatorInitial();
            case '+' :
                return new OperatorPlus();
            case '-' :
                return new OperatorMinus();
            case '=' :
                return new OperatorInitial();
        }
        // Handle error here (unreconized operator)
        throw new UnsupportedOperationException("Unknown Operator \'" + c +"\' received ");
   
    }
}
