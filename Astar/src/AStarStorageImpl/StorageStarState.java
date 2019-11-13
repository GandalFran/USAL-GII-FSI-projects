package AStarStorageImpl;

import AStar.AStarState;
import POJO.Box;
import POJO.BoxStack;
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

    public StorageStarState(List<Box> boxes, Storage storage, AStarState father){
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
                .append("\n\tg(n): ").append(this.calculateGn())
                .append("\n\th(n): ").append(this.calculateHn())
                //.append("\n\tfather: ").append(super.getFather())
                .append("\n\tboxes: [");

        for(Box b: this.boxes)
            sb.append(b.toString()).append(", ");

        sb.append("]")
                .append("\n\tstorage:")
                .append(storage.toString().replace("\n","\n\t" ));

        return sb.toString();
    }

    public Storage getStorage() {
        return storage;
    }

    public List<Box> getBoxes() {
        return boxes;
    }

    @Override
    public AStarState clone() {
        List<Box> newBoxes = new ArrayList<>();
        for (Box box : this.boxes)
            newBoxes.add((Box)box.clone());
        return new StorageStarState(newBoxes,(Storage) this.storage.clone(), super.getFather());
    }

    @Override
    public boolean isFinalState() {
        return this.boxes.isEmpty();
    }

    @Override
    public boolean isSameNode(AStarState node) {
        if(!node.getClass().equals(this.getClass()))
            return false;
        else
            return this.storage.equals(((StorageStarState)node).storage);
    }

    @Override
    public int calculateHn() {
        //H(n) = -1* numero de pilas vacias
        int emptyStacks = 0;
        for(BoxStack stack : this.storage.getStacks()) {
            if (stack.isEmpty()) {
                emptyStacks++;
            }
        }
        return (-1*emptyStacks);
        /*int restingBoxes = this.boxes.size();
        int restingBoxesInStack = 0;

        for(int i=0; i< this.storage.getStacks().length; i++){
            if(!this.storage.getStacks()[i].isEmpty())
                restingBoxesInStack = this.storage.getStacks()[i].getLimite() - this.storage.getStacks()[i].getActual();
            restingBoxes -= restingBoxesInStack;
        }

        return (int) Math.ceil(restingBoxes/ this.storage.getStacks()[0].getLimite());*/
    }

    @Override
    public void updateGnOnFatherConflict(AStarState newFather) {

    }

    @Override
    public int calculateGn() {
        //G(n) = numero de pilas con alguna caja
        int notEmptyStacks = 0;
        for(BoxStack stack : this.storage.getStacks()) {
            if (!stack.isEmpty()) {
                notEmptyStacks++;
            }
        }
        return notEmptyStacks;
    }

    @Override
    public List<AStarState> expand(){
        List<AStarState> statesWithAllExpansions = new ArrayList<>();

        // expand all states
        statesWithAllExpansions.addAll(this.expandAddBoxStates());
        statesWithAllExpansions.addAll(this.expandRemoveBoxStates());
        // set current node as father
        statesWithAllExpansions.forEach(node -> node.setFather(this));

        return statesWithAllExpansions;
    }


    private List<AStarState> expandAddBoxStates(){

        Box firstBox = this.boxes.get(0);
        List<AStarState> states = new ArrayList<>();

        for(int i=0; i < this.storage.getStacks().length; i++ ){
            if(this.storage.getStacks()[i].isBoxAllowed(firstBox)) {
                StorageStarState newState = (StorageStarState) this.clone();
                newState.boxes.remove(firstBox);
                newState.storage.getStacks()[i].addBox(firstBox);
                states.add(newState);
            }
        }

        return states;
    }

    private List<AStarState> expandRemoveBoxStates(){
        Box removedBox;
        List<AStarState> states = new ArrayList<>();

        for(int i=0; i < this.storage.getStacks().length; i++ ){
            if(!this.storage.getStacks()[i].isEmpty()) {
                StorageStarState newState = (StorageStarState) this.clone();
                removedBox = newState.storage.getStacks()[i].removeBox();
                if(null != removedBox) {
                    newState.boxes.add(removedBox);
                    states.add(newState);
                }
            }
        }

        return states;
    }
}
