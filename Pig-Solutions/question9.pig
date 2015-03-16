/*What is the number of users in US who saw videotitles on TV in December 2013.*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId:chararray,TitleID:chararray,VideoTitles:chararray,VideoCategory:chararray,Region:chararray,DeviceType:chararray,StreamType:chararray,StreamBandwidth:int,StreamingProtocol:chararray,VideoPlayedTime:chararray);
movies = filter inputFile by Region!='Region'; -- filtered the headerline
fltrdByRegionAndDEvice = filter movies by Region=='US' AND DeviceType=='tv';
convertedInProperDate = FOREACH fltrdByRegionAndDEvice GENERATE UserId,VideoTitles,Region,DeviceType,ToDate(VideoPlayedTime,'MM/dd/yyyy H:m') as date;
filteredByMonthAndYear= filter convertedInProperDate by GetMonth(date)==12 AND GetYear(date)==13;
groupedByAll = GROUP filteredByMonthAndYear ALL;
noOfUsers = FOREACH groupedByAll {
unique_user_who_watched= DISTINCT filteredByMonthAndYear.$0;
GENERATE group,COUNT(unique_user_who_watched);
};

store noOfUsers into 'q9solution';



