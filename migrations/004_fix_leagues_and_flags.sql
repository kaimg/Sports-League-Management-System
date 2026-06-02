-- Fix leagues colors
ALTER TABLE leagues ADD COLUMN IF NOT EXISTS color VARCHAR(20) DEFAULT '#343a40';

UPDATE leagues SET color = '#007bff' WHERE LOWER(name) LIKE '%premier%';
UPDATE leagues SET color = '#dc3545' WHERE LOWER(name) LIKE '%liga%';
UPDATE leagues SET color = '#ffc107' WHERE LOWER(name) LIKE '%bundesliga%';
UPDATE leagues SET color = '#28a745' WHERE LOWER(name) LIKE '%serie%';
UPDATE leagues SET color = '#6f42c1' WHERE LOWER(name) LIKE '%ligue%';

-- Update countries flags
UPDATE countries AS c
SET flag_url = 'https://flagcdn.com/' || v.code || '.svg'
FROM (VALUES
    ('England', 'gb-eng'), ('Italy', 'it'), ('Spain', 'es'), ('Germany', 'de'),
    ('France', 'fr'), ('Albania', 'al'), ('Algeria', 'dz'), ('Andorra', 'ad'),
    ('Angola', 'ao'), ('Argentina', 'ar'), ('Armenia', 'am'), ('Australia', 'au'),
    ('Austria', 'at'), ('Belgium', 'be'), ('Benin', 'bj'), ('Bosnia-Herzegovina', 'ba'),
    ('Brazil', 'br'), ('Bulgaria', 'bg'), ('Burkina Faso', 'bf'), ('Cameroon', 'cm'),
    ('Canada', 'ca'), ('Cape Verde Islands', 'cv'), ('Chile', 'cl'), ('Colombia', 'co'),
    ('Congo', 'cg'), ('Costa Rica', 'cr'), ('Croatia', 'hr'), ('Cyprus', 'cy'),
    ('Czech Republic', 'cz'), ('DR Congo', 'cd'), ('Denmark', 'dk'), ('Dominican Republic', 'do'),
    ('Ecuador', 'ec'), ('Egypt', 'eg'), ('Equatorial Guinea', 'gq'), ('Estonia', 'ee'),
    ('Finland', 'fi'), ('Gabon', 'ga'), ('Gambia', 'gm'), ('Georgia', 'ge'),
    ('Ghana', 'gh'), ('Greece', 'gr'), ('Grenada', 'gd'), ('Guadeloupe', 'gp'),
    ('Guinea', 'gn'), ('Honduras', 'hn'), ('Hungary', 'hu'), ('Iceland', 'is'),
    ('Iran', 'ir'), ('Ireland', 'ie'), ('Israel', 'il'), ('Ivory Coast', 'ci'),
    ('Jamaica', 'jm'), ('Japan', 'jp'), ('Kosovo', 'xk'), ('Lithuania', 'lt'),
    ('Luxembourg', 'lu'), ('Mali', 'ml'), ('Martinique', 'mq'), ('Mexico', 'mx'),
    ('Montenegro', 'me'), ('Morocco', 'ma'), ('Mozambique', 'mz'), ('Netherlands', 'nl'),
    ('New Zealand', 'nz'), ('Nigeria', 'ng'), ('North Macedonia', 'mk'), ('Norway', 'no'),
    ('Paraguay', 'py'), ('Peru', 'pe'), ('Philippines', 'ph'), ('Poland', 'pl'),
    ('Portugal', 'pt'), ('Romania', 'ro'), ('Russia', 'ru'), ('Scotland', 'gb-sct'),
    ('Senegal', 'sn'), ('Serbia', 'rs'), ('Slovakia', 'sk'), ('Slovenia', 'si'),
    ('South Africa', 'za'), ('South Korea', 'kr'), ('Suriname', 'sr'), ('Sweden', 'se'),
    ('Switzerland', 'ch'), ('Syria', 'sy'), ('Togo', 'tg'), ('Tunisia', 'tn'),
    ('Turkey', 'tr'), ('USA', 'us'), ('Ukraine', 'ua'), ('Uruguay', 'uy'),
    ('Uzbekistan', 'uz'), ('Venezuela', 've'), ('Wales', 'gb-wls'), ('Zambia', 'zm'),
    ('Zimbabwe', 'zw'), ('Northern Ireland', 'gb-nir')
) AS v(name, code)
WHERE c.name = v.name;
