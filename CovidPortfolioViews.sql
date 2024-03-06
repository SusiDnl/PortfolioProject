USE [PortfolioProject]

CREATE VIEW CovidDeaths_View AS
SELECT ISNULL([iso_code], '') AS iso_code
      ,ISNULL([continent], '') AS continent
      ,ISNULL([location], '') AS location
      ,ISNULL([date], '') AS date
      ,ISNULL([population], 0) AS population
      ,CAST(ISNULL([total_cases], 0) AS float) AS total_cases
      ,CAST(ISNULL([new_cases], 0) AS float) AS new_cases
      ,CAST(ISNULL([new_cases_smoothed], 0) AS float) AS new_cases_smoothed
      ,CAST(ISNULL([total_deaths], 0) AS float) AS total_deaths
      ,CAST(ISNULL([new_deaths], 0) AS float) AS new_deaths
      ,CAST(ISNULL([new_deaths_smoothed], 0) AS float) AS new_deaths_smoothed
      ,CAST(ISNULL([total_cases_per_million], 0) AS float) AS total_cases_per_million
      ,CAST(ISNULL([new_cases_per_million], 0) AS float) AS new_cases_per_million
      ,CAST(ISNULL([new_cases_smoothed_per_million], 0) AS float) AS new_cases_smoothed_per_million
      ,CAST(ISNULL([total_deaths_per_million], 0) AS float) AS total_deaths_per_million
      ,CAST(ISNULL([new_deaths_per_million], 0) AS float) AS new_deaths_per_million
      ,CAST(ISNULL([new_deaths_smoothed_per_million], 0) AS float) AS new_deaths_smoothed_per_million
      ,CAST(ISNULL([reproduction_rate], 0) AS float) AS reproduction_rate
      ,CAST(ISNULL([icu_patients], 0) AS float) AS icu_patients
      ,CAST(ISNULL([icu_patients_per_million], 0) AS float) AS icu_patients_per_million
      ,CAST(ISNULL([hosp_patients], 0) AS float) AS hosp_patients
      ,CAST(ISNULL([hosp_patients_per_million], 0) AS float) AS hosp_patients_per_million
      ,CAST(ISNULL([weekly_icu_admissions], 0) AS float) AS weekly_icu_admissions
      ,CAST(ISNULL([weekly_icu_admissions_per_million], 0) AS float) AS weekly_icu_admissions_per_million
      ,CAST(ISNULL([weekly_hosp_admissions], 0) AS float) AS weekly_hosp_admissions
      ,CAST(ISNULL([weekly_hosp_admissions_per_million], 0) AS float) AS weekly_hosp_admissions_per_million
  FROM [dbo].[CovidDeaths]

use PortfolioProject

CREATE VIEW CovidVaccinations_View AS
SELECT	ISNULL([iso_code], '') AS iso_code,
		ISNULL([continent], '') AS continent,
		ISNULL([location], '') AS location,
		ISNULL([date], '') AS date,
		CAST(ISNULL(new_tests, 0) AS FLOAT) as new_tests,
		CAST(ISNULL(total_tests_per_thousand, 0) AS FLOAT) as total_tests_per_thousand,
		CAST(ISNULL(new_tests_per_thousand, 0) AS FLOAT) as new_tests_per_thousand,
		CAST(ISNULL(new_tests_smoothed, 0) AS FLOAT) as new_tests_smoothed,
		CAST(ISNULL(new_tests_smoothed_per_thousand, 0) AS FLOAT) as new_tests_smoothed_per_thousand,
		CAST(ISNULL(positive_rate, 0) AS FLOAT) as positive_rate,
		CAST(ISNULL(tests_per_case, 0) AS FLOAT) as tests_per_case,
		CAST(ISNULL(tests_units, '') AS varchar) as tests_units,
		CAST(ISNULL(total_vaccinations, 0) AS FLOAT) as total_vaccinations,
		CAST(ISNULL(people_vaccinated, 0) AS FLOAT) as people_vaccinated,
		CAST(ISNULL(people_fully_vaccinated, 0) AS FLOAT) as people_fully_vaccinated,
		CAST(ISNULL(total_boosters, 0) AS FLOAT) as total_boosters,
		CAST(ISNULL(new_vaccinations, 0) AS FLOAT) as new_vaccinations,
		CAST(ISNULL(new_vaccinations_smoothed, 0) AS FLOAT) as new_vaccinations_smoothed,
		CAST(ISNULL(total_vaccinations_per_hundred, 0) AS FLOAT) as total_vaccinations_per_hundred,
		CAST(ISNULL(people_vaccinated_per_hundred, 0) AS FLOAT) as people_vaccinated_per_hundred,
		CAST(ISNULL(people_fully_vaccinated_per_hundred, 0) AS FLOAT) as people_fully_vaccinated_per_hundred,
		CAST(ISNULL(total_boosters_per_hundred, 0) AS FLOAT) as total_boosters_per_hundred,
		CAST(ISNULL(new_vaccinations_smoothed_per_million, 0) AS FLOAT) as new_vaccinations_smoothed_per_million,
		CAST(ISNULL(new_people_vaccinated_smoothed, 0) AS FLOAT) as new_people_vaccinated_smoothed,
		CAST(ISNULL(new_people_vaccinated_smoothed_per_hundred, 0) AS FLOAT) as new_people_vaccinated_smoothed_per_hundred,
		CAST(ISNULL(stringency_index, 0) AS FLOAT) as stringency_index,
		CAST(ISNULL(population_density, 0) AS FLOAT) as population_density,
		CAST(ISNULL(median_age, 0) AS FLOAT) as median_age,
		CAST(ISNULL(aged_65_older, 0) AS FLOAT) as aged_65_older,
		CAST(ISNULL(aged_70_older, 0) AS FLOAT) as aged_70_older,
		CAST(ISNULL(gdp_per_capita, 0) AS FLOAT) as gdp_per_capita,
		CAST(ISNULL(extreme_poverty, 0) AS FLOAT) as extreme_poverty,
		CAST(ISNULL(cardiovasc_death_rate, 0) AS FLOAT) as cardiovasc_death_rate,
		CAST(ISNULL(diabetes_prevalence, 0) AS FLOAT) as diabetes_prevalence,
		CAST(ISNULL(female_smokers, 0) AS FLOAT) as female_smokers,
		CAST(ISNULL(male_smokers, 0) AS FLOAT) as male_smokers,
		CAST(ISNULL(handwashing_facilities, 0) AS FLOAT) as handwashing_facilities,
		CAST(ISNULL(hospital_beds_per_thousand, 0) AS FLOAT) as hospital_beds_per_thousand,
		CAST(ISNULL(life_expectancy, 0) AS FLOAT) as life_expectancy,
		CAST(ISNULL(human_development_index, 0) AS FLOAT) as human_development_index,
		CAST(ISNULL(excess_mortality_cumulative_absolute, 0) AS FLOAT) as excess_mortality_cumulative_absolute,
		CAST(ISNULL(excess_mortality_cumulative, 0) AS FLOAT) as excess_mortality_cumulative,
		CAST(ISNULL(excess_mortality, 0) AS FLOAT) as excess_mortality,
		CAST(ISNULL(excess_mortality_cumulative_per_million, 0) AS FLOAT) as excess_mortality_cumulative_per_million
FROM [PortfolioProject]..[CovidVaccinations]

Select Top 10 * FROM [PortfolioProject]..[CovidVaccinations]

SELECT * 
FROM sys.views 
WHERE name = 'CovidVaccinations_view';
