import AStar.AStar;
import AStar.AStarState;
import AStar.exceptions.NoAvailableStatesException;

import java.util.ArrayList;
import java.util.List;

public class Main {

    public static void main(String[] args) throws InterruptedException {

        AStar aStar = new AStar();
        AStarState finalState = null;
        try{
            aStar.initialize();
            finalState = aStar.run(initialState());
        }catch (NoAvailableStatesException e){
            System.out.println("Unable to find solution for initial state: \n " + initialState().toString());
            System.exit(0);
        }

        Thread.sleep(1000);

        List<AStarState> stateList = AStar.stateTreeAsList(finalState);

        System.out.println("Solution found in depth " + stateList.size() + ": ");
        for(int i=0; i<stateList.size(); i++){
           System.out.println("\nSTATE " + i + ": ");
           System.out.print(stateList.get(i).toString());
        }
    }


    public static AStarState initialState(){
        return TestLoader.loadState("test2");
    }
}
