select co.condition_occurrence_id, co.condition_concept_id, c.concept_name
from 
(
	select condition_occurrence_id, condition_concept_id
	from de.condition_occurrence
) co
join 
(
	select concept_id, concept_name 
	from de.concept
	where lower(concept_name) ~ '^[abcde]'
	and lower(concept_name) ~ 'heart'
) c
on co.condition_concept_id  = c.concept_id 
order by condition_occurrence_id
;
