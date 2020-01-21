package Calulator.EntryState;

import Calulator.Calculator;


/**
 *
 * @author Robert Diepenbrock
 */
public class EnterFirstDigit extends EntryState {
    // Initial Key Entry State (When calculator is turned on or cleared)
    // Accepts Spaces and digits 1-9 only.
    @Override
    public void processKeyStroke(Calculator calc, char keyStroke) {
        // This is a new number
        calc.setAccm(0);
        
        // Between 1 and 9 or leading space is OK
        if( keyStroke == ' ' ) return; //eat leading spaces
        
        if( ('1' <= keyStroke) && (keyStroke <= '9' ) ) {
            calc.setAccm( keyStroke - '0' );
            // Nex State for rest of number
            calc.setEntryState( new EnterDigits() );
        } else {
            throw new UnsupportedOperationException("Expected a non-zero digit or space, received: \'" + keyStroke + "\'" );
        }
    }  
}
