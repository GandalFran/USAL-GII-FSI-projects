package AStar;


import java.util.List;

public abstract class AStarState implements Cloneable, Comparable<AStarState>  {

    private AStarState father;

    public AStarState() {
        this.father = null;
    }

    public AStarState getFather() {
        return father;
    }

    public void setFather(AStarState father) {
        this.father = father;
    }

    public int getGn(){
        return this.calculateGn();
    }

    public int getHn(){
        return this.calculateHn();
    }

    public int getFn(){
        return this.getHn() + this.getGn();
    }

    @Override
    public boolean equals(Object o){
        if(!this.getClass().equals(o.getClass()))
            return false;
        else
            return this.isSameNode((AStarState) o);
    }

    @Override
    public abstract int hashCode();

    @Override
    public abstract String toString();

    @Override
    public abstract AStarState clone();

    @Override
    public int compareTo(AStarState s) {
        return (this.getFn()-s.getFn());
    }

    public abstract boolean isSameNode(AStarState node);

    public abstract boolean isFinalState();

    public abstract int calculateGn();

    public abstract int calculateHn();

    public abstract List<AStarState> expand();

}
