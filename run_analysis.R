subject_train<-read.table("./train/subject_train.txt")



X_train<-read.table("./train/X_train.txt")
Y_train<-read.table("./train/Y_train.txt")

subject_test<-read.table("./test/subject_test.txt")
X_test<-read.table("./test/X_test.txt")
Y_test<-read.table("./test/Y_test.txt")

activity_labels<-read.table("./activity_labels.txt")
features<-read.table("./features.txt")


train_subject_y<-cbind(subject_train, Y_train) ##Unimos el sujeto y la vble y 

##Renombro las variables 
names(train_subject_y)[1]<-"subject"
names(train_subject_y)[2]<-"Y"

View(train_subject_y)



##Hacemos lo mismo para el training
test_subject_y<-cbind(subject_test, Y_test) ##Unimos el sujeto y la vble y 
##Renombro las variables 
names(test_subject_y)[1]<-"subject"
names(test_subject_y)[2]<-"Y"


View(test_subject_y)



names(X_train)<-features$V2 ####Renombro las variables de X train con los nombres de features$V2
names(X_test)<-features$V2 ####Renombro las variables de X test con los nombres de features$V2

train<-cbind(train_subject_y, X_train) ##Unimos todos los subconjuntos de train
test<-cbind(test_subject_y, X_test)  ##Unimos todos los subconjuntos de test

View(train)


fin<-rbind(train,test) ##Creamos el conjunto final
View(fin)
fin_label=merge(activity_labels, fin, by.x="V1", by.y="Y", all=FALSE, sort=FALSE)
View(fin_label)

##Renombramos las dos variables que nos quedan
names(fin_label)[1]<-"Y"
names(fin_label)[2]<-"Activity"

##Ahora nos quedamos sólo con las variables de media y desviación de datos de cada vble
final_1<-fin_label[1:9]
final_2<-fin_label[44:49]
final_3<-fin_label[84:89]
final<-cbind(final_1, final_2, final_3)
head(fin_label[89])
View(final)

#rfinal<- reshape(final, timevar="Activity", idvar = "subject" , direction = "wide")
#View(rfinal2)



#Para hacer la media de cada variable
tidydata <-ddply(final,.(subject,Activity),numcolwise(mean))
View(tidydata)

write.table (tidydata, file = "tidydata.txt", sep = " ") 

#rfinal2<-tapply(final[3:21], final$Activity, mean)


