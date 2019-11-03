package POJO;

import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Storage {
    private final static Logger LOGGER = Logger.getLogger("POJO.Storage");

    private BoxStack [] pilas;
    private final int NUM_STACKS = 5;

    public Storage() {

        this.pilas = new BoxStack[NUM_STACKS];
        for(int i=0; i<NUM_STACKS; i++)
            this.pilas[i] = new BoxStack(i);
        LOGGER.log(Level.INFO, String.format("Storage: new [%s]", this.toString()));
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Storage)) return false;

        Storage storage = (Storage) o;

        // Probably incorrect - comparing Object[] arrays with Arrays.equals
        return Arrays.equals(getPilas(), storage.getPilas());
    }

    @Override
    public int hashCode() {
        return Arrays.hashCode(getPilas());
    }

    @Override
    public String toString() {
        return "Storage{" +
                "pilas=" + Arrays.toString(pilas) +
                '}';
    }

    public BoxStack[] getPilas() {
        return pilas;
    }

}
