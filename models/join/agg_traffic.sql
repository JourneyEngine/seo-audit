SELECT 
date,
site,
domain,
url,
ifnull(sum(impressions_30d), 0) impressions_30d,
ifnull(max(total_impressions_30d), 0) total_impressions_30d,
ifnull(max(med_impressions_30d), 0) med_impressions_30d,
ifnull(max(top_10pct_impressions_30d), 0) top_10pct_impressions_30d,
ifnull(sum(clicks_30d), 0) clicks_30d,
ifnull(max(total_clicks_30d), 0) total_clicks_30d,
ifnull(max(ctr_30d), 0) ctr_30d,
ifnull(max(med_ctr_30d), 0) med_ctr_30d,
ifnull(CASE WHEN max(total_impressions_30d) > 0 THEN max(total_clicks_30d) / max(total_impressions_30d) ELSE null END, 0) as total_ctr_30d,
ifnull(max(avg_position_30d), 0) avg_position_30d,
ifnull(sum(impressions_mom), 0) impressions_mom,
ifnull(max(total_impressions_mom), 0) total_impressions_mom,
ifnull(sum(clicks_mom), 0) clicks_mom,
ifnull(max(total_clicks_mom), 0) total_clicks_mom,
ifnull(max(ctr_mom), 0) ctr_mom,
ifnull(CASE WHEN max(total_impressions_mom) > 0 THEN max(total_clicks_mom) / max(total_impressions_mom) ELSE null END, 0) as total_ctr_mom,
ifnull(max(avg_position_mom), 0) avg_position_mom,
ifnull(sum(impressions_yoy), 0) impressions_yoy,
ifnull(max(total_impressions_yoy), 0) total_impressions_yoy,
ifnull(sum(clicks_yoy), 0) clicks_yoy,
ifnull(max(total_clicks_yoy), 0) total_clicks_yoy,
ifnull(max(ctr_yoy), 0) ctr_yoy,
ifnull(CASE WHEN max(total_impressions_yoy) > 0 THEN max(total_clicks_yoy) / max(total_impressions_yoy) ELSE null END, 0) as total_ctr_yoy,
ifnull(max(avg_position_yoy), 0) avg_position_yoy,
ifnull(sum(impressions_ttm), 0) impressions_ttm,
ifnull(sum(clicks_ttm), 0) clicks_ttm,
ifnull(max(ctr_ttm), 0) ctr_ttm,
ifnull(max(avg_position_ttm), 0) avg_position_ttm,
ifnull(sum(top_3_keywords), 0) top_3_keywords,
ifnull(sum(top_5_keywords), 0) top_5_keywords,
ifnull(sum(top_10_keywords), 0) top_10_keywords,
ifnull(sum(top_20_keywords), 0) top_20_keywords,
max(main_keyword) main_keyword,
max(main_impressions) main_impressions,
max(main_clicks) main_clicks,
max(main_avg_position) main_avg_position,
max(main_top_url) main_top_url,
max(main_top_url_clicks) main_top_url_clicks,
max(best_keyword) best_keyword,
max(best_impressions) best_impressions,
max(best_clicks) best_clicks,
max(best_avg_position) best_avg_position,
max(best_top_url) best_top_url,
max(best_top_url_clicks) best_top_url_clicks,
ifnull(sum(sessions_30d), 0) sessions_30d,
ifnull(max(total_organic_sessions_30d), 0) total_organic_sessions_30d,
ifnull(max(bottom_quartile_sessions_30d), 0) bottom_quartile_sessions_30d,
ifnull(max(med_sessions_30d), 0) med_sessions_30d,
ifnull(max(top_quartile_sessions_30d), 0) top_quartile_sessions_30d,	
ifnull(sum(transaction_revenue_30d), 0) transaction_revenue_30d,
ifnull(sum(transactions_30d), 0) transactions_30d,
ifnull(max(total_organic_transactions_30d), 0) total_organic_transactions_30d,
ifnull(max(ecommerce_conversion_rate_30d), 0) ecommerce_conversion_rate_30d,
ifnull(max(med_transaction_conversion_rate_30d), 0) med_transaction_conversion_rate_30d,
ifnull(CASE WHEN max(total_organic_sessions_30d) > 0 THEN max(total_organic_transactions_30d) / max(total_organic_sessions_30d) ELSE null END, 0) as total_organic_ecommerce_conversion_rate_30d,
ifnull(sum(goal_completions_all_goals_30d), 0) goal_completions_all_goals_30d,
ifnull(max(total_organic_goal_completions_all_goals_30d), 0) total_organic_goal_completions_all_goals_30d,
ifnull(max(goal_conversion_rate_all_goals_30d), 0) goal_conversion_rate_all_goals_30d,
ifnull(CASE WHEN max(total_organic_sessions_30d) > 0 THEN max(total_organic_goal_completions_all_goals_30d) / max(total_organic_sessions_30d) ELSE null END, 0) as total_organic_goal_conversion_rate_30d,
ifnull(max(blended_conversions_30d), 0) blended_conversions_30d,	
ifnull(max(blended_conversion_rate_30d), 0) blended_conversion_rate_30d,	
ifnull(max(bottom_quartile_blended_conversions_30d), 0) bottom_quartile_blended_conversions_30d,	
ifnull(max(med_blended_conversions_30d), 0) med_blended_conversions_30d,	
ifnull(max(top_quartile_blended_conversions_30d), 0) top_quartile_blended_conversions_30d,	
ifnull(max(bottom_quartile_blended_conversion_rate_30d), 0) bottom_quartile_blended_conversion_rate_30d,	
ifnull(max(med_blended_conversion_rate_30d), 0) med_blended_conversion_rate_30d,	
ifnull(max(top_quartile_blended_conversion_rate_30d), 0) top_quartile_blended_conversion_rate_30d, 
ifnull(max(bounce_rate_30d), 0) bounce_rate_30d,
ifnull(max(avg_seconds_on_site_30d), 0) avg_seconds_on_site_30d,
ifnull(max(med_goal_conversion_rate_30d),0) med_goal_conversion_rate_30d,
ifnull(sum(sessions_mom), 0) sessions_mom,
ifnull(max(total_organic_sessions_mom), 0) total_organic_sessions_mom,
ifnull(sum(transaction_revenue_mom), 0) transaction_revenue_mom,
ifnull(sum(transactions_mom), 0) transactions_mom,
ifnull(max(total_organic_transactions_mom), 0) total_organic_transactions_mom,
ifnull(max(ecommerce_conversion_rate_mom), 0) ecommerce_conversion_rate_mom,
ifnull(CASE WHEN max(total_organic_sessions_mom) > 0 THEN max(total_organic_transactions_mom) / max(total_organic_sessions_mom) ELSE null END, 0) as total_organic_ecommerce_conversion_rate_mom,
ifnull(sum(goal_completions_all_goals_mom), 0) goal_completions_all_goals_mom,
ifnull(max(total_organic_goal_completions_all_goals_mom), 0) total_organic_goal_completions_all_goals_mom,
ifnull(max(goal_conversion_rate_all_goals_mom), 0) goal_conversion_rate_all_goals_mom,
ifnull(CASE WHEN max(total_organic_sessions_mom) > 0 THEN max(total_organic_goal_completions_all_goals_mom) / max(total_organic_sessions_mom) ELSE null END, 0) as total_organic_goal_conversion_rate_mom,
ifnull(max(bounce_rate_mom), 0) bounce_rate_mom,
ifnull(max(avg_seconds_on_site_mom), 0) avg_seconds_on_site_mom,
ifnull(sum(sessions_yoy), 0) sessions_yoy,
ifnull(max(total_organic_sessions_yoy), 0) total_organic_sessions_yoy,
ifnull(sum(transaction_revenue_yoy), 0) transaction_revenue_yoy,
ifnull(sum(transactions_yoy), 0) transactions_yoy,
ifnull(max(total_organic_transactions_yoy), 0) total_organic_transactions_yoy,
ifnull(max(ecommerce_conversion_rate_yoy), 0) ecommerce_conversion_rate_yoy,
ifnull(CASE WHEN max(total_organic_sessions_yoy) > 0 THEN max(total_organic_transactions_yoy) / max(total_organic_sessions_yoy) ELSE null END, 0) as total_organic_ecommerce_conversion_rate_yoy,
ifnull(sum(goal_completions_all_goals_yoy), 0) goal_completions_all_goals_yoy,
ifnull(max(total_organic_goal_completions_all_goals_yoy), 0) total_organic_goal_completions_all_goals_yoy,
ifnull(max(goal_conversion_rate_all_goals_yoy), 0) goal_conversion_rate_all_goals_yoy,
ifnull(CASE WHEN max(total_organic_sessions_yoy) > 0 THEN max(total_organic_goal_completions_all_goals_yoy) / max(total_organic_sessions_yoy) ELSE null END, 0) as total_organic_goal_conversion_rate_yoy,
ifnull(max(bounce_rate_yoy), 0) bounce_rate_yoy,
ifnull(max(avg_seconds_on_site_yoy), 0) avg_seconds_on_site_yoy,
ifnull(sum(sessions_ttm), 0) sessions_ttm,
ifnull(sum(transaction_revenue_ttm), 0) transaction_revenue_ttm,
ifnull(sum(transactions_ttm), 0) transactions_ttm,
ifnull(max(ecommerce_conversion_rate_ttm), 0) ecommerce_conversion_rate_ttm,
ifnull(sum(goal_completions_all_goals_ttm), 0) goal_completions_all_goals_ttm,
ifnull(max(goal_conversion_rate_all_goals_ttm), 0) goal_conversion_rate_all_goals_ttm,
ifnull(max(bounce_rate_ttm), 0) bounce_rate_ttm,
ifnull(max(avg_seconds_on_site_ttm), 0) avg_seconds_on_site_ttm
FROM (

	SELECT 
	date,
	account,
	site,
	domain,
	url,
	impressions_30d,
	sum(impressions_30d) over w1 as total_impressions_30d,
	PERCENTILE_DISC(impressions_30d, 0.5 IGNORE NULLS) OVER w1 AS med_impressions_30d,
	PERCENTILE_DISC(impressions_30d, 0.9 IGNORE NULLS) OVER w1 AS top_10pct_impressions_30d,		
	clicks_30d,
	sum(clicks_30d) over w1 as total_clicks_30d,
	ctr_30d,	
	PERCENTILE_DISC(ctr_30d, 0.5 IGNORE NULLS) OVER w1 AS med_ctr_30d,
	avg_position_30d,
	impressions_mom,
	sum(impressions_mom) over w1 as total_impressions_mom,
	clicks_mom,
	sum(clicks_mom) over w1 as total_clicks_mom,
	ctr_mom,
	avg_position_mom,
	impressions_yoy,
	sum(impressions_yoy) over w1 as total_impressions_yoy,
	clicks_yoy,
	sum(clicks_yoy) over w1 as total_clicks_yoy,
	ctr_yoy,	
	avg_position_yoy,	
	impressions_ttm,
	clicks_ttm,
	ctr_ttm,	
	avg_position_ttm,		
	null as top_3_keywords,
	null as top_5_keywords,
	null as top_10_keywords,
	null as top_20_keywords,
	'' as main_keyword,
	null as main_impressions,
	null as main_clicks,
	null as main_avg_position,
	'' as main_top_url,
	null as main_top_url_clicks,
	'' as best_keyword,
	null as best_impressions,
	null as best_clicks,
	null as best_avg_position,
	'' as best_top_url,
	null as best_top_url_clicks,
	null as sessions_30d,
	null as total_organic_sessions_30d,
	null as bottom_quartile_sessions_30d,
	null as med_sessions_30d,
	null as top_quartile_sessions_30d,	
	null as transaction_revenue_30d,
	null as transactions_30d,
	null as total_organic_transactions_30d,
	null as ecommerce_conversion_rate_30d,
	null as med_transaction_conversion_rate_30d,
	null as goal_completions_all_goals_30d,
	null as total_organic_goal_completions_all_goals_30d,
	null as goal_conversion_rate_all_goals_30d,
	null as med_goal_conversion_rate_30d,
	null as blended_conversions_30d,	
	null as bottom_quartile_blended_conversions_30d,	
	null as med_blended_conversions_30d,	
	null as top_quartile_blended_conversions_30d,	
	null as blended_conversion_rate_30d,	
	null as bottom_quartile_blended_conversion_rate_30d,	
	null as med_blended_conversion_rate_30d,	
	null as top_quartile_blended_conversion_rate_30d, 
	null as bounce_rate_30d,
	null as avg_seconds_on_site_30d,
	null as sessions_mom,
	null as total_organic_sessions_mom,
	null as transaction_revenue_mom,
	null as transactions_mom,
	null as total_organic_transactions_mom,
	null as ecommerce_conversion_rate_mom,
	null as goal_completions_all_goals_mom,
	null as total_organic_goal_completions_all_goals_mom,
	null as goal_conversion_rate_all_goals_mom,
	null as bounce_rate_mom,
	null as avg_seconds_on_site_mom,
	null as sessions_yoy,
	null as total_organic_sessions_yoy,
	null as transaction_revenue_yoy,
	null as transactions_yoy,
	null as total_organic_transactions_yoy,
	null as ecommerce_conversion_rate_yoy,
	null as goal_completions_all_goals_yoy,
	null as total_organic_goal_completions_all_goals_yoy,
	null as goal_conversion_rate_all_goals_yoy,
	null as bounce_rate_yoy,
	null as avg_seconds_on_site_yoy,
	null as sessions_ttm,
	null as transaction_revenue_ttm,
	null as transactions_ttm,
	null as ecommerce_conversion_rate_ttm,
	null as goal_completions_all_goals_ttm,
	null as goal_conversion_rate_all_goals_ttm,
	null as bounce_rate_ttm,
	null as avg_seconds_on_site_ttm
	FROM {{ref('search_console_url_stats')}}
	WINDOW w1 as (PARTITION BY date, site)

	UNION ALL  

	SELECT 
	date,
	account,
	site,
	domain,
	url,
	null as impressions_30d,
	null as total_impressions_30d,
	null as med_impressions_30d,
	null as top_10pct_impressions_30d,
	null as clicks_30d,
	null as total_clicks_30d,
	null as ctr_30d,
	null as med_ctr_30d,
	null as avg_position_30d,
	null as impressions_mom,
	null as total_impressions_mom,
	null as clicks_mom,
	null as total_clicks_mom,
	null as ctr_mom,
	null as avg_position_mom,
	null as impressions_yoy,
	null as total_impressions_yoy,
	null as clicks_yoy,
	null as total_clicks_yoy,
	null as ctr_yoy,
	null as avg_position_yoy,		
	null as impressions_ttm,
	null as clicks_ttm,
	null as ctr_ttm,
	null as avg_position_ttm,			
	top_3_keywords,
	top_5_keywords,
	top_10_keywords,
	top_20_keywords,
	main_keyword,
	main_impressions,
	main_clicks,
	main_avg_position,
	main_top_url,
	main_top_url_clicks,
	best_keyword,
	best_impressions,
	best_clicks,
	best_avg_position,
	best_top_url,
	best_top_url_clicks,
	null as sessions_30d,
	null as total_organic_sessions_30d,
	null as bottom_quartile_sessions_30d,
	null as med_sessions_30d,
	null as top_quartile_sessions_30d,	
	null as transaction_revenue_30d,
	null as transactions_30d,
	null as total_organic_transactions_30d,
	null as ecommerce_conversion_rate_30d,
	null as med_transaction_conversion_rate_30d,
	null as goal_completions_all_goals_30d,
	null as total_organic_goal_completions_all_goals_30d,
	null as goal_conversion_rate_all_goals_30d,
	null as med_goal_conversion_rate_30d,
	null as blended_conversions_30d,	
	null as bottom_quartile_blended_conversions_30d,	
	null as med_blended_conversions_30d,	
	null as top_quartile_blended_conversions_30d,	
	null as blended_conversion_rate_30d,	
	null as bottom_quartile_blended_conversion_rate_30d,	
	null as med_blended_conversion_rate_30d,	
	null as top_quartile_blended_conversion_rate_30d, 
	null as bounce_rate_30d,
	null as avg_seconds_on_site_30d,
	null as sessions_mom,
	null as total_organic_sessions_mom,
	null as transaction_revenue_mom,
	null as transactions_mom,
	null as total_organic_transactions_mom,
	null as ecommerce_conversion_rate_mom,
	null as goal_completions_all_goals_mom,
	null as total_organic_goal_completions_all_goals_mom,
	null as goal_conversion_rate_all_goals_mom,
	null as bounce_rate_mom,
	null as avg_seconds_on_site_mom,
	null as sessions_yoy,
	null as total_organic_sessions_yoy,
	null as transaction_revenue_yoy,
	null as transactions_yoy,
	null as total_organic_transactions_yoy,
	null as ecommerce_conversion_rate_yoy,
	null as goal_completions_all_goals_yoy,
	null as total_organic_goal_completions_all_goals_yoy,
	null as goal_conversion_rate_all_goals_yoy,
	null as bounce_rate_yoy,
	null as avg_seconds_on_site_yoy,
	null as sessions_ttm,
	null as transaction_revenue_ttm,
	null as transactions_ttm,
	null as ecommerce_conversion_rate_ttm,
	null as goal_completions_all_goals_ttm,
	null as goal_conversion_rate_all_goals_ttm,
	null as bounce_rate_ttm,
	null as avg_seconds_on_site_ttm
	FROM {{ref('search_console_url_keyword_stats')}}

	UNION ALL  

	SELECT 
	date,
	account,
	site,
	domain,
	url,
	null as impressions_30d,
	null as total_impressions_30d,
	null as med_impressions_30d,
	null as top_10pct_impressions_30d,	
	null as clicks_30d,
	null as total_clicks_30d,
	null as ctr_30d,
	null as med_ctr_30d,
	null as avg_position_30d,
	null as impressions_mom,
	null as total_impressions_mom,
	null as clicks_mom,
	null as total_clicks_mom,
	null as ctr_mom,
	null as avg_position_mom,
	null as impressions_yoy,
	null as total_impressions_yoy,
	null as clicks_yoy,
	null as total_clicks_yoy,
	null as ctr_yoy,
	null as avg_position_yoy,		
	null as impressions_ttm,
	null as clicks_ttm,
	null as ctr_ttm,
	null as avg_position_ttm,			
	null as top_3_keywords,
	null as top_5_keywords,
	null as top_10_keywords,
	null as top_20_keywords,
	'' as main_keyword,
	null as main_impressions,
	null as main_clicks,
	null as main_avg_position,
	'' as main_top_url,
	null as main_top_url_clicks,
	'' as best_keyword,
	null as best_impressions,
	null as best_clicks,
	null as best_avg_position,
	'' as best_top_url,
	null as best_top_url_clicks,
	sessions_30d,
	sum(sessions_30d) over w1 as total_organic_sessions_30d,
	PERCENTILE_DISC(sessions_30d, 0.25 IGNORE NULLS) OVER w1 AS bottom_quartile_sessions_30d,
	PERCENTILE_DISC(sessions_30d, 0.5 IGNORE NULLS) OVER w1 AS med_sessions_30d,
	PERCENTILE_DISC(sessions_30d, 0.75 IGNORE NULLS) OVER w1 AS top_quartile_sessions_30d,		
	transaction_revenue_30d,
	transactions_30d,
	sum(transactions_30d) over w1 as total_organic_transactions_30d,
	ecommerce_conversion_rate_30d,
	PERCENTILE_DISC(ecommerce_conversion_rate_30d, 0.5 IGNORE NULLS) OVER w1 AS med_transaction_conversion_rate_30d,
	goal_completions_all_goals_30d,
	sum(goal_completions_all_goals_30d) over w1 as total_organic_goal_completions_all_goals_30d,
	goal_conversion_rate_all_goals_30d,
	PERCENTILE_DISC(goal_conversion_rate_all_goals_30d, 0.5 IGNORE NULLS) OVER w1 AS med_goal_conversion_rate_30d,
	blended_conversions_30d,	
	PERCENTILE_DISC(blended_conversions_30d, 0.25 IGNORE NULLS) OVER w1 AS bottom_quartile_blended_conversions_30d,	
	PERCENTILE_DISC(blended_conversions_30d, 0.5 IGNORE NULLS) OVER w1 AS med_blended_conversions_30d,	
	PERCENTILE_DISC(blended_conversions_30d, 0.75 IGNORE NULLS) OVER w1 AS top_quartile_blended_conversions_30d,	
	blended_conversion_rate_30d,	
	PERCENTILE_DISC(blended_conversion_rate_30d, 0.25 IGNORE NULLS) OVER w1 AS bottom_quartile_blended_conversion_rate_30d,	
	PERCENTILE_DISC(blended_conversion_rate_30d, 0.5 IGNORE NULLS) OVER w1 AS med_blended_conversion_rate_30d,	
	PERCENTILE_DISC(blended_conversion_rate_30d, 0.75 IGNORE NULLS) OVER w1 AS top_quartile_blended_conversion_rate_30d, 
	bounce_rate_30d,
	avg_seconds_on_site_30d,
	sessions_mom,
	sum(sessions_mom) over w1 as total_organic_sessions_mom,
	transaction_revenue_mom,
	transactions_mom,
	sum(transactions_mom) over w1 as total_organic_transactions_mom,
	ecommerce_conversion_rate_mom,
	goal_completions_all_goals_mom,
	sum(goal_completions_all_goals_mom) over w1 as total_organic_goal_completions_all_goals_mom,
	goal_conversion_rate_all_goals_mom,
	bounce_rate_mom,
	avg_seconds_on_site_mom,
	sessions_yoy,
	sum(sessions_yoy) over w1 as total_organic_sessions_yoy,
	transaction_revenue_yoy,
	transactions_yoy,
	sum(transactions_yoy) over w1 as total_organic_transactions_yoy,
	ecommerce_conversion_rate_yoy,
	goal_completions_all_goals_yoy,
	sum(goal_completions_all_goals_yoy) over w1 as total_organic_goal_completions_all_goals_yoy,
	goal_conversion_rate_all_goals_yoy,
	bounce_rate_yoy,
	avg_seconds_on_site_yoy,
	sessions_ttm,
	transaction_revenue_ttm,
	transactions_ttm,
	ecommerce_conversion_rate_ttm,
	goal_completions_all_goals_ttm,
	goal_conversion_rate_all_goals_ttm,
	bounce_rate_ttm,
	avg_seconds_on_site_ttm
	FROM {{ref('ga_stats')}}  
	WINDOW w1 as (PARTITION BY date, site)
) 
WHERE date is not null
GROUP BY date, site, domain, url
