public class OperatorInitial extends OperatorState {
    // The inntial operator state (i.e. no operator yet)
    @Override
    public void processKeyStroke(Calculator calc, char keyStroke) {
        // Do nothing on purpose
     }

    @Override
    public void doOperation(Calculator calc) {
        // Total is set to Accm, Accm is set to zero
        calc.setTotal(calc.getAccm());
        return ;
    }
    
}
