package AStar;

import AStar.exceptions.NoAvailableStatesException;
import com.google.common.graph.GraphBuilder;
import com.google.common.graph.MutableGraph;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AStar {

    private List<AStarState> opened;
    private List<AStarState> closed;
    private MutableGraph<AStarState> graph;

    public AStar(){
        this.opened = new ArrayList<>();
        this.closed = new ArrayList<>();
        this.graph = null;
    }

    /**
     * @author Francisco y Hector
     *
     * Inicializa la clase para trabajar con el algoritmo A*. Limpia las liastas de abiertos y cerrados, ademas de
     * instanciar un nuevo grafo.
     */
    public void initialize(){
        this.opened.clear();
        this.closed.clear();
        // instance new graph
        this.graph = GraphBuilder.directed().allowsSelfLoops(false).build();
    }

    /**
     * @author Francisco y Hector
     * @param initialState estado inicial a partir del cual iniciar la busqueda.
     * @return el restultado de la ejecucion del algoritmo en un AStarStateResult.
     * @throws NoAvailableStatesException cuando no quedan nodos disponibles en la lista de abiertos.
     *
     * Aplica el algoritmo A*.
     */
    public AStarResult run(AStarState initialState) throws NoAvailableStatesException {
        AStarState openedNode, finalState;
        AStarResult result = new AStarResult();

        //measure time
        long finishTime;
        long startTime = System.currentTimeMillis();

        //add first node to opened
        this.opened.add(initialState);
        this.graph.addNode(initialState);

        //start loop
        while(true){

            //check if there is nodes in opened
            if(this.opened.isEmpty()){
                throw new NoAvailableStatesException("No availabe states to open in opened");
            }

            //take first node of opened, put it on closed and open it
            openedNode = this.opened.get(0);
            this.opened.remove(openedNode);
            this.closed.add(this.closed.size(),openedNode);

            //check if node is final state
            if(openedNode.isFinalState()){
                finalState = openedNode;
                finishTime = System.currentTimeMillis();
                break;
            }

            //expand node
            List<AStarState> descendants = this.expand(openedNode);

            //set father pointer in children
            for(AStarState child : descendants) {
                this.selectFather(child);
                this.addToList(child);
            }

            //sort opened
            this.sortOpenedNodes();
        }

        result.setElapsedTime(finishTime-startTime);
        result.setFinalState(finalState);
        result.setInitialState(initialState);
        result.setNumClosed(this.closed.size());
        result.setNumOpened(this.opened.size());
        result.setSolution(AStar.stateTreeAsList(finalState));

        return result;
    }

    /**
     * @author Francisco y Hector
     * @param node nodo que se expandira.
     * @return lista de nodos hijos de node. Si hay alguno que ya existia antes de expandir, se devolvera la referencia
     *         a este.
     *
     * Expande un nodo y para cada hijo añade las relaciones necesarias en el grafo. Si hay algun hijo repetido,
     * devuleve la referencia a el nodo ya existente en abiertos o cerrados en vez de la del nuevo nodo.
     */
    private List<AStarState> expand(AStarState node){
        AStarState definitiveNode;
        List<AStarState> expansionResult = new ArrayList<>();

        for(AStarState expandedNode : node.expand()){
            if(this.opened.contains(expandedNode)){
                definitiveNode = this.getNodeInList(expandedNode,this.opened);
            } else if(this.closed.contains(expandedNode)){
                definitiveNode = this.getNodeInList(expandedNode,this.closed);
            } else{
                definitiveNode = expandedNode;
                this.graph.addNode(definitiveNode);
            }

            expansionResult.add(definitiveNode);
            this.graph.putEdge(node, definitiveNode);
        }

        return expansionResult;
    }

    /**
     * @author Francisco y Hector
     * @param node nodo a buscar en lista.
     * @param list lista en la que buscar.
     * @return referencia a el nodo en la lista cuyo contenido es el mismo que node.
     *
     * Busca un nodo en una lista y en el caso de encotrarlo devuelve la referencia a este.
     */
    private AStarState getNodeInList(AStarState node, List<AStarState> list){
        for(AStarState lNode : list){
            if(lNode.isSameNode(node)) {
                return lNode;
            }
        }
        return null;
    }

    /**
     * @author Francisco y Hector
     * @param node nodo del cual se va a seleccionar el apuntador al padre.
     *
     * En el caso de que un nodo tenga mas de un padre, actualizarlo. En el caso de actualizarlo se actualizan a sus
     * sucesores.
     */
    private void selectFather(AStarState node){
        Set<AStarState> fathers = this.graph.predecessors(node);
        // if node has more than one father
        if(fathers != null && fathers.size() > 1){
            // update the node information -> father and G(n)
            boolean nodeHasBeenUpdated = this.updateNodeOnFatherConflict(node, fathers);
            if(nodeHasBeenUpdated) {
                // apply the select father method to all node children
                for (AStarState successor : this.graph.successors(node)) {
                    this.selectFather(successor);
                }
            }
        }
    }

    /**
     * @author Francisco y Hector
     * @param node nodo del cual seleccionar el padre.
     * @param availableFathers lista de padres posibles.
     * @return true en el caso de actualizar el nodo (cambiar el padre) y false en otro caso.
     *
     * Selecciona el padre con el menor G(n) y en el caso de ser disinto del nodo padre, actualizar el nodo.
     */
    private boolean updateNodeOnFatherConflict(AStarState node, Set<AStarState> availableFathers){
        boolean updated = false;
        //the recursivity is only made on selectFather

        //get the node with lowest gn
        AStarState bestFather = node.getFather();
        for(AStarState possibleFather : availableFathers) {
            if(bestFather != null && bestFather.getGn() > possibleFather.getGn() && !this.isNodeInAntecesorLine(node, possibleFather))
                bestFather = possibleFather;
        }

        //check if is same father
        if(bestFather != node.getFather()){
            updated = true;
            node.setFather(bestFather);
            node.updateGnOnFatherConflict(bestFather);
        }

        return updated;
    }

    /**
     * @author Francisco y Hector
     * @param node nodo del que se va a comprobar si el hijo esta en sus antecesores.
     * @param child nodo obtenido de expandir node, el cual se va a comprobar si esta en los antecesores de node.
     * @return true en el caso de child sea un antecesor de node y false en otro caso.
     *
     * Comprueba si child (hijo de node) esta en los antecesores de node.
     */
    private boolean isNodeInAntecesorLine(AStarState node, AStarState child){
        while(null != node){
            if(child.isSameNode(node))
                return true;
            node = node.getFather();
        }

        return false;
    }

    /**
     * @author Francisco y Hector
     * @param node nodo a añadir a abiertos
     *
     * Añade node a la lista de abiertos en el caso de que no este en esta.
     */
    private void addToList(AStarState node){
        if(! this.opened.contains(node)
                && ! this.closed.contains(node)){
            this.opened.add(node);
        }
    }

    /**
     * @author Francisco y Hector
     *
     * Ordenar la lista de abiertos por f(n).
     */
    private void sortOpenedNodes(){
        Collections.sort(this.opened);
    }

    /**
     * @author Francisco y Hector
     * @param node nodo del que obtener los antecesores.
     * @return lista con los antecesores ordenada del nodo inicial a node.
     *
     * Obtiene una lista del nodo inicial a node con todos los antecesores de nodo.
     */
    private static List<AStarState> stateTreeAsList(AStarState node){
        List<AStarState> stateList = new ArrayList<>();

        if(null == node)
            return null;

        do{
            stateList.add(0,node);
            node = node.getFather();
            if(stateList.contains(node)){
                System.out.println(node.toString());
            }
        }while(null != node);

        return stateList;
    }
}
