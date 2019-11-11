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

    public StorageStarState(List<Box> boxes, Storage storage, int gn, AStarState father){
        super.setGn(gn);
        super.setFather(father);
        this.boxes = boxes;
        this.storage = storage;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof StorageStarState)) return false;

        StorageStarState that = (StorageStarState) o;

        if (!getStorage().equals(that.getStorage())) return false;
        return getBoxes().equals(that.getBoxes());
    }

    @Override
    public int hashCode() {
        int result = getStorage().hashCode();
        result = 31 * result + getBoxes().hashCode();
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

    @Override
    public AStarState clone() {
        List<Box> newBoxes = new ArrayList<>();
        for (Box box : this.boxes)
            newBoxes.add((Box)box.clone());
        return new StorageStarState(newBoxes,(Storage) this.storage.clone(), super.getGn(), super.getFather());
    }

    @Override
    public boolean isFinalState() {
        return this.boxes.isEmpty();
    }

    @Override
    public int calculateHn() {
        //hn -> numero de pilas que faltan para meter las cajas restantes
        int restingBoxes = this.boxes.size();
        int restingBoxesInStack = 0;

        for(int i=0; i< this.storage.getStacks().length; i++){
            if(!this.storage.getStacks()[i].isEmpty())
                restingBoxesInStack = this.storage.getStacks()[i].getLimite() - this.storage.getStacks()[i].getActual();
                restingBoxes -= restingBoxesInStack;
        }

        return (int) Math.ceil(restingBoxes/ this.storage.getStacks()[0].getLimite());
    }

    @Override
    public boolean isSameNode(AStarState node) {
        if(!node.getClass().equals(this.getClass()))
            return false;
        else
            return this.storage.equals(((StorageStarState)node).storage);
    }

}
