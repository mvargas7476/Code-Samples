public class OperatorStateSingleton {
    private static OperatorStateSingleton instance = null;
    private static OperatorState state;
    
    private OperatorStateSingleton() {
        state = new OperatorInitial();
    };
    
    public  synchronized static OperatorStateSingleton instance() {
        if( instance == null ) {
            // Create a new OpEnteryState
            instance = new OperatorStateSingleton();
            
            // Start in the initial state
            state = OperatorStateFactory.opKeyStroke('\u0000');
        }
        return instance;
    }
    
    public static OperatorState getOpEntryState () { 
        instance();
        return state; 
    }
    
    public static void setOpEntryState( char keyStroke ) {
        state = OperatorStateFactory.opKeyStroke( keyStroke );
    }
    
}
