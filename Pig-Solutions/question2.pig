/* No of users streaming video titles in the US experience maximum stream bandwidth.*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId,TitleID,VideoTitles,VideoCategory,Region,DeviceType,StreamType,StreamBandwidth:int);
describe inputFile;
movies = filter inputFile by Region!='Region'; -- filtered the headerline
orderByStreamBandwidth =  ORDER movies BY StreamBandwidth DESC; 
maxBandwidth_record = LIMIT orderByStreamBandwidth 1;

USBasedUsersWithMaxBandWidth = filter movies BY Region=='US' and StreamBandwidth==maxBandwidth_record.$7;
countOfUSBasedUsersWithMaxBandWidth =  FOREACH (GROUP USBasedUsersWithMaxBandWidth ALL){
unique_user_id = DISTINCT USBasedUsersWithMaxBandWidth.UserId;
GENERATE COUNT(unique_user_id);
};
store countOfUSBasedUsersWithMaxBandWidth into 'pig-question2-solution';

