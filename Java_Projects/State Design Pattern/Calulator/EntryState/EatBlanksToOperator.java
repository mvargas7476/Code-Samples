package Calulator.EntryState;

import Calulator.Calculator;
import Calulator.Operator.OperatorStateFactory;

/**
 *
 * @author Robert Diepenbrock
 */
public class EatBlanksToOperator extends EntryState {
    // Eats any spaces before an operator 
    @Override
    public void processKeyStroke(Calculator calc, char keyStroke) {
        // Just consume spaces until we hit an operator
        if( keyStroke == ' ' ) return;

        // Error on digits
        if ( ('0' <= keyStroke) && (keyStroke <= '9') )
            throw new UnsupportedOperationException("Operator expected blank or operator: \'" + keyStroke +"\' received ");
        
        // Perform last operator
        calc.getOpStae().doOperation(calc);
        
        // Set Next Operator state based on keyStroke
        calc.setOpStae(OperatorStateFactory.opKeyStroke(keyStroke));
        
        // Set Calc state to start a new number entry
        calc.setEntryState( new EnterFirstDigit() );
    }
    
}
