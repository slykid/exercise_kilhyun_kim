create table drug_exposure_person_1891866 as
select drug_concept_id
	, min(drug_exposure_start_date) drug_exposure_start_date
	, max(drug_exposure_end_date) drug_exposure_end_date
	, (max(drug_exposure_end_date) - min(drug_exposure_start_date) + 1) drug_exposure_dates
from de.drug_exposure
where person_id = 1891866
group by drug_concept_id
order by drug_exposure_dates desc
;