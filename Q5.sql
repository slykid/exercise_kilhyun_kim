select count(condition_concept_id)
from
(
	select condition_concept_id, person_id 
	from de.condition_occurrence co
	where co.condition_concept_id in (
		3191208,36684827,3194332,3193274,43531010,4130162,45766052,
		45757474,4099651,4129519,4063043,4230254,4193704,4304377,
		201826,3194082,3192767
	)
) co
join 
(
	select p.person_id
	from
	(
		select person_id
		from person
		where extract(year from AGE(birth_datetime)) >= 18
	) p 
	join
	(
		select dp.person_id
		from
		(
			select person_id, (max(drug_exposure_end_date) - min(drug_exposure_start_date) + 1) exposure_date_cnt
			from de.drug_exposure de
			where drug_concept_id = 40163924
			group by person_id
		) dp
		where exposure_date_cnt > 90
	) target
	on p.person_id = target.person_id
	
) target_18
on co.person_id = target_18.person_id
;



