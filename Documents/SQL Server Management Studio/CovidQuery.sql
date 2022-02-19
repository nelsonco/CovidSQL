Select *
From CovidDeaths
order by 3,4


Select *
From CovidVaccinations
order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
order by 1,2

-- Total Cases vs Total Deaths
-- Likely hood of dying if you contract covid in the US

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where location like '%states%'
order by 1,2


-- Total Cases vs Population


Select Location, date, population, total_cases, (total_cases/population)*100 as DeathPercentage
From CovidDeaths
Where location like '%states%'
order by 1,2

-- Infection Rate Max
Select Location, population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentInfected
From CovidDeaths
Group by Location, population
order by PercentInfected desc

-- Highest Deaths per Pop
Select Location, population, Max(cast(total_deaths as int)) as HighestDeathCount, Max((total_deaths/population))*100 as PercentDeaths
From CovidDeaths
Where continent is not NULL
Group by Location, population
order by PercentDeaths desc

-- Highest Deaths per Continent/ Income
Select location, population, Max(cast(total_deaths as int)) as HighestDeathCount, Max((total_deaths/population))*100 as PercentDeaths
From CovidDeaths
Where continent is NULL
Group by location, population
order by PercentDeaths desc

-- Global Numbers

Select date, SUM(new_cases), SUM(cast(new_deaths as int))
From CovidDeaths 
Where location like '%World%'
Group by date

-- Total Population vs Vaccinations

Select 
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date

Create View USDeathPercentage as 
Select Location, date, population, total_cases, (total_cases/population)*100 as DeathPercentage
From CovidDeaths
Where location like '%states%'
--order by 1,2