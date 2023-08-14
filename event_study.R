#perform statistical pre-treatment PTA check

#create a date variable in months
trips_triple_by_day <- trips_triple_by_day %>%
  mutate(start_time_month=trunc(start_time_day, unit='months'))


#filter to non-member
pta_check_df <- trips_triple_by_day %>%
  filter(non_member==1)

#create factor variable, R throws an error in the regression if you don't do this
pta_check_df$start_time_month <- factor(pta_check_df$start_time_month)

#build regression (this is equation 3)
reg_month_pta_check <- feols(log(n) ~ i(start_time_month, ref='2019-01-01')*treat, vcov='hetero', data=pta_check_df)

#output reg table
etable(reg_month_pta_check)


#export a reg table (this is only used to copy-paste the output into Word, I recommend using Latex)
#this is table 4

model_pta_check <- list(
  'OLS' = reg_month_pta_check
)

model_pta_check_output <- msummary(model_pta_check,
                              statistic=NULL,
                              estimate='{estimate} ({std.error}) {stars}',
                              gof_omit = 'BIC|AIC|R2 Within|R2 Within Adj.|RMSE',
                              coef_rename = c('Intercept','Feb','Mar','Apr','May','June','July','Aug','Sep','Oct','Nov','Dec','Treat (NYC)',
                                              'Treat x Feb','Treat x Mar','Treat x Apr','Treat x May','Treat x June','Treat x July','Treat x Aug','Treat x Sep','Treat x Oct','Treat x Nov','Treat x Dec'),
                              stars = TRUE,
                              font_size = 8, 
                              title = 'Table n',
)

model_pta_check_output
