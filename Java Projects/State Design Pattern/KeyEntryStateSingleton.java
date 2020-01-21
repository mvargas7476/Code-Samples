public class KeyEntryStateSingleton {
    private static KeyEntryStateSingleton instance = null;
    private KeyEntryState KeyState;
    
    private KeyEntryStateSingleton() {
        KeyState = new KeyEntryInit();
    };
    
    public  synchronized static KeyEntryStateSingleton instance() {
        if( instance == null )
            instance = new KeyEntryStateSingleton();
        
        return instance;
    }
    
    public void setKeyState( KeyEntryState newState ) {
        KeyState = newState;
    }
    
    public void processKeyStroke( Calculator calc, char keyStroke) {
         KeyState.processKeyStroke(calc, keyStroke);
    };
}
