package Calulator.EntryState;

import Calulator.Calculator;
import Calulator.Operator.OperatorStateFactory;

/**
 *
 * @author Robert Diepenbrock
 */
public class EnterDigits extends EntryState {
    // Enter digits 0-9 Stopping at space or operator
    @Override
    public void processKeyStroke(Calculator calc, char keyStroke) {
        // Between 0 and 9 or trailing spaces OK
        if( ('0' <= keyStroke) && (keyStroke <= '9' ) ) {
            // Enter Digits into Accumulator
            calc.setAccm( (calc.getAccm() * 10) + (keyStroke - '0') );
            return;
        }
        
        if( keyStroke == ' ' ) {
            // Goto Eat space before operator
            calc.setEntryState( new EatSpace() );
            return;
        }
        // Perform last operation
        calc.getOpStae().doOperation(calc);
        
        // Set operation to keyStroke 
        calc.setOpStae(OperatorStateFactory.opKeyStroke(keyStroke));
    }
}
    