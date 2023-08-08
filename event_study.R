#perform statistical pre-treatment PTA check
trips_triple_by_day <- trips_triple_by_day %>%
  mutate(start_time_month=trunc(start_time_day, unit='months'))


#get pre-treatment df
pta_check_df <- trips_triple_by_day %>%
  filter(non_member==1)

# pta_check_df$start_time_month <- unlist(pta_check_df$start_time_month)
pta_check_df$start_time_month <- factor(pta_check_df$start_time_month)

#build regression
# reg_pta_check <- feols(log(n) ~ start_time_day*treat, data=pta_check_df)

reg_month_pta_check <- feols(log(n) ~ i(start_time_month, ref='2019-01-01')*treat, data=pta_check_df)


# etable(reg_pta_check)

etable(reg_month_pta_check)


#export a reg table

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
