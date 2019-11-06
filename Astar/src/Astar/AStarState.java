package Astar;


public abstract class AStarState implements Cloneable, Comparable<AStarState>  {

    private int gn;
    private int hn;
    private AStarState father;

    public AStarState() {
        this.gn = 0;
        this.hn = 0;
        this.father = null;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof AStarState)) return false;

        AStarState aStarState = (AStarState) o;

        if (getGn() != aStarState.getGn()) return false;
        if (getHn() != aStarState.getHn()) return false;
        return getFather() != null ? getFather().equals(aStarState.getFather()) : aStarState.getFather() == null;
    }

    @Override
    public int hashCode() {
        int result = getGn();
        result = 31 * result + getHn();
        result = 31 * result + (getFather() != null ? getFather().hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "AStarState{" +
                "gn=" + gn +
                ", hn=" + hn +
                ", fn=" + (hn+gn) +
                ", father=" + father +
                '}';
    }

    @Override
    public int compareTo(AStarState s) {
        return (this.getFn()-s.getFn());
    }


    @Override
    public AStarState clone() {
        return null;
    }

    public abstract boolean isSameNode(AStarState node);

    public abstract boolean isFinalState();

    public AStarState getFather() {
        return father;
    }

    public void setFather(AStarState father) {
        this.father = father;
    }

    public int getGn() {
        return gn;
    }

    public void setGn(int gn) {
        this.gn = gn;
    }

    public int getHn() {
        return hn;
    }

    public void setHn(int hn) {
        this.hn = hn;
    }

    public int getFn(){
        return gn + hn;
    }
}
