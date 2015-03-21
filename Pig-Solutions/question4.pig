/*List the video titles that are most popular (top 5) among the users*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId:chararray,TitleID:chararray,VideoTitles:chararray,VideoCategory:chararray,Region:chararray,DeviceType:chararray,StreamType:chararray,StreamBandwidth:int);
describe inputFile;
movies = filter inputFile by Region!='Region'; -- filtered the headerline
grpByTitle = group movies by VideoTitles;
countPerTitle = foreach grpByTitle{
	unique_users = DISTINCT movies.UserId;
	generate group, COUNT(unique_users) as user_count;
	} 
ordered_By_userCount = order countPerTitle by user_count DESC;
top5Titles = limit ordered_By_userCount 5;
store top5Titles into 'question4-solution';

