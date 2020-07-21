SELECT *
FROM (

  SELECT
  crawl_id,
  first_value(crawl_id) over w2 as latest_crawl_id,
  count(distinct(url)) OVER (PARTITION by canonical_url) urls_to_canonical,
  first_value(crawl_datetime) OVER w1 as latest_crawl_datetime,    
  first_value(query_string_url) over w1 as latest_query_string_url,
  first_value(eventid) over w1 as latest_event_id,
  url_canonical_trailing_slash_match,
  max(url_canonical_trailing_slash_match) over w3 as max_trailing_slash_match,
  eventid,
  domain,
  site,
  url,
  url_stripped,
  non_html_url,
  domain_canonical,
  canonical_url,
  canonical_url_stripped,
  query_string_url_first_param,
  query_string_url,
  query_string_canonical_url,  
  url_protocol,
  canonical_url_protocol,
  is_canonicalized,
  crawl_datetime,
  crawl_date,
  crawl_month,
  crawl_report_month,
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
  meta_noindex,
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
  h1_tag,
  h2_tag,
  redirect_chain,
  redirected_to_status_code,
  is_redirect_loop,
  duplicate_page,
  duplicate_page_count,
  duplicate_body,
  duplicate_body_count,
  qt_dec_price,
  qt_cur_price,
  qt_add_to_cart,
  qt_google_maps,
  qt_learn_more,
  qt_reviews,
  qt_size,
  qt_form_submit,
  qt_infinite_scroll,
  decimal_price,
  currency_price,
  add_to_cart,
  learn_more,
  review,
  size,
  paginated_page
  FROM 
  (
    SELECT 
    eventid,
    crawl_id,
    a.domain,
    b.site,
    CASE WHEN url = canonical_url THEN url
      WHEN url_stripped = canonical_url_stripped AND query_string_url_first_param = query_string_canonical_url THEN canonical_url
      -- WHEN query_string_url_first_param is not null THEN null
      -- WHEN http_status_code = 404 THEN url
      ELSE url_stripped
      END as url,      
    url_stripped,
    non_html_url,
    domain_canonical,
    canonical_url,
    canonical_url_stripped,
    query_string_url_first_param,
    query_string_url,
    query_string_canonical_url,  
    url_protocol,
    canonical_url_protocol,
    is_canonicalized,
    url_canonical_trailing_slash_match,
    crawl_datetime,
    crawl_date,
    crawl_month,
    CASE WHEN extract(DAY from crawl_date) >= 15 THEN crawl_month ELSE date_sub(crawl_month, INTERVAL 1 MONTH) END as crawl_report_month,
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
    meta_noindex,
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
    h1_tag,
    h2_tag,
    redirect_chain,
    redirected_to_status_code,
    is_redirect_loop,
    duplicate_page,
    duplicate_page_count,
    duplicate_body,
    duplicate_body_count,
    qt_dec_price,
    qt_cur_price,
    qt_add_to_cart,
    qt_google_maps,
    qt_learn_more,
    qt_reviews,
    qt_size,
    qt_form_submit,
    qt_infinite_scroll,
    decimal_price,
    currency_price,
    add_to_cart,
    learn_more,
    review,
    size,
    paginated_page
    FROM
    ( 
        SELECT 
        EventId,
        Crawl_Id,
        lower(replace(replace(replace(Url,'www.',''),'http://',''),'https://','')) as url,
        lower(regexp_replace(replace(replace(replace(Url,'www.',''),'http://',''),'https://',''),r'\?.*$','')) as url_stripped,
        -- CASE WHEN regexp_contains(url, r'^.*\/([^\/]+?\.[^\/]+)$') 
        --   THEN lower(regexp_replace(replace(replace(replace(url,'www.',''),'http://',''),'https://',''),r'\?.*$',''))
        --   ELSE lower(regexp_replace(replace(replace(replace(url,'www.',''),'http://',''),'https://',''),r'\?.*$',''))
        --   END as url_stripped,
        regexp_contains(Url, '.img$|.png$|.jpg$|.css$.|js$|.pdf$') as non_html_url,
        regexp_extract(Url,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') as domain,
        regexp_extract(Canonical_Url,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') as domain_canonical,
        lower(replace(replace(replace(Canonical_Url,'www.',''),'http://',''),'https://','')) canonical_url,
        lower(regexp_replace(replace(replace(replace(Canonical_Url,'www.',''),'http://',''),'https://',''),r'\?.*$','')) as canonical_url_stripped,
        -- CASE WHEN regexp_contains(canonical_url, r'^.*\/([^\/]+?\.[^\/]+)$') 
        --   THEN lower(regexp_replace(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://',''),r'\?.*$',''))
        --   ELSE lower(trim(regexp_replace(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://',''),r'\?.*$',''),'/'))
        --   END as canonical_url_stripped,      
        ifnull(split(split(Url, '?')[SAFE_ORDINAL(2)],'&')[SAFE_ORDINAL(1)], '') query_string_url_first_param,
        ifnull(split(Url, '?')[SAFE_ORDINAL(2)], '') as query_string_url,
        ifnull(split(Canonical_Url, '?')[SAFE_ORDINAL(2)], '') as query_string_canonical_url,
        case when Url like 'https%' then 'https' 
          when Url like 'http%' then 'http'
          else 'none' end as url_protocol,
        case when Canonical_Url like 'https%' then 'https' 
          when Canonical_Url like 'http%' then 'http'
          else 'none' end as canonical_url_protocol, 
        case 
          when Canonical_Url is not null then 1
          else 0 end as is_canonicalized,
        CASE WHEN substr(url,length(url),1) = substr(canonical_url,length(canonical_url),1) THEN 1 ELSE 0 END as url_canonical_trailing_slash_match,                    
        Crawl_Datetime as crawl_datetime,  
        cast(Crawl_Datetime as date) crawl_date,
        DATE_TRUNC(date( Crawl_Datetime ), month) crawl_month,
        Found_At_Sitemap as found_at_sitemap,
        Http_Status_Code as http_status_code,
        Level as level,
        lower(Schema_Type) schema_type,
        Header_Content_Type as header_content_type,
        Word_Count as word_count, 
        Page_Title as page_title,
        Page_Title_Length as page_title_length,
        Description as description,
        Description_Length as description_length,
        Indexable as indexable,
        Robots_Noindex as robots_noindex,
        Meta_Noindex as meta_noindex,
        Is_Self_Canonical as is_self_canonical,
        cast(Backlink_Count as int64) backlink_count,
        cast(Backlink_Domain_Count as int64) backlink_domain_count,
        Redirected_To_Url as redirected_to_url,
        CASE WHEN regexp_extract(trim(Redirected_To_Url, '/'),r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') = regexp_extract(Url ,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)')
          OR regexp_extract(trim(Url, '/'),r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') = regexp_extract(Redirected_To_Url ,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)')
          THEN 1 ELSE 0 END as self_redirect,
        Found_At_Url as found_at_url,
        Rel_Next_Url as rel_next_url,
        Rel_Prev_Url as rel_prev_url,
        Links_In_Count as links_in_count,
        Links_Out_Count as links_out_count,
        External_Links_Count as external_links_count,
        Internal_Links_Count as internal_links_count,
        lower(replace(replace(replace(H1_Tag, "[\"",""),"\"]",""),'"','')) h1_tag,
        lower(replace(replace(replace(H2_Tag, "[\"",""),"\"]",""),'"','')) h2_tag,
        Redirect_Chain as redirect_chain,
        Redirected_To_Status_Code as redirected_to_status_code,
        Is_Redirect_Loop as is_redirect_loop,
        Duplicate_Page as duplicate_page,
        Duplicate_Page_Count as duplicate_page_count,
        Duplicate_Body as duplicate_body,
        Duplicate_Body_Count as duplicate_body_count,
        Form_Submit as form_submit,
        Infinite_Scroll as infinite_scroll,
        (LENGTH(decimal_price) - LENGTH(replace(decimal_price, '|', '')))/2 as qt_dec_price,
        (LENGTH(currency_price) - LENGTH(replace(currency_price, '|', '')))/2 as qt_cur_price,
        (LENGTH(Add_to_cart) - LENGTH(replace(Add_to_cart, '|', '')))/2 as qt_add_to_cart,
        (LENGTH(Google_Maps) - LENGTH(replace(Google_Maps, '|', '')))/2 as qt_google_maps,
        (LENGTH(Learn_more) - LENGTH(replace(Learn_more, '|', '')))/2 as qt_learn_more,
        (LENGTH(Review) - LENGTH(replace(Review, '|', '')))/2 as qt_reviews,
        (LENGTH(Size) - LENGTH(replace(Size, '|', '')))/2 as qt_size,
        (LENGTH(form_submit) - LENGTH(replace(form_submit, '"', '')))/2 as qt_form_submit,
        (LENGTH(infinite_scroll) - LENGTH(replace(infinite_scroll, '"', '')))/2 as qt_infinite_scroll,          
        Decimal_Price as decimal_price,
        Currency_Price as currency_price,
        Google_Maps as google_maps,
        Add_To_Cart as add_to_cart,
        Learn_More as learn_more,
        Review as review,
        Size as size,
        Paginated_Page as paginated_page      
        FROM  
        `{{ target.project }}.deepcrawl_webhook_qr.deepcrawl_all_pages_report_data_source` 
        WHERE Url not like '%target=_blank%'
        AND ( Url = Primary_Url OR Primary_Url is null )
        AND Http_Status_Code not in (401, 403, 503)
        AND Header_Content_Type = 'text/html'
        AND DATE(Crawl_Datetime) <= CURRENT_DATE()

        UNION ALL

        SELECT 
        1 as EventId,
        crawl_id,
        lower(replace(replace(replace(url,'www.',''),'http://',''),'https://','')) as url,
        lower(regexp_replace(replace(replace(replace(url,'www.',''),'http://',''),'https://',''),r'\?.*$','')) as url_stripped,
        -- CASE WHEN regexp_contains(url, r'^.*\/([^\/]+?\.[^\/]+)$') 
        --   THEN lower(regexp_replace(replace(replace(replace(url,'www.',''),'http://',''),'https://',''),r'\?.*$',''))
        --   ELSE lower(regexp_replace(replace(replace(replace(url,'www.',''),'http://',''),'https://',''),r'\?.*$',''))
        --   END as url_stripped,
        regexp_contains(url, '.img$|.png$|.jpg$|.css$.|js$|.pdf$') as non_html_url,
        regexp_extract(url,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') as domain,
        regexp_extract(canonical_url,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') as domain_canonical,
        lower(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://','')) canonical_url,
        lower(regexp_replace(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://',''),r'\?.*$','')) as canonical_url_stripped,
        -- CASE WHEN regexp_contains(canonical_url, r'^.*\/([^\/]+?\.[^\/]+)$') 
        --   THEN lower(regexp_replace(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://',''),r'\?.*$',''))
        --   ELSE lower(trim(regexp_replace(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://',''),r'\?.*$',''),'/'))
        --   END as canonical_url_stripped,      
        ifnull(split(split(url, '?')[SAFE_ORDINAL(2)],'&')[SAFE_ORDINAL(1)], '') query_string_url_first_param,
        ifnull(split(url, '?')[SAFE_ORDINAL(2)], '') as query_string_url,
        ifnull(split(canonical_url, '?')[SAFE_ORDINAL(2)], '') as query_string_canonical_url,
        case when url like 'https%' then 'https' 
          when url like 'http%' then 'http'
          else 'none' end as url_protocol,
        case when canonical_url like 'https%' then 'https' 
          when canonical_url like 'http%' then 'http'
          else 'none' end as canonical_url_protocol, 
        case 
          when canonical_url is not null then 1
          else 0 end as is_canonicalized,
        CASE WHEN substr(url,length(url),1) = substr(canonical_url,length(canonical_url),1) THEN 1 ELSE 0 END as url_canonical_trailing_slash_match,          
        crawl_datetime,  
        cast(crawl_datetime as date) crawl_date,
        DATE_TRUNC(date( crawl_datetime ), month) crawl_month,
        found_at_sitemap,
        http_status_code,
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
        meta_noindex,
        is_self_canonical,
        cast(backlink_count as int64) backlink_count,
        cast(backlink_domain_count as int64) backlink_domain_count,
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
        lower(replace(replace(replace(h1_tag, "[\"",""),"\"]",""),'"','')) h1_tag,
        lower(replace(replace(replace(h2_tag, "[\"",""),"\"]",""),'"','')) h2_tag,
        redirect_chain,
        redirected_to_status_code,
        is_redirect_loop,
        duplicate_page,
        duplicate_page_count,
        duplicate_body,
        duplicate_body_count,
        form_submit,
        infinite_scroll,
        (LENGTH(Decimal_Price) - LENGTH(REGEXP_REPLACE(Decimal_Price, '"', '')))/2 as qt_dec_price,
        (LENGTH(Currency_Price) - LENGTH(REGEXP_REPLACE(Currency_Price, '"', '')))/2 as qt_cur_price,
        (LENGTH(Add_To_Cart) - LENGTH(REGEXP_REPLACE(Add_To_Cart, '"', '')))/2 as qt_add_to_cart,
        (LENGTH(Google_Maps) - LENGTH(REGEXP_REPLACE(Google_Maps, '"', '')))/2 as qt_google_maps,
        (LENGTH(Learn_More) - LENGTH(REGEXP_REPLACE(Learn_More, '"', '')))/2 as qt_learn_more,
        (LENGTH(Review) - LENGTH(REGEXP_REPLACE(Review, '"', '')))/2 as qt_reviews,
        (LENGTH(Size) - LENGTH(REGEXP_REPLACE(Size, '"', '')))/2 as qt_size,
        (LENGTH(Form_Submit) - LENGTH(REGEXP_REPLACE(Form_Submit, '"', '')))/2 as qt_form_submit,
        (LENGTH(Infinite_Scroll) - LENGTH(REGEXP_REPLACE(Infinite_Scroll, '"', '')))/2 as qt_infinite_scroll,
        decimal_price,
        currency_price,
        google_maps,
        add_to_cart,
        learn_more,
        review,
        size,
        paginated_page      
        FROM  
        `{{ target.project }}.{{ target.schema }}.deepcrawl` 
        WHERE url not like '%target=_blank%'
        AND ( url = primary_url OR primary_url is null )
        AND http_status_code not in (401, 403, 503)
        AND header_content_type = 'text/html'
        
          ) a
    LEFT JOIN {{ ref('domains_proc') }} b
    ON (
      a.domain = b.domain
      )
    )
    WHERE self_redirect = 0 
    AND non_html_url = false
    WINDOW w1 as (PARTITION BY domain, crawl_report_month, url ORDER BY found_at_sitemap desc, is_canonicalized desc, crawl_datetime desc, eventid desc ),
    w2 as (PARTITION BY domain, crawl_report_month ORDER BY crawl_id desc )
)
WHERE latest_crawl_datetime = crawl_datetime
AND latest_crawl_id = crawl_id
AND latest_query_string_url = query_string_url
AND latest_event_id = eventid
AND max_trailing_slash_match = url_canonical_trailing_slash_match
GROUP BY   crawl_id,
  latest_crawl_id,
  urls_to_canonical,
  latest_crawl_datetime,    
  latest_query_string_url,
  domain,
  site,
  url,
  url_stripped,
  non_html_url,
  domain_canonical,
  canonical_url,
  canonical_url_stripped,
  query_string_url_first_param,
  query_string_url,
  query_string_canonical_url,  
  url_protocol,
  canonical_url_protocol,
  is_canonicalized,
  crawl_datetime,
  crawl_date,
  crawl_month,
  crawl_report_month,
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
  meta_noindex,
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
  h1_tag,
  h2_tag,
  redirect_chain,
  redirected_to_status_code,
  is_redirect_loop,
  duplicate_page,
  duplicate_page_count,
  duplicate_body,
  duplicate_body_count,
  qt_dec_price,
  qt_cur_price,
  qt_add_to_cart,
  qt_google_maps,
  qt_learn_more,
  qt_reviews,
  qt_size,
  qt_form_submit,
  qt_infinite_scroll,
  decimal_price,
  currency_price,
  add_to_cart,
  learn_more,
  review,
  size,
  paginated_page,
  latest_event_id,
  eventid,
  url_canonical_trailing_slash_match,
  max_url_canonical_trailing_slash_match