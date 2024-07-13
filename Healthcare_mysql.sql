# 1.Number of Patients across various summaries

select sum(NumberofpatientsinSerumphosphorussummary) as Serumphosphorussummary
,sum(Numberofpatientsincludedinhospitalizationsummary) as hospitalizationsummary,sum(`dia1`.`Number of Patients included in survival summary`) as survivalsummary
,sum(`dia1`.`Number of Patients included in fistula summary`) as fistulasummary,sum(`dia1`.`Number of patients in long term catheter summary`) as cathetersummary
,sum(`dia1`.`Number of patients in nPCR summary`) as nPCRsummary,sum(Numberofpatientsinhypercalcemiasummary) as hypercalcemiasummary from d.dia1 ;

# 2.Profit Vs Non-Profit Stats

select State,
       count(case when `dia1`.`ProfitorNon-Profit` = 'Profit'then 1 else null end) as Profit,
       count(case when `dia1`.`ProfitorNon-Profit`= 'Non-Profit' then 1 else null end) as NonProfit,
       count(`dia1`.`ProfitorNon-Profit`) as profitornonprofit
from d.dia1 group by State order by profitornonprofit desc ;

# 3.Chain Organizations w.r.t. Total Performance Score as No Score

select dia1.ChainOrganization as ChainOrganization,count(dia2.TotalPerformanceScore) as TotalPerformanceScore from d.dia1 join d.dia2 on dia1.FacilityName = `dia2`.`Facility Name` 
where TotalPerformanceScore = 'No Score' group by ChainOrganization order by TotalPerformanceScore desc;

# 4.Dialysis Stations Stats

select State,count(`dia1`.`#ofDialysisStations`) as Dialysis_Stations from d.dia1 group by State order by Dialysis_Stations desc;

# 5.# of Category Text  - As Expected

select
    count(case when PatientTransfusioncategorytext = 'As Expected' then 1 end) as 'Patient Transfusioncategory text',
    count(case when`dia1`.`Patient hospitalization category text` = 'As Expected' then 1 end) as 'Patient hospitalization category text',
    count(case when `dia1`.`Patient Hospital Readmission Category` = 'As Expected' then 1 end) as 'Patient Hospital Readmission Category',
	count(case when`dia1`.`Patient Survival Category Text` = 'As Expected' then 1 end) as 'Patient Survival Category Text',
    count(case when `dia1`.`Patient Infection category text` = 'As Expected' then 1 end) as 'Patient Infection category text',
    count(case when `dia1`.`Fistula Category Text` = 'As Expected' then 1 end) as 'Fistula Category Text',
    count(case when `dia1`.`SWR category text` = 'As Expected' then 1 end) as 'SWR category text',
    count(case when `dia1`.`PPPW category text` = 'As Expected' then 1 end) as 'PPPW category text'
from d.dia1; 

# 6. Average Payment Reduction Rate

select concat(round(sum(PY2020PaymentReductionPercentage)/count(case when PY2020PaymentReductionPercentage !='No Reduction' then 1 end)* 100,2),'%') as 'Average Payment Reduction Rate' from d.dia2 ;