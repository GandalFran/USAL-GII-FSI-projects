package POJO;

import Astar.AstarPOJO;

import java.util.logging.Level;
import java.util.logging.Logger;

public class Box implements AstarPOJO {
    private final static Logger LOGGER = Logger.getLogger("POJO.Box");

    private int ID;
    private int diaentrada;
    private int diasalida;

    public Box(int ID, int diaentrada, int diasalida) {
        this.ID = ID;
        this.diaentrada = diaentrada;
        this.diasalida = diasalida;
        LOGGER.log(Level.INFO, String.format("Box: new [%s]", this.toString()));
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Box)) return false;

        Box box = (Box) o;

        if (getID() != box.getID()) return false;
        if (getDiaentrada() != box.getDiaentrada()) return false;
        return getDiasalida() == box.getDiasalida();
    }

    @Override
    public int hashCode() {
        int result = getID();
        result = 31 * result + getDiaentrada();
        result = 31 * result + getDiasalida();
        return result;
    }

    @Override
    public String toString() {
        return "Box{" +
                "ID=" + ID +
                ", diaentrada=" + diaentrada +
                ", diasalida=" + diasalida +
                '}';
    }

    public int getID() {
        return ID;
    }

    public int getDiaentrada() {
        return diaentrada;
    }

    public int getDiasalida() {
        return diasalida;
    }

}
