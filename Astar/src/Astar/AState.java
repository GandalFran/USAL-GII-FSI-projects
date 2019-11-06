package Astar;

public abstract class AState implements Cloneable{

    private AStar father;

    public AState() {
        this.father = null;
    }

    public abstract boolean isFinalState();

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof AState)) return false;

        AState aState = (AState) o;

        return father.equals(aState.father);
    }

    @Override
    public int hashCode() {
        return father.hashCode();
    }

    @Override
    public String toString() {
        return "AState{" +
                "father=" + father +
                '}';
    }

    public AStar getFather() {
        return father;
    }

    public void setFather(AStar father) {
        this.father = father;
    }
}
