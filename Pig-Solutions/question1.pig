/* No of Video Titles watched in different regions.*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId,TitleID,VideoTitles,VideoCategory,Region);
describe inputFile;
movies = filter inputFile by Region!='Region';
groupedByRegion = group movies by Region;

noOfVideoTilesWatchedPerRegion = foreach groupedByRegion {
distinct_titles = distinct movies.VideoTitles;
generate group,COUNT(distinct_titles);
};
store noOfVideoTilesWatchedPerRegion into 'pig-question1';