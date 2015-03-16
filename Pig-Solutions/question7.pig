/*What is the number of videotitles seen by the user who saw videotitle “A  cause for Thankfulness”*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId:chararray,TitleID:chararray,VideoTitles:chararray,VideoCategory:chararray,Region:chararray,DeviceType:chararray,StreamType:chararray,StreamBandwidth:int,StreamingProtocol:chararray);
movies = filter inputFile by Region!='Region'; -- filtered the headerline

records_with_cause_movie = filter movies by VideoTitles=='A Cause for Thankfulness ';
filteredByRequiredUserId = filter movies by UserId==records_with_cause_movie.$0;

grpByAll = GROUP filteredByRequiredUserId ALL;
describe grpByAll;
titlesWatchedByUser = foreach grpByAll {
generate records_with_cause_movie.$0,COUNT(grpByAll.filteredByRequiredUserId.VideoTitles);
};

store titlesWatchedByUser into 'q7solution';

