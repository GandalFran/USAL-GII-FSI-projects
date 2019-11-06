package Astar;

import POJO.Storage;

public class AStateStorage extends AState{
    private Storage storage;


    public AStateStorage(Storage storage){
        this.storage = storage;
    }

    @Override
    public AState clone() {
        AStateStorage stateCopy = new AStateStorage((Storage)this.storage.clone());
        return stateCopy;
    }
}
