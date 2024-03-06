
SELECT *
FROM PortfolioProject..CovidDeaths_View
ORDER BY 3,4

SELECT *
FROM PortfolioProject..CovidDeaths_View
WHERE continent IS NOT NULL
ORDER BY 3,4

SELECT *
FROM PortfolioProject..CovidDeaths_View
ORDER BY 3,4

-- Select Data that we are going to be using
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths_View
ORDER BY 1,2


-- Looking at Total Cases vs Total Deaths
-- Show likelihood of dying if you contract covid in your country
SELECT location, date, total_cases, total_deaths,
CASE WHEN total_cases > 0 THEN (total_deaths/total_cases) ELSE 0 END *100 as DeathPercentage
FROM PortfolioProject..CovidDeaths_View
WHERE location like '%states%'
AND continent IS NOT NULL
ORDER BY 1,2 DESC

SELECT location, date, total_cases, total_deaths,
CASE WHEN total_cases > 0 THEN (total_deaths/total_cases) ELSE 0 END *100 as DeathPercentage
FROM PortfolioProject..CovidDeaths_View
WHERE location like '%states%'
AND continent IS NOT NULL
ORDER BY 5 DESC


-- before creating View for CovidDeaths
SELECT location, date, total_cases, total_deaths,
CASE WHEN CAST(ISNULL(total_cases,0) AS Decimal(27,8)) > 0 THEN 
(CAST(ISNULL(total_deaths,0) AS Decimal(27,8))/CAST(ISNULL(total_cases,0) AS Decimal(27,8))) ELSE 0 
-- CASE WHEN ISNULL(total_cases,0) > 0 THEN ISNULL(population,0)/ISNULL(total_cases,0) ELSE 0 
END *100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
AND continent IS NOT NULL
ORDER BY 1,2


-- Looking at Total Cases vs Population
-- Shows what percentage of population got covid
SELECT location, date, population, total_cases,
CASE WHEN total_cases > 0 THEN (total_deaths/total_cases) ELSE 0 END *100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths_View
WHERE location like '%states%'
AND continent IS NOT NULL
ORDER BY 1,2

SELECT location, date, population, total_cases, 
CASE WHEN total_cases > 0 THEN (population/total_cases) ELSE 0 END *100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths_View
WHERE location like '%states%'
AND continent IS NOT NULL
ORDER BY 1,2

-- Looking at Countries with Highest Infection Rate compared to Population
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths_View
-- WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC


-- Showing Countries with Highest Death Count per Population
-- total_deaths data type is nvarchar so we have to 
-- MAX(cast(total_deaths as int)) if total_deaths is nvarchar
SELECT location, population, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths_View
-- WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY TotalDeathCount DESC

SELECT location, population, MAX(total_deaths) as TotalDeathCount, MAX((total_deaths/population))*100 as PercentPopulationDeath
FROM PortfolioProject..CovidDeaths
-- WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY TotalDeathCount DESC, PercentPopulationDeath DESC

-- Let's break things down by continent
-- Showing continents with the highest death count per population
SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths_View
-- WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths_View
-- WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths_View
-- WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global Numbers
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
CASE WHEN SUM(new_cases) > 0 THEN (SUM(new_deaths)*100 / SUM(new_cases)) ELSE 0 
END AS DeathPercentage
FROM PortfolioProject..CovidDeaths_View
-- WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2


Select Top 10 * From PortfolioProject.dbo.CovidVaccinations_View

-- Looking at Total Population vs Vaccinations
SELECT continent
FROM PortfolioProject..CovidVaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject..CovidDeaths_View dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition By dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated -- at 3.17hr
--, (RollingPeopleVaccinated/Population) * 100
FROM PortfolioProject..CovidDeaths_View dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

-- USE CTE (for grouping)
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition By dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths_View dea
JOIN PortfolioProject..CovidVaccinations_View vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
) 
SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercentPopulationVaccinated
FROM PopvsVac


-- TEMP Table
DROP Table if Exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition By dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated-- at 3.17hr
FROM PortfolioProject..CovidDeaths_View dea
JOIN PortfolioProject..CovidVaccinations_view vac
	ON dea.location = vac.location
	AND dea.date = vac.date
-- WHERE dea.continent IS NOT NULL
-- ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated


-- Creating View to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition By dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated-- at 3.17hr
FROM PortfolioProject..CovidDeaths_View dea
JOIN PortfolioProject..CovidVaccinations_view vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL


SELECT TOP 100 *
FROM PercentPopulationVaccinated





