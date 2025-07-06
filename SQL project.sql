create table student_table (
Id int primary key,
First_name varchar,
Last_name varchar,
Email varchar,
Gender varchar,
Part_time_job bool,
Absense_days int,
Extracurricular_activities bool,
weekly_self_study_hours int,
career_aspiration varchar,
math_score int,
history_score int,
physics_score int,
chemistry_score int,
biology_score int,
english_score int,
geography_score int);
select * from student_table
Copy student_table from 
'C:\Program Files\PostgreSQL\17\data\dataset\student_scores.csv'
delimiter','csv header;
select career_aspiration, avg(math_score) as average_math_score
from student_table group by career_aspiration order by average_math_score desc;
select career_aspiration, avg(english_score) as average_english_score from student_table
group by career_aspiration
having avg(english_score)>75
order by average_english_score desc;
select first_name, last_name, math_score from student_table
where math_score>(select avg(math_score) from student_table)
select first_name, last_name, career_aspiration, physics_score, 
rank()over(partition by career_aspiration order by physics_score desc)
as rank_in_career from student_table
order by career_aspiration, rank_in_career 
select concat(first_name,' ',last_name) as full_name,email from student_table
where email like '%academy%'
select career_aspiration,gender,floor(min(chemistry_score))as lowest_chemistry_score,
ceil(max(chemistry_score)) as highest_chemistry_score,round(avg(chemistry_score),2)
as average_chemistry_score, 
--rank()over(partition by career_aspiration order by gender) as rank_in_career to be done
from student_table
group by career_aspiration,gender
order by gender desc
select career_aspiration,avg(history_score) as average_history_score from student_table
group by career_aspiration
having(avg(history_score))>85 and count(id)>=5
select id,first_name,last_name,biology_score,chemistry_score from student_table
where biology_score>(select avg(biology_score)from student_table) and
chemistry_score>(select avg(chemistry_score) from student_table)
select id, first_name, last_name,
round((absense_days::decimal / (select sum(absense_days) from student_table)
* 100), 2) as absence_percentage
from student_table
order by absence_percentage desc;
select id, first_name, last_name,
(case when math_score > 80 then 1 else 0 end +
case when history_score > 80 then 1 else 0 end +
case when physics_score > 80 then 1 else 0 end +
case when chemistry_score > 80 then 1 else 0 end +
case when biology_score > 80 then 1 else 0 end +
case when english_score > 80 then 1 else 0 end) as subjects_above_80
from student_table
where (case when math_score > 80 then 1 else 0 end +
case when history_score > 80 then 1 else 0 end +
case when physics_score > 80 then 1 else 0 end +
case when chemistry_score > 80 then 1 else 0 end +
case when biology_score > 80 then 1 else 0 end +
case when english_score > 80 then 1 else 0 end) >= 3

