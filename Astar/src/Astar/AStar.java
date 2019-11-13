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
                this.addToList(child);
            }

            //sort opened
            LOGGER.log(Level.INFO,"sort opened nodes list");
            this.sortOpenedNodes();
        }

        return finalState;
    }

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

    private AStarState getNodeInList(AStarState node, List<AStarState> list){
        for(AStarState lNode : list){
            if(lNode.isSameNode(node)) {
                return lNode;
            }
        }
        return null;
    }


    private void selectFather(AStarState node){
        Set<AStarState> fathers = this.graph.predecessors(node);
        // if node has more than one father
        if(fathers.size() > 1){
            // update the node information -> father and G(n)
            this.updateNodeOnFatherConflict(node, fathers);
            // apply the select father method to all node childs
            for(AStarState successor : this.graph.successors(node)){
                //TODO -> A lo mejor da problemas el gn porque hay que recalcularlo en toda la descenencia. Por lo que
                //TODO    si hacemos lo de que dependa del padre, hacer una funcion recursiva pillando el padre hasta
                //TODO    null para ir sumando de 1 en 1 y asi calcualr el gn cada vez.
                this.selectFather(successor);
            }
        }
    }

    private void updateNodeOnFatherConflict(AStarState node, Set<AStarState> availableFathers){
        //the recursivity is only made on selectFather
        for(AStarState possibleFather : availableFathers){
            //importante: se hace el bulce completo sin break para coger el menor padre
            if(node.getFather().getGn() > possibleFather.getGn()){
                node.setFather(possibleFather);
                node.updateGnOnFatherConflict(possibleFather);
            }
        }
    }

    private void addToList(AStarState node){
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
