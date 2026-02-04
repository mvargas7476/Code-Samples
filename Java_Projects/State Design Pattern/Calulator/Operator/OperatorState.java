package Calulator.Operator;

import Calulator.Calculator;
import Calulator.EntryState.EnterFirstDigit;

/**
 *
 * @author Robert Diepenbrock
 */
public abstract class OperatorState {
    
    // All Operators process keyStrokes the same way
    public void processKeyStroke( Calculator calc, char keyStroke) {
        // Save this Operaator State to Calculator 
        calc.setOpStae( OperatorStateFactory.opKeyStroke(keyStroke) );
        // We are now looking for a new nuber
        calc.setEntryState(new EnterFirstDigit() );
    };
    
    // Children Must Implment their own Operation 
    public abstract void doOperation( Calculator calc);
}
