
USE master;
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'OLIT')
BEGIN
    ALTER DATABASE OLIT SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE OLIT;
END
GO

CREATE DATABASE OLIT
GO

USE OLIT
GO

CREATE TABLE Role (
    RoleID INT PRIMARY KEY,
    RoleName NVARCHAR(10) CHECK (RoleName IN ('Admin', 'Expert', 'Student')) DEFAULT 'Other'
);

CREATE TABLE Account (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    RoleID INT FOREIGN KEY REFERENCES Role(RoleID),
    FullName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')) DEFAULT 'Other',
    Email NVARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20),
    Password NVARCHAR(255) NOT NULL,
    URLAvatar NVARCHAR(255),
    Status NVARCHAR(20) NOT NULL CHECK (Status IN ('active', 'warning', 'banned')) DEFAULT 'active',
    Address NVARCHAR(200),
    Birthday DATE
);

CREATE TABLE Setting (
    SettingID INT PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Account(UserID),
    SettingType NVARCHAR(50),
    SettingValue NVARCHAR(MAX),
    SettingOrder INT,
    SettingDecription NVARCHAR(255),
    SettingStatus BIT NOT NULL DEFAULT 0
);

CREATE TABLE PostCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    URL NVARCHAR(255)
);

CREATE TABLE Post (
    PostID INT PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Account(UserID),
    CategoryID INT FOREIGN KEY REFERENCES PostCategory(CategoryID),
    BlogTitle NVARCHAR(255) NOT NULL,
    PostDetails NVARCHAR(MAX),
    Status BIT NOT NULL DEFAULT 0,
    UpdatedDate DATETIME,
    ThumbnailURL NVARCHAR(255),
	IsHot         BIT           NOT NULL DEFAULT 0
);

CREATE TABLE Subject (
    SubjectID INT IDENTITY(1,1) PRIMARY KEY,
    SubjectName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50), -- Chỉ là text, không khóa ngoại
    OwnerID INT FOREIGN KEY REFERENCES Account(UserID),
	FeaturedFlag BIT NOT NULL DEFAULT(0),
    Status BIT NOT NULL DEFAULT 0,
    Description NVARCHAR(MAX)
);

CREATE TABLE Dimension (
    DimensionID INT PRIMARY KEY,
    SubjectID INT FOREIGN KEY REFERENCES Subject(SubjectID),
    DimensionName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(255)
);

CREATE TABLE ExpertSubject (
    ExpertID INT FOREIGN KEY REFERENCES Account(UserID),
    SubjectID INT FOREIGN KEY REFERENCES Subject(SubjectID),
    PRIMARY KEY (ExpertID, SubjectID)
);

CREATE TABLE SubjectMedia (
    MediaID INT IDENTITY(1,1) NOT NULL PRIMARY KEY ,
    SubjectID INT FOREIGN KEY REFERENCES Subject(SubjectID),
    MediaURL NVARCHAR(255) NOT NULL,
    MediaType NVARCHAR(10) CHECK (MediaType IN ('image', 'video')),
    MediaName NVARCHAR(255)
);


CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    SubjectID INT FOREIGN KEY REFERENCES Subject(SubjectID),
    CourseTitle NVARCHAR(255) NOT NULL,
    CourseTag NVARCHAR(100),
    URLCourse NVARCHAR(255),
    CourseDetail NVARCHAR(MAX),
    CourseLevel NVARCHAR(50),
    FeatureFlag NVARCHAR(50),
    Status BIT NOT NULL DEFAULT 0,
    CourseraDuration INT,
);

CREATE TABLE CourseMedia (
    MediaID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT FOREIGN KEY REFERENCES Course(CourseID),
    MediaURL NVARCHAR(255) NOT NULL,
    MediaType NVARCHAR(10) CHECK (MediaType IN ('image', 'video')),
);

CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Account(UserID),
    CourseID INT FOREIGN KEY REFERENCES Course(CourseID),
    Content NVARCHAR(MAX),
    Star INT CHECK (Star BETWEEN 1 AND 5),
    CreatedAt DATETIME DEFAULT GETDATE(),
    Status BIT NOT NULL DEFAULT 1, -- 1: Hiển thị, 0: Ẩn
	ImageURL NVARCHAR(255) NULL
);

CREATE TABLE CourseSection (
    SectionID INT PRIMARY KEY,
    CourseID INT FOREIGN KEY REFERENCES Course(CourseID),
    SectionTitle NVARCHAR(255) NOT NULL
);

CREATE TABLE SectionModule (
    ModuleID INT PRIMARY KEY,
    SectionID INT FOREIGN KEY REFERENCES CourseSection(SectionID),
    ModuleTitle NVARCHAR(255) NOT NULL
);

CREATE TABLE PricePackage (
    PackageID INT PRIMARY KEY,
    CourseID INT FOREIGN KEY REFERENCES Course(CourseID),
    Name NVARCHAR(100) NOT NULL,
    AccessDuration INT,
    ListPrice DECIMAL(18,2),
    SalePrice DECIMAL(18,2),
    Status BIT NOT NULL DEFAULT 0,
    Description NVARCHAR(MAX)
);

CREATE TABLE Registration (
    RegistrationID INT PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Account(UserID),
    CourseID INT FOREIGN KEY REFERENCES Course(CourseID),
    PackageID INT FOREIGN KEY REFERENCES PricePackage(PackageID),
    ApprovedBy INT FOREIGN KEY REFERENCES Account(UserID),
    Status NVARCHAR(20) NOT NULL CHECK (Status IN ('Pending', 'Approved', 'NotApproved')) DEFAULT 'Pending',
    ValidTo DATE,
    ValidFrom DATE
);

CREATE TABLE Lesson (
    LessonID INT PRIMARY KEY,
    ModuleID INT FOREIGN KEY REFERENCES SectionModule(ModuleID),
    LessonTitle NVARCHAR(255) NOT NULL,
    LessonDetails NVARCHAR(MAX),
    Status BIT NOT NULL DEFAULT 0,
    URLLesson NVARCHAR(255) NOT NULL,
    [Order] INT
);

CREATE TABLE LessonProgress (        -- 1 user 1 lesson 1 dòng
    UserID     INT      NOT NULL,
    LessonID   INT      NOT NULL,
    Completed  BIT      NOT NULL DEFAULT 0,
    CompletedAt DATETIME NULL,
    CONSTRAINT PK_LessonProgress PRIMARY KEY (UserID, LessonID),
    CONSTRAINT FK_LP_User   FOREIGN KEY (UserID)  REFERENCES Account(UserID),
    CONSTRAINT FK_LP_Lesson FOREIGN KEY (LessonID)REFERENCES Lesson(LessonID)
);

CREATE TABLE Quiz (
    QuizID INT PRIMARY KEY,
    SectionID INT FOREIGN KEY REFERENCES CourseSection(SectionID),
    QuizName NVARCHAR(100) NOT NULL,
    PassRate DECIMAL(5,2),
    QuizType NVARCHAR(50),
    QuizDuration INT,
    QuizLevel NVARCHAR(50),
    Status BIT NOT NULL DEFAULT 0
);

CREATE TABLE QuizAttempt (
    AttemptID INT PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Account(UserID),
    QuizID INT FOREIGN KEY REFERENCES Quiz(QuizID),
    StartTime DATETIME,
    EndTime DATETIME,
    TotalScore DECIMAL(5,2)
);

CREATE TABLE Question (
    QuestionID INT IDENTITY(1,1) PRIMARY KEY,
    QuestionContent NVARCHAR(MAX) NOT NULL,
    QuestionType INT NOT NULL,
    Status BIT NOT NULL DEFAULT 0,
    QuestionLevel INT NOT NULL,
	CreatedBy INT FOREIGN KEY REFERENCES Account(UserID) NOT NULL,
	CreatedAt DATETIME DEFAULT GETDATE() NOT NULL,
	SubjectID INT FOREIGN KEY REFERENCES Subject(SubjectID) NOT NULL,
    LessonID INT FOREIGN KEY REFERENCES Lesson(LessonID) NOT NULL
);

CREATE TABLE QuestionDimension (
    QuestionID INT FOREIGN KEY REFERENCES Question(QuestionID) ON DELETE CASCADE,
    DimensionID INT FOREIGN KEY REFERENCES Dimension(DimensionID) ON DELETE CASCADE,
    PRIMARY KEY (QuestionID, DimensionID)
);


CREATE TABLE QuestionAnswer (
	AnswerID INT IDENTITY(1,1) PRIMARY KEY,
	AnswerDetail NVARCHAR(MAX) NOT NULL,
	Explanation NVARCHAR(MAX) NOT NULL,
	IsCorrect BIT NOT NULL DEFAULT 0,
	QuestionID INT NOT NULL,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE
);

CREATE TABLE QuestionMedia (
    MediaID INT IDENTITY(1,1) PRIMARY KEY,
    MediaURL NVARCHAR(255) NOT NULL,
	MediaType INT NOT NULL,
    MediaDescription NVARCHAR(255) NOT NULL,
    QuestionID INT NOT NULL,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE
);

CREATE TABLE QuizQuestion (
    QuizQuestionID INT PRIMARY KEY,
    QuizID INT FOREIGN KEY REFERENCES Quiz(QuizID),
    QuestionID INT FOREIGN KEY REFERENCES Question(QuestionID),
    QuestionOrder INT,
    Points DECIMAL(5,2) DEFAULT 1.0
);

CREATE TABLE UserAnswer (
    UserAnswerID INT PRIMARY KEY,
    QuestionID INT FOREIGN KEY REFERENCES Question(QuestionID),
    AttemptID INT FOREIGN KEY REFERENCES QuizAttempt(AttemptID),
    UserAnswerContent NVARCHAR(MAX),
    IsCorrect BIT NOT NULL DEFAULT 0
);

CREATE TABLE Slider (
    SliderID INT PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Account(UserID),
    CourseID INT FOREIGN KEY REFERENCES Course(CourseID),
    Title NVARCHAR(255) NOT NULL,
    ImageURL NVARCHAR(255),
    Backlink NVARCHAR(255),
    Status BIT NOT NULL DEFAULT 0,
    Notes NVARCHAR(MAX),
    DisplayOrder INT,
    ValidFrom DATE
);
ALTER TABLE Registration
DROP CONSTRAINT CK__Registrat__Statu__787EE5A0;
GO
ALTER TABLE Registration
ADD CONSTRAINT CK_Registration_Status
CHECK (Status IN ('Pending', 'Approved', 'NotApproved', 'Paid'));