(deffacts InitialSituation
	(ScholarshipsTotalSum 1000)

	(Student
        (ID 1S)
		(Name P Q)
		(Group 1401B)
		(DisciplineNames DSP ROB MAN)
		(NoAbsLab 0 1 0)
		(NoAbsProj -1 1 2)
		(ExamGrades 10.0 10.0 10.0)
		(LabGrades 10.0 10.0 10.0)
		(ProjGrades -1.0 9.0 10.0)
		(FinalGrades -1.0 -1.0 -1.0)
		(NoDisciplinesFailed 0)
		(AverageFinalGrades 0.0)
		(OptionsGuidingProf 1P 2P 3P)
	)
    
    (Student
        (ID 2S)
		(Name L B)
		(Group 1401B)
		(DisciplineNames DSP ROB MAN)
		(NoAbsLab 0 0 0)
		(NoAbsProj -1 0 0)
		(ExamGrades 6.0 6.0 6.0)
		(LabGrades 6.0 6.0 6.0)
		(ProjGrades -1.0 9.0 10.0)
		(FinalGrades -1.0 -1.0 -1.0)
		(NoDisciplinesFailed 0)
		(AverageFinalGrades 0.0)
		(OptionsGuidingProf 1P 2P 3P)
	)
    
    (Student
        (ID 3S)
		(Name Y D)
		(Group 1401B)
		(DisciplineNames DSP ROB MAN)
		(NoAbsLab 0 1 2)
		(NoAbsProj -1 1 2)
		(ExamGrades 5.0 5.0 5.0)
		(LabGrades 6.0 10.0 10.0)
		(ProjGrades -1.0 10.0 3.0)
		(FinalGrades -1.0 -1.0 -1.0)
		(NoDisciplinesFailed 0)
		(AverageFinalGrades 0.0)
		(OptionsGuidingProf 1P 2P 3P)
	)
    
    (Student
        (ID 4S)
		(Name A B)
		(Group 1401B)
		(DisciplineNames DSP ROB MAN)
		(NoAbsLab 0 3 3)
		(NoAbsProj -1 1 1)
		(ExamGrades 6.0 9.0 6.0)
		(LabGrades 8.0 9.0 10.0)
		(ProjGrades -1.0 9.0 10.0)
		(FinalGrades -1.0 -1.0 -1.0)
		(NoDisciplinesFailed 0)
		(AverageFinalGrades 0.0)
		(OptionsGuidingProf 1P 2P 3P)
	)
	
	(Professor
		(ID 1P)
		(Name K W)
		(NoMaxGuidingPositions 0)
		(PrefferedExamDates 2 4 6)
		(OccupiedPrefferedExamDates no no no)
		(Disciplines DSP MAN)
	)
	
	(Professor
		(ID 2P)
		(Name R N)
		(NoMaxGuidingPositions 1)
		(PrefferedExamDates 2 5 9)
		(OccupiedPrefferedExamDates no no no)
		(Disciplines ROB)
	)
	
	(Professor
		(ID 3P)
		(Name F U)
		(NoMaxGuidingPositions 2)
		(PrefferedExamDates 6 8 10)
		(OccupiedPrefferedExamDates no no no)
	)
	
	(Discipline
		(Name DSP)
		(ExamGradeWeight 60)
		(LabGradeWeight 40)
		(ProjGradeWeight 0)
	)
	
	(Discipline
		(Name ROB)
		(ExamGradeWeight 50)
		(LabGradeWeight 30)
		(ProjGradeWeight 20)
	)
	
	(Discipline
		(Name MAN)
		(ExamGradeWeight 50)
		(LabGradeWeight 40)
		(ProjGradeWeight 10)
	)
    
    (OrderedStudentsList)
    
    (Scholarship
        (Name Meritorious)
        (MaxNumber 5)
        (Ratio 50)
    )
	
	(Scholarship
        (Name Integral)
        (MaxNumber 1)
        (Ratio 30)
    )
	
	(Scholarship
        (Name Partial)
        (MaxNumber 3)
        (Ratio 20)
    )
	
	(Group
		(Name 1401B)
		(Disciplines DSP ROB MAN)
		(ExamDatesOptions 2 6 2 10 4 10)
		(ExamDates 0 0 0)
	)
)