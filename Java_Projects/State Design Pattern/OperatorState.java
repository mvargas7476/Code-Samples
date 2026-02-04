public abstract class OperatorState {
    // Set the Next Operation
    public void processKeyStroke( Calculator calc, char keyStroke) {
        if( keyStroke == ' ' ) return;
        // setup new operator
        OperatorStateSingleton.setOpEntryState(keyStroke);
        KeyEntryStateSingleton.instance().setKeyState( new KeyEntryInit() );
    };
    // Must implement the operation in the children
    public abstract void doOperation( Calculator calc);
}
