public class KeyOperator extends KeyEntryState {

    @Override
    public void processKeyStroke(Calculator calc, char keyStroke) {
        // Just consume spaces until we hit an operator
        if( keyStroke == ' ' ) return;

        // Error on digits
        if ( ('0' <= keyStroke) && (keyStroke <= '9') )
            throw new UnsupportedOperationException("Operator expected, digit " + keyStroke +" received ");
        
        // We have an operator keyStroke
        
        // Perform last operator
        OperatorStateSingleton.getOpEntryState().doOperation(calc);
        
        // Set Next Operator state based on keyStroke
        OperatorStateSingleton.setOpEntryState( keyStroke );
        
        // Set Calc state to start a new number entry
        KeyEntryStateSingleton.instance().setKeyState( new KeyEntryInit() );
    }
    
}
