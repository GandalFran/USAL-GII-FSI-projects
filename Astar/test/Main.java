import AStar.AStar;
import AStar.AStarState;
import AStar.exceptions.NoAvailableStatesException;
import AStarStorageImpl.StorageStarState;
import POJO.Box;
import POJO.Storage;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

public class Main {

    public static void main(String[] args) {

        AStar aStar = new AStar();
        AStarState finalState = null;
        try{
            aStar.initialize();
            finalState = aStar.run(initialState());
        }catch (NoAvailableStatesException e){
            System.out.println("Unable to find solution for initial state: \n " + initialState().toString());
            System.exit(0);
        }

        List<AStarState> stateList = AStar.stateTreeAsList(finalState);

        System.out.println("Solution found in depth " + stateList.size() + ": ");
        for(int i=0; i<stateList.size(); i++){
           System.out.println("STATE " + i + ": ");
           System.out.print(stateList.get(i).toString());
        }
    }


    public static AStarState initialState(){
        Storage storage = new Storage();
        List<Box> boxes = TestLoader.getBoxes(TestLoader.getTestFileWithName("test1"));
        AStarState state = new StorageStarState(boxes,storage,null);
        return state;
    }
}
