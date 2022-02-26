select visit_occurrence_id
	, (visit_end_date - visit_start_date + 1) total_visit_date_cnt -- �� ������ ��
from de.visit_occurrence
;

select max_visit_date_cnt  -- �� ������ �� �ִ밪
	, count(max_visit_date_cnt) visitors_cnt  -- �� �����ϼ� �ִ밪�� ���� ȯ�ڼ�
from
(
	select max(visit_end_date - visit_start_date + 1) max_visit_date_cnt
	from de.visit_occurrence
) visit_count
group by max_visit_date
;



