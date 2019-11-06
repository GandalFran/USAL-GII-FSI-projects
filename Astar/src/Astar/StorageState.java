package Astar;

import POJO.Box;
import POJO.Storage;

import java.util.ArrayList;
import java.util.List;

public class StorageState extends AState{

    private Storage storage;
    private List<Box> boxes;


    public StorageState(List<Box> boxes, Storage storage){
        this.boxes = boxes;
        this.storage = storage;
    }

    @Override
    public AState clone() {
        List<Box> newBoxes = new ArrayList<>();
        for (Box box : this.boxes)
            newBoxes.add((Box)box.clone());
        return new StorageState(newBoxes,(Storage) this.storage.clone());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof StorageState)) return false;
        if (!super.equals(o)) return false;

        StorageState that = (StorageState) o;

        if (getStorage() != null ? !getStorage().equals(that.getStorage()) : that.getStorage() != null) return false;
        return getBoxes() != null ? getBoxes().equals(that.getBoxes()) : that.getBoxes() == null;
    }

    @Override
    public int hashCode() {
        int result = super.hashCode();
        result = 31 * result + (getStorage() != null ? getStorage().hashCode() : 0);
        result = 31 * result + (getBoxes() != null ? getBoxes().hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "StorageState{" +
                "storage=" + storage +
                ", boxes=" + boxes +
                '}';
    }

    @Override
    public boolean isFinalState() {
        return this.boxes.isEmpty();
    }


    public Storage getStorage() {
        return storage;
    }

    public void setStorage(Storage storage) {
        this.storage = storage;
    }

    public List<Box> getBoxes() {
        return boxes;
    }

    public void setBoxes(List<Box> boxes) {
        this.boxes = boxes;
    }
}
