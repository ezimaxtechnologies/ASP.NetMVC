-- =============================================      

-- Author:  <Author,,Name>      

-- Create date: <Create Date,,>      

-- Description: <Description,,>      

-- =============================================      



Alter PROCEDURE [dbo].[spGetTeacherImpactSummary]      

	@teacherId int,      

	@schoolId int,      

	@schoolYearId int,

	@ClassId INT      

AS      

BEGIN      

	

	DECLARE @districtId INT      

	

	-- Use Table Variable for class filter    

	DECLARE @tblTempClassID table  

	(  

		ID INT IDENTITY(1,1),  

		ClassId INT  

	)     

      

	IF (@ClassId = -1)   

	BEGIN       

		INSERT INTO @tblTempClassID(ClassID)       

		SELECT tc1.ClassId      

		FROM tblClassTeacher tc1      

		WHERE tc1.UserId = @teacherId

	END      

	ELSE      

	BEGIN        

		 INSERT INTO @tblTempClassID(ClassID)      

		 SELECT @ClassId    

	END 

 

	SET @districtId = (SELECT districtId FROM tblSchool WHERE SchoolId = @SchoolId)      

    SELECT 

		base.Grade

		,base.AssessmentType

		,base.ClassSubject

		,base.AssessmentTypeId

		,agw.Weighting

		,base.Impact

		,base.SubjectId
		
		,base.NoOfStudent       

	FROM      

		(SELECT 

			s.DistrictId

			,a.SchoolYearId

			,sc.GradeLevel AS Grade

			,a.SubjectId

			,a.AssessmentTypeId

			,at.AssessmentTypeDesc AS AssessmentType

			,sub.SubjectDesc AS ClassSubject

			,SUM(ISNULL(sc.ScaledScoreProjDif,0)) AS Impact   
			
			,COUNT(cs2.StudentId) AS NoOfStudent   

		FROM tblAssessment a      

		JOIN tblAssessmentScore sc ON sc.AssessmentId = a.AssessmentId     

		-- and sc.SchoolID = @schoolId  --Code Uncommented for US 73    

		JOIN tblSubject sub ON a.SubjectId = sub.SubjectId      

		JOIN tblAssessmentType at ON at.AssessmentTypeId = a.AssessmentTypeId      

		JOIN tblschool s ON s.SchoolId = sc.SchoolID      

		JOIN  (	SELECT DISTINCT --Apply distinct keyword for US 108

					cs1.StudentId

					--,c.Grade --Code commented for US 108

					,c.SubjectId       

				FROM tblClassStudent cs1      

				JOIN tblClass c ON c.ClassId = cs1.ClassId      

				WHERE cs1.ClassId IN ( SELECT ClassID FROM  @tblTempClassID)      

				AND c.SchoolYearId =  @schoolYearId      

				) AS cs2 

				ON cs2.StudentId = sc.StudentId       

		-- and cs2.Grade = sc.GradeLevel   --Code Uncommented for US 73    

		AND cs2.SubjectId = a.SubjectId      

		WHERE a.AssessmentId IN (SELECT AssessmentId FROM [dbo].[udfDistrictsLastAssessmentsTable](@districtId, @schoolYearId ))      

		GROUP BY s.DistrictId, a.SchoolYearId, sc.GradeLevel, a.SubjectId, a.AssessmentTypeId, at.AssessmentTypeDesc, sub.SubjectDesc

		) AS base      

	JOIN tblAssessmentWeighting aw ON aw.DistrictId = base.DistrictId AND aw.SchoolYearId = base.SchoolYearId 

	AND aw.AssessmentTypeId = base.AssessmentTypeId AND aw.SubjectId = base.SubjectId      

	JOIN tblAssessmentGradeWeighting agw ON agw.AssessmentWeightingId = aw.AssessmentWeightingId AND base.Grade = agw.Grade  

	ORDER BY base.Grade, aw.subjectId, agw.Weighting DESC   
END 