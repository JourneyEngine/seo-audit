SELECT
date,
crawl_date,
site,
domain,
url,
found_at,
page_type,
found_at_sitemap,
found_at_url,
canonical_url,
canonical_status,
top_admin_action,
top_admin_action_reason,
crawl_action,
http_status_action,
sitemap_action,
canonical_action,
schema_action,
cannibalization_action,
content_action,
internal_link_action,
external_link_action,
meta_rewrite_action,
category_action,
pagination_action,
url_protocol,
canonical_url_protocol,
protocol_match,
protocol_count,
http_status_code,
level,
schema_type,
header_content_type,
word_count, 
page_title,
title_contains_top_keyword,
page_title_length,
description,
description_contains_top_keyword,
description_length,
robots_noindex,
meta_noindex,
is_noindex,
redirected_to_url,
h1_tag,
h2_tag,
redirect_chain,
redirected_to_status_code,
is_redirect_loop,
duplicate_page,
duplicate_page_count,
duplicate_body,
duplicate_body_count,
sessions_30d,
pct_of_organic_sessions_30d,
transaction_revenue_30d,
transactions_30d,
pct_of_organic_transactions_30d,
ecommerce_conversion_rate_30d,
med_transaction_conversion_rate_30d,
goal_completions_all_goals_30d,
pct_of_organic_goal_completions_all_goals_30d,
goal_conversion_rate_all_goals_30d,
med_goal_conversion_rate_30d,
bounce_rate_30d,
avg_seconds_on_site_30d,
sessions_mom,
sessions_mom_pct,
transaction_revenue_mom,
transaction_revenue_mom_pct,
transactions_mom,
transactions_mom_pct,
goal_completions_all_goals_mom,
goal_completions_all_goals_mom_pct,
sessions_yoy,
sessions_yoy_pct,
transaction_revenue_yoy,
transaction_revenue_yoy_pct,
transactions_yoy,
transactions_yoy_pct,
goal_completions_all_goals_yoy,
goal_completions_all_goals_yoy_pct,
sessions_ttm,
transaction_revenue_ttm,
transactions_ttm,
ecommerce_conversion_rate_ttm,
goal_completions_all_goals_ttm,
goal_conversion_rate_all_goals_ttm,
bounce_rate_ttm,
avg_seconds_on_site_ttm,
gaining_traffic_mom,
gaining_traffic_yoy,
backlink_count,
ref_domain_count,
med_ref_domain_count,
internal_links_in_count,
internal_links_out_count,
impressions_30d,
clicks_30d,
ctr_30d,
avg_position_30d,
impressions_mom,
impressions_mom_pct,
clicks_mom,
clicks_mom_pct,
ctr_mom,
ctr_mom_pct,
avg_position_mom,
impressions_yoy,
impressions_yoy_pct,
clicks_yoy,
ctr_yoy,	
ctr_yoy_pct,
avg_position_yoy,	
impressions_ttm,
clicks_ttm,
ctr_ttm,
avg_position_ttm,
top_5_keywords,
top_10_keywords,
top_20_keywords,
main_keyword,
main_impressions,
main_clicks,
main_avg_position,
main_top_url,
main_keyword_cannibalization_flag,
main_top_url_clicks,
best_keyword,
best_impressions,
best_clicks,
best_avg_position,
best_top_url,
best_top_url_clicks,
best_keyword_cannibalization_flag,
on_off_page_action,
architecture_action
FROM {{ ref('actions_hierarchy') }}