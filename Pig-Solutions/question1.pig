/* No of Video Titles watched in different regions.*/
inputFile = load 'movies.csv' using PigStorage(',') as (UserId,TitleID,VideoTitles,VideoCategory,Region);
describe inputFile;
movies = filter inputFile by Region!='Region';
groupedByRegion = group movies by Region;
describe groupedByRegion;
noOfVideoTilesWatchedPerRegion = foreach groupedByRegion generate group,COUNT(movies.Region);
dump noOfVideoTilesWatchedPerRegion;