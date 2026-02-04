public class KeyEntryInit extends KeyEntryState {
    // Initial Key Entry State (When calculator is turned on or cleared)
    
    @Override
    public void processKeyStroke(Calculator calc, char keyStroke) {
        // This is a new number
        calc.setAccm(0);
        
        // Between 1 and 9 or leading space is OK
        if( keyStroke == ' ' ) return;
        if( ('1' <= keyStroke) && (keyStroke <= '9' ) ) {
            calc.setAccm( keyStroke - '0' );
            
            // move to accepting all digits
            KeyEntryStateSingleton.instance().setKeyState( new KeyDigits() );
        } else {
            // This is not a digit or a leading space
            throw new UnsupportedOperationException("Invalid Key Pressed: " + keyStroke );
        }
    }  
}
