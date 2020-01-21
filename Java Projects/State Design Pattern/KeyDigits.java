public class KeyDigits extends KeyEntryState {

    @Override
    public void processKeyStroke(Calculator calc, char keyStroke) {
        // Between 0 and 9 or trailing spaces OK
        if( ('0' <= keyStroke) && (keyStroke <= '9' ) ) {
            // Accumilate digits
            calc.setAccm( (calc.getAccm() * 10) + (keyStroke - '0') );
            return;
        }
        
        // Entry State goes to Key In an Operator
        KeyEntryStateSingleton.instance().setKeyState( new KeyOperator() );
        
        // Process the keyStroke by the KeyOperator State
        OperatorStateSingleton.getOpEntryState().processKeyStroke(calc, keyStroke);
    }
    
}
    