with drug_list as (
	select distinct drug_concept_id, concept_name, count(*) as cnt 
	from de.drug_exposure
	join 
		de.concept
	on drug_concept_id = concept_id
	where concept_id in (
		40213154,19078106,19009384,40224172,19127663,1511248,40169216,1539463,
		19126352,1539411,1332419,40163924,19030765,19106768,19075601
	)
	group by drug_concept_id, concept_name
	order by count(*) desc
) 
, drugs as (select drug_concept_id, concept_name from drug_list)
, prescription_count as (select drug_concept_id, cnt from drug_list)
select dp.drug_concept_id1
	, d.concept_name
	, case when dp.drug_concept_id1 = pc1.drug_concept_id then pc1.cnt end cnt
from de.drug_pair dp
left join prescription_count pc1
on dp.drug_concept_id1 = pc1.drug_concept_id
left join prescription_count pc2
on dp.drug_concept_id2 = pc2.drug_concept_id
join drugs d
on dp.drug_concept_id1 = d.drug_concept_id
where pc1.cnt < pc2.cnt	
;
