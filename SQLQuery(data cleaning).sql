
-- cleaning data in SQL 

select * from portfolioproject.dbo.nashvillehousing


---standardize data format

select saledateconverted ,convert(date,saledate)
from portfolioproject.dbo.nashvillehousing

update nashvillehousing 
set saledate=convert(date,saledate)


ALTER TABLE nASHVILLEhousing
add saledateconverted date;

update nashvillehousing 
set saledateconverted =convert(date,saledate)

--populate property address data


select * 
from portfolioproject.dbo.nashvillehousing
--where propertyaddress is null
order by parcelID

select a.parcelid,a.propertyaddress,b.parcelid,b.propertyaddress ,
isnull(a.propertyaddress,b.propertyaddress)
from portfolioproject.dbo.nashvillehousing a
join portfolioproject.dbo.nashvillehousing b
 on  a.parcelid=b.parcelid
 and a.[uniqueID]<> b.[uniqueid]
where a.propertyaddress is null


update a
set propertyaddress=isnull(a.propertyaddress,b.propertyaddress)
from portfolioproject.dbo.nashvillehousing a
join portfolioproject.dbo.nashvillehousing b
 on  a.parcelid=b.parcelid
 and a.[uniqueID]<> b.[uniqueid]
where a.propertyaddress is null


--BREAKING OUT NADDRESS INTO INDIVIDUAL COLUMNS(ADDRESS,CITY,STATE)



select PROPERTYADDRESS 
from portfolioproject.dbo.nashvillehousing
--where propertyaddress is null
--order by parcelID

select 
substring (propertyaddress,1,charindex(',',propertyaddress)-1)as address
,substring (propertyaddress,charindex(',',propertyaddress)+1,len(propertyaddress))as address
from portfolioproject.dbo.nashvillehousing

ALTER TABLE nASHVILLEhousing
add propertysplitaddress varchar(255);

update nashvillehousing 
set propertysplitaddress =substring (propertyaddress,1,charindex(',',propertyaddress)-1)

ALTER TABLE nASHVILLEhousing
add propertysplitcity varchar(255);

update nashvillehousing 
set propertysplitcity =substring (propertyaddress,charindex(',',propertyaddress)+1,len(propertyaddress))


select* from portfolioproject.dbo.nashvillehousing



select owneraddress 
from portfolioproject.dbo.nashvillehousing


select 
PARSENAME (replace(owneraddress ,',','.'),3)
,PARSENAME (replace(owneraddress ,',','.'),2)
,PARSENAME (replace(owneraddress ,',','.'),1)
from portfolioproject.dbo.nashvillehousing



ALTER TABLE nASHVILLEhousing
add ownersplitaddress nvarchar(255);

update nashvillehousing 
set ownersplitaddress =PARSENAME (replace(owneraddress ,',','.'),3)

ALTER TABLE nASHVILLEhousing
add ownersplitcity nvarchar(255);

update nashvillehousing 
set ownersplitcity =PARSENAME (replace(owneraddress ,',','.'),2)

ALTER TABLE nASHVILLEhousing
add ownersplitstate nvarchar(255);

update nashvillehousing 
set ownersplitstate =PARSENAME (replace(owneraddress ,',','.'),1)



select* from portfolioproject.dbo.nashvillehousing



-- changing Y and N to yes and no in "sold as vacant" field


select distinct (soldasvacant)
from portfolioproject.dbo.nashvillehousing	

select soldasvacant 
,case when soldasvacant ='Y' then 'Yes'
	 WHEN soldasvacant='N' THEN 'No'
	 else soldasvacant
	 end
from portfolioproject.dbo.nashvillehousing	

update nashvillehousing
set soldasvacant=case when soldasvacant ='Y' then 'Yes'
	 WHEN soldasvacant='N' THEN 'No'
	 else soldasvacant
	 end


--REMOVE DUPLICATES

WITH ROWNUMCTE AS (
select*,
	row_number() over(
	partition by parcelid,
				 propertyaddress,
				 saleprice,
				 saledate,
				 legalreference
				 order by 
					uniqueid
						)row_num
from portfolioproject.dbo.nashvillehousing
--order by parcelid
)
select*
from ROWNUMCTE
where row_num>1
--order by propertyaddress


--DELETE UNUSED COLUMNS

Select *
from portfolioproject.dbo.nashvillehousing

alter table portfolioproject.dbo.nashvillehousing
drop column saledate,owneraddress,taxdistrict
