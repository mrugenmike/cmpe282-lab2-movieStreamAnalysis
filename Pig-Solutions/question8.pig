/*Name the videotitle belonging to “Thriller” category, watched on “Tablet” in “UK” region at “400” stream bandwidth*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId:chararray,TitleID:chararray,VideoTitles:chararray,VideoCategory:chararray,Region:chararray,DeviceType:chararray,StreamType:chararray,StreamBandwidth:int,StreamingProtocol:chararray);
movies = filter inputFile by Region!='Region'; -- filtered the headerline

filteredByCriteria = filter movies by VideoCategory=='Thriller' AND DeviceType=='tablet' AND  Region=='UK' AND StreamBandwidth==400;

titles = foreach (GROUP filteredByCriteria ALL){
generate filteredByCriteria.VideoTitles;
}

store titles into 'q8solution';