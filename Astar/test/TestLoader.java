import AStarStorageImpl.StorageStarState;
import POJO.Box;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

import POJO.Storage;
import com.google.gson.Gson;

public class TestLoader {

    public static String getTestFileWithName(String testName){
        File f = new File("."+ File.separator + "test" + File.separator + "resources" + File.separator + testName + ".json");
        return f.getAbsolutePath();
    }

    public static StorageStarState loadState(String name){
        TestObject test;
        Gson g = new Gson();

        try{
            String testPath = TestLoader.getTestFileWithName(name);
            String fileText = TestLoader.readFile(testPath);
            test = g.fromJson(fileText, TestObject.class);
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }

        if((test.getNumStacks()*test.getNumBoxPerStack())<test.getBoxes().size()){
            System.err.println(
                    String.format("There are more boxes than allowed %d boxes, %d stacks and %d box per stack"
                            ,test.getBoxes().size(),test.getNumStacks(),test.getNumBoxPerStack())
            );
            System.exit(0);
        }

        Storage s = new Storage(test.getNumStacks(),test.getNumBoxPerStack());
        return new StorageStarState(test.getBoxes(),s);
    }

    private static String readFile(String path) throws Exception{
        List<String> inputList;
        Path p = new File( path ).toPath();

        inputList = Files.readAllLines( p );
        StringBuilder sb = new StringBuilder();
        inputList.forEach(element -> {
            sb.append(element);
        });

        return sb.toString();
    }
}


class TestObject {
    private Box[] boxes;
    private int numStacks;
    private int numBoxPerStack;

    public TestObject(){
        this.boxes = null;
        this.numStacks = 0;
        this.numBoxPerStack = 0;
    }

    public TestObject(Box[] boxes, int numBoxPerStack, int numStacks) {
        this.boxes = boxes;
        this.numStacks = numStacks;
        this.numBoxPerStack = numBoxPerStack;
    }

    public List<Box> getBoxes() {
        return Arrays.asList(boxes);
    }

    public void setBoxes(Box[] boxes) {
        this.boxes = boxes;
    }

    public int getNumBoxPerStack() {
        return numBoxPerStack;
    }

    public void setNumBoxPerStack(int numBoxPerStack) {
        this.numBoxPerStack = numBoxPerStack;
    }

    public int getNumStacks() {
        return numStacks;
    }

    public void setNumStacks(int numStacks) {
        this.numStacks = numStacks;
    }
}