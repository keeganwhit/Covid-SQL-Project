


--pulls the necessary data
Select location, date, total_cases, new_cases, total_deaths, population
from covidproject..CovidDeaths
order by 1,2

--Shows the population of countries above 10,000,000 and the total covid cases for countries on 10/4/2022
Select Distinct location, population, total_cases
from covidproject..CovidDeaths
where population > 10000000 and date = '2022-10-04' 
order by population asc



--Total cases versus total deaths to see likelyhood of dying from Covid in the United States
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from covidproject..CovidDeaths
where location = 'United States'


--Total cases versus population to see what percentage of the US population has gotten Covid
Select location, date, total_cases, population, (total_cases/population)*100 as PopulationCasesPercentage
from covidproject..CovidDeaths
where location = 'United States'
order by 1,2


--Shows the countries with the highest infection rate which shows the countries that are most likely to get covid
Select location, population, max(total_cases) as highestcases, max(total_cases/population)*100 as infectedpopulation
from covidproject..CovidDeaths
Group by location, population
order by infectedpopulation desc




--Covid death count in each country
--Shows the amount of Covid deaths in each country
Select location, max(total_deaths) as totaldeaths
from covidproject..CovidDeaths
where continent != 'null'
group by location
order by totaldeaths desc



--Highest death count by continent
--Shows the amount of deaths caused by Covid in each continent
Select continent, max(total_deaths) as totaldeaths
from covidproject..CovidDeaths
where continent != 'null'
group by continent
order by totaldeaths desc


--All information
--Joins my two tables together so I can pull data from either
select *
from covidproject..CovidVaccinations vac
join covidproject..CovidDeaths dea
	on vac.location = dea.location
	and vac.covid_date = dea.date




--Total population vs vaccines
--Joins two tables to show the amount of citizens that are vaccinated for each country updated daily
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(bigint, vac.new_vaccinations )) over (partition by dea.location order by dea.location, dea.date) as peoplevaccinated
from covidproject..CovidVaccinations vac
join covidproject..CovidDeaths dea
	on vac.location = dea.location
	and vac.covid_date = dea.date
where dea.continent is not null
order by 2,3



