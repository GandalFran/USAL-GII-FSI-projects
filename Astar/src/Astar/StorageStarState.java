package Astar;

import POJO.Box;
import POJO.Storage;

import java.util.ArrayList;
import java.util.List;

public class StorageStarState extends AStarState {

    private Storage storage;
    private List<Box> boxes;

    public StorageStarState(List<Box> boxes, Storage storage){
        this.boxes = boxes;
        this.storage = storage;
    }

    private StorageStarState(List<Box> boxes, Storage storage, int gn, int hn, AStarState father){
        super.setGn(gn);
        super.setHn(hn);
        super.setFather(father);
        this.boxes = boxes;
        this.storage = storage;
    }

    @Override
    public AStarState clone() {
        List<Box> newBoxes = new ArrayList<>();
        for (Box box : this.boxes)
            newBoxes.add((Box)box.clone());
        return new StorageStarState(newBoxes,(Storage) this.storage.clone(), super.getGn(), super.getHn(), super.getFather());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof StorageStarState)) return false;
        if (!super.equals(o)) return false;

        StorageStarState that = (StorageStarState) o;

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
        StringBuilder sb = new StringBuilder();

        sb.append("\tf(n): ").append(super.getFn())
                .append("\n\tg(n): ").append(super.getGn())
                .append("\n\th(n): ").append(super.getHn())
                .append("\n\tfather: ").append(super.getFather())
                .append("\n\tboxes: [");

        for(Box b: boxes)
            sb.append(b.toString()).append(", ");

        sb.append("]")
                .append("\n\tstorage:")
                .append(storage.toString().replace("\n","\n\t" ));

        return sb.toString();
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
