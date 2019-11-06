package POJO;


import java.util.logging.Level;
import java.util.logging.Logger;

public class BoxStack implements Cloneable{
    private final static Logger LOGGER = Logger.getLogger("POJO.BoxStack");

    private int ID;
    private Box [] boxes;
    private int actual;
    private int limite;

    private final int MAX_BOX_PER_STACK = 4;

    public BoxStack(int ID) {
        this.ID = ID;
        this.boxes = new Box [MAX_BOX_PER_STACK];
        this.actual = 0;
        this.limite = MAX_BOX_PER_STACK;
        LOGGER.log(Level.INFO, String.format("BoxStack: %d: new [%s]", this.ID, this.toString()));
    }

    private BoxStack(int ID, Box[] boxes, int actual, int limite) {
        this.ID = ID;
        this.boxes = boxes;
        this.actual = actual;
        this.limite = limite;
    }

    @Override
    public Object clone(){
        Box [] newboxes = new Box [MAX_BOX_PER_STACK];
        for(int i=0; i<this.boxes.length; i++)
            newboxes[i] = (Box) this.boxes[i].clone();
        return new BoxStack(this.ID,newboxes,this.actual,this.limite);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof BoxStack)) return false;

        BoxStack boxStack = (BoxStack) o;

        if (actual != boxStack.actual) return false;
        if (limite != boxStack.limite) return false;
        return boxes.equals(boxStack.boxes);
    }

    @Override
    public int hashCode() {
        int result = boxes.hashCode();
        result = 31 * result + actual;
        result = 31 * result + limite;
        return result;
    }

    @Override
    public String toString() {
        return "BoxStack{" +
                "boxes=" + boxes +
                ", actual=" + actual +
                ", limite=" + limite +
                '}';
    }

    public boolean isBoxAllowed(Box b){
        boolean isAllowed = (this.actual == 0
                || (this.actual < this.limite && b.getDiasalida() > this.boxes[this.actual].getDiasalida())
        );
        LOGGER.log(Level.INFO, String.format("isBoxAllowed: %d: [%b] [%s]", this.ID, isAllowed, b.toString()));
        return isAllowed;
    }

    public boolean addBox(Box b) {
        LOGGER.log(Level.INFO, String.format("addBox: %d: trying to add box [%b]", this.ID, b.toString()));
        if(this.isBoxAllowed(b)) {
            this.actual++;
            this.boxes[this.actual] = b;
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
            LOGGER.log(Level.INFO, String.format("addBox: %d: removed box [%s]", this.ID, this.boxes[actual].toString()));
            this.boxes[actual] = null;
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
