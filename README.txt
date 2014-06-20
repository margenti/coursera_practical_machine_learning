coursera_practical_machine_learning
===================================

course project

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about
personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of
enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior,
or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do,
but they rarely quantify how well they do it. In this project, your goal will be to use data from accelerometers on the
belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in
5 different ways
The goal of your project is to predict the manner in which they did the exercise. This is the "classe" variable in the
training set. You may use any of the other variables to predict with. You should create a report describing how you built
your model, how you used cross validation, what you think the expected out of sample error is, and why you made the
choices you did. You will also use your prediction model to predict 20 different test cases.

################
Cross validation
################

Cross-validation is a model validation technique used to evaluate how the results of a statistical analysis can be
generalized to a set of independent data. Notice that in a prediction problem it is normal to have a set of data you
can develop your model with (training data) and another set, treated like unknown data, you can test your model with
(testing data).
In this exercise, you can use an important set of data (with an high number of cases) and you will know its
classification by the proposed categories (A,B,C,D,E). To do a cross-validation, you need to divide the data in
two groups: on one side you will have the training data and on the other side you will have the testing data. So,
in this manner, you  can understand how good your model is.
To split the data I used the caret function “createDataPartition”, and the datas has been  splitted in various size
to test more than one option, in particular I used training data=20%, 50%, 60%, 80% of the total data. Anyway for
the final model I used training=60% of total data, like it was explained in course video lectures.

------------------------
trainIndex <- createDataPartition(y = validData$classe, p=0.6,list=FALSE)

trainData <- validData[trainIndex,]
testData <- validData[-trainIndex,]
------------------------

###################################
Preparing training and testing data
###################################

The data for this project come from this source: http://groupware.les.inf.puc-rio.br/har. It contains a big variety
of information and not all the data are relevant. First of all, it is neccesary filter some irrelevant fields, like
timestamp, X, user_name, new_window.. These fields can deteriorate training results.
In the second hand, it is not possible to use all variables. There are computer time restrictions to use them. A set
of 39 variables (that you can see in the R code) have been selected for use in training stage. It could be a good
improvement in accuracy results to have a better computer performance  and, in this way to use more variables.
Finally, it is required another filter to remove NA values in testing data. These NA values could interfere in
accuracy calculation.

##############
Training phase
##############

For training stage it has been used caret R package, in particular train function. This function allows different
configurations and several training and preprocessing  methods. It has been tested with these training methods:

-	Bayesian generalized linear model – bayesglm.
-	Neural network - nnet . 
-	CART – rpart.
-	Linear discriminant analysis – lda. 
-	Naive bayes – nb.
-	Random forest – rf. 
-	Support vector machine with linear kernel – svmLinear. 
-	k-nearest neighbors – knn.

In sample error section it will be shown accuracy values obtained for some important combination of different methods

############
Sample error
############

With testing data and “predict” Caret-function we can make an idea of the accuracy of the model constructed with the
training data. Here we will give you a table with some results obtained with different configurations of training
and preprocessing

--------------------------------------------------------------------------------------------------------------------------
Method   Pre-process            Training data rate   Testing data rate      Accuracy
knn      None                   20%                  80%                    73%
rf       None                   20%                  80%                    96%
knn      None                   60%                  40%                    87%
rf       None                   60%                  40%                    98.8%
knn      c("center","scale")    60%                  40%                    93.7%
rf       c("center","scale")    60%                  40%                    99.3%
--------------------------------------------------------------------------------------------------------------------------

########
Boosting
########

I also did a “manual” boosting to evaluate the data. It consisted in taking the results of several different
models (i will call the models h_i, i=1,…,N and the respective result h_i(x) where x is the test case)and take
the mean result of them. To do this, i changed the results into numbers, it means A=1, B=2, C=3, D=4, E=5,
(i assumed that A and B are nearer than A and C and so on) and i took the function f(x) = sum(h_i(x))/N 
So the final result i submitted was the result of f(x)
