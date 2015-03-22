package mahout.tut.recommender;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.impl.common.LongPrimitiveIterator;
import org.apache.mahout.cf.taste.impl.model.file.FileDataModel;
import org.apache.mahout.cf.taste.impl.neighborhood.ThresholdUserNeighborhood;
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender;
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity;
import org.apache.mahout.cf.taste.model.DataModel;
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.similarity.UserSimilarity;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class UserRecommender {
    public static void main(String[] args) {
        try {
            DataModel model = new FileDataModel(new File("/Users/mrugen/Documents/Spring 2015/CMPE 282/Lab-2/MahoutTutorial/data/ratings.csv"));
            UserSimilarity userSimilarity = new PearsonCorrelationSimilarity(model);

            UserNeighborhood userNeighborhood = new ThresholdUserNeighborhood(0.1,userSimilarity,model);
            GenericUserBasedRecommender recommender = new GenericUserBasedRecommender(model, userNeighborhood,userSimilarity);

            for(LongPrimitiveIterator prim = model.getUserIDs(); prim.hasNext();){
                long userID = prim.nextLong();
                List<RecommendedItem> recommendedItems = recommender.recommend(userID, 3);

                for(RecommendedItem recommendation : recommendedItems){
                    System.out.println("UserID:"+userID+ "  MovieID: "+recommendation.getItemID()+" Recommendation-Value:"+recommendation.getValue());
                }
            }
        } catch (IOException e) {
            System.out.println("There was an error.");
            e.printStackTrace();
        } catch (TasteException e) {
            System.out.println("There was a taste error.");
            e.printStackTrace();
        }

    }
}
