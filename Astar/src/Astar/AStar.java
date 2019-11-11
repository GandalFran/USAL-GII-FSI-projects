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
    private final static Logger LOGGER = Logger.getLogger("AStar.AStar");

    private List<AStarState> opened;
    private List<AStarState> closed;
    private MutableGraph<AStarState> graph;
    public AStar(){
        this.opened = new ArrayList<>();
        this.closed = new ArrayList<>();
        this.graph = null;
    }

    public void initialize(){
        this.opened.clear();
        this.closed.clear();
        // instance new graph
        this.graph = GraphBuilder.directed().allowsSelfLoops(false).build();
    }

    public AStarState run(AStarState initialState) throws NoAvailableStatesException {
        AStarState openedNode, finalState;

        //add first node to opened
        LOGGER.log(Level.INFO,String.format("Added first state to opened [%s]", this.opened.toString()) );
        this.opened.add(initialState);

        //start loop
        while(true){
            LOGGER.log(Level.INFO,"New loop iteration");
            LOGGER.log(Level.INFO,String.format("Content of opened: %s",this.opened.toString()));
            LOGGER.log(Level.INFO,String.format("Content of closed: %s",this.closed.toString()));

            //check if there is nodes in opened
            LOGGER.log(Level.INFO,"Check if there is available nodes in opened");
            if(this.opened.isEmpty()){
                LOGGER.log(Level.WARNING,"No availabe states to open in opened");
                throw new NoAvailableStatesException("No availabe states to open in opened");
            }

            //take first node of opened, put it on closed and open it
            LOGGER.log(Level.INFO,String.format("Select first node from opened: [%s]",this.opened.get(0).toString()));
            openedNode = this.opened.get(0);
            this.opened.remove(openedNode);
            this.closed.add(this.closed.size(),openedNode);

            //check if node is final state
            LOGGER.log(Level.INFO,"check if node is final state");
            if(openedNode.isFinalState()){
                LOGGER.log(Level.INFO,"found final state");
                finalState = openedNode;
                break;
            }

            //expand node
            LOGGER.log(Level.INFO,"expand selected node");
            List<AStarState> descendants = this.expand(openedNode);

            //set father pointer in children
            LOGGER.log(Level.INFO,"set father pointers in new state nodes");
            for(AStarState child : descendants) {
                this.selectFather(child);
                this.addToLists(child);
            }

            //sort opened
            LOGGER.log(Level.INFO,"sort opened nodes list");
            this.sortOpenedNodes();
        }

        return finalState;
    }

    private List<AStarState> expand(AStarState node){
        return null;

        //PARA HECTOR
        // hace falta comprobar si hay el mismo nodo en abiertos o cerrados con isSameNode (lo hice en selectFather
        // pero no deberia ir ahi ahora con el grafo, por lo que si quieres puedes copiar y pegar). esto se hace para
        // poder enganchar al nodo actual a todos los padres que deba tener.
        /*

        for(AStarState n : this.opened){
            if(node.isSameNode(n)){
                isNodeInOpened = true;
            }
        }

        for(AStarState n : this.opened){
            if(node.isSameNode(n)){
                isNodeInClosed = true;
            }
        }

        */

        //PARA HECTOR2:
        //  añadir nodo al grafo:
        //  this.graph.addNode(newnode);
        //  this.graph.putEdge(parent, newnode);

        //PARA HECTOR3:
        //  en el estado, pon al nodo actual como padre en plan de nuevoNodoHijo.setFather(node)
    }


    private void selectFather(AStarState node){
        //IMPORTANTE: TODO: si fathers no devuelve null cuando no hay padres, no va a funciona
        Set<AStarState> fathers = this.graph.predecessors(node);
        if(fathers != null){
            this.updateFatherOnConflict(node, fathers);
            for(AStarState sucesor : this.graph.successors(node)){
                this.selectFather(sucesor);
            }
        }
    }

    private void updateFatherOnConflict(AStarState node, Set<AStarState> availableFathers){
        //TODO: seleccionar el padre para este nodo
        //TODO: la recursivdiad no se hace aqui sino en select father
    }

    private void addToLists(AStarState node){
        if(! this.opened.contains(node)
                && ! this.closed.contains(node)){
            this.opened.add(node);
        }
    }

    private void sortOpenedNodes(){
        Collections.sort(this.opened);
    }

    public static List<AStarState> stateTreeAsList(AStarState node){
        List<AStarState> stateList = new ArrayList<>();

        if(null == node)
            return null;

        do {
            stateList.add(0,node.clone());
            node = node.getFather();
        }while(null != node);

        return stateList;
    }
}
