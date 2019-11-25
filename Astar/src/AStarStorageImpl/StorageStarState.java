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
        this.boxes = boxes;
        this.storage = storage;
        super.setFather(father);
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

        sb.append("\n\tf(n): ").append(String.format("%d",super.getFn()))
                .append("\n\tg(n): ").append(String.format("%d",this.calculateGn()))
                .append("\n\th(n): ").append(String.format("%d",this.calculateHn()))
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

    /* F(n) =  - numero de pilas vacias + suma de la fecha de los dias de salida de las cajas en la lista
        Debido a esto, se priorizan los estados con menos pilas ocupadas y los estados cuya suma de dias de salida en
       la lista de produccion es menor.
       No obstante, el numero de pilas es mucho menor en comparacion a la suma de dias de salida de cajas en la lista
       de produccion, por lo que en un principio, se priorizaran en la lista de abiertos los estados en los que se
       metan primero las cajas con una mayor fecha de dia salida. Tras esto, tendran mayor prioridad los estados en
       los que se hayan ocupado menos pilas.
     */
    @Override
    public int calculateHn() {
        //H(n) = suma de la fecha de los dias de salida de las cajas en la lista
        /*
        Con esta heuristica, priorizamos los estados en los que en la lista de cajas por meter quedan cajas con una
        fecha de dia salida menor.
        De esta forma, se meteran primero las cajas con una fecha de salida superior posibilitando una resolucion,
        ya que solo hemos implementado para que se metan las cajas en las pilas, no para sacar de las pilas.
         */
        int additionDiaSalida = 0;
        // calculate the addition of the diaSalida of boxes resting in list
        for(Box b : this.boxes) {
            additionDiaSalida += b.getDiasalida();
        }
        return additionDiaSalida;
    }

    @Override
    public int calculateGn() {
        //G(n) = - numero de pilas vacias
        /*
        Con esta heuristica, priorizamos los estados en los que haya menos pilas usadas.
        */
        int numEmptyStacks = 0;
        //calculate the number of empty stacks
        for(BoxStack stack : this.storage.getStacks()) {
            if(stack.isEmpty()) {
                numEmptyStacks++;
            }
        }
        return -numEmptyStacks;
    }

    @Override
    public List<AStarState> expand(){
        // la forma de expander es para cada caja en la lista, intentar meterla en todsa las pilas posibles
        List<AStarState> statesWithAllExpansions = new ArrayList<>();
        // expand all states
        this.boxes.forEach(b -> statesWithAllExpansions.addAll(this.expandAddBoxStates(b)));
        // set current node as father
        statesWithAllExpansions.forEach(node -> node.setFather(this));
        return statesWithAllExpansions;
    }

    @Override
    public void updateGnOnFatherConflict(AStarState newFather) {
        // en este caso no necesitamos recalcular nada asique se queda vacio
    }

    private List<AStarState> expandAddBoxStates(Box box){
        // para meter una caja en todas las pilas posibles y generar como maximo 5 estados nuevos (uno por pila)
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
}
