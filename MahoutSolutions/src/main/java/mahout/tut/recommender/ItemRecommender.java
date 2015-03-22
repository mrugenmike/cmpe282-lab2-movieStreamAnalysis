package mahout.tut.recommender;
import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.impl.common.LongPrimitiveIterator;
import org.apache.mahout.cf.taste.impl.model.file.FileDataModel;
import org.apache.mahout.cf.taste.impl.recommender.GenericItemBasedRecommender;
import org.apache.mahout.cf.taste.impl.similarity.LogLikelihoodSimilarity;
import org.apache.mahout.cf.taste.model.DataModel;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.similarity.ItemSimilarity;

public class ItemRecommender {

	public static void main(String[] args) {
		try {
			DataModel model = new FileDataModel(new File("/Users/mrugen/Documents/Spring 2015/CMPE 282/Lab-2/MahoutTutorial/data/ratings.csv"));
			ItemSimilarity item = new LogLikelihoodSimilarity(model);
			GenericItemBasedRecommender gm = new GenericItemBasedRecommender(model, item);

			for(LongPrimitiveIterator prim = model.getItemIDs(); prim.hasNext();){
				long itemID = prim.nextLong();
				List<RecommendedItem> recommendedItems = gm.mostSimilarItems(itemID, 3);

				for(RecommendedItem recommendation : recommendedItems){
					System.out.println("MovieId:"+itemID+ "  SimilarMovieId: "+recommendation.getItemID()+" Recommendation-Value:"+recommendation.getValue());
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
