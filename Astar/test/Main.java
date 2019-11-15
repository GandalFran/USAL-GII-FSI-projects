import AStar.AStar;
import AStar.AStarState;
import AStar.AStartResult;
import AStar.exceptions.NoAvailableStatesException;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;

public class Main {

    public static void main(String[] args) throws InterruptedException {

        AStartResult result = null;
        AStar aStar = new AStar();

        //System.out.println(initialState().getGn());

        //System.exit(0);

        try{
            aStar.initialize();
            result = aStar.run(initialState());
        }catch (NoAvailableStatesException e){
            System.out.println("Unable to find solution for initial state: \n " + initialState().toString());
            System.exit(0);
        }
        printSolution(result);
    }


    public static AStarState initialState(){
        return TestLoader.loadState("test1");
    }

    public static void printSolution(AStartResult result){
        System.out.println(String.format("\n\n%50s"," ").replace(" ","="));
        System.out.println("\tSTATS");
        System.out.println(String.format("%50s"," ").replace(" ","="));
        System.out.println("\t\tExplored nodes:  " + (result.getNumOpened() + result.getNumClosed()));
        System.out.println("\t\tOpened nodes:    " + result.getNumOpened());
        System.out.println("\t\tClosed nodes:    " + result.getNumClosed());
        System.out.println("\t\tSolution length: " + result.getSolution().size());
        System.out.println("\t\tElapsed time:    " + secondsToDurationStr(result.getElapsedTime()));
        System.out.println(String.format("%50s"," ").replace(" ","="));
        System.out.println("\tINITIAL STATE");
        System.out.println(String.format("%50s"," ").replace(" ","="));
        System.out.println(result.getInitialState().toString().replace("\n","\n\t"));
        System.out.println(String.format("\n%50s"," ").replace(" ","="));
        System.out.println("\tFINAL STATE");
        System.out.println(String.format("%50s"," ").replace(" ","="));
        System.out.println(result.getFinalState().toString().replace("\n","\n\t"));
        System.out.println(String.format("\n%50s"," ").replace(" ","="));

        System.out.println("Print detailed solution? (Y/N)");
        String solution;
        do{
            solution = new Scanner(System.in).next();
        }while(!solution.toUpperCase().equals("N") && !solution.toUpperCase().equals("Y"));
        if(solution.toUpperCase().equals("N"))
            return;

        System.out.println(String.format("%50s"," ").replace(" ","="));
        System.out.println("\tSOLUTION");
        System.out.println(String.format("%50s"," ").replace(" ","="));
        for(int i=0; i<result.getSolution().size(); i++){
            System.out.print("\n\tSTATE " + i + ": ");
            System.out.print(result.getSolution().get(i).toString().replace(" ","="));
        }
    }

    public static String secondsToDurationStr(long millis){
        long hours = TimeUnit.MILLISECONDS.toHours(millis);
        long minutes = TimeUnit.MILLISECONDS.toMinutes(millis) - TimeUnit.MINUTES.toMinutes(TimeUnit.MILLISECONDS.toHours(millis));
        long seconds = TimeUnit.MILLISECONDS.toSeconds(millis) - TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millis))- TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toHours(millis));
        return String.format("%02d:%02d:%02d", hours, minutes, seconds);
    }
}
