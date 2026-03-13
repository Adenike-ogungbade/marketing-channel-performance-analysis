-- ROI and profit by channel
SELECT cp.channel,
	   SUM(cp.spend_naira) AS total_spend,
       SUM(ra.total_revenue_naira) AS total_revenue,
       SUM(ra.total_revenue_naira) - SUM(cp.spend_naira) AS profit,
       SUM(ra.total_revenue_naira) / SUM(cp.spend_naira) AS ROI
FROM 01_campaign_performance cp
JOIN 03_revenue_analysis ra
	ON cp.channel = ra.channel
GROUP BY channel
ORDER BY profit DESC;


-- retention analysis
SELECT channel,
	   AVG(month_1_active / cohort_size) AS month1_retention,
       AVG(month_3_active / cohort_size) AS month3_retention,
       AVG(month_6_active / cohort_size) AS month6_retention,
       AVG(month_9_active / cohort_size) AS month9_retention,
       AVG(month_12_active / cohort_size) AS month12_retention,
       AVG(month_18_active / cohort_size) AS month18_retention
FROM 02_user_cohorts
GROUP BY channel
ORDER BY channel DESC;


-- revenue analysis
SELECT channel,
	   SUM(total_revenue_naira) AS total_revenue,
       SUM(active_users) AS active_users,
       AVG(arpu_naira) AS avg_arpu
FROM 03_revenue_analysis
GROUP BY channel
ORDER BY total_revenue DESC;


-- customer acquisition cost by channel
SELECT channel,
	   SUM(spend_naira) AS total_spend,
       SUM(activated_users) AS activated_users,
       SUM(spend_naira) / SUM(activated_users) AS customer_acquistion_cost
FROM 01_campaign_performance
GROUP BY channel
ORDER BY customer_acquistion_cost DESC;


-- total spend by channel
SELECT channel,
	   SUM(spend_naira) AS total_spend,
       SUM(impressions) AS total_impressions,
       SUM(clicks) AS total_clicks,
       SUM(total_users) AS total_users,
       SUM(activated_users) AS activated_users,
       SUM(clicks) / SUM(impressions) AS click_through_rate,
       SUM(activated_users) / SUM(clicks) AS conversion_rate
FROM 01_campaign_performance
GROUP BY channel
ORDER BY total_spend DESC;
