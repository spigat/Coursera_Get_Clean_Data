# I imported in r-studio all necessary files (X_test,X_train,Y_test,Y_train, features,subject_test,subject_train)

#1 Merge test and train dataset
total <- rbind(X_test, X_train)
#2 Extracts columns means and stds 
Allmeans<-colMeans(total)
Allsd<-apply(total, 2, sd)

#3 Name activities in full dataset
activ<-rbind(y_test,y_train) #rowbind column activities from test and train dataset
total<-cbind(total,activ)   # colbind activities in total dataset
total<-cbind(total,activ) #creates a new column (that will take description in next step)

total[,563]<-activity_labels[match(total[,562],activity_labels[,1]),2]

#4 Appropriate labels the dataset with descriptivwe activity names
names(total)<-features[,2]
names(total)[562] <- "Activity_Nr"
names(total)[563] <- "Activity_Descr"

subj<-rbind(subject_test,subject_train) #rowbind column subject from test and train dataset
total<-cbind(total,subj)   # colbind subject in total dataset
names(total)[564] <- "Subject" 

total<-cbind(total[,1:561],total[,563:564]) #remove column 562 Activity_Nr
tidy<-aggregate(.~total$Activity_Descr+total$Subject,data=total, mean )

write.csv(tidy, "tidydataset.csv")
write.table(tidy, "tidydataset.txt", sep="\t")
#End
