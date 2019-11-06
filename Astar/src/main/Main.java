package main;

import Astar.AStar;
import Astar.NoAvailableStatesException;
import Astar.StorageState;
import POJO.Box;
import POJO.Storage;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        AStar aStar = new AStar();
        aStar.initialize();
        try{
            aStar.run(initialState());
        }catch (NoAvailableStatesException e){
            System.out.println("Unable to find solution for initial state: " + initialState().toString());
            System.exit(0);
        }
    }

    @NotNull
    public static StorageState initialState(){
        List<Box> boxes = new ArrayList<>();
        Storage storage = new Storage();
        return new StorageState(boxes,storage);
    }
}
