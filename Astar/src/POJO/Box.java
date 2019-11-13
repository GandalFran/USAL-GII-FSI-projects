package POJO;


import java.util.logging.Level;
import java.util.logging.Logger;

public class Box implements Cloneable {
    private final static Logger LOGGER = Logger.getLogger("POJO.Box");

    private int id;
    private int diaentrada;
    private int diasalida;

    public Box(int ID, int diaentrada, int diasalida) {
        this.id = ID;
        this.diaentrada = diaentrada;
        this.diasalida = diasalida;
        LOGGER.log(Level.INFO, String.format("Box: new [%s]", this.toString()));
    }

    @Override
    public Object clone(){
        return new Box(this.id,this.diaentrada,this.diasalida);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Box)) return false;

        Box box = (Box) o;

        if (getId() != box.getId()) return false;
        if (getDiaentrada() != box.getDiaentrada()) return false;
        return getDiasalida() == box.getDiasalida();
    }

    @Override
    public int hashCode() {
        int result = getId();
        result = 31 * result + getDiaentrada();
        result = 31 * result + getDiasalida();
        return result;
    }

    @Override
    public String toString() {
        return ("Box(" + id + ", " + diaentrada + ", " + diasalida + ")");
    }

    public int getId() {
        return id;
    }

    public int getDiaentrada() {
        return diaentrada;
    }

    public int getDiasalida() {
        return diasalida;
    }

}
