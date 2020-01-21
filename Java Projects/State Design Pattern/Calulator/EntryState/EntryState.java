package Calulator.EntryState;

import Calulator.Calculator;

/**
 *
 * @author Robert Diepenbrock
 */
public abstract class EntryState {
    
    public abstract void processKeyStroke( Calculator calc, char keyStroke);
    
}
