/********************** Produced By *********************

      / \   ___| |_ _   _| |_ ___  |_   _|__  ___| |__  
     / _ \ / __| __| | | | __/ _ \   | |/ _ \/ __| '_ \ 
    / ___ \\__ \ |_| |_| | ||  __/   | |  __/ (__| | | |
   /_/   \_\___/\__|\__,_|\__\___|   |_|\___|\___|_| |_|
    
-- URL			      : www.AstuteTech.co.za
-- Author/Creator     : Ruan van Zyl
-- Company Postion    : Business Intelligence Specialist
-- Date			      : 03-07-2017    
-- Purpose            : Replicate Financial tool from Access to SQL 
-- Part				  : ForeCast
************************ History ************************
-- Modifications Made By : None
-- Last Modifications Date : None
-- Modifications Made : None
*********************************************************/

SET NOCOUNT ON;

/*************************************************
***** Clear final tables - E_DEMAND_PROJECTION_CLEAR
**************************************************/

TRUNCATE TABLE [dbo].[E_DEMAND_PROJECTION];

/*************** 
***** E_DEMAND_PROJECTION_01_BASE ****
****************/

SELECT
           D_DEMAND_PROJECTION.DEMAND_ID AS [Role ID]
         ,V_SCOPE.LABEL
         ,V_SCOPE_WS.LABEL
         ,V_SCOPE_WS_PRG.LABEL
         ,V_SCOPE_WS_PRG_DWE.LABEL
         ,V_FUNCTION.LABEL                                                                                    AS Function
         ,V_ROLE_TYPE.LABEL                                                                                   AS [Role Type]
         ,D_DEMAND_PROJECTION.ROLE_SPECIALIZATION                                                             AS [Role Specialization]
         ,D_DEMAND_PROJECTION.ROLE_DETAILS                                                                    AS [Role Details]
         ,IIf(IsNull([V_STAFFING_STATUS].[LABEL]),"Staffing Unknown/Not Staffed",[V_STAFFING_STATUS].[LABEL]) AS [Staffing Status]
         ,V_RESOURCE_TYPE.LABEL                                                                               AS [Resource Type]
         ,V_VENDOR.LABEL                                                                                      AS Vendor
         ,D_PERSON.PERSON_NAME                                                                                AS [Resource Name]
         ,D_PERSON.EXTERNAL_ID                                                                                AS [Resource ID]
         ,V_HR_STATUS.HR_STATUS                                                                               AS [HR Status]
         ,V_LOCATION.LABEL                                                                                    AS [Primary Location]
         ,IIf(((IsNull([V_STAFFING_STATUS].[V_STAFFING_STATUS_ID])
           Or [V_STAFFING_STATUS].[V_STAFFING_STATUS_ID]=1)
           And
           (
                      [D_DEMAND_PROJECTION].[V_RESOURCE_TYPE_ID]=1
           )
           And
           (
                      [LEGACY_STATUS]="Current"
           )
           )
           Or
           (
                      [V_STAFFING_STATUS].[V_STAFFING_STATUS_ID]    =2
                      And [D_DEMAND_PROJECTION].[V_RESOURCE_TYPE_ID]=1
                      And [D_PERSON].[HR_START_DATE]                <#1/1/2014#
           )
           ,"Current","New")                    AS [Internal Status]
         ,D_DEMAND_PROJECTION.HOURLY_BILL_RATE AS [Hourly Bill Rate]
         ,V_TREATMENT.LABEL                    AS Treatment
         ,V_PHASE.LABEL                        AS [Phase Override]
         ,D_DEMAND_PROJECTION.HOURS_2016_00
         ,D_DEMAND_PROJECTION.HOURS_2017_01
         ,D_DEMAND_PROJECTION.HOURS_2017_02
         ,D_DEMAND_PROJECTION.HOURS_2017_03
         ,D_DEMAND_PROJECTION.HOURS_2017_04
         ,D_DEMAND_PROJECTION.HOURS_2017_05
         ,D_DEMAND_PROJECTION.HOURS_2017_06
         ,D_DEMAND_PROJECTION.HOURS_2017_07
         ,D_DEMAND_PROJECTION.HOURS_2017_08
         ,D_DEMAND_PROJECTION.HOURS_2017_09
         ,D_DEMAND_PROJECTION.HOURS_2017_10
         ,D_DEMAND_PROJECTION.HOURS_2017_11
         ,D_DEMAND_PROJECTION.HOURS_2017_12
         ,D_DEMAND_PROJECTION.HOURS_2018_01
         ,D_DEMAND_PROJECTION.HOURS_2018_02
         ,D_DEMAND_PROJECTION.HOURS_2018_03
         ,D_DEMAND_PROJECTION.HOURS_2018_04
         ,D_DEMAND_PROJECTION.HOURS_2018_05
         ,D_DEMAND_PROJECTION.HOURS_2018_06
         ,D_DEMAND_PROJECTION.HOURS_2018_07
         ,D_DEMAND_PROJECTION.HOURS_2018_08
         ,D_DEMAND_PROJECTION.HOURS_2018_09
         ,D_DEMAND_PROJECTION.HOURS_2018_10
         ,D_DEMAND_PROJECTION.HOURS_2018_11
         ,D_DEMAND_PROJECTION.HOURS_2018_12
         ,D_DEMAND_PROJECTION.HOURS_2019_01
         ,D_DEMAND_PROJECTION.HOURS_2019_02
         ,D_DEMAND_PROJECTION.HOURS_2019_03
         ,D_DEMAND_PROJECTION.HOURS_2019_04
         ,D_DEMAND_PROJECTION.HOURS_2019_05
         ,D_DEMAND_PROJECTION.HOURS_2019_06
         ,D_DEMAND_PROJECTION.HOURS_2019_07
         ,D_DEMAND_PROJECTION.HOURS_2019_08
         ,D_DEMAND_PROJECTION.HOURS_2019_09
         ,D_DEMAND_PROJECTION.HOURS_2019_10
         ,D_DEMAND_PROJECTION.HOURS_2019_11
         ,D_DEMAND_PROJECTION.HOURS_2019_12
         ,D_DEMAND_PROJECTION.HOURS_2020_00
         ,D_DEMAND_PROJECTION.HOURS_2021_00
         ,D_DEMAND_PROJECTION.V_SCOPE_WS_PRG_DWE_ID
         ,V_GRP_PERSON_DIV.LEADER_NAME
         ,V_GRP_PERSON_TEAM.LEADER_NAME
         ,V_SCOPE_WS_PRG_DWE.PRJ_STATUS
         ,D_DEMAND_PROJECTION.BAU_SOURCE
FROM
    V_VENDOR
    RIGHT JOIN
                (V_TREATMENT
                RIGHT JOIN
                            (V_STAFFING_STATUS
                            RIGHT JOIN
                                    (V_ROLE_TYPE
                                    RIGHT JOIN
                                                (V_RESOURCE_TYPE
                                                RIGHT JOIN
                                                            (V_PHASE
                                                            RIGHT JOIN
                                                                        (V_LOCATION
                                                                        RIGHT JOIN
                                                                                (V_FUNCTION
                                                                                RIGHT JOIN
                                                                                            (V_SCOPE
                                                                                            RIGHT JOIN
                                                                                                        ((((D_PERSON
                                                                                                        LEFT JOIN
                                                                                                                    V_GRP_PERSON_DIV
                                                                                                                    ON
                                                                                                                            D_PERSON.V_GRP_PERSON_DIV_ID = V_GRP_PERSON_DIV.V_GRP_PERSON_DIV_ID)
                                                                                                        LEFT JOIN
                                                                                                                    V_GRP_PERSON_TEAM
                                                                                                                    ON
                                                                                                                            D_PERSON.V_GRP_PERSON_TEAM_ID = V_GRP_PERSON_TEAM.V_GRP_PERSON_TEAM_ID)
                                                                                                        LEFT JOIN
                                                                                                                    V_HR_STATUS
                                                                                                                    ON
                                                                                                                            D_PERSON.HR_STATUS = V_HR_STATUS.ID)
                                                                                                        RIGHT JOIN
                                                                                                                    (V_SCOPE_WS
                                                                                                                    RIGHT JOIN
                                                                                                                            (V_SCOPE_WS_PRG
                                                                                                                            RIGHT JOIN
                                                                                                                                        (V_SCOPE_WS_PRG_DWE
                                                                                                                                        RIGHT JOIN
                                                                                                                                                    D_DEMAND_PROJECTION
                                                                                                                                                    ON
                                                                                                                                                                V_SCOPE_WS_PRG_DWE.[V_SCOPE_WS_PRG_DWE_ID] = D_DEMAND_PROJECTION.[V_SCOPE_WS_PRG_DWE_ID])
                                                                                                                                        ON
                                                                                                                                                    V_SCOPE_WS_PRG.[V_SCOPE_WS_PRG_ID] = V_SCOPE_WS_PRG_DWE.V_SCOPE_WS_PRG_ID)
                                                                                                                            ON
                                                                                                                                        V_SCOPE_WS.[V_SCOPE_WS_ID] = V_SCOPE_WS_PRG.[V_SCOPE_WS_ID])
                                                                                                                    ON
                                                                                                                            D_PERSON.D_PERSON_ID = D_DEMAND_PROJECTION.D_PERSON_ID)
                                                                                                        ON
                                                                                                                    V_SCOPE.V_SCOPE_ID = V_SCOPE_WS.V_SCOPE_ID)
                                                                                            ON
                                                                                                        V_FUNCTION.V_FUNCTION_ID = D_DEMAND_PROJECTION.V_FUNCTION_ID)
                                                                                ON
                                                                                            V_LOCATION.V_LOCATION_ID = D_DEMAND_PROJECTION.V_LOCATION_ID)
                                                                        ON
                                                                                V_PHASE.V_PHASE_ID = D_DEMAND_PROJECTION.V_PHASE_ID)
                                                            ON
                                                                        V_RESOURCE_TYPE.V_RESOURCE_TYPE_ID = D_DEMAND_PROJECTION.V_RESOURCE_TYPE_ID)
                                                ON
                                                            V_ROLE_TYPE.V_ROLE_TYPE_ID = D_DEMAND_PROJECTION.V_ROLE_TYPE_ID)
                                    ON
                                                V_STAFFING_STATUS.V_STAFFING_STATUS_ID = D_PERSON.V_STAFFING_STATUS_ID)
                            ON
                                    V_TREATMENT.V_TREATMENT_ID = D_DEMAND_PROJECTION.V_TREATMENT_ID)
                ON
                            V_VENDOR.V_VENDOR_ID = D_DEMAND_PROJECTION.V_VENDOR_ID;

/*************** 
***** E_DEMAND_PROJECTION_02_CASH ****
****************/

SELECT 
E_DEMAND_PROJECTION_01_BASE.*,
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2016_00]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2016_00]*[Hourly Bill Rate],0)) AS [CASH 2016-00],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_01]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_01]*[Hourly Bill Rate],0)) AS [CASH 2017-01],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_02]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_02]*[Hourly Bill Rate],0)) AS [CASH 2017-02],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_03]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_03]*[Hourly Bill Rate],0)) AS [CASH 2017-03],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_04]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_04]*[Hourly Bill Rate],0)) AS [CASH 2017-04],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_05]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_05]*[Hourly Bill Rate],0)) AS [CASH 2017-05],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_06]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_06]*[Hourly Bill Rate],0)) AS [CASH 2017-06],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_07]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_07]*[Hourly Bill Rate],0)) AS [CASH 2017-07],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_08]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_08]*[Hourly Bill Rate],0)) AS [CASH 2017-08],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_09]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_09]*[Hourly Bill Rate],0)) AS [CASH 2017-09],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_10]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_10]*[Hourly Bill Rate],0)) AS [CASH 2017-10],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_11]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_11]*[Hourly Bill Rate],0)) AS [CASH 2017-11],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2017_12]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2017_12]*[Hourly Bill Rate],0)) AS [CASH 2017-12],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_01]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_01]*[Hourly Bill Rate],0)) AS [CASH 2018-01],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_02]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_02]*[Hourly Bill Rate],0)) AS [CASH 2018-02],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_03]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_03]*[Hourly Bill Rate],0)) AS [CASH 2018-03],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_04]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_04]*[Hourly Bill Rate],0)) AS [CASH 2018-04],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_05]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_05]*[Hourly Bill Rate],0)) AS [CASH 2018-05],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_06]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_06]*[Hourly Bill Rate],0)) AS [CASH 2018-06],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_07]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_07]*[Hourly Bill Rate],0)) AS [CASH 2018-07],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_08]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_08]*[Hourly Bill Rate],0)) AS [CASH 2018-08],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_09]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_09]*[Hourly Bill Rate],0)) AS [CASH 2018-09],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_10]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_10]*[Hourly Bill Rate],0)) AS [CASH 2018-10],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_11]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_11]*[Hourly Bill Rate],0)) AS [CASH 2018-11],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2018_12]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2018_12]*[Hourly Bill Rate],0)) AS [CASH 2018-12],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_01]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_01]*[Hourly Bill Rate],0)) AS [CASH 2019-01],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_02]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_02]*[Hourly Bill Rate],0)) AS [CASH 2019-02],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_03]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_03]*[Hourly Bill Rate],0)) AS [CASH 2019-03],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_04]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_04]*[Hourly Bill Rate],0)) AS [CASH 2019-04],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_05]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_05]*[Hourly Bill Rate],0)) AS [CASH 2019-05],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_06]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_06]*[Hourly Bill Rate],0)) AS [CASH 2019-06],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_07]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_07]*[Hourly Bill Rate],0)) AS [CASH 2019-07],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_08]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_08]*[Hourly Bill Rate],0)) AS [CASH 2019-08],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_09]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_09]*[Hourly Bill Rate],0)) AS [CASH 2019-09],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_10]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_10]*[Hourly Bill Rate],0)) AS [CASH 2019-10],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_11]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_11]*[Hourly Bill Rate],0)) AS [CASH 2019-11],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2019_12]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2019_12]*[Hourly Bill Rate],0)) AS [CASH 2019-12],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2020_00]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2020_00]*[Hourly Bill Rate],0)) AS [CASH 2020-00],
IIf(IsNull(IIf(B.[Internal Status]<>'Current',[HOURS_2021_00]*[Hourly Bill Rate],0)),0,IIf(B.[Internal Status]<>'Current',[HOURS_2021_00]*[Hourly Bill Rate],0)) AS [CASH 2021-00],
IIf(IsNull([CASH 2017-01]),0,[CASH 2017-01])+IIf(IsNull([CASH 2017-02]),0,[CASH 2017-02])+IIf(IsNull([CASH 2017-03]),0,[CASH 2017-03]) AS [CASH 2017-1Q],
IIf(IsNull([CASH 2017-04]),0,[CASH 2017-04])+IIf(IsNull([CASH 2017-05]),0,[CASH 2017-05])+IIf(IsNull([CASH 2017-06]),0,[CASH 2017-06]) AS [CASH 2017-2Q],
IIf(IsNull([CASH 2017-07]),0,[CASH 2017-07])+IIf(IsNull([CASH 2017-08]),0,[CASH 2017-08])+IIf(IsNull([CASH 2017-09]),0,[CASH 2017-09]) AS [CASH 2017-3Q],
IIf(IsNull([CASH 2017-10]),0,[CASH 2017-10])+IIf(IsNull([CASH 2017-11]),0,[CASH 2017-11])+IIf(IsNull([CASH 2017-12]),0,[CASH 2017-12]) AS [CASH 2017-4Q],
IIf(IsNull([CASH 2018-01]),0,[CASH 2018-01])+IIf(IsNull([CASH 2018-02]),0,[CASH 2018-02])+IIf(IsNull([CASH 2018-03]),0,[CASH 2018-03]) AS [CASH 2018-1Q],
IIf(IsNull([CASH 2018-04]),0,[CASH 2018-04])+IIf(IsNull([CASH 2018-05]),0,[CASH 2018-05])+IIf(IsNull([CASH 2018-06]),0,[CASH 2018-06]) AS [CASH 2018-2Q],
IIf(IsNull([CASH 2018-07]),0,[CASH 2018-07])+IIf(IsNull([CASH 2018-08]),0,[CASH 2018-08])+IIf(IsNull([CASH 2018-09]),0,[CASH 2018-09]) AS [CASH 2018-3Q],
IIf(IsNull([CASH 2018-10]),0,[CASH 2018-10])+IIf(IsNull([CASH 2018-11]),0,[CASH 2018-11])+IIf(IsNull([CASH 2018-12]),0,[CASH 2018-12]) AS [CASH 2018-4Q],
IIf(IsNull([CASH 2019-01]),0,[CASH 2019-01])+IIf(IsNull([CASH 2019-02]),0,[CASH 2019-02])+IIf(IsNull([CASH 2019-03]),0,[CASH 2019-03]) AS [CASH 2019-1Q],
IIf(IsNull([CASH 2019-04]),0,[CASH 2019-04])+IIf(IsNull([CASH 2019-05]),0,[CASH 2019-05])+IIf(IsNull([CASH 2019-06]),0,[CASH 2019-06]) AS [CASH 2019-2Q],
IIf(IsNull([CASH 2019-07]),0,[CASH 2019-07])+IIf(IsNull([CASH 2019-08]),0,[CASH 2019-08])+IIf(IsNull([CASH 2019-09]),0,[CASH 2019-09]) AS [CASH 2019-3Q],
IIf(IsNull([CASH 2019-10]),0,[CASH 2019-10])+IIf(IsNull([CASH 2019-11]),0,[CASH 2019-11])+IIf(IsNull([CASH 2019-12]),0,[CASH 2019-12]) AS [CASH 2019-4Q],
[CASH 2017-1Q]+[CASH 2017-2Q]+[CASH 2017-3Q]+[CASH 2017-4Q] AS [CASH 2017-00],
[CASH 2018-1Q]+[CASH 2018-2Q]+[CASH 2018-3Q]+[CASH 2018-4Q] AS [CASH 2018-00],
[CASH 2019-1Q]+[CASH 2019-2Q]+[CASH 2019-3Q]+[CASH 2019-4Q] AS [CASH 2019-00],
[CASH 2016-00]+[CASH 2017-00]+[CASH 2018-00]+[CASH 2019-00]+[CASH 2020-00]+[CASH 2021-00] AS [CASH ALL]

FROM E_DEMAND_PROJECTION_01_BASE B;


/*************** 
***** E_DEMAND_PROJECTION_03_OPEX ****
****************/

SELECT 
C.*,
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2016-00],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2016_00]='Plan' Or [PHASE_2016_00]='Functional Requirements' Or [PHASE_2016_00]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2016_00]),[Cash 2016-00],0),[Cash 2016-00]))) AS [OPEX 2016-00],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-01],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_01]='Plan' Or [PHASE_2017_01]='Functional Requirements' Or [PHASE_2017_01]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_01]),[Cash 2017-01],0),[Cash 2017-01]))) AS [OPEX 2017-01],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-02],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_02]='Plan' Or [PHASE_2017_02]='Functional Requirements' Or [PHASE_2017_02]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_02]),[Cash 2017-02],0),[Cash 2017-02]))) AS [OPEX 2017-02],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-03],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_03]='Plan' Or [PHASE_2017_03]='Functional Requirements' Or [PHASE_2017_03]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_03]),[Cash 2017-03],0),[Cash 2017-03]))) AS [OPEX 2017-03],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-04],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_04]='Plan' Or [PHASE_2017_04]='Functional Requirements' Or [PHASE_2017_04]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_04]),[Cash 2017-04],0),[Cash 2017-04]))) AS [OPEX 2017-04],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-05],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_05]='Plan' Or [PHASE_2017_05]='Functional Requirements' Or [PHASE_2017_05]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_05]),[Cash 2017-05],0),[Cash 2017-05]))) AS [OPEX 2017-05],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-06],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_06]='Plan' Or [PHASE_2017_06]='Functional Requirements' Or [PHASE_2017_06]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_06]),[Cash 2017-06],0),[Cash 2017-06]))) AS [OPEX 2017-06],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-07],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_07]='Plan' Or [PHASE_2017_07]='Functional Requirements' Or [PHASE_2017_07]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_07]),[Cash 2017-07],0),[Cash 2017-07]))) AS [OPEX 2017-07],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-08],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_08]='Plan' Or [PHASE_2017_08]='Functional Requirements' Or [PHASE_2017_08]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_08]),[Cash 2017-08],0),[Cash 2017-08]))) AS [OPEX 2017-08],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-09],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_09]='Plan' Or [PHASE_2017_09]='Functional Requirements' Or [PHASE_2017_09]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_09]),[Cash 2017-09],0),[Cash 2017-09]))) AS [OPEX 2017-09],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-10],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_10]='Plan' Or [PHASE_2017_10]='Functional Requirements' Or [PHASE_2017_10]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_10]),[Cash 2017-10],0),[Cash 2017-10]))) AS [OPEX 2017-10],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-11],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_11]='Plan' Or [PHASE_2017_11]='Functional Requirements' Or [PHASE_2017_11]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_11]),[Cash 2017-11],0),[Cash 2017-11]))) AS [OPEX 2017-11],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2017-12],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2017_12]='Plan' Or [PHASE_2017_12]='Functional Requirements' Or [PHASE_2017_12]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2017_12]),[Cash 2017-12],0),[Cash 2017-12]))) AS [OPEX 2017-12],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-01],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_01]='Plan' Or [PHASE_2018_01]='Functional Requirements' Or [PHASE_2018_01]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_01]),[Cash 2018-01],0),[Cash 2018-01]))) AS [OPEX 2018-01],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-02],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_02]='Plan' Or [PHASE_2018_02]='Functional Requirements' Or [PHASE_2018_02]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_02]),[Cash 2018-02],0),[Cash 2018-02]))) AS [OPEX 2018-02],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-03],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_03]='Plan' Or [PHASE_2018_03]='Functional Requirements' Or [PHASE_2018_03]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_03]),[Cash 2018-03],0),[Cash 2018-03]))) AS [OPEX 2018-03],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-04],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_04]='Plan' Or [PHASE_2018_04]='Functional Requirements' Or [PHASE_2018_04]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_04]),[Cash 2018-04],0),[Cash 2018-04]))) AS [OPEX 2018-04],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-05],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_05]='Plan' Or [PHASE_2018_05]='Functional Requirements' Or [PHASE_2018_05]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_05]),[Cash 2018-05],0),[Cash 2018-05]))) AS [OPEX 2018-05],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-06],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_06]='Plan' Or [PHASE_2018_06]='Functional Requirements' Or [PHASE_2018_06]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_06]),[Cash 2018-06],0),[Cash 2018-06]))) AS [OPEX 2018-06],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-07],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_07]='Plan' Or [PHASE_2018_07]='Functional Requirements' Or [PHASE_2018_07]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_07]),[Cash 2018-07],0),[Cash 2018-07]))) AS [OPEX 2018-07],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-08],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_08]='Plan' Or [PHASE_2018_08]='Functional Requirements' Or [PHASE_2018_08]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_08]),[Cash 2018-08],0),[Cash 2018-08]))) AS [OPEX 2018-08],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-09],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_09]='Plan' Or [PHASE_2018_09]='Functional Requirements' Or [PHASE_2018_09]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_09]),[Cash 2018-09],0),[Cash 2018-09]))) AS [OPEX 2018-09],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-10],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_10]='Plan' Or [PHASE_2018_10]='Functional Requirements' Or [PHASE_2018_10]='Support' Or [Phase Override]='Functional Requirements' Or [Phase 	Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_10]),[Cash 2018-10],0),[Cash 2018-10]))) AS [OPEX 2018-10],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-11],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_11]='Plan' Or [PHASE_2018_11]='Functional Requirements' Or [PHASE_2018_11]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_11]),[Cash 2018-11],0),[Cash 2018-11]))) AS [OPEX 2018-11],
IIf(C.Treatment='NO CAP' Or C.Treatment='RUN',[Cash 2018-12],IIf([Phase Override]='Design' Or [Phase Override]='Build' Or [Phase Override]='Test' Or [Phase Override]='Deploy',0,IIf(S.Treatment='CAP',IIf([PHASE_2018_12]='Plan' Or [PHASE_2018_12]='Functional Requirements' Or [PHASE_2018_12]='Support' Or [Phase Override]='Functional Requirements' Or [Phase Override]='Plan' Or [Phase Override]='Support' Or IsNull([PHASE_2018_12]),[Cash 2018-12],0),[Cash 2018-12]))) AS [OPEX 2018-12]
FROM E_DEMAND_PROJECTION_02_CASH C
LEFT JOIN D_SCHEDULE S
	ON C.[V_SCOPE_WS_PRG_DWE_ID]=S.[V_SCOPE_WS_PRG_DWE_ID];

/*************** 
***** E_DEMAND_PROJECTION_03_OPEX_02 ****
****************/

SELECT
          E_DEMAND_PROJECTION_03_OPEX.*
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-01],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_01]='Plan'
          Or [PHASE_2019_01] ='Functional Requirements'
          Or [PHASE_2019_01] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_01]),[Cash 2019-01],0),[Cash 2019-01]))) AS [OPEX 2019-01]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-02],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_02]='Plan'
          Or [PHASE_2019_02] ='Functional Requirements'
          Or [PHASE_2019_02] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_02]),[Cash 2019-02],0),[Cash 2019-02]))) AS [OPEX 2019-02]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-03],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_03]='Plan'
          Or [PHASE_2019_03] ='Functional Requirements'
          Or [PHASE_2019_03] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_03]),[Cash 2019-03],0),[Cash 2019-03]))) AS [OPEX 2019-03]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-04],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_04]='Plan'
          Or [PHASE_2019_04] ='Functional Requirements'
          Or [PHASE_2019_04] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_04]),[Cash 2019-04],0),[Cash 2019-04]))) AS [OPEX 2019-04]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-05],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_05]='Plan'
          Or [PHASE_2019_05] ='Functional Requirements'
          Or [PHASE_2019_05] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_05]),[Cash 2019-05],0),[Cash 2019-05]))) AS [OPEX 2019-05]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-06],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_06]='Plan'
          Or [PHASE_2019_06] ='Functional Requirements'
          Or [PHASE_2019_06] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_06]),[Cash 2019-06],0),[Cash 2019-06]))) AS [OPEX 2019-06]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-07],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_07]='Plan'
          Or [PHASE_2019_07] ='Functional Requirements'
          Or [PHASE_2019_07] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_07]),[Cash 2019-07],0),[Cash 2019-07]))) AS [OPEX 2019-07]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-08],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_08]='Plan'
          Or [PHASE_2019_08] ='Functional Requirements'
          Or [PHASE_2019_08] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_08]),[Cash 2019-08],0),[Cash 2019-08]))) AS [OPEX 2019-08]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-09],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_09]='Plan'
          Or [PHASE_2019_09] ='Functional Requirements'
          Or [PHASE_2019_09] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_09]),[Cash 2019-09],0),[Cash 2019-09]))) AS [OPEX 2019-09]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-10],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_10]='Plan'
          Or [PHASE_2019_10] ='Functional Requirements'
          Or [PHASE_2019_10] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_10]),[Cash 2019-10],0),[Cash 2019-10]))) AS [OPEX 2019-10]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-11],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_11]='Plan'
          Or [PHASE_2019_11] ='Functional Requirements'
          Or [PHASE_2019_11] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_11]),[Cash 2019-11],0),[Cash 2019-11]))) AS [OPEX 2019-11]
        ,IIf([E_DEMAND_PROJECTION_03_OPEX].[Treatment]='NO CAP'
          Or [E_DEMAND_PROJECTION_03_OPEX].[Treatment] ='RUN',[Cash 2019-12],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf([D_SCHEDULE].[Treatment]='CAP',IIf([PHASE_2019_12]='Plan'
          Or [PHASE_2019_12] ='Functional Requirements'
          Or [PHASE_2019_12] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2019_12]),[Cash 2019-12],0),[Cash 2019-12]))) AS [OPEX 2019-12]
        ,IIf(E_DEMAND_PROJECTION_03_OPEX.Treatment='NO CAP'
          Or E_DEMAND_PROJECTION_03_OPEX.Treatment ='RUN',[Cash 2020-00],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf(D_SCHEDULE.Treatment='CAP',IIf([PHASE_2020_00]='Plan'
          Or [PHASE_2020_00] ='Functional Requirements'
          Or [PHASE_2020_00] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2020_00]),[Cash 2020-00],0),[Cash 2020-00]))) AS [OPEX 2020-00]
        ,IIf(E_DEMAND_PROJECTION_03_OPEX.Treatment='NO CAP'
          Or E_DEMAND_PROJECTION_03_OPEX.Treatment ='RUN',[Cash 2021-00],IIf([Phase Override]='Design'
          Or [Phase Override]='Build'
          Or [Phase Override]='Test'
          Or [Phase Override]='Deploy',0,IIf(D_SCHEDULE.Treatment='CAP',IIf([PHASE_2021_00]='Plan'
          Or [PHASE_2021_00] ='Functional Requirements'
          Or [PHASE_2021_00] ='Support'
          Or [Phase Override]='Functional Requirements'
          Or [Phase Override]='Plan'
          Or [Phase Override]='Support'
          Or IsNull([PHASE_2021_00]),[Cash 2021-00],0),[Cash 2021-00]))) AS [OPEX 2021-00]
FROM E_DEMAND_PROJECTION_03_OPEX
          LEFT JOIN  D_SCHEDULE
                    ON E_DEMAND_PROJECTION_03_OPEX.[V_SCOPE_WS_PRG_DWE_ID]=D_SCHEDULE.[V_SCOPE_WS_PRG_DWE_ID]
;

/*************** 
***** E_DEMAND_PROJECTION_04_CAPEX ****
****************/

SELECT
	O.[Role ID],
	[CAPEX 2016-00] = ISNULL(O.[CASH 2016-00],'0') - ISNULL(O.[OPEX 2016-00],'0'),
	[CAPEX 2017-01] = isnull(O.[CASH 2017-01],'0') - ISNULL(O.[OPEX 2017-01],'0'),
	[CAPEX 2017-02] = ISNULL(O.[CASH 2017-02],'0') - ISNULL(O.[OPEX 2017-02],'0'),
	[CAPEX 2017-03] = ISNULL(O.[CASH 2017-03],'0') - ISNULL(O.[OPEX 2017-03],'0'),
	[CAPEX 2017-04] = ISNULL(O.[CASH 2017-04],'0') - ISNULL(O.[OPEX 2017-04],'0'),
	[CAPEX 2017-05] = ISNULL(O.[CASH 2017-05],'0') - ISNULL(O.[OPEX 2017-05],'0'),
	[CAPEX 2017-06] = ISNULL(O.[CASH 2017-06],'0') - ISNULL(O.[OPEX 2017-06],'0'),
	[CAPEX 2017-07] = ISNULL(O.[CASH 2017-07],'0') - ISNULL(O.[OPEX 2017-07],'0'),
	[CAPEX 2017-08] = ISNULL(O.[CASH 2017-08],'0') - ISNULL(O.[OPEX 2017-08],'0'),
	[CAPEX 2017-09] = ISNULL(O.[CASH 2017-09],'0') - ISNULL(O.[OPEX 2017-09],'0'),
	[CAPEX 2017-10] = ISNULL(O.[CASH 2017-10],'0') - ISNULL(O.[OPEX 2017-10],'0'),
	[CAPEX 2017-11] = ISNULL(O.[CASH 2017-11],'0') - ISNULL(O.[OPEX 2017-11],'0'),
	[CAPEX 2017-12] = ISNULL(O.[CASH 2017-12],'0') - ISNULL(O.[OPEX 2017-12],'0'),
	[CAPEX 2018-01] = ISNULL(O.[CASH 2018-01],'0') - ISNULL(O.[OPEX 2018-01],'0'),
	[CAPEX 2018-02] = ISNULL(O.[CASH 2018-02],'0') - ISNULL(O.[OPEX 2018-02],'0'),
	[CAPEX 2018-03] = ISNULL(O.[CASH 2018-03],'0') - ISNULL(O.[OPEX 2018-03],'0'),
	[CAPEX 2018-04] = ISNULL(O.[CASH 2018-04],'0') - ISNULL(O.[OPEX 2018-04],'0'),
	[CAPEX 2018-05] = ISNULL(O.[CASH 2018-05],'0') - ISNULL(O.[OPEX 2018-05],'0'),
	[CAPEX 2018-06] = ISNULL(O.[CASH 2018-06],'0') - ISNULL(O.[OPEX 2018-06],'0'),
	[CAPEX 2018-07] = ISNULL(O.[CASH 2018-07],'0') - ISNULL(O.[OPEX 2018-07],'0'),
	[CAPEX 2018-08] = ISNULL(O.[CASH 2018-08],'0') - ISNULL(O.[OPEX 2018-08],'0'),
	[CAPEX 2018-09] = ISNULL(O.[CASH 2018-09],'0') - ISNULL(O.[OPEX 2018-09],'0'),
	[CAPEX 2018-10] = ISNULL(O.[CASH 2018-10],'0') - ISNULL(O.[OPEX 2018-10],'0'),
	[CAPEX 2018-11] = ISNULL(O.[CASH 2018-11],'0') - ISNULL(O.[OPEX 2018-11],'0'),
	[CAPEX 2018-12] = ISNULL(O.[CASH 2018-12],'0') - ISNULL(O.[OPEX 2018-12],'0'),
	[CAPEX 2019-01] = ISNULL(O.[CASH 2019-01],'0') - ISNULL(O.[OPEX 2019-01],'0'),
	[CAPEX 2019-02] = ISNULL(O.[CASH 2019-02],'0') - ISNULL(O.[OPEX 2019-02],'0'),
	[CAPEX 2019-03] = ISNULL(O.[CASH 2019-03],'0') - ISNULL(O.[OPEX 2019-03],'0'),
	[CAPEX 2019-04] = ISNULL(O.[CASH 2019-04],'0') - ISNULL(O.[OPEX 2019-04],'0'),
	[CAPEX 2019-05] = ISNULL(O.[CASH 2019-05],'0') - ISNULL(O.[OPEX 2019-05],'0'),
	[CAPEX 2019-06] = ISNULL(O.[CASH 2019-06],'0') - ISNULL(O.[OPEX 2019-06],'0'),
	[CAPEX 2019-07] = ISNULL(O.[CASH 2019-07],'0') - ISNULL(O.[OPEX 2019-07],'0'),
	[CAPEX 2019-08] = ISNULL(O.[CASH 2019-08],'0') - ISNULL(O.[OPEX 2019-08],'0'),
	[CAPEX 2019-09] = ISNULL(O.[CASH 2019-09],'0') - ISNULL(O.[OPEX 2019-09],'0'),
	[CAPEX 2019-10] = ISNULL(O.[CASH 2019-10],'0') - ISNULL(O.[OPEX 2019-10],'0'),
	[CAPEX 2019-11] = ISNULL(O.[CASH 2019-11],'0') - ISNULL(O.[OPEX 2019-11],'0'),
	[CAPEX 2019-12] = ISNULL(O.[CASH 2019-12],'0') - ISNULL(O.[OPEX 2019-12],'0'),
	[CAPEX 2020-00] = ISNULL(O.[CASH 2020-00],'0') - ISNULL(O.[OPEX 2020-00],'0'),
	[CAPEX 2021-00] = ISNULL(O.[CASH 2021-00],'0') - ISNULL(O.[OPEX 2021-00],'0') 
FROM E_DEMAND_PROJECTION_03_OPEX_02 O WITH (NOLOCK)
ORDER BY O.[Role Id]
OPTION (MAXDOP 24);

/****************************************************************
***** Insert into export tables - E_DEMAND_PROJECTION_LOAD_1 ****
*****************************************************************/

INSERT INTO E_DEMAND_PROJECTION 
(
	[Role ID],[Work Effort],Workstream,Program,Project,[Function],[Role Type],[Role Specialization],[Role Details],[Staffing Status],[Resource Type],Vendor,
	[Resource Name],[Resource ID],[HR Status],[Primary Location],[Internal Status],[Hourly Bill Rate],Treatment,[Phase Override],[Hours 2016-00],[Hours 2017-01],
	[Hours 2017-02],[Hours 2017-03],[Hours 2017-04],[Hours 2017-05],[Hours 2017-06],[Hours 2017-07],[Hours 2017-08],[Hours 2017-09],[Hours 2017-10],[Hours 2017-11],
	[Hours 2017-12],[Hours 2018-01],[Hours 2018-02],[Hours 2018-03],[Hours 2018-04],[Hours 2018-05],[Hours 2018-06],[Hours 2018-07],[Hours 2018-08],[Hours 2018-09],
	[Hours 2018-10],[Hours 2018-11],[Hours 2018-12],[Hours 2019-01],[Hours 2019-02],[Hours 2019-03],[Hours 2019-04],[Hours 2019-05],[Hours 2019-06],[Hours 2019-07],
	[Hours 2019-08],[Hours 2019-09],[Hours 2019-10],[Hours 2019-11],[Hours 2019-12],[Hours 2020-00],[Hours 2021-00],[CASH 2016-00],[CASH 2017-01],[CASH 2017-02],
	[CASH 2017-03],[CASH 2017-04],[CASH 2017-05],[CASH 2017-06],[CASH 2017-07],[CASH 2017-08],[CASH 2017-09],[CASH 2017-10],[CASH 2017-11],[CASH 2017-12],[CASH 2018-01],
	[CASH 2018-02],[CASH 2018-03],[CASH 2018-04],[CASH 2018-05],[CASH 2018-06],[CASH 2018-07],[CASH 2018-08],[CASH 2018-09],[CASH 2018-10],[CASH 2018-11],[CASH 2018-12],
	[CASH 2019-01],[CASH 2019-02],[CASH 2019-03],[CASH 2019-04],[CASH 2019-05],[CASH 2019-06],[CASH 2019-07],[CASH 2019-08],[CASH 2019-09],[CASH 2019-10],[CASH 2019-11],
	[CASH 2019-12],[CASH 2020-00],[CASH 2021-00],[OPEX 2016-00],[OPEX 2017-01],[OPEX 2017-02],[OPEX 2017-03],[OPEX 2017-04],[OPEX 2017-05],[OPEX 2017-06],[OPEX 2017-07],
	[OPEX 2017-08],[OPEX 2017-09],[OPEX 2017-10],[OPEX 2017-11],[OPEX 2017-12],[OPEX 2018-01],[OPEX 2018-02],[OPEX 2018-03],[OPEX 2018-04],[OPEX 2018-05],[OPEX 2018-06],
	[OPEX 2018-07],[OPEX 2018-08],[OPEX 2018-09],[OPEX 2018-10],[OPEX 2018-11],[OPEX 2018-12],[OPEX 2019-01],[OPEX 2019-02],[OPEX 2019-03],[OPEX 2019-04],[OPEX 2019-05],
	[OPEX 2019-06],[OPEX 2019-07],[OPEX 2019-08],[OPEX 2019-09],[OPEX 2019-10],[OPEX 2019-11],[OPEX 2019-12],[OPEX 2020-00],[OPEX 2021-00],[CASH 2017-00],[CASH 2018-00],
	[CASH 2019-00],[CASH ALL],[IT Lead],[IT Team],[Level Details Status],[BAU Source] 
)

SELECT 
	E.[Role ID],
	E.V_SCOPE.LABEL,
	E.V_SCOPE_WS.LABEL,
	E.V_SCOPE_WS_PRG.LABEL,
	E.V_SCOPE_WS_PRG_DWE.LABEL,
	E.[Function],
	E.[Role Type],
	E.[Role Specialization],
	E.[Role Details],
	E.[Staffing Status],
	E.[Resource Type],
	E.Vendor,
	E.[Resource Name],
	E.[Resource ID],
	E.[HR Status],
	E.[Primary Location],
	E.[Internal Status],
	E.[Hourly Bill Rate],
	E.Treatment,
	E.[Phase Override],
	E.HOURS_2016_00,
	E.HOURS_2017_01,
	E.HOURS_2017_02,
	E.HOURS_2017_03,
	E.HOURS_2017_04,
	E.HOURS_2017_05,
	E.HOURS_2017_06,
	E.HOURS_2017_07,
	E.HOURS_2017_08,
	E.HOURS_2017_09,
	E.HOURS_2017_10,
	E.HOURS_2017_11,
	E.HOURS_2017_12,
	E.HOURS_2018_01,
	E.HOURS_2018_02,
	E.HOURS_2018_03,
	E.HOURS_2018_04,
	E.HOURS_2018_05,
	E.HOURS_2018_06,
	E.HOURS_2018_07,
	E.HOURS_2018_08,
	E.HOURS_2018_09,
	E.HOURS_2018_10,
	E.HOURS_2018_11,
	E.HOURS_2018_12,
	E.HOURS_2019_01,
	E.HOURS_2019_02,
	E.HOURS_2019_03,
	E.HOURS_2019_04,
	E.HOURS_2019_05,
	E.HOURS_2019_06,
	E.HOURS_2019_07,
	E.HOURS_2019_08,
	E.HOURS_2019_09,
	E.HOURS_2019_10,
	E.HOURS_2019_11,
	E.HOURS_2019_12,
	E.HOURS_2020_00,
	E.HOURS_2021_00,
	E.[CASH 2016-00],
	E.[CASH 2017-01],
	E.[CASH 2017-02],
	E.[CASH 2017-03],
	E.[CASH 2017-04],
	E.[CASH 2017-05],
	E.[CASH 2017-06],
	E.[CASH 2017-07],
	E.[CASH 2017-08],
	E.[CASH 2017-09],
	E.[CASH 2017-10],
	E.[CASH 2017-11],
	E.[CASH 2017-12],
	E.[CASH 2018-01],
	E.[CASH 2018-02],
	E.[CASH 2018-03],
	E.[CASH 2018-04],
	E.[CASH 2018-05],
	E.[CASH 2018-06],
	E.[CASH 2018-07],
	E.[CASH 2018-08],
	E.[CASH 2018-09],
	E.[CASH 2018-10],
	E.[CASH 2018-11],
	E.[CASH 2018-12],
	E.[CASH 2019-01],
	E.[CASH 2019-02],
	E.[CASH 2019-03],
	E.[CASH 2019-04],
	E.[CASH 2019-05],
	E.[CASH 2019-06],
	E.[CASH 2019-07],
	E.[CASH 2019-08],
	E.[CASH 2019-09],
	E.[CASH 2019-10],
	E.[CASH 2019-11],
	E.[CASH 2019-12],
	E.[CASH 2020-00],
	E.[CASH 2021-00],
	E.[OPEX 2016-00],
	E.[OPEX 2017-01],
	E.[OPEX 2017-02],
	E.[OPEX 2017-03],
	E.[OPEX 2017-04],
	E.[OPEX 2017-05],
	E.[OPEX 2017-06],
	E.[OPEX 2017-07],
	E.[OPEX 2017-08],
	E.[OPEX 2017-09],
	E.[OPEX 2017-10],
	E.[OPEX 2017-11],
	E.[OPEX 2017-12],
	E.[OPEX 2018-01],
	E.[OPEX 2018-02],
	E.[OPEX 2018-03],
	E.[OPEX 2018-04],
	E.[OPEX 2018-05],
	E.[OPEX 2018-06],
	E.[OPEX 2018-07],
	E.[OPEX 2018-08],
	E.[OPEX 2018-09],
	E.[OPEX 2018-10],
	E.[OPEX 2018-11],
	E.[OPEX 2018-12],
	E.[OPEX 2019-01],
	E.[OPEX 2019-02],
	E.[OPEX 2019-03],
	E.[OPEX 2019-04],
	E.[OPEX 2019-05],
	E.[OPEX 2019-06],
	E.[OPEX 2019-07],
	E.[OPEX 2019-08],
	E.[OPEX 2019-09],
	E.[OPEX 2019-10],
	E.[OPEX 2019-11],
	E.[OPEX 2019-12],
	E.[OPEX 2020-00],
	E.[OPEX 2021-00],
	E.[CASH 2017-00],
	E.[CASH 2018-00],
	E.[CASH 2019-00],
	E.[CASH ALL],
	E.V_GRP_PERSON_DIV.LEADER_NAME,
	E.V_GRP_PERSON_TEAM.LEADER_NAME,
	E.PRJ_STATUS,
	E.BAU_SOURCE
FROM E_DEMAND_PROJECTION_03_OPEX_02 WITH (NOLOCK);

/****************************************************************
***** Insert into export tables - E_DEMAND_PROJECTION_LOAD_2 ****
*****************************************************************/

UPDATE E 
SET E.[CAPEX 2016-00] = C.[CAPEX 2016-00],
	E.[CAPEX 2017-01] = C.[CAPEX 2017-01],
	E.[CAPEX 2017-02] = C.[CAPEX 2017-02],
	E.[CAPEX 2017-03] = C.[CAPEX 2017-03],
	E.[CAPEX 2017-04] = C.[CAPEX 2017-04],
	E.[CAPEX 2017-05] = C.[CAPEX 2017-05],
	E.[CAPEX 2017-06] = C.[CAPEX 2017-06],
	E.[CAPEX 2017-07] = C.[CAPEX 2017-07],
	E.[CAPEX 2017-08] = C.[CAPEX 2017-08],
	E.[CAPEX 2017-09] = C.[CAPEX 2017-09],
	E.[CAPEX 2017-10] = C.[CAPEX 2017-10],
	E.[CAPEX 2017-11] = C.[CAPEX 2017-11],
	E.[CAPEX 2017-12] = C.[CAPEX 2017-12],
	E.[CAPEX 2018-01] = C.[CAPEX 2018-01],
	E.[CAPEX 2018-02] = C.[CAPEX 2018-02],
	E.[CAPEX 2018-03] = C.[CAPEX 2018-03],
	E.[CAPEX 2018-04] = C.[CAPEX 2018-04],
	E.[CAPEX 2018-05] = C.[CAPEX 2018-05],
	E.[CAPEX 2018-06] = C.[CAPEX 2018-06],
	E.[CAPEX 2018-07] = C.[CAPEX 2018-07],
	E.[CAPEX 2018-08] = C.[CAPEX 2018-08],
	E.[CAPEX 2018-09] = C.[CAPEX 2018-09],
	E.[CAPEX 2018-10] = C.[CAPEX 2018-10],
	E.[CAPEX 2018-11] = C.[CAPEX 2018-11],
	E.[CAPEX 2018-12] = C.[CAPEX 2018-12],
	E.[CAPEX 2019-01] = C.[CAPEX 2019-01],
	E.[CAPEX 2019-02] = C.[CAPEX 2019-02],
	E.[CAPEX 2019-03] = C.[CAPEX 2019-03],
	E.[CAPEX 2019-04] = C.[CAPEX 2019-04],
	E.[CAPEX 2019-05] = C.[CAPEX 2019-05],
	E.[CAPEX 2019-06] = C.[CAPEX 2019-06],
	E.[CAPEX 2019-07] = C.[CAPEX 2019-07],
	E.[CAPEX 2019-08] = C.[CAPEX 2019-08],
	E.[CAPEX 2019-09] = C.[CAPEX 2019-09],
	E.[CAPEX 2019-10] = C.[CAPEX 2019-10],
	E.[CAPEX 2019-11] = C.[CAPEX 2019-11],
	E.[CAPEX 2019-12] = C.[CAPEX 2019-12],
	E.[CAPEX 2020-00] = C.[CAPEX 2020-00],
	E.[CAPEX 2021-00] = C.[CAPEX 2021-00]
FROM E_DEMAND_PROJECTION E WITH (NOLOCK)
INNER JOIN E_DEMAND_PROJECTION_04_CAPEX C WITH (NOLOCK)
	ON E.[Role ID] = C.[Role ID];

/****************************************************************
*** Insert into export tables - E_DEMAND_PROJECTION_05_L1ROLLUP **
*****************************************************************/

UPDATE E_DEMAND_PROJECTION 
SET [CASH 2017-1Q] = [CASH 2017-01]+[CASH 2017-02]+[CASH 2017-03],
    [CASH 2017-2Q] = [CASH 2017-04]+[CASH 2017-05]+[CASH 2017-06],
	[CASH 2017-3Q] = [CASH 2017-07]+[CASH 2017-08]+[CASH 2017-09],
	[CASH 2017-4Q] = [CASH 2017-10]+[CASH 2017-11]+[CASH 2017-12],
	[CASH 2018-1Q] = [Cash 2018-01]+[Cash 2018-02]+[Cash 2018-03],
	[CASH 2018-2Q] = [Cash 2018-04]+[Cash 2018-05]+[Cash 2018-06],
	[CASH 2018-3Q] = [Cash 2018-07]+[Cash 2018-08]+[Cash 2018-09],
	[CASH 2018-4Q] = [Cash 2018-10]+[Cash 2018-11]+[Cash 2018-12],
	[CASH 2019-1Q] = [CASH 2019-01]+[CASH 2019-02]+[CASH 2019-03],
	[CASH 2019-2Q] = [CASH 2019-04]+[CASH 2019-05]+[CASH 2019-06],
	[CASH 2019-3Q] = [CASH 2019-07]+[CASH 2019-08]+[CASH 2019-09],
	[CASH 2019-4Q] = [CASH 2019-10]+[CASH 2019-11]+[CASH 2019-12],
	[OPEX 2017-1Q] = [OPEX 2017-01]+[OPEX 2017-02]+[OPEX 2017-03],
	[OPEX 2017-2Q] = [OPEX 2017-04]+[OPEX 2017-05]+[OPEX 2017-06],
	[OPEX 2017-3Q] = [OPEX 2017-07]+[OPEX 2017-08]+[OPEX 2017-09],
	[OPEX 2017-4Q] = [OPEX 2017-10]+[OPEX 2017-11]+[OPEX 2017-12],
	[OPEX 2018-1Q] = [OPEX 2018-01]+[OPEX 2018-02]+[OPEX 2018-03],
	[OPEX 2018-2Q] = [OPEX 2018-04]+[OPEX 2018-05]+[OPEX 2018-06],
	[OPEX 2018-3Q] = [OPEX 2018-07]+[OPEX 2018-08]+[OPEX 2018-09],
	[OPEX 2018-4Q] = [OPEX 2018-10]+[OPEX 2018-11]+[OPEX 2018-12],
	[OPEX 2019-1Q] = [OPEX 2019-01]+[OPEX 2019-02]+[OPEX 2019-03],
	[OPEX 2019-2Q] = [OPEX 2019-04]+[OPEX 2019-05]+[OPEX 2019-06],
	[OPEX 2019-3Q] = [OPEX 2019-07]+[OPEX 2019-08]+[OPEX 2019-09],
	[OPEX 2019-4Q] = [OPEX 2019-10]+[OPEX 2019-11]+[OPEX 2019-12],
	[CAPEX 2017-1Q] = [CAPEX 2017-01]+[CAPEX 2017-02]+[CAPEX 2017-03],
	[CAPEX 2017-2Q] = [CAPEX 2017-04]+[CAPEX 2017-05]+[CAPEX 2017-06],
	[CAPEX 2017-3Q] = [CAPEX 2017-07]+[CAPEX 2017-08]+[CAPEX 2017-09],
	[CAPEX 2017-4Q] = [CAPEX 2017-10]+[CAPEX 2017-11]+[CAPEX 2017-12],
	[CAPEX 2018-1Q] = [CAPEX 2018-01]+[CAPEX 2018-02]+[CAPEX 2018-03],
	[CAPEX 2018-2Q] = [CAPEX 2018-04]+[CAPEX 2018-05]+[CAPEX 2018-06],
	[CAPEX 2018-3Q] = [CAPEX 2018-07]+[CAPEX 2018-08]+[CAPEX 2018-09],
	[CAPEX 2018-4Q] = [CAPEX 2018-10]+[CAPEX 2018-11]+[CAPEX 2018-12],
	[CAPEX 2019-1Q] = [CAPEX 2019-01]+[CAPEX 2019-02]+[CAPEX 2019-03],
	[CAPEX 2019-2Q] = [CAPEX 2019-04]+[CAPEX 2019-05]+[CAPEX 2019-06],
	[CAPEX 2019-3Q] = [CAPEX 2019-07]+[CAPEX 2019-08]+[CAPEX 2019-09],
	[CAPEX 2019-4Q] = [CAPEX 2019-10]+[CAPEX 2019-11]+[CAPEX 2019-12];

/****************************************************************
*** Insert into export tables - E_DEMAND_PROJECTION_05_L3ROLLUP **
*****************************************************************/

---------------------------------------- DLM ----------------------------------------
-- Rename the above script to    E_DEMAND_PROJECTION_05_L3ROLLUP
-- I want to remove the [Sum Future Hours] calc - would require dynamic variable
-------------------------------------------------------------------------------------

UPDATE E
SET 
E.[CASH ALL] = [CASH 2016-00]+[CASH 2017-00]+[CASH 2018-00]+[CASH 2019-00]+[CASH 2020-00]+[CASH 2021-00],
E.[OPEX ALL] = [OPEX 2016-00]+[OPEX 2017-00]+[OPEX 2018-00]+[OPEX 2019-00]+[OPEX 2020-00]+[OPEX 2021-00],
E.[CAPEX ALL] = [CAPEX 2016-00]+[CAPEX 2017-00]+[CAPEX 2018-00]+[CAPEX 2019-00]+[CAPEX 2020-00]+[CAPEX 2021-00],
E.[Sum Hours] =		
	ISNULL([Hours 2016-00],0)+
	ISNULL([Hours 2017-01],0))+
	ISNULL([Hours 2017-02],0)+
	ISNULL([Hours 2017-03],0)+
	ISNULL([Hours 2017-04],0)+
	ISNULL([Hours 2017-05],0)+
	ISNULL([Hours 2017-06],0)+
	ISNULL([Hours 2017-07],0)+
	ISNULL([Hours 2017-08],0)+
	ISNULL([Hours 2017-09],0)+
	ISNULL([Hours 2017-10],0)+
	ISNULL([Hours 2017-11],0)+
	ISNULL([Hours 2017-12],0)+
	ISNULL([Hours 2018-01],0)+
	ISNULL([Hours 2018-02],0)+
	ISNULL([Hours 2018-03],0)+
	ISNULL([Hours 2018-04],0)+
	ISNULL([Hours 2018-05],0)+
	ISNULL([Hours 2018-06],0)+
	ISNULL([Hours 2018-07],0)+
	ISNULL([Hours 2018-08],0)+
	ISNULL([Hours 2018-09],0)+
	ISNULL([Hours 2018-10],0)+
	ISNULL([Hours 2018-11],0)+
	ISNULL([Hours 2018-12],0)+
	ISNULL([Hours 2019-01],0)+
	ISNULL([Hours 2019-02],0)+
	ISNULL([Hours 2019-03],0)+
	ISNULL([Hours 2019-04],0)+
	ISNULL([Hours 2019-05],0)+
	ISNULL([Hours 2019-06],0)+
	ISNULL([Hours 2019-07],0)+
	ISNULL([Hours 2019-08],0)+
	ISNULL([Hours 2019-09],0)+
	ISNULL([Hours 2019-10],0)+
	ISNULL([Hours 2019-11],0)+
	ISNULL([Hours 2019-12],0)+
	ISNULL([Hours 2020-00],0)+
	ISNULL([Hours 2021-00],0),
-- E.[Sum Future Hours] =  
	-- ISNULL([Hours 2017-06],0)+
	-- ISNULL([Hours 2017-07],0)+
	-- ISNULL([Hours 2017-08],0)+
	-- ISNULL([Hours 2017-09],0)+
	-- ISNULL([Hours 2017-10],0)+
	-- ISNULL([Hours 2017-11],0)+
	-- ISNULL([Hours 2017-12],0)+
	-- ISNULL([Hours 2018-01],0)+
	-- ISNULL([Hours 2018-02],0)+
	-- ISNULL([Hours 2018-03],0)+
	-- ISNULL([Hours 2018-04],0)+
	-- ISNULL([Hours 2018-05],0)+
	-- ISNULL([Hours 2018-06],0)+
	-- ISNULL([Hours 2018-07],0)+
	-- ISNULL([Hours 2018-08],0)+
	-- ISNULL([Hours 2018-09],0)+
	-- ISNULL([Hours 2018-10],0)+
	-- ISNULL([Hours 2018-11],0)+
	-- ISNULL([Hours 2018-12],0)+
	-- ISNULL([Hours 2019-01],0)+
	-- ISNULL([Hours 2019-02],0)+
	-- ISNULL([Hours 2019-03],0)+
	-- ISNULL([Hours 2019-04],0)+
	-- ISNULL([Hours 2019-05],0)+
	-- ISNULL([Hours 2019-06],0)+
	-- ISNULL([Hours 2019-07],0)+
	-- ISNULL([Hours 2019-08],0)+
	-- ISNULL([Hours 2019-09],0)+
	-- ISNULL([Hours 2019-10],0)+
	-- ISNULL([Hours 2019-11],0)+
	-- ISNULL([Hours 2019-12],0)+
	-- ISNULL([Hours 2020-00],0)+
	-- ISNULL([Hours 2021-00])
FROM E_DEMAND_PROJECTION E WITH (NOLOCK);

/****************************************************************
*** Insert into export tables - E_DEMAND_PROJECTION_06_L2ROLLUP **
*****************************************************************/

UPDATE E
SET E.[CASH 2017-00] = [CASH 2017-1Q]+[CASH 2017-2Q]+[CASH 2017-3Q]+[CASH 2017-4Q],
	E.[CASH 2018-00] = [CASH 2018-1Q]+[CASH 2018-2Q]+[CASH 2018-3Q]+[CASH 2018-4Q],
	E.[CASH 2019-00] = [CASH 2019-1Q]+[CASH 2019-2Q]+[CASH 2019-3Q]+[CASH 2019-4Q],
	E.[OPEX 2017-00] = [OPEX 2017-1Q]+[OPEX 2017-2Q]+[OPEX 2017-3Q]+[OPEX 2017-4Q],
	E.[OPEX 2018-00] = [OPEX 2018-1Q]+[OPEX 2018-2Q]+[OPEX 2018-3Q]+[OPEX 2018-4Q],
	E.[OPEX 2019-00] = [OPEX 2019-1Q]+[OPEX 2019-2Q]+[OPEX 2019-3Q]+[OPEX 2019-4Q],
	E.[CAPEX 2017-00] = [CAPEX 2017-1Q]+[CAPEX 2017-2Q]+[CAPEX 2017-3Q]+[CAPEX 2017-4Q],
	E.[CAPEX 2018-00] = [CAPEX 2018-1Q]+[CAPEX 2018-2Q]+[CAPEX 2018-3Q]+[CAPEX 2018-4Q],
	E.[CAPEX 2019-00] = [CAPEX 2019-1Q]+[CAPEX 2019-2Q]+[CAPEX 2019-3Q]+[CAPEX 2019-4Q]
FROM E_DEMAND_PROJECTION E WITH (NOLOCK);

/****************************************************************
*** Insert into export tables - E_DEMAND_PROJECTION_08_L4ROLLUP **
*****************************************************************/

---------------------------------------- DLM ----------------------------------------
-- I want to remove this calc
-------------------------------------------------------------------------------------

-- UPDATE E
-- SET E.[Has Hours] = CASE WHEN ISNULL(E.[Sum Hours],0) > 0 THEN 'YES' ELSE 'NO' END,
	-- E.[Has Future Hours] = CASE WHEN ISNULL(E.[Sum Hours],0) > 0 THEN 'YES' ELSE 'NO' END 
	-- E.[Has Future Capacity] = CASE WHEN ISNULL(E.[Has Future Capacity],0) > 0 THEN 'YES' ELSE 'NO' END 
-- FROM E_DEMAND_PROJECTION E WITH (NOLOCK)
-- LEFT JOIN V_SCOPE_WS_PRG_DWE V WITH (NOLOCK)
	-- ON E.Project = V.LABEL 
-- LEFT JOIN E_CAPACITY C WITH (NOLOCK)
	 -- ON E.[Resource ID] = C.[Resource ID];

/****************************************************************
***** Insert into export tables - E_EXPENSE_PROJECTION_CLEAR ****
*****************************************************************/

---------------------------------------- DLM ----------------------------------------
-- Truncating incorrect table
 TRUNCATE TABLE [dbo].[E_EXPENSE_PROJECTION];
-------------------------------------------------------------------------------------

/****************************************************************
**** Insert into export tables - E_EXPENSE_PROJECTION_01_BASE ***
*****************************************************************/

SELECT
	D_EXPENSE_PROJECTION.EXPENSE_ID
	,V_SCOPE.LABEL                    AS [Work Effort]
	,V_SCOPE_WS.LABEL                 AS Workstream
	,V_SCOPE_WS_PRG.LABEL             AS Program
	,V_SCOPE_WS_PRG_DWE.LABEL         AS Project
	,V_FUNCTION.LABEL                 AS Function
	,V_EXPENSE_TYPE.LABEL             AS Type
	,V_VENDOR.LABEL                   AS Vendor
	,D_EXPENSE_PROJECTION.DESCRIPTION AS Description
	,V_TREATMENT.LABEL                AS Treatment
	,D_EXPENSE_PROJECTION.CASH_2016_00
	,D_EXPENSE_PROJECTION.CASH_2017_01
	,D_EXPENSE_PROJECTION.CASH_2017_02
	,D_EXPENSE_PROJECTION.CASH_2017_03
	,D_EXPENSE_PROJECTION.CASH_2017_04
	,D_EXPENSE_PROJECTION.CASH_2017_05
	,D_EXPENSE_PROJECTION.CASH_2017_06
	,D_EXPENSE_PROJECTION.CASH_2017_07
	,D_EXPENSE_PROJECTION.CASH_2017_08
	,D_EXPENSE_PROJECTION.CASH_2017_09
	,D_EXPENSE_PROJECTION.CASH_2017_10
	,D_EXPENSE_PROJECTION.CASH_2017_11
	,D_EXPENSE_PROJECTION.CASH_2017_12
	,D_EXPENSE_PROJECTION.CASH_2018_01
	,D_EXPENSE_PROJECTION.CASH_2018_02
	,D_EXPENSE_PROJECTION.CASH_2018_03
	,D_EXPENSE_PROJECTION.CASH_2018_04
	,D_EXPENSE_PROJECTION.CASH_2018_05
	,D_EXPENSE_PROJECTION.CASH_2018_06
	,D_EXPENSE_PROJECTION.CASH_2018_07
	,D_EXPENSE_PROJECTION.CASH_2018_08
	,D_EXPENSE_PROJECTION.CASH_2018_09
	,D_EXPENSE_PROJECTION.CASH_2018_10
	,D_EXPENSE_PROJECTION.CASH_2018_11
	,D_EXPENSE_PROJECTION.CASH_2018_12
	,D_EXPENSE_PROJECTION.CASH_2019_01
	,D_EXPENSE_PROJECTION.CASH_2019_02
	,D_EXPENSE_PROJECTION.CASH_2019_03
	,D_EXPENSE_PROJECTION.CASH_2019_04
	,D_EXPENSE_PROJECTION.CASH_2019_05
	,D_EXPENSE_PROJECTION.CASH_2019_06
	,D_EXPENSE_PROJECTION.CASH_2019_07
	,D_EXPENSE_PROJECTION.CASH_2019_08
	,D_EXPENSE_PROJECTION.CASH_2019_09
	,D_EXPENSE_PROJECTION.CASH_2019_10
	,D_EXPENSE_PROJECTION.CASH_2019_11
	,D_EXPENSE_PROJECTION.CASH_2019_12
	,D_EXPENSE_PROJECTION.CASH_2020_00
	,D_EXPENSE_PROJECTION.CASH_2021_00
	,D_EXPENSE_PROJECTION.OPEX_2016_00
	,D_EXPENSE_PROJECTION.OPEX_2017_01
	,D_EXPENSE_PROJECTION.OPEX_2017_02
	,D_EXPENSE_PROJECTION.OPEX_2017_03
	,D_EXPENSE_PROJECTION.OPEX_2017_04
	,D_EXPENSE_PROJECTION.OPEX_2017_05
	,D_EXPENSE_PROJECTION.OPEX_2017_06
	,D_EXPENSE_PROJECTION.OPEX_2017_07
	,D_EXPENSE_PROJECTION.OPEX_2017_08
	,D_EXPENSE_PROJECTION.OPEX_2017_09
	,D_EXPENSE_PROJECTION.OPEX_2017_10
	,D_EXPENSE_PROJECTION.OPEX_2017_11
	,D_EXPENSE_PROJECTION.OPEX_2017_12
	,D_EXPENSE_PROJECTION.OPEX_2018_01
	,D_EXPENSE_PROJECTION.OPEX_2018_02
	,D_EXPENSE_PROJECTION.OPEX_2018_03
	,D_EXPENSE_PROJECTION.OPEX_2018_04
	,D_EXPENSE_PROJECTION.OPEX_2018_05
	,D_EXPENSE_PROJECTION.OPEX_2018_06
	,D_EXPENSE_PROJECTION.OPEX_2018_07
	,D_EXPENSE_PROJECTION.OPEX_2018_08
	,D_EXPENSE_PROJECTION.OPEX_2018_09
	,D_EXPENSE_PROJECTION.OPEX_2018_10
	,D_EXPENSE_PROJECTION.OPEX_2018_11
	,D_EXPENSE_PROJECTION.OPEX_2018_12
	,D_EXPENSE_PROJECTION.OPEX_2019_01
	,D_EXPENSE_PROJECTION.OPEX_2019_02
	,D_EXPENSE_PROJECTION.OPEX_2019_03
	,D_EXPENSE_PROJECTION.OPEX_2019_04
	,D_EXPENSE_PROJECTION.OPEX_2019_05
	,D_EXPENSE_PROJECTION.OPEX_2019_06
	,D_EXPENSE_PROJECTION.OPEX_2019_07
	,D_EXPENSE_PROJECTION.OPEX_2019_08
	,D_EXPENSE_PROJECTION.OPEX_2019_09
	,D_EXPENSE_PROJECTION.OPEX_2019_10
	,D_EXPENSE_PROJECTION.OPEX_2019_11
	,D_EXPENSE_PROJECTION.OPEX_2019_12
	,D_EXPENSE_PROJECTION.OPEX_2020_00
	,D_EXPENSE_PROJECTION.OPEX_2021_00
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_01]),0,[D_EXPENSE_PROJECTION].[CASH_2017_01])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_02]),0,[D_EXPENSE_PROJECTION].[CASH_2017_02])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_03]),0,[D_EXPENSE_PROJECTION].[CASH_2017_03]) AS CASH_2017_1Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_04]),0,[D_EXPENSE_PROJECTION].[CASH_2017_04])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_05]),0,[D_EXPENSE_PROJECTION].[CASH_2017_05])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_06]),0,[D_EXPENSE_PROJECTION].[CASH_2017_06]) AS CASH_2017_2Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_07]),0,[D_EXPENSE_PROJECTION].[CASH_2017_07])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_08]),0,[D_EXPENSE_PROJECTION].[CASH_2017_08])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_09]),0,[D_EXPENSE_PROJECTION].[CASH_2017_09]) AS CASH_2017_3Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_10]),0,[D_EXPENSE_PROJECTION].[CASH_2017_10])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_11]),0,[D_EXPENSE_PROJECTION].[CASH_2017_11])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2017_12]),0,[D_EXPENSE_PROJECTION].[CASH_2017_12]) AS CASH_2017_4Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_01]),0,[D_EXPENSE_PROJECTION].[CASH_2018_01])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_02]),0,[D_EXPENSE_PROJECTION].[CASH_2018_02])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_03]),0,[D_EXPENSE_PROJECTION].[CASH_2018_03]) AS CASH_2018_1Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_04]),0,[D_EXPENSE_PROJECTION].[CASH_2018_04])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_05]),0,[D_EXPENSE_PROJECTION].[CASH_2018_05])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_06]),0,[D_EXPENSE_PROJECTION].[CASH_2018_06]) AS CASH_2018_2Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_07]),0,[D_EXPENSE_PROJECTION].[CASH_2018_07])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_08]),0,[D_EXPENSE_PROJECTION].[CASH_2018_08])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_09]),0,[D_EXPENSE_PROJECTION].[CASH_2018_09]) AS CASH_2018_3Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_10]),0,[D_EXPENSE_PROJECTION].[CASH_2018_10])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_11]),0,[D_EXPENSE_PROJECTION].[CASH_2018_11])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2018_12]),0,[D_EXPENSE_PROJECTION].[CASH_2018_12]) AS CASH_2018_4Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_01]),0,[D_EXPENSE_PROJECTION].[CASH_2019_01])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_02]),0,[D_EXPENSE_PROJECTION].[CASH_2019_02])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_03]),0,[D_EXPENSE_PROJECTION].[CASH_2019_03]) AS CASH_2019_1Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_04]),0,[D_EXPENSE_PROJECTION].[CASH_2019_04])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_05]),0,[D_EXPENSE_PROJECTION].[CASH_2019_05])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_06]),0,[D_EXPENSE_PROJECTION].[CASH_2019_06]) AS CASH_2019_2Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_07]),0,[D_EXPENSE_PROJECTION].[CASH_2019_07])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_08]),0,[D_EXPENSE_PROJECTION].[CASH_2019_08])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_09]),0,[D_EXPENSE_PROJECTION].[CASH_2019_09]) AS CASH_2019_3Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_10]),0,[D_EXPENSE_PROJECTION].[CASH_2019_10])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_11]),0,[D_EXPENSE_PROJECTION].[CASH_2019_11])+IIf(IsNull([D_EXPENSE_PROJECTION].[CASH_2019_12]),0,[D_EXPENSE_PROJECTION].[CASH_2019_12]) AS CASH_2019_4Q
	,[Cash_2017_1Q]                                                                            +[Cash_2017_2Q]+[Cash_2017_3Q]+[Cash_2017_4Q]                                                                                                                                          AS CASH_2017_00
	,[Cash_2018_1Q]                                                                            +[Cash_2018_2Q]+[Cash_2018_3Q]+[Cash_2018_4Q]                                                                                                                                          AS CASH_2018_00
	,[Cash_2019_1Q]                                                                            +[Cash_2019_2Q]+[Cash_2019_3Q]+[Cash_2019_4Q]                                                                                                                                          AS CASH_2019_00
	,[CASH_2017_00]                                                                            +[CASH_2018_00]+[CASH_2019_00]                                                                                                                                                         AS CASH_ALL
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_01]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_01])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_02]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_02])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_03]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_03]) AS OPEX_2017_1Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_04]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_04])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_05]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_05])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_06]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_06]) AS OPEX_2017_2Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_07]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_07])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_08]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_08])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_09]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_09]) AS OPEX_2017_3Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_10]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_10])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_11]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_11])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2017_12]),0,[D_EXPENSE_PROJECTION].[OPEX_2017_12]) AS OPEX_2017_4Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_01]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_01])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_02]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_02])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_03]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_03]) AS OPEX_2018_1Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_04]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_04])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_05]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_05])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_06]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_06]) AS OPEX_2018_2Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_07]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_07])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_08]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_08])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_09]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_09]) AS OPEX_2018_3Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_10]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_10])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_11]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_11])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2018_12]),0,[D_EXPENSE_PROJECTION].[OPEX_2018_12]) AS OPEX_2018_4Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_01]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_01])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_02]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_02])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_03]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_03]) AS OPEX_2019_1Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_04]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_04])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_05]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_05])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_06]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_06]) AS OPEX_2019_2Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_07]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_07])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_08]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_08])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_09]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_09]) AS OPEX_2019_3Q
	,IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_10]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_10])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_11]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_11])+IIf(IsNull([D_EXPENSE_PROJECTION].[OPEX_2019_12]),0,[D_EXPENSE_PROJECTION].[OPEX_2019_12]) AS OPEX_2019_4Q
	,[OPEX_2017_1Q]                                                                            +[OPEX_2017_2Q]+[OPEX_2017_3Q]+[OPEX_2017_4Q]                                                                                                                                          AS OPEX_2017_00
	,[OPEX_2018_1Q]                                                                            +[OPEX_2018_2Q]+[OPEX_2018_3Q]+[OPEX_2018_4Q]                                                                                                                                          AS OPEX_2018_00
	,[OPEX_2019_1Q]                                                                            +[OPEX_2019_2Q]+[OPEX_2019_3Q]+[OPEX_2019_4Q]                                                                                                                                          AS OPEX_2019_00
	,[OPEX_2017_00]                                                                            +[OPEX_2018_00]+[OPEX_2019_00]                                                                                                                                                         AS OPEX_ALL
	,D_EXPENSE_PROJECTION.V_SCOPE_WS_PRG_DWE_ID
	,V_SCOPE_WS_PRG_DWE.PRJ_STATUS
FROM
           V_TREATMENT
           RIGHT JOIN
                      (V_FUNCTION
                      RIGHT JOIN
                                 (V_EXPENSE_TYPE
                                 RIGHT JOIN
                                            (V_SCOPE
                                            INNER JOIN
                                                       (V_SCOPE_WS
                                                       INNER JOIN
                                                                  (V_SCOPE_WS_PRG
                                                                  INNER JOIN
                                                                             (V_SCOPE_WS_PRG_DWE
                                                                             INNER JOIN
                                                                                        (D_EXPENSE_PROJECTION
                                                                                        LEFT JOIN
                                                                                                   V_VENDOR
                                                                                                   ON
                                                                                                              D_EXPENSE_PROJECTION.V_VENDOR_ID = V_VENDOR.V_VENDOR_ID)
                                                                                        ON
                                                                                                   V_SCOPE_WS_PRG_DWE.[V_SCOPE_WS_PRG_DWE_ID] = D_EXPENSE_PROJECTION.[V_SCOPE_WS_PRG_DWE_ID])
                                                                             ON
                                                                                        V_SCOPE_WS_PRG.[V_SCOPE_WS_PRG_ID] = V_SCOPE_WS_PRG_DWE.V_SCOPE_WS_PRG_ID)
                                                                  ON
                                                                             V_SCOPE_WS.[V_SCOPE_WS_ID] = V_SCOPE_WS_PRG.[V_SCOPE_WS_ID])
                                                       ON
                                                                  V_SCOPE.V_SCOPE_ID = V_SCOPE_WS_PRG_DWE.V_SCOPE_ID)
                                            ON
                                                       V_EXPENSE_TYPE.V_EXPENSE_TYPE_ID = D_EXPENSE_PROJECTION.V_EXPENSE_TYPE_ID)
                                 ON
                                            V_FUNCTION.V_FUNCTION_ID = D_EXPENSE_PROJECTION.V_FUNCTION_ID)
                      ON
                                 V_TREATMENT.V_TREATMENT_ID = D_EXPENSE_PROJECTION.V_TREATMENT_ID
GROUP BY
	D_EXPENSE_PROJECTION.EXPENSE_ID
	,V_SCOPE.LABEL
	,V_SCOPE_WS.LABEL
	,V_SCOPE_WS_PRG.LABEL
	,V_SCOPE_WS_PRG_DWE.LABEL
	,V_FUNCTION.LABEL
	,V_EXPENSE_TYPE.LABEL
	,V_VENDOR.LABEL
	,D_EXPENSE_PROJECTION.DESCRIPTION
	,V_TREATMENT.LABEL
	,D_EXPENSE_PROJECTION.CASH_2016_00
	,D_EXPENSE_PROJECTION.CASH_2017_01
	,D_EXPENSE_PROJECTION.CASH_2017_02
	,D_EXPENSE_PROJECTION.CASH_2017_03
	,D_EXPENSE_PROJECTION.CASH_2017_04
	,D_EXPENSE_PROJECTION.CASH_2017_05
	,D_EXPENSE_PROJECTION.CASH_2017_06
	,D_EXPENSE_PROJECTION.CASH_2017_07
	,D_EXPENSE_PROJECTION.CASH_2017_08
	,D_EXPENSE_PROJECTION.CASH_2017_09
	,D_EXPENSE_PROJECTION.CASH_2017_10
	,D_EXPENSE_PROJECTION.CASH_2017_11
	,D_EXPENSE_PROJECTION.CASH_2017_12
	,D_EXPENSE_PROJECTION.CASH_2018_01
	,D_EXPENSE_PROJECTION.CASH_2018_02
	,D_EXPENSE_PROJECTION.CASH_2018_03
	,D_EXPENSE_PROJECTION.CASH_2018_04
	,D_EXPENSE_PROJECTION.CASH_2018_05
	,D_EXPENSE_PROJECTION.CASH_2018_06
	,D_EXPENSE_PROJECTION.CASH_2018_07
	,D_EXPENSE_PROJECTION.CASH_2018_08
	,D_EXPENSE_PROJECTION.CASH_2018_09
	,D_EXPENSE_PROJECTION.CASH_2018_10
	,D_EXPENSE_PROJECTION.CASH_2018_11
	,D_EXPENSE_PROJECTION.CASH_2018_12
	,D_EXPENSE_PROJECTION.CASH_2019_01
	,D_EXPENSE_PROJECTION.CASH_2019_02
	,D_EXPENSE_PROJECTION.CASH_2019_03
	,D_EXPENSE_PROJECTION.CASH_2019_04
	,D_EXPENSE_PROJECTION.CASH_2019_05
	,D_EXPENSE_PROJECTION.CASH_2019_06
	,D_EXPENSE_PROJECTION.CASH_2019_07
	,D_EXPENSE_PROJECTION.CASH_2019_08
	,D_EXPENSE_PROJECTION.CASH_2019_09
	,D_EXPENSE_PROJECTION.CASH_2019_10
	,D_EXPENSE_PROJECTION.CASH_2019_11
	,D_EXPENSE_PROJECTION.CASH_2019_12
	,D_EXPENSE_PROJECTION.CASH_2020_00
	,D_EXPENSE_PROJECTION.CASH_2021_00
	,D_EXPENSE_PROJECTION.OPEX_2016_00
	,D_EXPENSE_PROJECTION.OPEX_2017_01
	,D_EXPENSE_PROJECTION.OPEX_2017_02
	,D_EXPENSE_PROJECTION.OPEX_2017_03
	,D_EXPENSE_PROJECTION.OPEX_2017_04
	,D_EXPENSE_PROJECTION.OPEX_2017_05
	,D_EXPENSE_PROJECTION.OPEX_2017_06
	,D_EXPENSE_PROJECTION.OPEX_2017_07
	,D_EXPENSE_PROJECTION.OPEX_2017_08
	,D_EXPENSE_PROJECTION.OPEX_2017_09
	,D_EXPENSE_PROJECTION.OPEX_2017_10
	,D_EXPENSE_PROJECTION.OPEX_2017_11
	,D_EXPENSE_PROJECTION.OPEX_2017_12
	,D_EXPENSE_PROJECTION.OPEX_2018_01
	,D_EXPENSE_PROJECTION.OPEX_2018_02
	,D_EXPENSE_PROJECTION.OPEX_2018_03
	,D_EXPENSE_PROJECTION.OPEX_2018_04
	,D_EXPENSE_PROJECTION.OPEX_2018_05
	,D_EXPENSE_PROJECTION.OPEX_2018_06
	,D_EXPENSE_PROJECTION.OPEX_2018_07
	,D_EXPENSE_PROJECTION.OPEX_2018_08
	,D_EXPENSE_PROJECTION.OPEX_2018_09
	,D_EXPENSE_PROJECTION.OPEX_2018_10
	,D_EXPENSE_PROJECTION.OPEX_2018_11
	,D_EXPENSE_PROJECTION.OPEX_2018_12
	,D_EXPENSE_PROJECTION.OPEX_2019_01
	,D_EXPENSE_PROJECTION.OPEX_2019_02
	,D_EXPENSE_PROJECTION.OPEX_2019_03
	,D_EXPENSE_PROJECTION.OPEX_2019_04
	,D_EXPENSE_PROJECTION.OPEX_2019_05
	,D_EXPENSE_PROJECTION.OPEX_2019_06
	,D_EXPENSE_PROJECTION.OPEX_2019_07
	,D_EXPENSE_PROJECTION.OPEX_2019_08
	,D_EXPENSE_PROJECTION.OPEX_2019_09
	,D_EXPENSE_PROJECTION.OPEX_2019_10
	,D_EXPENSE_PROJECTION.OPEX_2019_11
	,D_EXPENSE_PROJECTION.OPEX_2019_12
	,D_EXPENSE_PROJECTION.OPEX_2020_00
	,D_EXPENSE_PROJECTION.OPEX_2021_00
	,D_EXPENSE_PROJECTION.V_SCOPE_WS_PRG_DWE_ID
	,V_SCOPE_WS_PRG_DWE.PRJ_STATUS
	,D_EXPENSE_PROJECTION.V_SCOPE_WS_PRG_DWE_ID;

---------------------------------------- DLM ----------------------------------------
-- Have made updates on our end since sending you the original scripts around the [Work Effort] field and [V_SCOPE] join. Will provide updates.
-------------------------------------------------------------------------------------


/****************************************************************
*** Insert into export tables - E_EXPENSE_PROJECTION_02_CAPEX ***
*****************************************************************/
	
SELECT 
EB.*,
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2016_00]),0,[CASH_2016_00])=0 Or IIf(IsNull([CASH_2016_00]),0,[CASH_2016_00])-IIf(IsNull([OPEX_2016_00]),0,[OPEX_2016_00])<0,0,IIf(IsNull([CASH_2016_00]),0,[CASH_2016_00])-IIf(IsNull([OPEX_2016_00]),0,[OPEX_2016_00])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2016_00]),0,[CASH_2016_00])=0 Or IIf(IsNull([CASH_2016_00]),0,[CASH_2016_00])-IIf(IsNull([OPEX_2016_00]),0,[OPEX_2016_00])<0,0,IIf(IsNull([CASH_2016_00]),0,[CASH_2016_00])-IIf(IsNull([OPEX_2016_00]),0,[OPEX_2016_00])),0),0)) AS [CAPEX 2016-00],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_01]),0,[CASH_2017_01])=0 Or IIf(IsNull([CASH_2017_01]),0,[CASH_2017_01])-IIf(IsNull([OPEX_2017_01]),0,[OPEX_2017_01])<0,0,IIf(IsNull([CASH_2017_01]),0,[CASH_2017_01])-IIf(IsNull([OPEX_2017_01]),0,[OPEX_2017_01])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_01]),0,[CASH_2017_01])=0 Or IIf(IsNull([CASH_2017_01]),0,[CASH_2017_01])-IIf(IsNull([OPEX_2017_01]),0,[OPEX_2017_01])<0,0,IIf(IsNull([CASH_2017_01]),0,[CASH_2017_01])-IIf(IsNull([OPEX_2017_01]),0,[OPEX_2017_01])),0),0)) AS [CAPEX 2017-01],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_02]),0,[CASH_2017_02])=0 Or IIf(IsNull([CASH_2017_02]),0,[CASH_2017_02])-IIf(IsNull([OPEX_2017_02]),0,[OPEX_2017_02])<0,0,IIf(IsNull([CASH_2017_02]),0,[CASH_2017_02])-IIf(IsNull([OPEX_2017_02]),0,[OPEX_2017_02])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_02]),0,[CASH_2017_02])=0 Or IIf(IsNull([CASH_2017_02]),0,[CASH_2017_02])-IIf(IsNull([OPEX_2017_02]),0,[OPEX_2017_02])<0,0,IIf(IsNull([CASH_2017_02]),0,[CASH_2017_02])-IIf(IsNull([OPEX_2017_02]),0,[OPEX_2017_02])),0),0)) AS [CAPEX 2017-02],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_03]),0,[CASH_2017_03])=0 Or IIf(IsNull([CASH_2017_03]),0,[CASH_2017_03])-IIf(IsNull([OPEX_2017_03]),0,[OPEX_2017_03])<0,0,IIf(IsNull([CASH_2017_03]),0,[CASH_2017_03])-IIf(IsNull([OPEX_2017_03]),0,[OPEX_2017_03])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_03]),0,[CASH_2017_03])=0 Or IIf(IsNull([CASH_2017_03]),0,[CASH_2017_03])-IIf(IsNull([OPEX_2017_03]),0,[OPEX_2017_03])<0,0,IIf(IsNull([CASH_2017_03]),0,[CASH_2017_03])-IIf(IsNull([OPEX_2017_03]),0,[OPEX_2017_03])),0),0)) AS [CAPEX 2017-03],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_04]),0,[CASH_2017_04])=0 Or IIf(IsNull([CASH_2017_04]),0,[CASH_2017_04])-IIf(IsNull([OPEX_2017_04]),0,[OPEX_2017_04])<0,0,IIf(IsNull([CASH_2017_04]),0,[CASH_2017_04])-IIf(IsNull([OPEX_2017_04]),0,[OPEX_2017_04])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_04]),0,[CASH_2017_04])=0 Or IIf(IsNull([CASH_2017_04]),0,[CASH_2017_04])-IIf(IsNull([OPEX_2017_04]),0,[OPEX_2017_04])<0,0,IIf(IsNull([CASH_2017_04]),0,[CASH_2017_04])-IIf(IsNull([OPEX_2017_04]),0,[OPEX_2017_04])),0),0)) AS [CAPEX 2017-04],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_05]),0,[CASH_2017_05])=0 Or IIf(IsNull([CASH_2017_05]),0,[CASH_2017_05])-IIf(IsNull([OPEX_2017_05]),0,[OPEX_2017_05])<0,0,IIf(IsNull([CASH_2017_05]),0,[CASH_2017_05])-IIf(IsNull([OPEX_2017_05]),0,[OPEX_2017_05])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_05]),0,[CASH_2017_05])=0 Or IIf(IsNull([CASH_2017_05]),0,[CASH_2017_05])-IIf(IsNull([OPEX_2017_05]),0,[OPEX_2017_05])<0,0,IIf(IsNull([CASH_2017_05]),0,[CASH_2017_05])-IIf(IsNull([OPEX_2017_05]),0,[OPEX_2017_05])),0),0)) AS [CAPEX 2017-05],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_06]),0,[CASH_2017_06])=0 Or IIf(IsNull([CASH_2017_06]),0,[CASH_2017_06])-IIf(IsNull([OPEX_2017_06]),0,[OPEX_2017_06])<0,0,IIf(IsNull([CASH_2017_06]),0,[CASH_2017_06])-IIf(IsNull([OPEX_2017_06]),0,[OPEX_2017_06])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_06]),0,[CASH_2017_06])=0 Or IIf(IsNull([CASH_2017_06]),0,[CASH_2017_06])-IIf(IsNull([OPEX_2017_06]),0,[OPEX_2017_06])<0,0,IIf(IsNull([CASH_2017_06]),0,[CASH_2017_06])-IIf(IsNull([OPEX_2017_06]),0,[OPEX_2017_06])),0),0)) AS [CAPEX 2017-06],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_07]),0,[CASH_2017_07])=0 Or IIf(IsNull([CASH_2017_07]),0,[CASH_2017_07])-IIf(IsNull([OPEX_2017_07]),0,[OPEX_2017_07])<0,0,IIf(IsNull([CASH_2017_07]),0,[CASH_2017_07])-IIf(IsNull([OPEX_2017_07]),0,[OPEX_2017_07])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_07]),0,[CASH_2017_07])=0 Or IIf(IsNull([CASH_2017_07]),0,[CASH_2017_07])-IIf(IsNull([OPEX_2017_07]),0,[OPEX_2017_07])<0,0,IIf(IsNull([CASH_2017_07]),0,[CASH_2017_07])-IIf(IsNull([OPEX_2017_07]),0,[OPEX_2017_07])),0),0)) AS [CAPEX 2017-07],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_08]),0,[CASH_2017_08])=0 Or IIf(IsNull([CASH_2017_08]),0,[CASH_2017_08])-IIf(IsNull([OPEX_2017_08]),0,[OPEX_2017_08])<0,0,IIf(IsNull([CASH_2017_08]),0,[CASH_2017_08])-IIf(IsNull([OPEX_2017_08]),0,[OPEX_2017_08])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_08]),0,[CASH_2017_08])=0 Or IIf(IsNull([CASH_2017_08]),0,[CASH_2017_08])-IIf(IsNull([OPEX_2017_08]),0,[OPEX_2017_08])<0,0,IIf(IsNull([CASH_2017_08]),0,[CASH_2017_08])-IIf(IsNull([OPEX_2017_08]),0,[OPEX_2017_08])),0),0)) AS [CAPEX 2017-08],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_09]),0,[CASH_2017_09])=0 Or IIf(IsNull([CASH_2017_09]),0,[CASH_2017_09])-IIf(IsNull([OPEX_2017_09]),0,[OPEX_2017_09])<0,0,IIf(IsNull([CASH_2017_09]),0,[CASH_2017_09])-IIf(IsNull([OPEX_2017_09]),0,[OPEX_2017_09])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_09]),0,[CASH_2017_09])=0 Or IIf(IsNull([CASH_2017_09]),0,[CASH_2017_09])-IIf(IsNull([OPEX_2017_09]),0,[OPEX_2017_09])<0,0,IIf(IsNull([CASH_2017_09]),0,[CASH_2017_09])-IIf(IsNull([OPEX_2017_09]),0,[OPEX_2017_09])),0),0)) AS [CAPEX 2017-09],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_10]),0,[CASH_2017_10])=0 Or IIf(IsNull([CASH_2017_10]),0,[CASH_2017_10])-IIf(IsNull([OPEX_2017_10]),0,[OPEX_2017_10])<0,0,IIf(IsNull([CASH_2017_10]),0,[CASH_2017_10])-IIf(IsNull([OPEX_2017_10]),0,[OPEX_2017_10])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_10]),0,[CASH_2017_10])=0 Or IIf(IsNull([CASH_2017_10]),0,[CASH_2017_10])-IIf(IsNull([OPEX_2017_10]),0,[OPEX_2017_10])<0,0,IIf(IsNull([CASH_2017_10]),0,[CASH_2017_10])-IIf(IsNull([OPEX_2017_10]),0,[OPEX_2017_10])),0),0)) AS [CAPEX 2017-10],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_11]),0,[CASH_2017_11])=0 Or IIf(IsNull([CASH_2017_11]),0,[CASH_2017_11])-IIf(IsNull([OPEX_2017_11]),0,[OPEX_2017_11])<0,0,IIf(IsNull([CASH_2017_11]),0,[CASH_2017_11])-IIf(IsNull([OPEX_2017_11]),0,[OPEX_2017_11])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_11]),0,[CASH_2017_11])=0 Or IIf(IsNull([CASH_2017_11]),0,[CASH_2017_11])-IIf(IsNull([OPEX_2017_11]),0,[OPEX_2017_11])<0,0,IIf(IsNull([CASH_2017_11]),0,[CASH_2017_11])-IIf(IsNull([OPEX_2017_11]),0,[OPEX_2017_11])),0),0)) AS [CAPEX 2017-11],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2017_12]),0,[CASH_2017_12])=0 Or IIf(IsNull([CASH_2017_12]),0,[CASH_2017_12])-IIf(IsNull([OPEX_2017_12]),0,[OPEX_2017_12])<0,0,IIf(IsNull([CASH_2017_12]),0,[CASH_2017_12])-IIf(IsNull([OPEX_2017_12]),0,[OPEX_2017_12])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2017_12]),0,[CASH_2017_12])=0 Or IIf(IsNull([CASH_2017_12]),0,[CASH_2017_12])-IIf(IsNull([OPEX_2017_12]),0,[OPEX_2017_12])<0,0,IIf(IsNull([CASH_2017_12]),0,[CASH_2017_12])-IIf(IsNull([OPEX_2017_12]),0,[OPEX_2017_12])),0),0)) AS [CAPEX 2017-12],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_01]),0,[CASH_2018_01])=0 Or IIf(IsNull([CASH_2018_01]),0,[CASH_2018_01])-IIf(IsNull([OPEX_2018_01]),0,[OPEX_2018_01])<0,0,IIf(IsNull([CASH_2018_01]),0,[CASH_2018_01])-IIf(IsNull([OPEX_2018_01]),0,[OPEX_2018_01])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_01]),0,[CASH_2018_01])=0 Or IIf(IsNull([CASH_2018_01]),0,[CASH_2018_01])-IIf(IsNull([OPEX_2018_01]),0,[OPEX_2018_01])<0,0,IIf(IsNull([CASH_2018_01]),0,[CASH_2018_01])-IIf(IsNull([OPEX_2018_01]),0,[OPEX_2018_01])),0),0)) AS [CAPEX 2018-01],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_02]),0,[CASH_2018_02])=0 Or IIf(IsNull([CASH_2018_02]),0,[CASH_2018_02])-IIf(IsNull([OPEX_2018_02]),0,[OPEX_2018_02])<0,0,IIf(IsNull([CASH_2018_02]),0,[CASH_2018_02])-IIf(IsNull([OPEX_2018_02]),0,[OPEX_2018_02])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_02]),0,[CASH_2018_02])=0 Or IIf(IsNull([CASH_2018_02]),0,[CASH_2018_02])-IIf(IsNull([OPEX_2018_02]),0,[OPEX_2018_02])<0,0,IIf(IsNull([CASH_2018_02]),0,[CASH_2018_02])-IIf(IsNull([OPEX_2018_02]),0,[OPEX_2018_02])),0),0)) AS [CAPEX 2018-02],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_03]),0,[CASH_2018_03])=0 Or IIf(IsNull([CASH_2018_03]),0,[CASH_2018_03])-IIf(IsNull([OPEX_2018_03]),0,[OPEX_2018_03])<0,0,IIf(IsNull([CASH_2018_03]),0,[CASH_2018_03])-IIf(IsNull([OPEX_2018_03]),0,[OPEX_2018_03])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_03]),0,[CASH_2018_03])=0 Or IIf(IsNull([CASH_2018_03]),0,[CASH_2018_03])-IIf(IsNull([OPEX_2018_03]),0,[OPEX_2018_03])<0,0,IIf(IsNull([CASH_2018_03]),0,[CASH_2018_03])-IIf(IsNull([OPEX_2018_03]),0,[OPEX_2018_03])),0),0)) AS [CAPEX 2018-03],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_04]),0,[CASH_2018_04])=0 Or IIf(IsNull([CASH_2018_04]),0,[CASH_2018_04])-IIf(IsNull([OPEX_2018_04]),0,[OPEX_2018_04])<0,0,IIf(IsNull([CASH_2018_04]),0,[CASH_2018_04])-IIf(IsNull([OPEX_2018_04]),0,[OPEX_2018_04])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_04]),0,[CASH_2018_04])=0 Or IIf(IsNull([CASH_2018_04]),0,[CASH_2018_04])-IIf(IsNull([OPEX_2018_04]),0,[OPEX_2018_04])<0,0,IIf(IsNull([CASH_2018_04]),0,[CASH_2018_04])-IIf(IsNull([OPEX_2018_04]),0,[OPEX_2018_04])),0),0)) AS [CAPEX 2018-04],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_05]),0,[CASH_2018_05])=0 Or IIf(IsNull([CASH_2018_05]),0,[CASH_2018_05])-IIf(IsNull([OPEX_2018_05]),0,[OPEX_2018_05])<0,0,IIf(IsNull([CASH_2018_05]),0,[CASH_2018_05])-IIf(IsNull([OPEX_2018_05]),0,[OPEX_2018_05])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_05]),0,[CASH_2018_05])=0 Or IIf(IsNull([CASH_2018_05]),0,[CASH_2018_05])-IIf(IsNull([OPEX_2018_05]),0,[OPEX_2018_05])<0,0,IIf(IsNull([CASH_2018_05]),0,[CASH_2018_05])-IIf(IsNull([OPEX_2018_05]),0,[OPEX_2018_05])),0),0)) AS [CAPEX 2018-05],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_06]),0,[CASH_2018_06])=0 Or IIf(IsNull([CASH_2018_06]),0,[CASH_2018_06])-IIf(IsNull([OPEX_2018_06]),0,[OPEX_2018_06])<0,0,IIf(IsNull([CASH_2018_06]),0,[CASH_2018_06])-IIf(IsNull([OPEX_2018_06]),0,[OPEX_2018_06])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_06]),0,[CASH_2018_06])=0 Or IIf(IsNull([CASH_2018_06]),0,[CASH_2018_06])-IIf(IsNull([OPEX_2018_06]),0,[OPEX_2018_06])<0,0,IIf(IsNull([CASH_2018_06]),0,[CASH_2018_06])-IIf(IsNull([OPEX_2018_06]),0,[OPEX_2018_06])),0),0)) AS [CAPEX 2018-06],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_07]),0,[CASH_2018_07])=0 Or IIf(IsNull([CASH_2018_07]),0,[CASH_2018_07])-IIf(IsNull([OPEX_2018_07]),0,[OPEX_2018_07])<0,0,IIf(IsNull([CASH_2018_07]),0,[CASH_2018_07])-IIf(IsNull([OPEX_2018_07]),0,[OPEX_2018_07])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_07]),0,[CASH_2018_07])=0 Or IIf(IsNull([CASH_2018_07]),0,[CASH_2018_07])-IIf(IsNull([OPEX_2018_07]),0,[OPEX_2018_07])<0,0,IIf(IsNull([CASH_2018_07]),0,[CASH_2018_07])-IIf(IsNull([OPEX_2018_07]),0,[OPEX_2018_07])),0),0)) AS [CAPEX 2018-07],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_08]),0,[CASH_2018_08])=0 Or IIf(IsNull([CASH_2018_08]),0,[CASH_2018_08])-IIf(IsNull([OPEX_2018_08]),0,[OPEX_2018_08])<0,0,IIf(IsNull([CASH_2018_08]),0,[CASH_2018_08])-IIf(IsNull([OPEX_2018_08]),0,[OPEX_2018_08])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_08]),0,[CASH_2018_08])=0 Or IIf(IsNull([CASH_2018_08]),0,[CASH_2018_08])-IIf(IsNull([OPEX_2018_08]),0,[OPEX_2018_08])<0,0,IIf(IsNull([CASH_2018_08]),0,[CASH_2018_08])-IIf(IsNull([OPEX_2018_08]),0,[OPEX_2018_08])),0),0)) AS [CAPEX 2018-08],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_09]),0,[CASH_2018_09])=0 Or IIf(IsNull([CASH_2018_09]),0,[CASH_2018_09])-IIf(IsNull([OPEX_2018_09]),0,[OPEX_2018_09])<0,0,IIf(IsNull([CASH_2018_09]),0,[CASH_2018_09])-IIf(IsNull([OPEX_2018_09]),0,[OPEX_2018_09])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_09]),0,[CASH_2018_09])=0 Or IIf(IsNull([CASH_2018_09]),0,[CASH_2018_09])-IIf(IsNull([OPEX_2018_09]),0,[OPEX_2018_09])<0,0,IIf(IsNull([CASH_2018_09]),0,[CASH_2018_09])-IIf(IsNull([OPEX_2018_09]),0,[OPEX_2018_09])),0),0)) AS [CAPEX 2018-09],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_10]),0,[CASH_2018_10])=0 Or IIf(IsNull([CASH_2018_10]),0,[CASH_2018_10])-IIf(IsNull([OPEX_2018_10]),0,[OPEX_2018_10])<0,0,IIf(IsNull([CASH_2018_10]),0,[CASH_2018_10])-IIf(IsNull([OPEX_2018_10]),0,[OPEX_2018_10])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_10]),0,[CASH_2018_10])=0 Or IIf(IsNull([CASH_2018_10]),0,[CASH_2018_10])-IIf(IsNull([OPEX_2018_10]),0,[OPEX_2018_10])<0,0,IIf(IsNull([CASH_2018_10]),0,[CASH_2018_10])-IIf(IsNull([OPEX_2018_10]),0,[OPEX_2018_10])),0),0)) AS [CAPEX 2018-10],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_11]),0,[CASH_2018_11])=0 Or IIf(IsNull([CASH_2018_11]),0,[CASH_2018_11])-IIf(IsNull([OPEX_2018_11]),0,[OPEX_2018_11])<0,0,IIf(IsNull([CASH_2018_11]),0,[CASH_2018_11])-IIf(IsNull([OPEX_2018_11]),0,[OPEX_2018_11])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_11]),0,[CASH_2018_11])=0 Or IIf(IsNull([CASH_2018_11]),0,[CASH_2018_11])-IIf(IsNull([OPEX_2018_11]),0,[OPEX_2018_11])<0,0,IIf(IsNull([CASH_2018_11]),0,[CASH_2018_11])-IIf(IsNull([OPEX_2018_11]),0,[OPEX_2018_11])),0),0)) AS [CAPEX 2018-11],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2018_12]),0,[CASH_2018_12])=0 Or IIf(IsNull([CASH_2018_12]),0,[CASH_2018_12])-IIf(IsNull([OPEX_2018_12]),0,[OPEX_2018_12])<0,0,IIf(IsNull([CASH_2018_12]),0,[CASH_2018_12])-IIf(IsNull([OPEX_2018_12]),0,[OPEX_2018_12])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2018_12]),0,[CASH_2018_12])=0 Or IIf(IsNull([CASH_2018_12]),0,[CASH_2018_12])-IIf(IsNull([OPEX_2018_12]),0,[OPEX_2018_12])<0,0,IIf(IsNull([CASH_2018_12]),0,[CASH_2018_12])-IIf(IsNull([OPEX_2018_12]),0,[OPEX_2018_12])),0),0)) AS [CAPEX 2018-12],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_01]),0,[CASH_2019_01])=0 Or IIf(IsNull([CASH_2019_01]),0,[CASH_2019_01])-IIf(IsNull([OPEX_2019_01]),0,[OPEX_2019_01])<0,0,IIf(IsNull([CASH_2019_01]),0,[CASH_2019_01])-IIf(IsNull([OPEX_2019_01]),0,[OPEX_2019_01])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_01]),0,[CASH_2019_01])=0 Or IIf(IsNull([CASH_2019_01]),0,[CASH_2019_01])-IIf(IsNull([OPEX_2019_01]),0,[OPEX_2019_01])<0,0,IIf(IsNull([CASH_2019_01]),0,[CASH_2019_01])-IIf(IsNull([OPEX_2019_01]),0,[OPEX_2019_01])),0),0)) AS [CAPEX 2019-01],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_02]),0,[CASH_2019_02])=0 Or IIf(IsNull([CASH_2019_02]),0,[CASH_2019_02])-IIf(IsNull([OPEX_2019_02]),0,[OPEX_2019_02])<0,0,IIf(IsNull([CASH_2019_02]),0,[CASH_2019_02])-IIf(IsNull([OPEX_2019_02]),0,[OPEX_2019_02])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_02]),0,[CASH_2019_02])=0 Or IIf(IsNull([CASH_2019_02]),0,[CASH_2019_02])-IIf(IsNull([OPEX_2019_02]),0,[OPEX_2019_02])<0,0,IIf(IsNull([CASH_2019_02]),0,[CASH_2019_02])-IIf(IsNull([OPEX_2019_02]),0,[OPEX_2019_02])),0),0)) AS [CAPEX 2019-02],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_03]),0,[CASH_2019_03])=0 Or IIf(IsNull([CASH_2019_03]),0,[CASH_2019_03])-IIf(IsNull([OPEX_2019_03]),0,[OPEX_2019_03])<0,0,IIf(IsNull([CASH_2019_03]),0,[CASH_2019_03])-IIf(IsNull([OPEX_2019_03]),0,[OPEX_2019_03])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_03]),0,[CASH_2019_03])=0 Or IIf(IsNull([CASH_2019_03]),0,[CASH_2019_03])-IIf(IsNull([OPEX_2019_03]),0,[OPEX_2019_03])<0,0,IIf(IsNull([CASH_2019_03]),0,[CASH_2019_03])-IIf(IsNull([OPEX_2019_03]),0,[OPEX_2019_03])),0),0)) AS [CAPEX 2019-03],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_04]),0,[CASH_2019_04])=0 Or IIf(IsNull([CASH_2019_04]),0,[CASH_2019_04])-IIf(IsNull([OPEX_2019_04]),0,[OPEX_2019_04])<0,0,IIf(IsNull([CASH_2019_04]),0,[CASH_2019_04])-IIf(IsNull([OPEX_2019_04]),0,[OPEX_2019_04])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_04]),0,[CASH_2019_04])=0 Or IIf(IsNull([CASH_2019_04]),0,[CASH_2019_04])-IIf(IsNull([OPEX_2019_04]),0,[OPEX_2019_04])<0,0,IIf(IsNull([CASH_2019_04]),0,[CASH_2019_04])-IIf(IsNull([OPEX_2019_04]),0,[OPEX_2019_04])),0),0)) AS [CAPEX 2019-04],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_05]),0,[CASH_2019_05])=0 Or IIf(IsNull([CASH_2019_05]),0,[CASH_2019_05])-IIf(IsNull([OPEX_2019_05]),0,[OPEX_2019_05])<0,0,IIf(IsNull([CASH_2019_05]),0,[CASH_2019_05])-IIf(IsNull([OPEX_2019_05]),0,[OPEX_2019_05])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_05]),0,[CASH_2019_05])=0 Or IIf(IsNull([CASH_2019_05]),0,[CASH_2019_05])-IIf(IsNull([OPEX_2019_05]),0,[OPEX_2019_05])<0,0,IIf(IsNull([CASH_2019_05]),0,[CASH_2019_05])-IIf(IsNull([OPEX_2019_05]),0,[OPEX_2019_05])),0),0)) AS [CAPEX 2019-05],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_06]),0,[CASH_2019_06])=0 Or IIf(IsNull([CASH_2019_06]),0,[CASH_2019_06])-IIf(IsNull([OPEX_2019_06]),0,[OPEX_2019_06])<0,0,IIf(IsNull([CASH_2019_06]),0,[CASH_2019_06])-IIf(IsNull([OPEX_2019_06]),0,[OPEX_2019_06])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_06]),0,[CASH_2019_06])=0 Or IIf(IsNull([CASH_2019_06]),0,[CASH_2019_06])-IIf(IsNull([OPEX_2019_06]),0,[OPEX_2019_06])<0,0,IIf(IsNull([CASH_2019_06]),0,[CASH_2019_06])-IIf(IsNull([OPEX_2019_06]),0,[OPEX_2019_06])),0),0)) AS [CAPEX 2019-06],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_07]),0,[CASH_2019_07])=0 Or IIf(IsNull([CASH_2019_07]),0,[CASH_2019_07])-IIf(IsNull([OPEX_2019_07]),0,[OPEX_2019_07])<0,0,IIf(IsNull([CASH_2019_07]),0,[CASH_2019_07])-IIf(IsNull([OPEX_2019_07]),0,[OPEX_2019_07])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_07]),0,[CASH_2019_07])=0 Or IIf(IsNull([CASH_2019_07]),0,[CASH_2019_07])-IIf(IsNull([OPEX_2019_07]),0,[OPEX_2019_07])<0,0,IIf(IsNull([CASH_2019_07]),0,[CASH_2019_07])-IIf(IsNull([OPEX_2019_07]),0,[OPEX_2019_07])),0),0)) AS [CAPEX 2019-07],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_08]),0,[CASH_2019_08])=0 Or IIf(IsNull([CASH_2019_08]),0,[CASH_2019_08])-IIf(IsNull([OPEX_2019_08]),0,[OPEX_2019_08])<0,0,IIf(IsNull([CASH_2019_08]),0,[CASH_2019_08])-IIf(IsNull([OPEX_2019_08]),0,[OPEX_2019_08])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_08]),0,[CASH_2019_08])=0 Or IIf(IsNull([CASH_2019_08]),0,[CASH_2019_08])-IIf(IsNull([OPEX_2019_08]),0,[OPEX_2019_08])<0,0,IIf(IsNull([CASH_2019_08]),0,[CASH_2019_08])-IIf(IsNull([OPEX_2019_08]),0,[OPEX_2019_08])),0),0)) AS [CAPEX 2019-08],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_09]),0,[CASH_2019_09])=0 Or IIf(IsNull([CASH_2019_09]),0,[CASH_2019_09])-IIf(IsNull([OPEX_2019_09]),0,[OPEX_2019_09])<0,0,IIf(IsNull([CASH_2019_09]),0,[CASH_2019_09])-IIf(IsNull([OPEX_2019_09]),0,[OPEX_2019_09])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_09]),0,[CASH_2019_09])=0 Or IIf(IsNull([CASH_2019_09]),0,[CASH_2019_09])-IIf(IsNull([OPEX_2019_09]),0,[OPEX_2019_09])<0,0,IIf(IsNull([CASH_2019_09]),0,[CASH_2019_09])-IIf(IsNull([OPEX_2019_09]),0,[OPEX_2019_09])),0),0)) AS [CAPEX 2019-09],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_10]),0,[CASH_2019_10])=0 Or IIf(IsNull([CASH_2019_10]),0,[CASH_2019_10])-IIf(IsNull([OPEX_2019_10]),0,[OPEX_2019_10])<0,0,IIf(IsNull([CASH_2019_10]),0,[CASH_2019_10])-IIf(IsNull([OPEX_2019_10]),0,[OPEX_2019_10])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_10]),0,[CASH_2019_10])=0 Or IIf(IsNull([CASH_2019_10]),0,[CASH_2019_10])-IIf(IsNull([OPEX_2019_10]),0,[OPEX_2019_10])<0,0,IIf(IsNull([CASH_2019_10]),0,[CASH_2019_10])-IIf(IsNull([OPEX_2019_10]),0,[OPEX_2019_10])),0),0)) AS [CAPEX 2019-10],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_11]),0,[CASH_2019_11])=0 Or IIf(IsNull([CASH_2019_11]),0,[CASH_2019_11])-IIf(IsNull([OPEX_2019_11]),0,[OPEX_2019_11])<0,0,IIf(IsNull([CASH_2019_11]),0,[CASH_2019_11])-IIf(IsNull([OPEX_2019_11]),0,[OPEX_2019_11])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_11]),0,[CASH_2019_11])=0 Or IIf(IsNull([CASH_2019_11]),0,[CASH_2019_11])-IIf(IsNull([OPEX_2019_11]),0,[OPEX_2019_11])<0,0,IIf(IsNull([CASH_2019_11]),0,[CASH_2019_11])-IIf(IsNull([OPEX_2019_11]),0,[OPEX_2019_11])),0),0)) AS [CAPEX 2019-11],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2019_12]),0,[CASH_2019_12])=0 Or IIf(IsNull([CASH_2019_12]),0,[CASH_2019_12])-IIf(IsNull([OPEX_2019_12]),0,[OPEX_2019_12])<0,0,IIf(IsNull([CASH_2019_12]),0,[CASH_2019_12])-IIf(IsNull([OPEX_2019_12]),0,[OPEX_2019_12])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2019_12]),0,[CASH_2019_12])=0 Or IIf(IsNull([CASH_2019_12]),0,[CASH_2019_12])-IIf(IsNull([OPEX_2019_12]),0,[OPEX_2019_12])<0,0,IIf(IsNull([CASH_2019_12]),0,[CASH_2019_12])-IIf(IsNull([OPEX_2019_12]),0,[OPEX_2019_12])),0),0)) AS [CAPEX 2019-12],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2020_00]),0,[CASH_2020_00])=0 Or IIf(IsNull([CASH_2020_00]),0,[CASH_2020_00])-IIf(IsNull([OPEX_2020_00]),0,[OPEX_2020_00])<0,0,IIf(IsNull([CASH_2020_00]),0,[CASH_2020_00])-IIf(IsNull([OPEX_2020_00]),0,[OPEX_2020_00])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2020_00]),0,[CASH_2020_00])=0 Or IIf(IsNull([CASH_2020_00]),0,[CASH_2020_00])-IIf(IsNull([OPEX_2020_00]),0,[OPEX_2020_00])<0,0,IIf(IsNull([CASH_2020_00]),0,[CASH_2020_00])-IIf(IsNull([OPEX_2020_00]),0,[OPEX_2020_00])),0),0)) AS [CAPEX 2020-00],
IIf(EB.TREATMENT='CAP',IIf(IIf(IsNull([CASH_2021_00]),0,[CASH_2021_00])=0 Or IIf(IsNull([CASH_2021_00]),0,[CASH_2021_00])-IIf(IsNull([OPEX_2021_00]),0,[OPEX_2021_00])<0,0,IIf(IsNull([CASH_2021_00]),0,[CASH_2021_00])-IIf(IsNull([OPEX_2021_00]),0,[OPEX_2021_00])),IIf(S.TREATMENT='CAP',IIf(EB.TREATMENT='DEFAULT',IIf(IIf(IsNull([CASH_2021_00]),0,[CASH_2021_00])=0 Or IIf(IsNull([CASH_2021_00]),0,[CASH_2021_00])-IIf(IsNull([OPEX_2021_00]),0,[OPEX_2021_00])<0,0,IIf(IsNull([CASH_2021_00]),0,[CASH_2021_00])-IIf(IsNull([OPEX_2021_00]),0,[OPEX_2021_00])),0),0)) AS [CAPEX 2021-00]
FROM E_EXPENSE_PROJECTION_01_BASE EB
LEFT JOIN D_SCHEDULE S
	ON EB.[V_SCOPE_WS_PRG_DWE_ID] = S.[V_SCOPE_WS_PRG_DWE_ID];


/****************************************************************
***** Insert into export tables - E_EXPENSE_PROJECTION_LOAD *****
*****************************************************************/

INSERT INTO E_EXPENSE_PROJECTION
( 
	[Index],[Work Effort],Workstream,Program,Project,Function,Type,Vendor,Description,Treatment,[CASH 2016-00],[Cash 2017-01],[Cash 2017-02],
	[Cash 2017-03],[Cash 2017-04],[Cash 2017-05],[Cash 2017-06],[Cash 2017-07],[Cash 2017-08],[Cash 2017-09],[Cash 2017-10],[Cash 2017-11],[Cash 2017-12],
	[Cash 2018-01],[Cash 2018-02],[Cash 2018-03],[Cash 2018-04],[Cash 2018-05],[Cash 2018-06],[Cash 2018-07],[Cash 2018-08],[Cash 2018-09],[Cash 2018-10],
	[Cash 2018-11],[Cash 2018-12],[Cash 2019-01],[Cash 2019-02],[Cash 2019-03],[Cash 2019-04],[Cash 2019-05],[Cash 2019-06],[Cash 2019-07],[Cash 2019-08],
	[Cash 2019-09],[Cash 2019-10],[Cash 2019-11],[Cash 2019-12],[CASH 2020-00],[CASH 2021-00],[OPEX 2016-00],[OPEX 2017-01],[OPEX 2017-02],[OPEX 2017-03],
	[OPEX 2017-04],[OPEX 2017-05],[OPEX 2017-06],[OPEX 2017-07],[OPEX 2017-08],[OPEX 2017-09],[OPEX 2017-10],[OPEX 2017-11],[OPEX 2017-12],[OPEX 2018-01],
	[OPEX 2018-02],[OPEX 2018-03],[OPEX 2018-04],[OPEX 2018-05],[OPEX 2018-06],[OPEX 2018-07],[OPEX 2018-08],[OPEX 2018-09],[OPEX 2018-10],[OPEX 2018-11],
	[OPEX 2018-12],[OPEX 2019-01],[OPEX 2019-02],[OPEX 2019-03],[OPEX 2019-04],[OPEX 2019-05],[OPEX 2019-06],[OPEX 2019-07],[OPEX 2019-08],[OPEX 2019-09],
	[OPEX 2019-10],[OPEX 2019-11],[OPEX 2019-12],[OPEX 2020-00],[OPEX 2021-00],[CAPEX 2016-00],[CAPEX 2017-01],[CAPEX 2017-02],[CAPEX 2017-03],[CAPEX 2017-04],
	[CAPEX 2017-05],[CAPEX 2017-06],[CAPEX 2017-07],[CAPEX 2017-08],[CAPEX 2017-09],[CAPEX 2017-10],[CAPEX 2017-11],[CAPEX 2017-12],[CAPEX 2018-01],[CAPEX 2018-02],
	[CAPEX 2018-03],[CAPEX 2018-04],[CAPEX 2018-05],[CAPEX 2018-06],[CAPEX 2018-07],[CAPEX 2018-08],[CAPEX 2018-09],[CAPEX 2018-10],[CAPEX 2018-11],[CAPEX 2018-12],
	[CAPEX 2019-01],[CAPEX 2019-02],[CAPEX 2019-03],[CAPEX 2019-04],[CAPEX 2019-05],[CAPEX 2019-06],[CAPEX 2019-07],[CAPEX 2019-08],[CAPEX 2019-09],[CAPEX 2019-10],
	[CAPEX 2019-11],[CAPEX 2019-12],[CAPEX 2020-00],[CAPEX 2021-00],[Level Details Status] 
)

SELECT
	EC.EXPENSE_ID,
	EC.[Work Effort],
	EC.Workstream,
	EC.Program,
	EC.Project,
	EC.Function,
	EC.Type,
	EC.Vendor,
	EC.Description,
	EC.Treatment,
	EC.CASH_2016_00,
	EC.CASH_2017_01,
	EC.CASH_2017_02,
	EC.CASH_2017_03,
	EC.CASH_2017_04,
	EC.CASH_2017_05,
	EC.CASH_2017_06,
	EC.CASH_2017_07,
	EC.CASH_2017_08,
	EC.CASH_2017_09,
	EC.CASH_2017_10,
	EC.CASH_2017_11,
	EC.CASH_2017_12,
	EC.CASH_2018_01,
	EC.CASH_2018_02,
	EC.CASH_2018_03,
	EC.CASH_2018_04,
	EC.CASH_2018_05,
	EC.CASH_2018_06,
	EC.CASH_2018_07,
	EC.CASH_2018_08,
	EC.CASH_2018_09,
	EC.CASH_2018_10,
	EC.CASH_2018_11,
	EC.CASH_2018_12,
	EC.CASH_2019_01,
	EC.CASH_2019_02,
	EC.CASH_2019_03,
	EC.CASH_2019_04,
	EC.CASH_2019_05,
	EC.CASH_2019_06,
	EC.CASH_2019_07,
	EC.CASH_2019_08,
	EC.CASH_2019_09,
	EC.CASH_2019_10,
	EC.CASH_2019_11,
	EC.CASH_2019_12,
	EC.CASH_2020_00,
	EC.CASH_2021_00,
	EC.OPEX_2016_00,
	EC.OPEX_2017_01,
	EC.OPEX_2017_02,
	EC.OPEX_2017_03,
	EC.OPEX_2017_04,
	EC.OPEX_2017_05,
	EC.OPEX_2017_06,
	EC.OPEX_2017_07,
	EC.OPEX_2017_08,
	EC.OPEX_2017_09,
	EC.OPEX_2017_10,
	EC.OPEX_2017_11,
	EC.OPEX_2017_12,
	EC.OPEX_2018_01,
	EC.OPEX_2018_02,
	EC.OPEX_2018_03,
	EC.OPEX_2018_04,
	EC.OPEX_2018_05,
	EC.OPEX_2018_06,
	EC.OPEX_2018_07,
	EC.OPEX_2018_08,
	EC.OPEX_2018_09,
	EC.OPEX_2018_10,
	EC.OPEX_2018_11,
	EC.OPEX_2018_12,
	EC.OPEX_2019_01,
	EC.OPEX_2019_02,
	EC.OPEX_2019_03,
	EC.OPEX_2019_04,
	EC.OPEX_2019_05,
	EC.OPEX_2019_06,
	EC.OPEX_2019_07,
	EC.OPEX_2019_08,
	EC.OPEX_2019_09,
	EC.OPEX_2019_10,
	EC.OPEX_2019_11,
	EC.OPEX_2019_12,
	EC.OPEX_2020_00,
	EC.OPEX_2021_00,
	EC.[CAPEX 2016-00],
	EC.[CAPEX 2017-01],
	EC.[CAPEX 2017-02],
	EC.[CAPEX 2017-03],
	EC.[CAPEX 2017-04],
	EC.[CAPEX 2017-05],
	EC.[CAPEX 2017-06],
	EC.[CAPEX 2017-07],
	EC.[CAPEX 2017-08],
	EC.[CAPEX 2017-09],
	EC.[CAPEX 2017-10],
	EC.[CAPEX 2017-11],
	EC.[CAPEX 2017-12],
	EC.[CAPEX 2018-01],
	EC.[CAPEX 2018-02],
	EC.[CAPEX 2018-03],
	EC.[CAPEX 2018-04],
	EC.[CAPEX 2018-05],
	EC.[CAPEX 2018-06],
	EC.[CAPEX 2018-07],
	EC.[CAPEX 2018-08],
	EC.[CAPEX 2018-09],
	EC.[CAPEX 2018-10],
	EC.[CAPEX 2018-11],
	EC.[CAPEX 2018-12],
	EC.[CAPEX 2019-01],
	EC.[CAPEX 2019-02],
	EC.[CAPEX 2019-03],
	EC.[CAPEX 2019-04],
	EC.[CAPEX 2019-05],
	EC.[CAPEX 2019-06],
	EC.[CAPEX 2019-07],
	EC.[CAPEX 2019-08],
	EC.[CAPEX 2019-09],
	EC.[CAPEX 2019-10],
	EC.[CAPEX 2019-11],
	EC.[CAPEX 2019-12],
	EC.[CAPEX 2020-00],
	EC.[CAPEX 2021-00],
	EC.PRJ_STATUS
FROM E_EXPENSE_PROJECTION_02_CAPEX EC;
	
	
/****************************************************************
** Insert into export tables - E_EXPENSE_PROJECTION_03_L1ROLLUP *
*****************************************************************/

UPDATE E_EXPENSE_PROJECTION SET 
E_EXPENSE_PROJECTION.[CASH 2017-1Q] = IIf(IsNull([CASH 2017-01]),0,[Cash 2017-01])+IIf(IsNull([CASH 2017-02]),0,[Cash 2017-02])+IIf(IsNull([CASH 2017-03]),0,[Cash 2017-03]),
E_EXPENSE_PROJECTION.[CASH 2017-2Q] = IIf(IsNull([CASH 2017-04]),0,[Cash 2017-04])+IIf(IsNull([CASH 2017-05]),0,[Cash 2017-05])+IIf(IsNull([CASH 2017-06]),0,[Cash 2017-06]),
E_EXPENSE_PROJECTION.[CASH 2017-3Q] = IIf(IsNull([CASH 2017-07]),0,[Cash 2017-07])+IIf(IsNull([CASH 2017-08]),0,[Cash 2017-08])+IIf(IsNull([CASH 2017-09]),0,[Cash 2017-09]),
E_EXPENSE_PROJECTION.[CASH 2017-4Q] = IIf(IsNull([CASH 2017-10]),0,[Cash 2017-10])+IIf(IsNull([CASH 2017-11]),0,[Cash 2017-11])+IIf(IsNull([CASH 2017-12]),0,[Cash 2017-12]),
E_EXPENSE_PROJECTION.[CASH 2018-1Q] = IIf(IsNull([CASH 2018-01]),0,[Cash 2018-01])+IIf(IsNull([CASH 2018-02]),0,[Cash 2018-02])+IIf(IsNull([CASH 2018-03]),0,[Cash 2018-03]),
E_EXPENSE_PROJECTION.[CASH 2018-2Q] = IIf(IsNull([CASH 2018-04]),0,[Cash 2018-04])+IIf(IsNull([CASH 2018-05]),0,[Cash 2018-05])+IIf(IsNull([CASH 2018-06]),0,[Cash 2018-06]),
E_EXPENSE_PROJECTION.[CASH 2018-3Q] = IIf(IsNull([CASH 2018-07]),0,[Cash 2018-07])+IIf(IsNull([CASH 2018-08]),0,[Cash 2018-08])+IIf(IsNull([CASH 2018-09]),0,[Cash 2018-09]),
E_EXPENSE_PROJECTION.[CASH 2018-4Q] = IIf(IsNull([CASH 2018-10]),0,[Cash 2018-10])+IIf(IsNull([CASH 2018-11]),0,[Cash 2018-11])+IIf(IsNull([CASH 2018-12]),0,[Cash 2018-12]),
E_EXPENSE_PROJECTION.[CASH 2019-1Q] = IIf(IsNull([CASH 2019-01]),0,[Cash 2019-01])+IIf(IsNull([CASH 2019-02]),0,[Cash 2019-02])+IIf(IsNull([CASH 2019-03]),0,[Cash 2019-03]),
E_EXPENSE_PROJECTION.[CASH 2019-2Q] = IIf(IsNull([CASH 2019-04]),0,[Cash 2019-04])+IIf(IsNull([CASH 2019-05]),0,[Cash 2019-05])+IIf(IsNull([CASH 2019-06]),0,[Cash 2019-06]),
E_EXPENSE_PROJECTION.[CASH 2019-3Q] = IIf(IsNull([CASH 2019-07]),0,[Cash 2019-07])+IIf(IsNull([CASH 2019-08]),0,[Cash 2019-08])+IIf(IsNull([CASH 2019-09]),0,[Cash 2019-09]),
E_EXPENSE_PROJECTION.[CASH 2019-4Q] = IIf(IsNull([CASH 2019-10]),0,[Cash 2019-10])+IIf(IsNull([CASH 2019-11]),0,[Cash 2019-11])+IIf(IsNull([CASH 2019-12]),0,[Cash 2019-12]),
E_EXPENSE_PROJECTION.[OPEX 2017-1Q] = IIf(IsNull([OPEX 2017-01]),0,[OPEX 2017-01])+IIf(IsNull([OPEX 2017-02]),0,[OPEX 2017-02])+IIf(IsNull([OPEX 2017-03]),0,[OPEX 2017-03]),
E_EXPENSE_PROJECTION.[OPEX 2017-2Q] = IIf(IsNull([OPEX 2017-04]),0,[OPEX 2017-04])+IIf(IsNull([OPEX 2017-05]),0,[OPEX 2017-05])+IIf(IsNull([OPEX 2017-06]),0,[OPEX 2017-06]),
E_EXPENSE_PROJECTION.[OPEX 2017-3Q] = IIf(IsNull([OPEX 2017-07]),0,[OPEX 2017-07])+IIf(IsNull([OPEX 2017-08]),0,[OPEX 2017-08])+IIf(IsNull([OPEX 2017-09]),0,[OPEX 2017-09]),
E_EXPENSE_PROJECTION.[OPEX 2017-4Q] = IIf(IsNull([OPEX 2017-10]),0,[OPEX 2017-10])+IIf(IsNull([OPEX 2017-11]),0,[OPEX 2017-11])+IIf(IsNull([OPEX 2017-12]),0,[OPEX 2017-12]),
E_EXPENSE_PROJECTION.[OPEX 2018-1Q] = IIf(IsNull([OPEX 2018-01]),0,[OPEX 2018-01])+IIf(IsNull([OPEX 2018-02]),0,[OPEX 2018-02])+IIf(IsNull([OPEX 2018-03]),0,[OPEX 2018-03]),
E_EXPENSE_PROJECTION.[OPEX 2018-2Q] = IIf(IsNull([OPEX 2018-04]),0,[OPEX 2018-04])+IIf(IsNull([OPEX 2018-05]),0,[OPEX 2018-05])+IIf(IsNull([OPEX 2018-06]),0,[OPEX 2018-06]),
E_EXPENSE_PROJECTION.[OPEX 2018-3Q] = IIf(IsNull([OPEX 2018-07]),0,[OPEX 2018-07])+IIf(IsNull([OPEX 2018-08]),0,[OPEX 2018-08])+IIf(IsNull([OPEX 2018-09]),0,[OPEX 2018-09]),
E_EXPENSE_PROJECTION.[OPEX 2018-4Q] = IIf(IsNull([OPEX 2018-10]),0,[OPEX 2018-10])+IIf(IsNull([OPEX 2018-11]),0,[OPEX 2018-11])+IIf(IsNull([OPEX 2018-12]),0,[OPEX 2018-12]),
E_EXPENSE_PROJECTION.[OPEX 2019-1Q] = IIf(IsNull([OPEX 2019-01]),0,[OPEX 2019-01])+IIf(IsNull([OPEX 2019-02]),0,[OPEX 2019-02])+IIf(IsNull([OPEX 2019-03]),0,[OPEX 2019-03]),
E_EXPENSE_PROJECTION.[OPEX 2019-2Q] = IIf(IsNull([OPEX 2019-04]),0,[OPEX 2019-04])+IIf(IsNull([OPEX 2019-05]),0,[OPEX 2019-05])+IIf(IsNull([OPEX 2019-06]),0,[OPEX 2019-06]),
E_EXPENSE_PROJECTION.[OPEX 2019-3Q] = IIf(IsNull([OPEX 2019-07]),0,[OPEX 2019-07])+IIf(IsNull([OPEX 2019-08]),0,[OPEX 2019-08])+IIf(IsNull([OPEX 2019-09]),0,[OPEX 2019-09]),
E_EXPENSE_PROJECTION.[OPEX 2019-4Q] = IIf(IsNull([OPEX 2019-10]),0,[OPEX 2019-10])+IIf(IsNull([OPEX 2019-11]),0,[OPEX 2019-11])+IIf(IsNull([OPEX 2019-12]),0,[OPEX 2019-12]),
E_EXPENSE_PROJECTION.[CAPEX 2017-1Q] = IIf(IsNull([CAPEX 2017-01]),0,[CAPEX 2017-01])+IIf(IsNull([CAPEX 2017-02]),0,[CAPEX 2017-02])+IIf(IsNull([CAPEX 2017-03]),0,[CAPEX 2017-03]),
E_EXPENSE_PROJECTION.[CAPEX 2017-2Q] = IIf(IsNull([CAPEX 2017-04]),0,[CAPEX 2017-04])+IIf(IsNull([CAPEX 2017-05]),0,[CAPEX 2017-05])+IIf(IsNull([CAPEX 2017-06]),0,[CAPEX 2017-06]),
E_EXPENSE_PROJECTION.[CAPEX 2017-3Q] = IIf(IsNull([CAPEX 2017-07]),0,[CAPEX 2017-07])+IIf(IsNull([CAPEX 2017-08]),0,[CAPEX 2017-08])+IIf(IsNull([CAPEX 2017-09]),0,[CAPEX 2017-09]),
E_EXPENSE_PROJECTION.[CAPEX 2017-4Q] = IIf(IsNull([CAPEX 2017-10]),0,[CAPEX 2017-10])+IIf(IsNull([CAPEX 2017-11]),0,[CAPEX 2017-11])+IIf(IsNull([CAPEX 2017-12]),0,[CAPEX 2017-12]),
E_EXPENSE_PROJECTION.[CAPEX 2018-1Q] = IIf(IsNull([CAPEX 2018-01]),0,[CAPEX 2018-01])+IIf(IsNull([CAPEX 2018-02]),0,[CAPEX 2018-02])+IIf(IsNull([CAPEX 2018-03]),0,[CAPEX 2018-03]),
E_EXPENSE_PROJECTION.[CAPEX 2018-2Q] = IIf(IsNull([CAPEX 2018-04]),0,[CAPEX 2018-04])+IIf(IsNull([CAPEX 2018-05]),0,[CAPEX 2018-05])+IIf(IsNull([CAPEX 2018-06]),0,[CAPEX 2018-06]),
E_EXPENSE_PROJECTION.[CAPEX 2018-3Q] = IIf(IsNull([CAPEX 2018-07]),0,[CAPEX 2018-07])+IIf(IsNull([CAPEX 2018-08]),0,[CAPEX 2018-08])+IIf(IsNull([CAPEX 2018-09]),0,[CAPEX 2018-09]),
E_EXPENSE_PROJECTION.[CAPEX 2018-4Q] = IIf(IsNull([CAPEX 2018-10]),0,[CAPEX 2018-10])+IIf(IsNull([CAPEX 2018-11]),0,[CAPEX 2018-11])+IIf(IsNull([CAPEX 2018-12]),0,[CAPEX 2018-12]),
E_EXPENSE_PROJECTION.[CAPEX 2019-1Q] = IIf(IsNull([CAPEX 2019-01]),0,[CAPEX 2019-01])+IIf(IsNull([CAPEX 2019-02]),0,[CAPEX 2019-02])+IIf(IsNull([CAPEX 2019-03]),0,[CAPEX 2019-03]),
E_EXPENSE_PROJECTION.[CAPEX 2019-2Q] = IIf(IsNull([CAPEX 2019-04]),0,[CAPEX 2019-04])+IIf(IsNull([CAPEX 2019-05]),0,[CAPEX 2019-05])+IIf(IsNull([CAPEX 2019-06]),0,[CAPEX 2019-06]),
E_EXPENSE_PROJECTION.[CAPEX 2019-3Q] = IIf(IsNull([CAPEX 2019-07]),0,[CAPEX 2019-07])+IIf(IsNull([CAPEX 2019-08]),0,[CAPEX 2019-08])+IIf(IsNull([CAPEX 2019-09]),0,[CAPEX 2019-09]),
E_EXPENSE_PROJECTION.[CAPEX 2019-4Q] = IIf(IsNull([CAPEX 2019-10]),0,[CAPEX 2019-10])+IIf(IsNull([CAPEX 2019-11]),0,[CAPEX 2019-11])+IIf(IsNull([CAPEX 2019-12]),0,[CAPEX 2019-12]);

/****************************************************************
** Insert into export tables - E_EXPENSE_PROJECTION_04_L2ROLLUP *
*****************************************************************/

UPDATE E_EXPENSE_PROJECTION 
SET E_EXPENSE_PROJECTION.[CASH 2017-00] = [CASH 2017-1Q]+[CASH 2017-2Q]+[CASH 2017-3Q]+[CASH 2017-4Q],
E_EXPENSE_PROJECTION.[CASH 2018-00] = [CASH 2018-1Q]+[CASH 2018-2Q]+[CASH 2018-3Q]+[CASH 2018-4Q],
E_EXPENSE_PROJECTION.[CASH 2019-00] = [CASH 2019-1Q]+[CASH 2019-2Q]+[CASH 2019-3Q]+[CASH 2019-4Q],
E_EXPENSE_PROJECTION.[OPEX 2017-00] = [OPEX 2017-1Q]+[OPEX 2017-2Q]+[OPEX 2017-3Q]+[OPEX 2017-4Q],
E_EXPENSE_PROJECTION.[OPEX 2018-00] = [OPEX 2018-1Q]+[OPEX 2018-2Q]+[OPEX 2018-3Q]+[OPEX 2018-4Q],
E_EXPENSE_PROJECTION.[OPEX 2019-00] = [OPEX 2019-1Q]+[OPEX 2019-2Q]+[OPEX 2019-3Q]+[OPEX 2019-4Q],
E_EXPENSE_PROJECTION.[CAPEX 2017-00] = [CAPEX 2017-1Q]+[CAPEX 2017-2Q]+[CAPEX 2017-3Q]+[CAPEX 2017-4Q],
E_EXPENSE_PROJECTION.[CAPEX 2018-00] = [CAPEX 2018-1Q]+[CAPEX 2018-2Q]+[CAPEX 2018-3Q]+[CAPEX 2018-4Q],
E_EXPENSE_PROJECTION.[CAPEX 2019-00] = [CAPEX 2019-1Q]+[CAPEX 2019-2Q]+[CAPEX 2019-3Q]+[CAPEX 2019-4Q];

/****************************************************************
** Insert into export tables - E_EXPENSE_PROJECTION_05_L3ROLLUP *
*****************************************************************/
---------------------------------------- DLM ----------------------------------------
-- -- I want to remove the [Sum Future Cash] calc - would require dynamic variable
-------------------------------------------------------------------------------------

UPDATE E_EXPENSE_PROJECTION 
SET E_EXPENSE_PROJECTION.[CASH ALL] = IIf(IsNull([CASH 2016-00]),0,[CASH 2016-00])+
IIf(IsNull([CASH 2017-00]),0,[CASH 2017-00])+
IIf(IsNull([CASH 2018-00]),0,[CASH 2018-00])+
IIf(IsNull([CASH 2019-00]),0,[CASH 2019-00])+
IIf(IsNull([CASH 2020-00]),0,[CASH 2020-00])+
IIf(IsNull([CASH 2021-00]),0,[CASH 2021-00]),E_EXPENSE_PROJECTION.[OPEX ALL] = IIf(IsNull([OPEX 2016-00]),0,[OPEX 2016-00])+
IIf(IsNull([OPEX 2017-00]),0,[OPEX 2017-00])+
IIf(IsNull([OPEX 2018-00]),0,[OPEX 2018-00])+
IIf(IsNull([OPEX 2019-00]),0,[OPEX 2019-00])+
IIf(IsNull([OPEX 2020-00]),0,[OPEX 2020-00])+
IIf(IsNull([OPEX 2021-00]),0,[OPEX 2021-00]),E_EXPENSE_PROJECTION.[CAPEX ALL] = IIf(IsNull([CAPEX 2016-00]),0,[CAPEX 2016-00])+
IIf(IsNull([CAPEX 2017-00]),0,[CAPEX 2017-00])+
IIf(IsNull([CAPEX 2018-00]),0,[CAPEX 2018-00])+
IIf(IsNull([CAPEX 2019-00]),0,[CAPEX 2019-00])+
IIf(IsNull([CAPEX 2020-00]),0,[CAPEX 2020-00])+
IIf(IsNull([CAPEX 2021-00]),0,[CAPEX 2021-00]),
-- E_EXPENSE_PROJECTION.[Sum Future Cash] = IIf(IsNull([Cash 2017-06]),0,[Cash 2017-06])+
-- IIf(IsNull([Cash 2017-07]),0,[Cash 2017-07])+
-- IIf(IsNull([Cash 2017-08]),0,[Cash 2017-08])+
-- IIf(IsNull([Cash 2017-09]),0,[Cash 2017-09])+
-- IIf(IsNull([Cash 2017-10]),0,[Cash 2017-10])+
-- IIf(IsNull([Cash 2017-11]),0,[Cash 2017-11])+
-- IIf(IsNull([Cash 2017-12]),0,[Cash 2017-12])+
-- IIf(IsNull([Cash 2018-01]),0,[Cash 2018-01])+
-- IIf(IsNull([Cash 2018-02]),0,[Cash 2018-02])+
-- IIf(IsNull([Cash 2018-03]),0,[Cash 2018-03])+
-- IIf(IsNull([Cash 2018-04]),0,[Cash 2018-04])+
-- IIf(IsNull([Cash 2018-05]),0,[Cash 2018-05])+
-- IIf(IsNull([Cash 2018-06]),0,[Cash 2018-06])+
-- IIf(IsNull([Cash 2018-07]),0,[Cash 2018-07])+
-- IIf(IsNull([Cash 2018-08]),0,[Cash 2018-08])+
-- IIf(IsNull([Cash 2018-09]),0,[Cash 2018-09])+
-- IIf(IsNull([Cash 2018-10]),0,[Cash 2018-10])+
-- IIf(IsNull([Cash 2018-11]),0,[Cash 2018-11])+
-- IIf(IsNull([Cash 2018-12]),0,[Cash 2018-12])+
-- IIf(IsNull([Cash 2019-01]),0,[Cash 2019-01])+
-- IIf(IsNull([Cash 2019-02]),0,[Cash 2019-02])+
-- IIf(IsNull([Cash 2019-03]),0,[Cash 2019-03])+
-- IIf(IsNull([Cash 2019-04]),0,[Cash 2019-04])+
-- IIf(IsNull([Cash 2019-05]),0,[Cash 2019-05])+
-- IIf(IsNull([Cash 2019-06]),0,[Cash 2019-06])+
-- IIf(IsNull([Cash 2019-07]),0,[Cash 2019-07])+
-- IIf(IsNull([Cash 2019-08]),0,[Cash 2019-08])+
-- IIf(IsNull([Cash 2019-09]),0,[Cash 2019-09])+
-- IIf(IsNull([Cash 2019-10]),0,[Cash 2019-10])+
-- IIf(IsNull([Cash 2019-11]),0,[Cash 2019-11])+
-- IIf(IsNull([Cash 2019-12]),0,[Cash 2019-12])+
-- IIf(IsNull([Cash 2020-00]),0,[Cash 2020-00])+
-- IIf(IsNull([Cash 2021-00]),0,[Cash 2021-00]);


/****************************************************************
******* Insert into export tables - E_LEVEL_DETAILS_CLEAR *******
*****************************************************************/

---------------------------------------- DLM ----------------------------------------
-- Truncating incorrect table
TRUNCATE TABLE E_LEVEL_DETAILS;
-------------------------------------------------------------------------------------

/****************************************************************
******* Insert into export tables - E_LEVEL_DETAILS_LOAD *******
*****************************************************************/

---------------------------------------- DLM ----------------------------------------
-- Have made updates on our end since sending you the original scripts around the [Work Effort] field and [V_SCOPE] join. Will provide updates.
-------------------------------------------------------------------------------------

INSERT INTO E_LEVEL_DETAILS 
(
	[Work Effort],Workstream,Program,Project,[Project Number],[Project Phase],[Program Lead],[Project Manager],[Program Level Project],[Child Project],
	[PAR Matching],[Total CTA Amount],[Project Lookup],[Project Status],[Project Classification],[Critical Project],[PRA Project],Description,[Cost Center],
	[Nature of Project],[Business PM],[Planned Start],[Planned Release],[Planned End] 
)

SELECT
S.LABEL,SW.LABEL,SP.LABEL,SD.PRJ_NAME,SD.PRJ_NUMBER,SD.PRJ_PHASE,V_SCOPE_WS_PRG.LEADER_NAME
SD.PRJ_MANAGER,IIf([PRG_PROJECT]=True,'Yes','No') AS Expr1,IIf([CHILD_PROJECT]=True,'Yes','No') AS Expr2,SD.FIN_PAR_NUMBER,
SD.FIN_PAR_AMOUNT,SD.LABEL,SD.PRJ_STATUS,SD.PRJ_CATEGORY,SD.PRJ_CRITICAL,
SD.PRJ_PRA,SD.PRJ_DESCRIPTION,SD.FIN_COST_CENTER,SD.BIZ_FUNCTION,SD.BIZ_MANAGER,
SD.PRJ_PLAN_START,SD.PRJ_PLAN_RELEASE,SD.PRJ_PLAN_END
--FROM V_SCOPE S
--INNER JOIN V_SCOPE_WS SW
--INNER JOIN V_SCOPE_WS_PRG SP
--INNER JOIN V_SCOPE_WS_PRG_DWE SD
--	ON V_SCOPE_WS_PRG.[V_SCOPE_WS_PRG_ID] = SD.V_SCOPE_WS_PRG_ID 
--	ON SW.[V_SCOPE_WS_ID] = SP.[V_SCOPE_WS_ID] 
--	ON S.V_SCOPE_ID = V_SCOPE_WS.V_SCOPE_ID;

	FROM V_SCOPE_WS S
	INNER JOIN V_SCOPE_WS_PRG SP
	INNER JOIN V_SCOPE_WS_PRG_DWE SD
		ON V_SCOPE_WS_PRG.[V_SCOPE_WS_PRG_ID] = V_SCOPE_WS_PRG_DWE.V_SCOPE_WS_PRG_ID) 
		ON V_SCOPE_WS.[V_SCOPE_WS_ID] = V_SCOPE_WS_PRG.[V_SCOPE_WS_ID]) 
	INNER JOIN V_SCOPE S
		ON V_SCOPE_WS_PRG_DWE.V_SCOPE_ID = V_SCOPE.V_SCOPE_ID;



/****************************************************************
******* Insert into export tables - E_SCHEDULE_CLEAR *******
*****************************************************************/

TRUNCATE TABLE E_SCHEDULE;

/****************************************************************
******* Insert into export tables - E_SCHEDULE_LOAD *******
*****************************************************************/

INSERT INTO E_SCHEDULE ( [Work Effort],Workstream,Program,Project,TREATMENT,[Phase 2016-00],[Phase 2017-01],[Phase 2017-02],[Phase 2017-03],[Phase 2017-04],[Phase 2017-05],[Phase 2017-06],[Phase 2017-07],[Phase 2017-08],[Phase 2017-09],[Phase 2017-10],[Phase 2017-11],[Phase 2017-12],[Phase 2018-01],[Phase 2018-02],[Phase 2018-03],[Phase 2018-04],[Phase 2018-05],[Phase 2018-06],[Phase 2018-07],[Phase 2018-08],[Phase 2018-09],[Phase 2018-10],[Phase 2018-11],[Phase 2018-12],[Phase 2019-01],[Phase 2019-02],[Phase 2019-03],[Phase 2019-04],[Phase 2019-05],[Phase 2019-06],[Phase 2019-07],[Phase 2019-08],[Phase 2019-09],[Phase 2019-10],[Phase 2019-11],[Phase 2019-12],[Phase 2020-00],[Phase 2021-00] )
SELECT V_SCOPE.LABEL,V_SCOPE_WS.LABEL,V_SCOPE_WS_PRG.LABEL,V_SCOPE_WS_PRG_DWE.LABEL,D_SCHEDULE.TREATMENT,D_SCHEDULE.PHASE_2016_00,D_SCHEDULE.PHASE_2017_01,D_SCHEDULE.PHASE_2017_02,D_SCHEDULE.PHASE_2017_03,D_SCHEDULE.PHASE_2017_04,D_SCHEDULE.PHASE_2017_05,D_SCHEDULE.PHASE_2017_06,D_SCHEDULE.PHASE_2017_07,D_SCHEDULE.PHASE_2017_08,D_SCHEDULE.PHASE_2017_09,D_SCHEDULE.PHASE_2017_10,D_SCHEDULE.PHASE_2017_11,D_SCHEDULE.PHASE_2017_12,D_SCHEDULE.PHASE_2018_01,D_SCHEDULE.PHASE_2018_02,D_SCHEDULE.PHASE_2018_03,D_SCHEDULE.PHASE_2018_04,D_SCHEDULE.PHASE_2018_05,D_SCHEDULE.PHASE_2018_06,D_SCHEDULE.PHASE_2018_07,D_SCHEDULE.PHASE_2018_08,D_SCHEDULE.PHASE_2018_09,D_SCHEDULE.PHASE_2018_10,D_SCHEDULE.PHASE_2018_11,D_SCHEDULE.PHASE_2018_12,D_SCHEDULE.PHASE_2019_01,D_SCHEDULE.PHASE_2019_02,D_SCHEDULE.PHASE_2019_03,D_SCHEDULE.PHASE_2019_04,D_SCHEDULE.PHASE_2019_05,D_SCHEDULE.PHASE_2019_06,D_SCHEDULE.PHASE_2019_07,D_SCHEDULE.PHASE_2019_08,D_SCHEDULE.PHASE_2019_09,D_SCHEDULE.PHASE_2019_10,D_SCHEDULE.PHASE_2019_11,D_SCHEDULE.PHASE_2019_12,D_SCHEDULE.PHASE_2020_00,D_SCHEDULE.PHASE_2021_00
FROM V_SCOPE INNER JOIN (V_SCOPE_WS INNER JOIN (V_SCOPE_WS_PRG INNER JOIN (D_SCHEDULE INNER JOIN V_SCOPE_WS_PRG_DWE ON D_SCHEDULE.[V_SCOPE_WS_PRG_DWE_ID] = V_SCOPE_WS_PRG_DWE.[V_SCOPE_WS_PRG_DWE_ID]) ON V_SCOPE_WS_PRG.[V_SCOPE_WS_PRG_ID] = V_SCOPE_WS_PRG_DWE.V_SCOPE_WS_PRG_ID) ON V_SCOPE_WS.[V_SCOPE_WS_ID] = V_SCOPE_WS_PRG.[V_SCOPE_WS_ID]) ON V_SCOPE.V_SCOPE_ID = V_SCOPE_WS.V_SCOPE_ID;

/****************************************************************
******* Insert into export tables - E_ACTUALS_CLEAR *******
*****************************************************************/

TRUNCATE TABLE E_ACTUALS;

/****************************************************************
********** Insert into export tables - E_ACTUALS_LOAD ***********
*****************************************************************/

INSERT INTO E_ACTUALS ( [Index],[Work Effort],Workstream,Program,Project,[Actuals Type],[Actuals Detail],Vendor,Function,[PO Number],[CASH 2016-00],[CASH 2017-01],[CASH 2017-02],[CASH 2017-03],[CASH 2017-04],[CASH 2017-05],[CASH 2017-06] )
SELECT D_ACTUALS.ACTUALS_ID AS [Index],V_SCOPE.LABEL AS [Work Effort],V_SCOPE_WS.LABEL AS Workstream,V_SCOPE_WS_PRG.LABEL AS Program,V_SCOPE_WS_PRG_DWE.LABEL AS Project,V_EXPENSE_TYPE.TYPE,V_EXPENSE_TYPE.LABEL,V_VENDOR.LABEL,V_FUNCTION.LABEL,D_ACTUALS.PO_NUMBER,Sum(IIf([D_ACTUALS].[POST_DATE]>=#1/1/2016# And [D_ACTUALS].[POST_DATE]<=#12/31/2016#,[D_ACTUALS].[POST_AMOUNT])) AS [CASH 2016-00],Sum(IIf([D_ACTUALS].[POST_DATE]>=#1/1/2017# And [D_ACTUALS].[POST_DATE]<=#1/31/2017#,[D_ACTUALS].[POST_AMOUNT])) AS [CASH 2017-01],Sum(IIf([D_ACTUALS].POST_DATE>=#2/1/2017# And [D_ACTUALS].POST_DATE<=#2/28/2017#,[D_ACTUALS].POST_AMOUNT)) AS [CASH 2017-02],Sum(IIf([D_ACTUALS].POST_DATE>=#3/1/2017# And [D_ACTUALS].POST_DATE<=#3/31/2017#,[D_ACTUALS].POST_AMOUNT)) AS [CASH 2017-03],Sum(IIf([D_ACTUALS].[POST_DATE]>=#4/1/2017# And [D_ACTUALS].[POST_DATE]<=#4/30/2017#,[D_ACTUALS].[POST_AMOUNT])) AS [CASH 2017-04],Sum(IIf([D_ACTUALS].[POST_DATE]>=#5/1/2017# And [D_ACTUALS].[POST_DATE]<=#5/31/2017#,[D_ACTUALS].[POST_AMOUNT])) AS [CASH 2017-05],Sum(IIf([D_ACTUALS].[POST_DATE]>=#6/1/2017# And [D_ACTUALS].[POST_DATE]<=#6/30/2017#,[D_ACTUALS].[POST_AMOUNT])) AS [CASH 2017-06]
FROM V_SCOPE INNER JOIN ((V_SCOPE_WS INNER JOIN (V_SCOPE_WS_PRG INNER JOIN (((D_ACTUALS INNER JOIN V_EXPENSE_TYPE ON D_ACTUALS.ACTUALS_TYPE = V_EXPENSE_TYPE.V_EXPENSE_TYPE_ID) LEFT JOIN V_VENDOR ON D_ACTUALS.V_VENDOR_ID = V_VENDOR.V_VENDOR_ID) INNER JOIN (V_SCOPE_WS_PRG_DWE INNER JOIN T_SAP_PRJ_NUMBER ON V_SCOPE_WS_PRG_DWE.V_SCOPE_WS_PRG_DWE_ID = T_SAP_PRJ_NUMBER.V_SCOPE_WS_PRG_DWE_ID) ON D_ACTUALS.SAP_NUMBER = T_SAP_PRJ_NUMBER.SAP_PRJ_NUMBER) ON V_SCOPE_WS_PRG.[V_SCOPE_WS_PRG_ID] = V_SCOPE_WS_PRG_DWE.V_SCOPE_WS_PRG_ID) ON V_SCOPE_WS.[V_SCOPE_WS_ID] = V_SCOPE_WS_PRG.[V_SCOPE_WS_ID]) INNER JOIN V_FUNCTION ON T_SAP_PRJ_NUMBER.V_FUNCTION_ID = V_FUNCTION.V_FUNCTION_ID) ON V_SCOPE.V_SCOPE_ID = V_SCOPE_WS.V_SCOPE_ID
GROUP BY D_ACTUALS.ACTUALS_ID,V_SCOPE.LABEL,V_SCOPE_WS.LABEL,V_SCOPE_WS_PRG.LABEL,V_SCOPE_WS_PRG_DWE.LABEL,V_EXPENSE_TYPE.TYPE,V_EXPENSE_TYPE.LABEL,V_VENDOR.LABEL,V_FUNCTION.LABEL,D_ACTUALS.PO_NUMBER;