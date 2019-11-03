package POJO;

import Astar.AstarPOJO;

import java.util.logging.Level;
import java.util.logging.Logger;

public class BoxStack implements AstarPOJO{
    private final static Logger LOGGER = Logger.getLogger("POJO.BoxStack");

    private int ID;
    private Box [] lbox;
    private int actual;
    private int limite;

    private final int MAX_BOX_PER_STACK = 4;

    public BoxStack(int ID) {
        this.ID = ID;
        this.lbox = new Box [MAX_BOX_PER_STACK];
        this.actual = 0;
        this.limite = MAX_BOX_PER_STACK;
        LOGGER.log(Level.INFO, String.format("BoxStack: %d: new [%s]", this.ID, this.toString()));
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof BoxStack)) return false;

        BoxStack boxStack = (BoxStack) o;

        if (actual != boxStack.actual) return false;
        if (limite != boxStack.limite) return false;
        return lbox.equals(boxStack.lbox);
    }

    @Override
    public int hashCode() {
        int result = lbox.hashCode();
        result = 31 * result + actual;
        result = 31 * result + limite;
        return result;
    }

    @Override
    public String toString() {
        return "BoxStack{" +
                "lbox=" + lbox +
                ", actual=" + actual +
                ", limite=" + limite +
                '}';
    }

    public boolean isBoxAllowed(Box b){
        boolean isAllowed = (this.actual == 0
                || (this.actual < this.limite && b.getDiasalida() > this.lbox[this.actual].getDiasalida())
        );
        LOGGER.log(Level.INFO, String.format("isBoxAllowed: %d: [%b] [%s]", this.ID, isAllowed, b.toString()));
        return isAllowed;
    }

    public boolean addBox(Box b) {
        LOGGER.log(Level.INFO, String.format("addBox: %d: trying to add box [%b]", this.ID, b.toString()));
        if(this.isBoxAllowed(b)) {
            this.actual++;
            this.lbox[this.actual] = b;
            LOGGER.log(Level.INFO, String.format("addBox: %d: box added to stack [%b]", this.ID, b.toString()));
            return true;
        }else{
            LOGGER.log(Level.INFO, String.format("addBox: %d: box not added to stack [%b]", this.ID, b.toString()));
            return false;
        }
    }

    public boolean removeBox() {
        LOGGER.log(Level.INFO, String.format("addBox: %d: trying to remove box", this.ID));
        if (this.actual > 0) {
            LOGGER.log(Level.INFO, String.format("addBox: %d: removed box [%s]", this.ID, this.lbox[actual].toString()));
            this.lbox[actual] = null;
            this.actual--;
            return true;
        }else{
            return false;
        }
    }

    public int getActual() {
        return actual;
    }

    public void setActual(int actual) {
        this.actual = actual;
    }

    public int getLimite() {
        return limite;
    }
}
