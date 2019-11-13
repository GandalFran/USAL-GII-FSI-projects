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
        this.actual = 0;
        this.limite = MAX_BOX_PER_STACK;
        this.boxes = new Box [this.limite];
    }

    public BoxStack(int ID, int stackSize) {
        this.ID = ID;
        this.actual = 0;
        this.limite = (stackSize <= 0) ? MAX_BOX_PER_STACK : stackSize;
        this.boxes = new Box [this.limite];
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
            if(null != this.boxes[i])
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
        StringBuilder sb = new StringBuilder();
        sb.append("("+actual+"/"+limite+") [");
        for(Box b : boxes) {
            if(null != b)
                sb.append(b.toString()).append(", ");
        }
        sb.append("]");
        return sb.toString();
    }

    public boolean isBoxAllowed(Box b){
        boolean isAllowed = (
                this.actual == 0
                || (this.actual < this.limite
                        && b.getDiasalida() >= this.boxes[this.actual-1].getDiasalida()
                )
        );
        return isAllowed;
    }

    public boolean addBox(Box b) {
        if(this.isBoxAllowed(b)) {
            this.boxes[this.actual] = b;
            this.actual++;
            LOGGER.log(Level.INFO, String.format("addBox: %d: box added to stack [%b]", this.ID, b.toString()));
            return true;
        }else{
            LOGGER.log(Level.INFO, String.format("addBox: %d: box not added to stack [%b]", this.ID, b.toString()));
            return false;
        }
    }

    public Box removeBox() {
        if (this.actual > 0) {
            Box deletedBox = this.boxes[this.actual-1];
            this.boxes[actual-1] = null;
            this.actual--;
            LOGGER.log(Level.INFO, String.format("removeBox: %d: removed box [%s]", this.ID, deletedBox.toString()));
            return deletedBox;
        }else{
            LOGGER.log(Level.INFO, String.format("removeBox: %d: box not removed from stack [%d]", this.ID, this.actual));
            return null;
        }
    }

    public boolean isEmpty(){
        return (this.limite - this.actual == 0);
    }
}
