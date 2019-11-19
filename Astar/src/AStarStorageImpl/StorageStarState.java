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
    private int initialNumberOfBoxes;

    public StorageStarState(List<Box> boxes, Storage storage){
        this.boxes = boxes;
        this.storage = storage;
        this.initialNumberOfBoxes = boxes.size();
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

        sb.append("\n\tf(n): ").append(String.format("%3.2f",super.getFn()))
                .append("\n\tg(n): ").append(String.format("%3.2f",this.calculateGn()))
                .append("\n\th(n): ").append(String.format("%3.2f",this.calculateHn()))
                .append("\n\tfather hash: ").append( (super.getFather() == null) ? null : super.getFather().hashCode() )
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
        if (this == node) return true;
        if (!(node instanceof StorageStarState)) return false;

        return this.storage.equals(((StorageStarState)node).storage);
    }

    @Override
    public float calculateHn() {
        return 0;
    }

    @Override
    public float calculateGn() {

        //G(n) = tasa de ocupacion actual
       /* int numOfNotEmptyStacks = 1;
        int numOfStackedBoxes = 0;
        int boxesPerStack = this.storage.getStacks()[0].getLimite();
        for(BoxStack stack : this.storage.getStacks()) {
            if(!stack.isEmpty()) {
                numOfNotEmptyStacks++;
                numOfStackedBoxes += stack.getActual();
            }
        }

        float occupationRate = ((float)numOfStackedBoxes)/(numOfNotEmptyStacks*boxesPerStack) ;
        return - occupationRate;*/

        //G(n) = numEmptyStacks +
        int numOfEmptyStacks = 0;
        int additionDiaSalida = 0;
        for(BoxStack stack : this.storage.getStacks()) {
            if(!stack.isEmpty()) {
                for(Box b : stack.getBoxes()) {
                    if(null != b)
                        additionDiaSalida += b.getDiasalida();
                }
            }else{
                numOfEmptyStacks++;
            }
        }

        return (-(float)(numOfEmptyStacks + additionDiaSalida));
    }

    @Override
    public List<AStarState> expand(){
        List<AStarState> statesWithAllExpansions = new ArrayList<>();

        // expand all states
        this.boxes.forEach(b -> {
            statesWithAllExpansions.addAll(this.expandAddBoxStates(b));
        });
        //statesWithAllExpansions.addAll(this.expandAddBoxStates(this.boxes.get(0)));
        //statesWithAllExpansions.addAll(this.expandRemoveBoxStates());

        // set current node as father
        statesWithAllExpansions.forEach(node -> node.setFather(this));

        return statesWithAllExpansions;
    }

    @Override
    public void updateGnOnFatherConflict(AStarState newFather) {

    }

    private List<AStarState> expandAddBoxStates(Box box){
        List<AStarState> states = new ArrayList<>();

        for(int i=0; i < this.storage.getStacks().length; i++ ){
            if(this.storage.getStacks()[i].isBoxAllowed(box)) {
                StorageStarState newState = (StorageStarState) this.clone();
                newState.boxes.remove(box);
                newState.storage.getStacks()[i].addBox(box);
                states.add(newState);
            }
        }

        return states;
    }

    private List<AStarState> expandRemoveBoxStates(){
        List<AStarState> states = new ArrayList<>();

        if(this.boxes.size() > 1) {
            for (int i = 0; i < this.storage.getStacks().length; i++) {
                if (!this.storage.getStacks()[i].isEmpty()) {
                    StorageStarState newState = (StorageStarState) this.clone();
                    Box removedBox = newState.storage.getStacks()[i].removeBox();
                    if (null != removedBox) {
                        newState.boxes.add(newState.boxes.size(), removedBox);
                        states.add(newState);
                    }
                }
            }
        }

        return states;
    }
}
