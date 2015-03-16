/* In the year 2013, how many videotitles were streamed through Gaming console?*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId:chararray,TitleID:chararray,VideoTitles:chararray,VideoCategory:chararray,Region:chararray,DeviceType:chararray,StreamType:chararray,StreamBandwidth:int,StreamingProtocol:chararray,VideoPlayedTime:chararray);
movies = filter inputFile by Region!='Region'; -- filtered the headerline

convertedInProperDate = FOREACH movies GENERATE UserId,VideoTitles,Region,DeviceType,ToDate(VideoPlayedTime,'MM/dd/yyyy H:m') as date;
fltrdByGamingConsoleAndYear = filter convertedInProperDate by DeviceType=='gaming console' AND GetYear(date)==13;

result = foreach (GROUP fltrdByGamingConsoleAndYear ALL) {
generate COUNT(fltrdByGamingConsoleAndYear.VideoTitles);
};

store result into 'q10';
