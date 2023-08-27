select * 
from PortfolioProject..coviddeath
--where continent is not null
order by 3, 4



--select * 
--from PortfolioProject..covidvaccination
--order by 3, 4
-- Select Data that we are gonna be using

select [location],[date],[new_cases],[total_cases],[population]
from PortfolioProject..coviddeath
where continent is not null
order by 1, 2

-- Looking at Total cases vs Total deaths

select [location],[date],[total_cases],[population],
([total_deaths]/[total_cases])*100 as DeathPercentage
from PortfolioProject..coviddeath
where location like '%India%'
and continent is not null
order by 1, 2
--Looking at Total Cases vs Population
--Shows what percentage of people got affected

select [location],[date],[population],[total_cases],
([total_cases]/[population])*100 as Peopleaffected
from PortfolioProject..coviddeath
where location like 'Al%'
and continent is not null
order by 1, 2

--Looking at countries with highest infection rate compare to Population
select [location],[population],Max([total_cases]) as TotalCases,
Max([total_cases]/[population])*100 as PercentPopulationInfected
from PortfolioProject..coviddeath
where continent is not null
group by [location], [population]
order by PercentPopulationInfected desc

--Showing countries with Highest death count per population
--Highest Percentage of death by Country

select [location],[population],Max([total_deaths]) as TotalDeathCount,
Max([total_deaths]/[population])*100 as DeathPercent
from PortfolioProject..coviddeath
where continent is not null
group by [location],[population]
order by DeathPercent desc

--Let's break things down by continent.

select [continent], Max([total_deaths]) as TotalDeathCount,
Max([total_deaths]/[population])*100 as DeathPercent
from PortfolioProject..coviddeath
where continent is not null
group by [continent]
order by DeathPercent desc


select [date], Sum([new_cases]) as TotalCases, Sum([new_deaths]) as TotalDeathCount,
(SUM(nullif([new_cases],0))/SUM(nullif([new_deaths],0))*100 as DeathsPercent
from PortfolioProject..coviddeath
where continent is not null
group by [date] 
order by 1, 2

--Looking at total population vs vaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as
RollingPeopleVaccinated
from PortfolioProject..coviddeath dea
join 
PortfolioProject..covidvaccination vac
	on dea.location = vac.location
	and dea.date = vac.date 
where dea.continent is not null
--and dea.location like 'Al%'
order by 2,3

