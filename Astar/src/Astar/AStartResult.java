package AStar;

import java.util.List;

public class AStartResult {

    private int numOpened;
    private int numClosed;
    private long elapsedTime;
    private AStarState finalState;
    private AStarState initialState;
    private List<AStarState> solution;

    public int getNumOpened() {
        return numOpened;
    }

    public void setNumOpened(int numOpened) {
        this.numOpened = numOpened;
    }

    public int getNumClosed() {
        return numClosed;
    }

    public void setNumClosed(int numClosed) {
        this.numClosed = numClosed;
    }

    public long getElapsedTime() {
        return elapsedTime;
    }

    public void setElapsedTime(long elapsedTime) {
        this.elapsedTime = elapsedTime;
    }

    public AStarState getFinalState() {
        return finalState;
    }

    public void setFinalState(AStarState finalState) {
        this.finalState = finalState;
    }

    public AStarState getInitialState() {
        return initialState;
    }

    public void setInitialState(AStarState initialState) {
        this.initialState = initialState;
    }

    public List<AStarState> getSolution() {
        return solution;
    }

    public void setSolution(List<AStarState> solution) {
        this.solution = solution;
    }
}


