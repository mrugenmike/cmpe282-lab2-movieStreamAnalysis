/*Count of HD video titles watched using different protocols.*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId:chararray,TitleID:chararray,VideoTitles:chararray,VideoCategory:chararray,Region:chararray,DeviceType:chararray,StreamType:chararray,StreamBandwidth:int,StreamingProtocol:chararray);
movies = filter inputFile by Region!='Region'; -- filtered the headerline

HD_videoTitles = filter movies by StreamType=='HD';
groupByProtocol = group HD_videoTitles by StreamingProtocol;
HDTitlesByProtocol = foreach groupByProtocol {
unique_video_titles = DISTINCT HD_videoTitles.VideoTitles;
generate group,COUNT(unique_video_titles);
 }

store HDTitlesByProtocol into 'q5solution';