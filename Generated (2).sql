/*
Created: 04/09/2023
Modified: 20/09/2023
Model: Asset Physical model
Database: MS SQL Azure
*/


-- Create tables section -------------------------------------------------

-- Table Asset_Location

CREATE TABLE [Asset_Location]
(
 [Location_ID] Bigint NOT NULL,
 [Location_Code] Varchar(50) NOT NULL,
 [Location_Short_Description] Varchar(100) NULL,
 [Location_Description] Varchar(4000) NULL,
 [FK_Location_ID] Bigint NOT NULL,
 [Location_Type_ID] Bigint NULL,
 [Location_Name] Varchar(50) NULL,
 [Location_Priority] Bigint NULL,
 [Failure_Class] Varchar(50) NULL,
 [Status] Varchar(50) NULL,
 [Impact_Classification] Varchar(50) NULL,
 [Process_Code] Varchar(50) NULL,
 [Job_Plan_Code] Varchar(50) NULL,
 [Production_Related_Work] Bit NULL,
 [Quality_Classification] Varchar(50) NULL,
 [Environmental_Classification] Varchar(50) NULL,
 [Safety_Classification] Varchar(50) NULL,
 [Maintenance_Plan_Code] Varchar(30) NULL,
 [Maintenance_Plan_Description] Varchar(100) NULL,
 [Maintenance_Plan_Frequency] Bigint NULL,
 [Maintenance_Plan_Frequency_UOM] Varchar(30) NULL,
 [Maintenance_Plan_Window_Duration] Bigint NULL,
 [Organization_ID] Bigint NULL
)
go

-- Create indexes for table Asset_Location

CREATE INDEX [IX_Hierarchy - Parent Location] ON [Asset_Location] ([FK_Location_ID])
go

CREATE INDEX [IX_Relationship2] ON [Asset_Location] ([Organization_ID])
go

-- Add keys for table Asset_Location

ALTER TABLE [Asset_Location] ADD CONSTRAINT [Location_ID] PRIMARY KEY ([Location_ID])
go

-- Table Asset_Asset

CREATE TABLE [Asset_Asset]
(
 [Asset_ID] Bigint NOT NULL,
 [Asset_number] Varchar(50) NOT NULL,
 [Asset_Short_Description] Varchar(100) NULL,
 [Asset_Description] Text NULL,
 [Installaton_date] Date NULL,
 [Status] Varchar(30) NULL,
 [Status_Date] Date NULL,
 [Manufacturer_Model_Number] Varchar(100) NULL,
 [Serial_Number] Varchar(50) NULL,
 [Units_Operation_Range] Varchar(30) NULL,
 [Min_Operating_Range] Varchar(30) NULL,
 [Max_Operating_Range] Bigint NULL,
 [Failure_Code] Varchar(50) NULL,
 [Budget] Bigint NULL,
 [Replacement_Cost] Bigint NULL,
 [Financial_Asset] Varchar(30) NULL,
 [Calibrated_In_House] Bit NULL,
 [M&TE] Bit NULL,
 [M&TE_Tool_Classification] Varchar(50) NULL,
 [M&TE_Tool_Model_Number] Varchar(50) NULL,
 [Tag_Name] Varchar(50) NULL,
 [Tag_Prefix] Varchar(30) NULL,
 [Tag_Suffix] Varchar(30) NULL,
 [Location_ID] Bigint NOT NULL,
 [FK_Asset_ID] Bigint NULL,
 [Organization_ID] Bigint NOT NULL
)
go

-- Create indexes for table Asset_Asset

CREATE INDEX [IX_Asset_Belongs_To_Location] ON [Asset_Asset] ([Location_ID])
go

CREATE INDEX [IX_Ancestor] ON [Asset_Asset] ([FK_Asset_ID])
go

CREATE INDEX [IX_Asset_Belongs_To_Organization] ON [Asset_Asset] ([Organization_ID])
go

-- Add keys for table Asset_Asset

ALTER TABLE [Asset_Asset] ADD CONSTRAINT [Asset_ID] PRIMARY KEY ([Asset_ID])
go

ALTER TABLE [Asset_Asset] ADD CONSTRAINT [Asset_Number] UNIQUE CLUSTERED ([Asset_number])
go

-- Table Asset_Work_Order

CREATE TABLE [Asset_Work_Order]
(
 [Work_Order_ID] Bigint NOT NULL,
 [Work_Order_Number] Varchar(50) NOT NULL,
 [Short_Description] Varchar(100) NULL,
 [Description] Varchar(4000) NULL,
 [Status] Varchar(50) NULL,
 [Status_Date] Datetime NULL,
 [Priority] Varchar(30) NULL,
 [Target_Start] Datetime NULL,
 [Actual_Start] Datetime NULL,
 [Actual_Finish] Datetime NULL,
 [Duration] Bigint NULL,
 [Work_Type] Varchar(30) NULL,
 [Crew] Varchar(50) NULL,
 [Location_ID] Bigint NULL,
 [Asset_ID] Bigint NULL,
 [Job_Plan_ID] Bigint NOT NULL,
 [Job_Plan_Short_Description] Varchar(100) NULL,
 [FK_Work_Order_ID] Bigint NULL,
 [Lead_ID] Varchar(30) NULL,
 [Lead_Name] Varchar(100) NULL,
 [Owner_ID] Varchar(30) NULL,
 [Owner_Name] Varchar(100) NULL,
 [Supervisor_ID] Varchar(30) NULL,
 [Supervisor_Name] Varchar(100) NULL
)
go

-- Create indexes for table Asset_Work_Order

CREATE INDEX [IX_Executed_In] ON [Asset_Work_Order] ([Location_ID])
go

CREATE INDEX [IX_Executed_For] ON [Asset_Work_Order] ([Asset_ID])
go

CREATE INDEX [IX_Originating Record] ON [Asset_Work_Order] ([FK_Work_Order_ID])
go

-- Add keys for table Asset_Work_Order

ALTER TABLE [Asset_Work_Order] ADD CONSTRAINT [Work_Order_ID] PRIMARY KEY ([Work_Order_ID])
go

ALTER TABLE [Asset_Work_Order] ADD CONSTRAINT [Work_Order_Number] UNIQUE CLUSTERED ([Work_Order_Number])
go

-- Table Asset_Document

CREATE TABLE [Asset_Document]
(
 [Document_ID] Bigint NOT NULL,
 [Document_Number] Bigint NULL,
 [Document_Name] Varchar(200) NULL,
 [FileName] Varchar(250) NULL,
 [Revision_Number] Varchar(30) NULL,
 [Latest_Revision] Bit NULL,
 [Organization_ID] Bigint NULL,
 [Building?] Bigint NULL,
 [Enterprise_Group] Varchar(50) NULL,
 [Intention] Varchar(200) NULL,
 [DocumentType] Varchar(50) NULL,
 [Document_Designator] Varchar(100) NULL,
 [Emission_Type] Varchar(50) NULL,
 [Title] Varchar(250) NULL,
 [Discipline] Varchar(100) NULL,
 [Discipline_Description] Varchar(250) NULL,
 [Sub_Discipline] Varchar(100) NULL,
 [Sub_Discipline_Description] Varchar(250) NULL,
 [Discipline_Designator] Varchar(100) NULL,
 [NonCritical] Bit NULL,
 [Critical_Business] Bit NULL,
 [Critical_Quality] Bit NULL,
 [Critical_HSE] Bit NULL,
 [Project_Name] Varchar(100) NULL,
 [System] Varchar(100) NULL,
 [System_Description] Varchar(250) NULL,
 [System_Type] Varchar(50) NULL,
 [Equipment_Classification] Varchar(50) NULL,
 [Equipment_Type] Varchar(50) NULL,
 [Equipment_Model_Number] Varchar(50) NULL,
 [Equipment_Number] Varchar(50) NULL,
 [Equipment_Producer] Varchar(50) NULL,
 [Equipment_Vendor] Varchar(50) NULL,
 [Equipment_Vendor_Document_ID] Bigint NULL,
 [Equipment_Vendor_Document_Revision] Varchar(30) NULL,
 [Equipment_Vendor_Document_Revision_Date] Date NULL,
 [Equipment_Vendor_Document_Type] Varchar(30) NULL,
 [URL] Varchar(250) NULL,
 [Attribute40] Bigint NULL,
 [Location_ID] Bigint NULL,
 [Asset_ID] Bigint NULL
)
go

-- Create indexes for table Asset_Document

CREATE INDEX [IX_Document_Is_Associated_With_Location] ON [Asset_Document] ([Location_ID])
go

CREATE INDEX [IX_Document_Is_About_Asset] ON [Asset_Document] ([Asset_ID])
go

-- Add keys for table Asset_Document

ALTER TABLE [Asset_Document] ADD CONSTRAINT [Document_ID] PRIMARY KEY ([Document_ID])
go

-- Table Asset_Alarm

CREATE TABLE [Asset_Alarm]
(
 [Alarm_Number] Varchar(30) NOT NULL,
 [Alarrm_Category] Varchar(30) NULL,
 [Type of Alarm] Varchar(30) NULL,
 [Area] Varchar(50) NULL,
 [Unit_Operation] Varchar(50) NULL,
 [Device_Tag] Varchar(50) NULL,
 [Description] Varchar(250) NULL,
 [Alarm_Value] Varchar(50) NULL,
 [Acknowledge_Status] Varchar(30) NULL,
 [Asset_ID] Bigint NOT NULL
)
go

-- Create indexes for table Asset_Alarm

CREATE INDEX [IX_Happens_In] ON [Asset_Alarm] ([Asset_ID])
go

-- Add keys for table Asset_Alarm

ALTER TABLE [Asset_Alarm] ADD CONSTRAINT [Alarm_Number] PRIMARY KEY ([Alarm_Number])
go

-- Table Asset_Job_Plan

CREATE TABLE [Asset_Job_Plan]
(
 [Job_Plan_ID] Bigint NOT NULL,
 [Short_Description] Varchar(100) NULL
)
go

-- Add keys for table Asset_Job_Plan

ALTER TABLE [Asset_Job_Plan] ADD CONSTRAINT [Job_Plan_ID] PRIMARY KEY ([Job_Plan_ID])
go

-- Table Asset_Task

CREATE TABLE [Asset_Task]
(
 [Sequence] Bigint NOT NULL,
 [Task_ID] Bigint NULL,
 [Task_Short_Description] Varchar(100) NULL,
 [Estimated Duration] Bigint NULL,
 [Status] Varchar(30) NULL,
 [Work_Order_ID] Bigint NOT NULL
)
go

-- Add keys for table Asset_Task

ALTER TABLE [Asset_Task] ADD CONSTRAINT [Sequence] PRIMARY KEY ([Sequence],[Work_Order_ID])
go

-- Table Asset_Organization

CREATE TABLE [Asset_Organization]
(
 [Organization_ID] Bigint NOT NULL,
 [Organization_Name] Varchar(100) NULL,
 [FK_Organization_ID] Bigint NULL
)
go

-- Create indexes for table Asset_Organization

CREATE INDEX [IX_Parent_Organization] ON [Asset_Organization] ([FK_Organization_ID])
go

-- Add keys for table Asset_Organization

ALTER TABLE [Asset_Organization] ADD CONSTRAINT [Organization_ID] PRIMARY KEY ([Organization_ID])
go

-- Table Asset_Failure_Code

CREATE TABLE [Asset_Failure_Code]
(
 [Failure_Code_ID] Bigint NOT NULL,
 [Failure_Code] Varchar(30) NULL,
 [Failure_Code_Description] Varchar(400) NULL,
 [Failure_Class] Varchar(100) NULL
)
go

-- Add keys for table Asset_Failure_Code

ALTER TABLE [Asset_Failure_Code] ADD CONSTRAINT [Failure_Code_ID] PRIMARY KEY ([Failure_Code_ID])
go

-- Table Asset_Asset_Asset_Failure_Code

CREATE TABLE [Asset_Asset_Asset_Failure_Code]
(
 [Asset_ID] Bigint NOT NULL,
 [Failure_Code_ID] Bigint NOT NULL
)
go

-- Table Asset_QMS_Change

CREATE TABLE [Asset_QMS_Change]
(
 [Change_Number] Varchar(30) NOT NULL,
 [Quality_Level] Varchar(30) NULL,
 [Change_Short_Description] Varchar(100) NULL,
 [Change_Description] Text NULL,
 [Primary_Business_Driver] Varchar(100) NULL,
 [Quality_Impacts] Varchar(400) NULL,
 [Regulatory_Review_Required] Bit NULL,
 [Regulatory_Review_Result] Varchar(400) NULL,
 [Regulatory_Commitment] Bit NULL,
 [QMS_Status] Varchar(100) NULL,
 [Date_Approved] Date NULL,
 [Actual_Effective_Date] Date NULL,
 [Target_Due_Date] Date NULL,
 [Criteria_For_Success] Text NULL,
 [Change_evaluation] Text NULL,
 [Evaluation_Result] Varchar(100) NULL,
 [Asset_ID] Bigint NOT NULL
)
go

-- Create indexes for table Asset_QMS_Change

CREATE INDEX [IX_Change_Belongs_to_Asset] ON [Asset_QMS_Change] ([Asset_ID])
go

-- Add keys for table Asset_QMS_Change

ALTER TABLE [Asset_QMS_Change] ADD CONSTRAINT [Change_Number] PRIMARY KEY ([Change_Number])
go

-- Table Asset_QMS_Deviation

CREATE TABLE [Asset_QMS_Deviation]
(
 [Deviation_Number] Varchar(50) NOT NULL,
 [Quality_Level] Varchar(30) NULL,
 [Date_Approved] Date NULL,
 [QMS_Deviation_Type] Varchar(50) NULL,
 [Event_Title] Varchar(200) NULL,
 [Deviation_Description] Text NULL,
 [Root_Cause_Description] Text NULL,
 [Action_Plan_Overview] Text NULL,
 [Final_Impact_Assessment] Text NULL,
 [QMS_Status] Varchar(50) NULL,
 [Management_System] Varchar(100) NULL,
 [Review_Quality_Event_History] Text NULL,
 [Quality_Impacts] Varchar(400) NULL,
 [Regulatory_Commitment] Bit NULL,
 [Regulatory_Reportable] Bit NULL,
 [Health_Hazard_Evaluation] Bit NULL,
 [Causal_Factor] Varchar(200) NULL,
 [Root_Cause_Category] Varchar(100) NULL,
 [Quality_Event_Category] Varchar(100) NULL,
 [Quality_Event_Type] Varchar(100) NULL,
 [Object_Concerned] Varchar(100) NULL,
 [Detection_Mode] Varchar(100) NULL,
 [Location] Varchar(100) NULL,
 [QMS_Action_Number] Varchar(200) NULL,
 [QMS_Action_Status] Varchar(100) NULL,
 [QMS_Action_Description] Text NULL,
 [QMS_Action_Type] Varchar(100) NULL,
 [Asset_ID] Bigint NOT NULL
)
go

-- Create indexes for table Asset_QMS_Deviation

CREATE INDEX [IX_Deviation_Belongs_To_Asset] ON [Asset_QMS_Deviation] ([Asset_ID])
go

-- Add keys for table Asset_QMS_Deviation

ALTER TABLE [Asset_QMS_Deviation] ADD CONSTRAINT [Deviation_Number] PRIMARY KEY ([Deviation_Number])
go

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [Asset_Location] ADD CONSTRAINT [Hierarchy - Parent Location] FOREIGN KEY ([FK_Location_ID]) REFERENCES [Asset_Location] ([Location_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Document] ADD CONSTRAINT [Document_Is_Associated_With_Location] FOREIGN KEY ([Location_ID]) REFERENCES [Asset_Location] ([Location_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Document] ADD CONSTRAINT [Document_Is_About_Asset] FOREIGN KEY ([Asset_ID]) REFERENCES [Asset_Asset] ([Asset_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Alarm] ADD CONSTRAINT [Happens_In] FOREIGN KEY ([Asset_ID]) REFERENCES [Asset_Asset] ([Asset_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Asset] ADD CONSTRAINT [Asset_Belongs_To_Location] FOREIGN KEY ([Location_ID]) REFERENCES [Asset_Location] ([Location_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Work_Order] ADD CONSTRAINT [Executed_In] FOREIGN KEY ([Location_ID]) REFERENCES [Asset_Location] ([Location_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Work_Order] ADD CONSTRAINT [Executed_For] FOREIGN KEY ([Asset_ID]) REFERENCES [Asset_Asset] ([Asset_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Work_Order] ADD CONSTRAINT [WO_Has_Job_Plan] FOREIGN KEY ([Job_Plan_ID]) REFERENCES [Asset_Job_Plan] ([Job_Plan_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Task] ADD CONSTRAINT [Tasks Assigned to Work Order] FOREIGN KEY ([Work_Order_ID]) REFERENCES [Asset_Work_Order] ([Work_Order_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Work_Order] ADD CONSTRAINT [Originating Record] FOREIGN KEY ([FK_Work_Order_ID]) REFERENCES [Asset_Work_Order] ([Work_Order_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Asset] ADD CONSTRAINT [Ancestor] FOREIGN KEY ([FK_Asset_ID]) REFERENCES [Asset_Asset] ([Asset_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Organization] ADD CONSTRAINT [Parent_Organization] FOREIGN KEY ([FK_Organization_ID]) REFERENCES [Asset_Organization] ([Organization_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Asset] ADD CONSTRAINT [Asset_Belongs_To_Organization] FOREIGN KEY ([Organization_ID]) REFERENCES [Asset_Organization] ([Organization_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_Location] ADD CONSTRAINT [Location_Belongs_To_Organization] FOREIGN KEY ([Organization_ID]) REFERENCES [Asset_Organization] ([Organization_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_QMS_Change] ADD CONSTRAINT [Change_Belongs_to_Asset] FOREIGN KEY ([Asset_ID]) REFERENCES [Asset_Asset] ([Asset_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Asset_QMS_Deviation] ADD CONSTRAINT [Deviation_Belongs_To_Asset] FOREIGN KEY ([Asset_ID]) REFERENCES [Asset_Asset] ([Asset_ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go




