/* No of Video Titles watched in different regions.*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId,TitleID,VideoTitles,VideoCategory,Region);
describe inputFile;
movies = filter inputFile by Region!='Region';
groupedByRegion = group movies by Region;
describe groupedByRegion;
noOfVideoTilesWatchedPerRegion = foreach groupedByRegion generate group,COUNT(movies.Region);
store noOfVideoTilesWatchedPerRegion into 'pig-question1';

