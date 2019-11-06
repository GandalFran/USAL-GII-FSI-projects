package POJO;

import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Storage implements Cloneable{
    private final static Logger LOGGER = Logger.getLogger("POJO.Storage");

    private BoxStack [] stacks;
    private final int NUM_STACKS = 5;

    public Storage() {

        this.stacks = new BoxStack[NUM_STACKS];
        for(int i=0; i<NUM_STACKS; i++)
            this.stacks[i] = new BoxStack(i);
        LOGGER.log(Level.INFO, String.format("Storage: new [%s]", this.toString()));
    }

    private Storage(BoxStack [] boxStack){
        this.stacks = boxStack;
    }

    @Override
    public Object clone(){
        BoxStack [] newBoxStack = new BoxStack[NUM_STACKS];
        for(int i =0; i<this.stacks.length; i++){
            newBoxStack[i] = (BoxStack) this.stacks[i].clone();
        }
        return new Storage(newBoxStack);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Storage)) return false;

        Storage storage = (Storage) o;

        // Probably incorrect - comparing Object[] arrays with Arrays.equals
        return Arrays.equals(getStacks(), storage.getStacks());
    }

    @Override
    public int hashCode() {
        return Arrays.hashCode(getStacks());
    }

    @Override
    public String toString() {
        return "Storage{" +
                "stacks=" + Arrays.toString(stacks) +
                '}';
    }

    public BoxStack[] getStacks() {
        return stacks;
    }
}
