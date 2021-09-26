
CREATE TABLE [Subjects](
	[SubjectID] INT PRIMARY KEY NOT NULL,
	[SubjectName] VARCHAR(50),
)
CREATE TABLE [Mojors](
	[MajorID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
)

CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY NOT NULL,
	[StudentNumber] INT NOT NULL,
	[StudentName] VARCHAR(50) NOT NULL,
	[MajorID] INT FOREIGN KEY REFERENCES Mojors([MajorID]),
)

CREATE TABLE [Payments](
	[PaymentID] INT PRIMARY KEY NOT NULL,
	[PaymentDate] DATE NOT NULL,
	[PaymentAmmount] DECIMAL NOT NULL,
	[StudentID] INT FOREIGN KEY REFERENCES Students([StudentID]),
)

CREATE TABLE [Agenda](
	[SubjectID] INT,
	[StudentID] INT,
	CONSTRAINT PK_SubjectID_StudentID PRIMARY KEY([SubjectID], [StudentID]),
	CONSTRAINT FK_SubjectID FOREIGN KEY([SubjectID]) REFERENCES Subjects([SubjectID]),
	CONSTRAINT FK_StudentID FOREIGN KEY([StudentID]) REFERENCES Students([StudentID])
)
