
select *
from portfolioproject..CovidDeaths
order by 3,4

select *
from portfolioproject..CovidVaccinations
order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
from portfolioproject..CovidDeaths
 order by 1,2

 --SHOWS LIKEHOOD OF DYING IF YOU CONTACT COVID IN YOUR COUNTRY
select location,date,total_cases,new_cases,total_deaths,
(total_deaths/total_cases)*100 DeathPercentage
from portfolioproject..CovidDeaths
where location like '%india%'
 order by 1,2

 --looking at total cases vs population
 --shows what percentage of poppulation got covid

select  location,date,population,total_cases,
(total_cases/population)*100 PercentPoppulationInfected
from portfolioproject..CovidDeaths
where location like '%india%'
 order by 1,2

 --looking at countries with highest Infection Rate Compared to population 

 select  location,population,max(total_cases) highest_Infection_Count ,
MAX((total_cases/population))*100 Percent_Population_Infected
from portfolioproject..CovidDeaths
--where location like '%india%'
group by location,population
 order by Percent_Population_Infected desc

 --showing countries with highest death count per population
 
select  location,max(cast(total_deaths as int)) as total_death_count
from portfolioproject..CovidDeaths
--where location like '%india%'
where continent is not null
group by location,population
 order by total_death_count desc

 -- LETS BREAK THINGS DOWN BY CONTINENT
 select  location,max(cast(total_deaths as int)) as total_death_count
from portfolioproject..CovidDeaths
--where location like '%india%'
where continent is null
group by location
 order by total_death_count desc

 --GLOBAL NUMBERS
 select date, sum (new_cases)as total_cases,sum(cast(new_deaths as int))as total_deaths ,
 sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..CovidDeaths
--where location like '%india%'
WHERE continent IS NOT NULL
group by date
 order by 1,2

 --TOTAL GLOBAL NUMBERS
  select  sum (new_cases)as total_cases,sum(cast(new_deaths as int))as total_deaths ,
 sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..CovidDeaths
--where location like '%india%'
WHERE continent IS NOT NULL
--group by date
 order by 1,2

 --LOOKING AT TOTAL POPULATION VS VACCINATION

 
 Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 sum(convert(int,vac.new_vaccinations ) )
 over (partition by dea.location order by dea.location ,dea.date) as Rolling_people_Vaccinationed
 from portfolioproject..CovidDeaths dea
 join portfolioproject..CovidVaccinations vac
 on dea.location=vac.location
 and dea.date=vac.date
 where dea.continent is not null
 order by 2,3
 


 --USE CTE
  with popvsvac (continent,location,date,population ,new_vaccinations, Rolling_people_Vaccinationed)
 as
  (
 Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 sum(convert(int,vac.new_vaccinations ) )
 over (partition by dea.location order by dea.location ,dea.date) as Rolling_people_Vaccinationed
 from portfolioproject..CovidDeaths dea
 join portfolioproject..CovidVaccinations vac
 on dea.location=vac.location
 and dea.date=vac.date
 where dea.continent is not null
 --order by 2,3
 )
 select * ,(Rolling_people_Vaccinationed/population)*100
 from popvsvac;




 -- TEMP TABLES

 drop table if exists #PercentPopulationVaccinated
 CREATE TABLE #PercentPopulationVaccinated
 (
 continent nvarchar(255),
 location nvarchar(255),
 date datetime,
 population numeric,
 New_vaccinations numeric,
 Rolling_people_Vaccinationed numeric
 )
 Insert Into  #PercentPopulationVaccinated
 Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 sum(convert(int,vac.new_vaccinations ) )
 over (partition by dea.location order by dea.location ,dea.date) as Rolling_people_Vaccinationed
 from portfolioproject..CovidDeaths dea
 join portfolioproject..CovidVaccinations vac
 on dea.location=vac.location
 and dea.date=vac.date
 --where dea.continent is not null
 --order by 2,3
 select * ,(Rolling_people_Vaccinationed/population)*100
 from #PercentPopulationVaccinated;

 -- CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION
 
 
 CREATE view  PercentPopulationVaccinated as
 Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 sum(convert(int,vac.new_vaccinations ) )
 over (partition by dea.location order by dea.location ,dea.date) as Rolling_people_Vaccinationed
 from portfolioproject..CovidDeaths dea
 join portfolioproject..CovidVaccinations vac
 on dea.location=vac.location
 and dea.date=vac.date
 where dea.continent is not null
 --order by 2,3


	

