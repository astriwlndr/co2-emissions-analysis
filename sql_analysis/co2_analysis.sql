-- =====================================================
-- CO2 Emissions Analysis
-- Dataset: Our World in Data CO2 Dataset
-- =====================================================

-- 1. Preview dataset
SELECT *
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
LIMIT 10;

-- 2. Total global CO2 emissions per year

SELECT
    year,
    SUM(co2) AS global_co2_emissions
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
GROUP BY year
ORDER BY year;

-- 3. Top 10 countries with highest total CO2 emissions

SELECT
    country,
    SUM(co2) AS total_emissions
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
GROUP BY country
ORDER BY total_emissions DESC
LIMIT 10;

-- 4. Average CO2 emissions per capita by country

SELECT
    country,
    AVG(co2_per_capita) AS avg_co2_per_capita
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
GROUP BY country
ORDER BY avg_co2_per_capita DESC
LIMIT 10;

-- 5. Countries with the highest emissions in the most recent year

SELECT
    country,
    year,
    co2
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
WHERE year = (SELECT MAX(year) FROM co2_emissions)
ORDER BY co2 DESC
LIMIT 10;

-- 6. CO2 emissions trend for selected countries

SELECT
    country,
    year,
    co2
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
WHERE country IN ('China', 'United States', 'India', 'Russia')
ORDER BY country, year;

-- 7. Total emissions by energy source per year

SELECT
    year,
    SUM(coal_co2) AS coal_emissions,
    SUM(oil_co2) AS oil_emissions,
    SUM(gas_co2) AS gas_emissions,
    SUM(cement_co2) AS cement_emissions
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
GROUP BY year
ORDER BY year;

-- 8. Percentage contribution of energy sources

SELECT
    year,
    SUM(coal_co2) / SUM(co2) * 100 AS coal_percentage,
    SUM(oil_co2) / SUM(co2) * 100 AS oil_percentage,
    SUM(gas_co2) / SUM(co2) * 100 AS gas_percentage
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
GROUP BY year
ORDER BY year;

-- 9. Countries with highest CO2 per capita

SELECT
    country,
    year,
    co2_per_capita
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
WHERE year = 2020
ORDER BY co2_per_capita DESC
LIMIT 10;

-- 10. Global emissions growth year to year

SELECT
    year,
    SUM(co2) AS total_emissions,
    SUM(co2) - LAG(SUM(co2)) OVER (ORDER BY year) AS emission_change
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
GROUP BY year
ORDER BY year;

-- 11. Countries with the fastest emissions growth

SELECT
    country,
    MAX(co2) - MIN(co2) AS emission_growth
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
GROUP BY country
ORDER BY emission_growth DESC
LIMIT 10;

-- 12. Emissions per GDP (carbon intensity)

SELECT
    country,
    year,
    co2 / gdp AS carbon_intensity
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
WHERE gdp IS NOT NULL
ORDER BY carbon_intensity DESC
LIMIT 10;

-- 13. Total emissions by decade

SELECT
    FLOOR(year / 10) * 10 AS decade,
    SUM(co2) AS total_emissions
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
GROUP BY decade
ORDER BY decade;

-- 14. Countries with lowest CO2 emissions per capita

SELECT
    country,
    AVG(co2_per_capita) AS avg_co2_per_capita
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`
GROUP BY country
ORDER BY avg_co2_per_capita ASC
LIMIT 10;

-- 15. Global CO2 emissions summary

SELECT
    MIN(year) AS start_year,
    MAX(year) AS end_year,
    SUM(co2) AS total_global_emissions,
    AVG(co2_per_capita) AS avg_global_co2_per_capita
FROM `ascendant-altar-489312-r5.co2_dataset.co2_dataset`;