package Astar;

import POJO.Box;
import POJO.BoxStack;
import POJO.Storage;

import java.util.ArrayList;
import java.util.List;

public class AStateStorage extends AState{

    private Storage storage;
    private List<Box> boxes;


    public AStateStorage(List<Box> boxes,Storage storage){
        this.boxes = boxes;
        this.storage = storage;
    }

    @Override
    public AState clone() {
        List<Box> newBoxes = new ArrayList<>();
        for (Box box : this.boxes)
            newBoxes.add((Box)box.clone());
        return new AStateStorage(newBoxes,(Storage) this.storage.clone());
    }

    @Override
    public boolean isFinalState() {
        return this.boxes.isEmpty();
    }

}
