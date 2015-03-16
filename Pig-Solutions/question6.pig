/*What is the number of distinct users who saw maximum videotitles.*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId:chararray,TitleID:chararray,VideoTitles:chararray,VideoCategory:chararray,Region:chararray,DeviceType:chararray,StreamType:chararray,StreamBandwidth:int,StreamingProtocol:chararray);
movies = filter inputFile by Region!='Region'; -- filtered the headerline

groupByUserId = group movies by UserId;

UserIdWithTitlesWatched = foreach groupByUserId {
unique_video_titles = DISTINCT movies.VideoTitles ;
generate group,COUNT(unique_video_titles) as titlesWatchedCount;
};

describe UserIdWithTitlesWatched;
groupByTitlesWatched = group UserIdWithTitlesWatched by titlesWatchedCount;

describe groupByTitlesWatched;
UniqueUsersWithMaxTitles = foreach groupByTitlesWatched {
generate group as VideoTitlesWatched,COUNT(UserIdWithTitlesWatched.group) as UserIdCount;
};
describe UniqueUsersWithMaxTitles;
orderBYMaxTitles = order UniqueUsersWithMaxTitles by VideoTitlesWatched DESC;
maxTitlesWatched_NoOfDistinctUsersWatchingThem = limit orderBYMaxTitles 1;
store maxTitlesWatched_NoOfDistinctUsersWatchingThem into 'q6solution';

