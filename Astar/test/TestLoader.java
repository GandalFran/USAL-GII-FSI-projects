import POJO.Box;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import com.google.gson.Gson;

public class TestLoader {

    public static String getTestFileWithName(String testName){
        File f = new File("."+ File.separator + "test" + File.separator + "resources" + File.separator + testName + ".json");
        return f.getAbsolutePath();
    }

    public static List<Box> getBoxes(String path){
        List<Box> boxes;
        Gson g = new Gson();

        try{
            String fileText = TestLoader.readFile(path);
            boxes = Arrays.asList(g.fromJson(fileText, Box[].class));
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
        return boxes;
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

