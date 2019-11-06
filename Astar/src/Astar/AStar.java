package Astar;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AStar {
    private final static Logger LOGGER = Logger.getLogger("AStar.AStar");

    private List<AState> opened;
    private List<AState> closed;

    public AStar(){
        this.opened = new ArrayList<>();
        this.closed = new ArrayList<>();
    }

    public void initialize(){
        this.opened.clear();
        this.closed.clear();
    }

    public void run(AState initialState) throws NoAvailableStatesException{

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
            AState openedNode = this.opened.get(0);
            this.opened.remove(openedNode);
            this.closed.add(this.closed.size(),openedNode);

            //check if node is final state
            LOGGER.log(Level.INFO,"Check if node is final state");
            if(openedNode.isFinalState()){
                break;
            }

            //expand node
            LOGGER.log(Level.INFO,"Expand selected node");
            List<AState> descendants = this.expand(openedNode);

            //set father pointer in childs
            LOGGER.log(Level.INFO,"Set father pointers in new state nodes");
            for(AState child : descendants) {
                this.selectFather(child,openedNode);
                if(! this.opened.contains(child)
                        && ! this.closed.contains(child)){
                   this.opened.add(child);
                }
            }

            //sort opened
            LOGGER.log(Level.INFO,"sort opened nodes list");
            this.sortopened();
        }
    }

    public List<AState> expand(AState node){
        return null;
    }

    public void selectFather(AState node, AState defaultFather){

    }

    public void sortopened(){

    }
}
