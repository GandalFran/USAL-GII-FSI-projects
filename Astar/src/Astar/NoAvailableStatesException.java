package Astar;

public class NoAvailableStatesException extends Exception{

    public NoAvailableStatesException(String errorMessage){
        super(errorMessage);
    }
}
