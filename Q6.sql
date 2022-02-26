with order_list as (
	select distinct de.person_id, de.drug_concept_id, start_date
	from 
	(
		select person_id, drug_concept_id, drug_exposure_start_date start_date, drug_exposure_end_date end_date
		from de.drug_exposure 
		where drug_concept_id in (19018935, 1539411, 1539463, 19075601, 1115171)
	) de 
	join
	(
		select person_id
		from de.condition_occurrence co
		where co.condition_concept_id in (
			3191208,36684827,3194332,3193274,43531010,4130162,45766052,
			45757474,4099651,4129519,4063043,4230254,4193704,4304377,
			201826,3194082,3192767
		)
	) person
	on de.person_id  = person.person_id
	order by person_id, start_date, drug_concept_id
)
, order_list2 as (
	select distinct person_id, start_date
			, case when array_to_string(array_agg(cast(drug_concept_id as int) order by drug_concept_id), ',') ~ ',' then '(' || array_to_string(array_agg(cast(drug_concept_id as int) order by drug_concept_id), ',') || ')'
				else array_to_string(array_agg(cast(drug_concept_id as int) order by drug_concept_id), ',') end temp_pattern
	from order_list
	group by person_id, start_date
	order by start_date
)
, tb_pattern as (
	select string_agg(temp_pattern, '->') pattern
	from
	(
		select distinct person_id, temp_pattern
		from order_list2
	) tmp
	group by person_id
)
select pattern, count(pattern) cnt
from tb_pattern
group by pattern
order by cnt desc, length(pattern)
;