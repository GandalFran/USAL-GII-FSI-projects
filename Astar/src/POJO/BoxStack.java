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

        for(int i=0; i<this.boxes.length; i++){
            if(this.boxes[i] == null || boxStack.boxes[i] == null){
                if(this.boxes[i] == null && boxStack.boxes[i] != null) return false;
                if(this.boxes[i] != null && boxStack.boxes[i] == null) return false;
            }
            else if(!this.boxes[i].equals(boxStack.boxes[i]))
                return false;
        }
        return true;
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
        if(this.isEmpty())
            return true;
        else if(this.actual < this.limite){
            Box firstBox = this.boxes[0];
            if(firstBox.getDiasalida() >= b.getDiasalida())
                return true;
        }

        return false;
    }

    public boolean addBox(Box b) {
        if(this.isBoxAllowed(b)) {
            for(int i=this.actual; i>0; i--){
                this.boxes[i] = this.boxes[i-1];
            }
            this.boxes[0] = b;
            this.actual++;
            return true;
        }else{
            return false;
        }
    }

    public boolean isEmpty(){
        return (this.actual == 0);
    }

    public int getActual(){
        return this.actual;
    }

    public int getLimite(){
        return this.limite;
    }

    public Box[] getBoxes(){
        return this.boxes;
    }
}
