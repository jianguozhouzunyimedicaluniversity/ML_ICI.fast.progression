roc.list.train <- pROC::roc(FPFL ~ GLM + LASSO + SVM + DT + RF + XGBoost + GBM, levels = c(0,1),direction='<',data = train.roc_data)
roc.list.test1 <- pROC::roc(FPFL ~ GLM + LASSO + SVM + DT + RF + XGBoost + GBM, levels = c(0,1),direction='<',data = test1.roc_data)
roc.list.test2 <- pROC::roc(FPFL ~ GLM + LASSO + SVM + DT + RF + XGBoost + GBM, levels = c(0,1),direction='<',data = test2.roc_data)

g.list.train <- pROC::ggroc(roc.list.train, legacy.axes = TRUE,aes=c("linetype", "color")) + 
  theme_bw() + # 更换黑白主题，默认为theme_grey() 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +  # 隐藏主、次网格线  
  scale_color_lancet() + 
  geom_segment(aes(x = 0, xend = 1, y = 0, yend = 1), color="darkgrey", linetype="dashed")+
  ggtitle("ROC curve in train cohort") +  
  xlab("1-Specificity") + ylab("Sensitivity") + 
  theme(legend.position = "none")+    
  annotate("text", x = 0.6, y = 0.4-0.05*1, label = model_x_train_legend.name[1],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*2, label = model_x_train_legend.name[2],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*3, label = model_x_train_legend.name[3],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*4, label = model_x_train_legend.name[4],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*5, label = model_x_train_legend.name[5],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*6, label = model_x_train_legend.name[6],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*7, label = model_x_train_legend.name[7],hjust = 0)


g.list.test1 <- pROC::ggroc(roc.list.test1, legacy.axes = TRUE,aes=c("linetype", "color")) + 
  theme_bw() + # 更换黑白主题，默认为theme_grey() 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +  # 隐藏主、次网格线  
  scale_color_lancet() + 
  geom_segment(aes(x = 0, xend = 1, y = 0, yend = 1), color="darkgrey", linetype="dashed")+
  ggtitle("ROC curve in validation cohort 1") +  
  xlab("1-Specificity") + ylab("Sensitivity") + 
  theme(legend.position = "none")+    
  annotate("text", x = 0.6, y = 0.4-0.05*1, label = model_x_test1_legend.name[1],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*2, label = model_x_test1_legend.name[2],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*3, label = model_x_test1_legend.name[3],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*4, label = model_x_test1_legend.name[4],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*5, label = model_x_test1_legend.name[5],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*6, label = model_x_test1_legend.name[6],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*7, label = model_x_test1_legend.name[7],hjust = 0)


g.list.test2 <- pROC::ggroc(roc.list.test2, legacy.axes = TRUE,aes=c("linetype", "color")) + 
  theme_bw() + # 更换黑白主题，默认为theme_grey() 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +  # 隐藏主、次网格线  
  scale_color_lancet() + 
  geom_segment(aes(x = 0, xend = 1, y = 0, yend = 1), color="darkgrey", linetype="dashed")+
  ggtitle("ROC curve in validation cohort 2") +  
  xlab("1-Specificity") + ylab("Sensitivity") + 
  theme(legend.position = "right")+    
  annotate("text", x = 0.6, y = 0.4-0.05*1, label = model_x_test2_legend.name[1],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*2, label = model_x_test2_legend.name[2],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*3, label = model_x_test2_legend.name[3],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*4, label = model_x_test2_legend.name[4],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*5, label = model_x_test2_legend.name[5],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*6, label = model_x_test2_legend.name[6],hjust = 0)+
  annotate("text", x = 0.6, y = 0.4-0.05*7, label = model_x_test2_legend.name[7],hjust = 0) 

up = g.list.train|g.list.test1|g.list.test2

# down auc------
Barplot_data = rbind(train_auc,test1_auc,test2_auc)
Barplot_data$cohort = c(rep("train", 7),rep("test1",7 ),rep("test2", 7))
Barplot_data$AUC = as.numeric(Barplot_data$AUC)

Barplot_data = Barplot_data %>% 
  mutate(Predictor = forcats::fct_relevel(Predictor, "GLM", "LASSO", "SVM", "DT", "RF", "XGBoost", "GBM"))

down = ggplot(Barplot_data,aes(x = Predictor, y = AUC,
                               ymin = 0, ymax = 1))+
  theme_bw() + # 更换黑白主题，默认为theme_grey() 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +  # 隐藏主、次网格线  
  geom_boxplot(aes(color = Predictor))+
  scale_color_lancet()+
  # geom_jitter(color="black", size=0.4, alpha=0.9) +
  geom_hline(yintercept=0.75, color="darkgrey", linetype="dashed")+
  ggtitle("AUC value of each models") 