package mahout.tut.convert;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;


/**
 cat u.data | cut -f1,2,3 | tr "\\t" "," --- in Unix systems
*/
public class ConvertMovieLens {

	
	public static void main(String args[]) throws IOException{
		BufferedReader br = new BufferedReader(new FileReader("/Users/mrugen/Documents/Spring 2015/CMPE 282/Lab-2/MahoutTutorial/data/ratings.dat"));
		BufferedWriter bw = new BufferedWriter(new FileWriter("/Users/mrugen/Documents/Spring 2015/CMPE 282/Lab-2/MahoutTutorial/data/ratings.csv"));
		
		String line;
		while((line = br.readLine())!= null){
			String[] values = line.split("::", -1);
			bw.write(values[0]+ ","+values[1]+","+values[2]+"\n");
			
		}
		br.close();
		bw.close();
	}
}
