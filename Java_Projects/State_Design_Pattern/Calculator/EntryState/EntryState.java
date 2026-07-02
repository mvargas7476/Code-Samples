package Calculator.EntryState;

import Calculator.Calculator;

/**
 *
 * @author Robert Diepenbrock
 */
public abstract class EntryState {
    
    public abstract void processKeyStroke( Calculator calc, char keyStroke);
    
}
