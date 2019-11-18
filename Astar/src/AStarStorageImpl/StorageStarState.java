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
        // % de cajas por ordenar -> dar prioridad a los que tienen alta tasa de ocupacion con mas cajas colocadas
        /*float percentageOfNotStoredBoxes = ((float)this.boxes.size())/this.initialNumberOfBoxes;
        return - percentageOfNotStoredBoxes;*/

        int usedStacks = 0;
        for(BoxStack stack : this.storage.getStacks()){
            if(!stack.isEmpty())
                usedStacks++;
        }

        return ((float)usedStacks)/ this.storage.getStacks().length;
    }

    @Override
    public float calculateGn() {
        /*
        //G(n) = tasa de ocupacion actual
        int numOfNotEmptyStacks = 1;
        int numOfStackedBoxes = 0;
        for(BoxStack stack : this.storage.getStacks()) {
            if(!stack.isEmpty()) {
                numOfNotEmptyStacks++;
                numOfStackedBoxes += stack.getActual();
            }
        }

        float occupationRate = ((float)numOfStackedBoxes)/numOfNotEmptyStacks ;
        return - occupationRate;
        */

        //G(n) = tasa de ocupacion actual / mejor tasa de ocupacion posible
        int numOfNotEmptyStacks = 1;
        int numOfStackedBoxes = 0;
        for(BoxStack stack : this.storage.getStacks()) {
            if(!stack.isEmpty()) {
                numOfNotEmptyStacks++;
                numOfStackedBoxes += stack.getActual();
            }
        }

        float currentOccupationRate = ((float)numOfStackedBoxes)/numOfNotEmptyStacks;
        float currentOccupationRate2 = ((float)numOfStackedBoxes)/(this.storage.getStacks()[0].getLimite()*numOfNotEmptyStacks);

        return - currentOccupationRate2;
    }

    @Override
    public List<AStarState> expand(){
        List<AStarState> statesWithAllExpansions = new ArrayList<>();

        // expand all states
        statesWithAllExpansions.addAll(this.expandAddBoxStates());
        statesWithAllExpansions.addAll(this.expandRemoveBoxStates());
        //statesWithAllExpansions.addAll(this.expandRotateList());


        // set current node as father
        statesWithAllExpansions.forEach(node -> node.setFather(this));

        return statesWithAllExpansions;
    }

    @Override
    public void updateGnOnFatherConflict(AStarState newFather) {

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

    private List<AStarState> expandRotateList(){
        List<AStarState> states = new ArrayList<>();

        if(this.boxes.size() > 1){
            StorageStarState newState = (StorageStarState) this.clone();
            Box firstBox = newState.boxes.remove(0);
            newState.boxes.add(newState.boxes.size(),firstBox);
            states.add(newState);
        }

        return states;
    }
}
