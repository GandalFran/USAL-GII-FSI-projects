package Astar;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AStar {
    private final static Logger LOGGER = Logger.getLogger("AStar.AStar");

    private List<AStarState> opened;
    private List<AStarState> closed;

    public AStar(){
        this.opened = new ArrayList<>();
        this.closed = new ArrayList<>();
    }

    public void initialize(){
        this.opened.clear();
        this.closed.clear();
    }

    public AStarState run(AStarState initialState) throws NoAvailableStatesException{
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
                this.selectFather(child,openedNode);
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
    }

    private void selectFather(AStarState node, AStarState defaultFather){

        boolean isNodeInOpened = false;
        boolean isNodeInClosed = false;

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

        if(!isNodeInOpened && !isNodeInClosed){
            node.setFather(defaultFather);
        }else if(isNodeInOpened || isNodeInClosed){
            this.updateFatherOnConflict(node, defaultFather);
            this.sortOpenedNodes();
        }
    }

    private void updateFatherOnConflict(AStarState node, AStarState newfather){

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
