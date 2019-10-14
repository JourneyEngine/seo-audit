SELECT 
domain,
site,
url,
crawl_datetime,
crawl_date,
crawl_month,
crawl_report_month,
latest_crawl_datetime,
max(domain_canonical) domain_canonical,
max(url_stripped) url_stripped,
max(canonical_url) canonical_url,
max(canonical_url_stripped) canonical_url_stripped,
max(urls_to_canonical) urls_to_canonical,
max(url_query_string_flag) url_query_string_flag,
max(canonical_query_string_flag) canonical_query_string_flag,
max(found_at_sitemap) found_at_sitemap,
max(http_status_code) http_status_code,
max(canonical_url_protocol) canonical_url_protocol,
max(level) level,
max(schema_type) schema_type,
max(header_content_type) header_content_type,
max(word_count) word_count, 
max(page_title) page_title,
max(page_title_length) page_title_length,
max(description) description,
max(description_length) description_length,
max(indexable) indexable,
max(robots_noindex) robots_noindex,
max(is_self_canonical) is_self_canonical,
max(backlink_count) backlink_count,
max(backlink_domain_count) backlink_domain_count,
max(redirected_to_url) redirected_to_url,
max(self_redirect) self_redirect,
max(found_at_url) found_at_url,
max(rel_next_url) rel_next_url,
max(rel_prev_url) rel_prev_url,
max(links_in_count) links_in_count,
max(links_out_count) links_out_count,
max(external_links_count) external_links_count,
max(internal_links_count) internal_links_count,
max(h1_tag) h1_tag,
max(h2_tag) h2_tag,
max(redirect_chain) redirect_chain,
max(redirected_to_status_code) redirected_to_status_code,
max(is_redirect_loop) is_redirect_loop,
max(duplicate_page) duplicate_page,
max(duplicate_page_count) duplicate_page_count,
max(duplicate_body) duplicate_body,
max(duplicate_body_count) duplicate_body_count,
max(qt_dec_price) qt_dec_price,
max(qt_cur_price) qt_cur_price,
max(qt_add_to_cart) qt_add_to_cart,
max(qt_google_maps) qt_google_maps,
max(qt_learn_more) qt_learn_more,
max(qt_reviews) qt_reviews,
max(qt_size) qt_size,
max(qt_form_submit) qt_form_submit,
max(qt_infinite_scroll) qt_infinite_scroll,
max(decimal_price) decimal_price,
max(currency_price) currency_price,
max(add_to_cart) add_to_cart,
max(learn_more) learn_more,
max(review) review,
max(size) size
FROM
(
  SELECT 
  a.domain,
  b.site,
  regexp_extract(canonical_url,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') as domain_canonical,
  url_proc url,
  lower(concat(trim(regexp_replace(replace(replace(replace(url,'www.',''),'http://',''),'https://',''),r'\?.*$',''),'/'),'/')) as url_stripped,
  lower(concat(trim(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://',''),'/'),'/')) canonical_url,
  lower(concat(trim(regexp_replace(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://',''),r'\?.*$',''),'/'),'/')) canonical_url_stripped,
  count(distinct(url_proc)) OVER (PARTITION by canonical_url) urls_to_canonical,
  case when url like '%?%' then 1 else 0 end as url_query_string_flag,
  case when canonical_url like '%?%' and canonical_url is not null then 1 else 0 end as canonical_query_string_flag,
  crawl_datetime,
  crawl_date,
  crawl_month,
  date_sub(crawl_month, INTERVAL 1 MONTH) crawl_report_month,
  first_value(crawl_datetime) OVER (PARTITION BY a.domain, crawl_month, url_proc ORDER BY crawl_datetime desc) latest_crawl_datetime,
  found_at_sitemap,
  http_status_code,
  case when url like 'https%' then 'https' 
    when url like 'http%' then 'http'
    else 'none' end as url_protocol,
  case when canonical_url like 'https%' then 'https' 
    when canonical_url like 'http%' then 'http'
    else 'none' end as canonical_url_protocol,  
  level,
  lower(schema_type) schema_type,
  header_content_type,
  word_count, 
  page_title,
  page_title_length,
  description,
  description_length,
  indexable,
  robots_noindex,
  is_self_canonical,
  backlink_count,
  backlink_domain_count,
  redirected_to_url,
  self_redirect,
  found_at_url,
  rel_next_url,
  rel_prev_url,
  links_in_count,
  links_out_count,
  external_links_count,
  internal_links_count,
  lower(h1_tag) h1_tag,
  lower(h2_tag) h2_tag,
  redirect_chain,
  redirected_to_status_code,
  is_redirect_loop,
  duplicate_page,
  duplicate_page_count,
  duplicate_body,
  duplicate_body_count,
  (LENGTH(decimal_price) - LENGTH(REGEXP_REPLACE(decimal_price, '"', '')))/2 as qt_dec_price,
  (LENGTH(currency_price) - LENGTH(REGEXP_REPLACE(currency_price, '"', '')))/2 as qt_cur_price,
  (LENGTH(Add_to_cart) - LENGTH(REGEXP_REPLACE(Add_to_cart, '"', '')))/2 as qt_add_to_cart,
  (LENGTH(Google_Maps) - LENGTH(REGEXP_REPLACE(Google_Maps, '"', '')))/2 as qt_google_maps,
  (LENGTH(Learn_more) - LENGTH(REGEXP_REPLACE(Learn_more, '"', '')))/2 as qt_learn_more,
  (LENGTH(Review) - LENGTH(REGEXP_REPLACE(Review, '"', '')))/2 as qt_reviews,
  (LENGTH(Size) - LENGTH(REGEXP_REPLACE(Size, '"', '')))/2 as qt_size,
  (LENGTH(form_submit) - LENGTH(REGEXP_REPLACE(form_submit, '"', '')))/2 as qt_form_submit,
  (LENGTH(infinite_scroll) - LENGTH(REGEXP_REPLACE(infinite_scroll, '"', '')))/2 as qt_infinite_scroll,
  decimal_price,
  currency_price,
  add_to_cart,
  learn_more,
  review,
  size
  FROM
  ( 
    -- SELECT 
    -- url,
    -- canonical_url,
    -- crawl_datetime,
    -- found_at_sitemap,
    -- http_status_code,
    -- level,
    -- schema_type,
    -- header_content_type,
    -- word_count, 
    -- page_title,
    -- page_title_length,
    -- description,
    -- description_length,
    -- indexable,
    -- robots_noindex,
    -- is_self_canonical,
    -- backlink_count,
    -- backlink_domain_count,
    -- redirected_to_url,
    -- found_at_url,
    -- rel_next_url,
    -- rel_prev_url,
    -- links_in_count,
    -- links_out_count,
    -- external_links_count,
    -- internal_links_count,
    -- h1_tag,
    -- h2_tag,
    -- redirect_chain,
    -- redirected_to_status_code,
    -- is_redirect_loop,
    -- duplicate_page,
    -- duplicate_page_count,
    -- duplicate_body,
    -- duplicate_body_count,
    -- decimal_price,
    -- currency_price,
    -- add_to_cart,
    -- google_maps,
    -- learn_more,
    -- review,
    -- size,
    -- form_submit,
    -- infinite_scroll,
    -- decimal_price,
    -- currency_price,
    -- add_to_cart,
    -- learn_more,
    -- review,
    -- size
    -- FROM  
    -- `{{ target.project }}.seo_audit.deepcrawl_cifl` 

    -- UNION ALL

      SELECT 
      url,
      lower(concat(trim(replace(replace(replace(url,'www.',''),'http://',''),'https://',''),'/'),'/')) as url_proc,
      regexp_extract(url,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') as domain,
      canonical_url,
      crawl_datetime,
      cast(crawl_datetime as date) crawl_date,
      DATE_TRUNC(date( crawl_datetime ), month) crawl_month,
      found_at_sitemap,
      http_status_code,
      level,
      schema_type,
      header_content_type,
      word_count, 
      page_title,
      page_title_length,
      description,
      description_length,
      indexable,
      robots_noindex,
      is_self_canonical,
      backlink_count,
      backlink_domain_count,
      redirected_to_url,
      CASE WHEN regexp_extract(trim(redirected_to_url, '/'),r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') = regexp_extract(url ,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)')
        OR regexp_extract(trim(url, '/'),r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') = regexp_extract(redirected_to_url ,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)')
        THEN 1 ELSE 0 END as self_redirect,
      found_at_url,
      rel_next_url,
      rel_prev_url,
      links_in_count,
      links_out_count,
      external_links_count,
      internal_links_count,
      replace(replace(replace(h1_tag, "[\"",""),"\"]",""),'"','') h1_tag,
      replace(replace(replace(h2_tag, "[\"",""),"\"]",""),'"','') h2_tag,
      redirect_chain,
      redirected_to_status_code,
      is_redirect_loop,
      duplicate_page,
      duplicate_page_count,
      duplicate_body,
      duplicate_body_count,
      form_submit,
      infinite_scroll,
      decimal_price,
      currency_price,
      google_maps,
      add_to_cart,
      learn_more,
      review,
      size
      FROM  
      `{{ target.project }}.{{ target.schema }}.deepcrawl` 
      WHERE url not like '%target=_blank%'
      and ( url = primary_url OR primary_url is null )
    ) a
  LEFT JOIN {{ ref('domains_proc') }} b
  ON (
    a.domain = b.domain
    )
 )
WHERE latest_crawl_datetime = crawl_datetime
AND self_redirect = 0 
GROUP BY domain, site, url, crawl_datetime, crawl_date, crawl_month, crawl_report_month, latest_crawl_datetime