predict  <- function() {
    library(caret)
    trainRawData <- read.csv("pml-training.csv")
    NAs <- apply(trainRawData,2,function(x) {sum(is.na(x))}) 
    validData <- trainRawData[,which(NAs == 0)]
    trainIndex <- createDataPartition(y = validData$classe, p=0.6,list=FALSE)
    trainData <- validData[trainIndex,]
    testData <- validData[-trainIndex,]
    removeIndex <- grep("timestamp|X|user_name|new_window",names(trainData))
    trainData <- trainData[,-removeIndex]
    modFit <- train(trainData$classe ~ roll_belt + pitch_belt + yaw_belt + gyros_belt_x + gyros_belt_y + gyros_belt_z + accel_belt_x + accel_belt_y + accel_belt_z + magnet_belt_x + magnet_belt_y + magnet_belt_z + gyros_arm_x + gyros_arm_y + gyros_arm_z + accel_arm_x + accel_arm_y + accel_arm_z + magnet_arm_x + magnet_arm_y + magnet_arm_z + gyros_dumbbell_x + gyros_dumbbell_y + gyros_dumbbell_z + accel_dumbbell_x + accel_dumbbell_y + accel_dumbbell_z + magnet_dumbbell_x + magnet_dumbbell_y + magnet_dumbbell_z + gyros_forearm_x + gyros_forearm_y + gyros_forearm_z + accel_forearm_x + accel_forearm_y + accel_forearm_z + magnet_forearm_x + magnet_forearm_y + magnet_forearm_z,data = trainData,preProcess=c("center","scale"),method="rf")
    NAs <- apply(testData,1,function(x) {sum(is.na(x))}) 
    validTest <- testData[which(NAs == 0),]
    print(confusionMatrix(predict(modFit,validTest),validTest$classe))
    test_clase <- read.csv("pml-testing.csv")
    prediction <- predict(modFit,test_clase)
    prediction
}
