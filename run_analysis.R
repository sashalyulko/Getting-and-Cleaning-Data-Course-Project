## Load the subjects' id's:

testsubjects=read.table("test\\subjects_test.txt")
trainsubjects=read.table("train\\subjects_train.txt")

## Load activity list and the measurement data:

Xtest=read.table("test\\X_test.txt")
Xtrain=read.table("train\\X_train.txt")

ytest=read.table("test\\y_test.txt")
ytrain=read.table("train\\y_train.txt")

## Combine subjects and activity labels:

test=cbind(testsubjects, ytest)
train=cbind(trainsubjects, ytrain)
subjects_and_labels=rbind(test, train)
names(subjects_and_labels)=c("Subjects", "Activities")

## Combine test and training data sets:

observations=rbind(Xtest, Xtrain)

## Extract only data for the mean and standard deviation for each measurement:

mean_std_vector = c(1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215,
227, 228, 240, 241, 253, 254, 266:271, 345:350, 424:429, 503, 504, 516, 517,
529, 530, 542, 543)
mean_std_obs = observations[, mean_std_vector]

## Label the new set of variables with the descriptive labels, extracted
## from "features.txt":

features=read.table("features.txt")
variable_labels=features[mean_std_vector, 2]

names(mean_std_obs) = variable_labels

## Name activities with descriptive activity names:

activities = c("Walking", "Walking upstairs", "Walking downstairs",
"Sitting", "Standing", "Laying")

N=dim(subjects_and_labels)[1]
activity_column=sample(0, N, replace=N)

for (i in 1:N){
activity_column[i] = activities[subjects_and_labels[i, 2]]}
end

subjects_and_labels$Activities = activity_column

## Data set:

Data_set = cbind(subjects_and_labels, mean_std_obs)

## Write data set as a text file:

write.table(Data_set, file="samsung_data.txt", row.names=FALSE)
