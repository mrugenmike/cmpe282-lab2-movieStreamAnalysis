/*List the No of users that watch video titles on different devices.*/
inputFile = load 'stream_movie_data.csv' using PigStorage(',') as (UserId:chararray,TitleID:chararray,VideoTitles:chararray,VideoCategory:chararray,Region:chararray,DeviceType:chararray,StreamType:chararray,StreamBandwidth:int);
describe inputFile;
movies = filter inputFile by Region!='Region'; -- filtered the headerline

grpByDeviceType = group movies by DeviceType;
noOfUsersOnDifferentDevices = foreach grpByDeviceType {
unique_users = DISTINCT movies.UserId;
generate group, COUNT(unique_users) as Count;
};
store noOfUsersOnDifferentDevices into 'question3-solution';
