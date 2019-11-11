package AStar.exceptions;


public class NoAvailableStatesException extends Exception{

    public NoAvailableStatesException(String errorMessage){
        super(errorMessage);
    }
}
