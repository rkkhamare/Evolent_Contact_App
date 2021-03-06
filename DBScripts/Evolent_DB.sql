USE [Evolent_DB]
GO
/****** Object:  StoredProcedure [dbo].[ev_usp_AddContactDetails]    Script Date: 15-Jun-2018 10:32:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================    
-- Author		: Rajdeepsingh Khamare
-- Create date	: 11-Jun-2018
-- Description	: This procedure use to add Contact details to table
-- Parameters	: @paramFirstName - First Name
--				  @paramLastName - Last Name
--				  @paramEmail - Email Address
--				  @paramPhoneNumber - Phone number 
-- Call			: EXEC [dbo].[ev_usp_AddContactDetails] 'Amaze','Fit','amaze@fit.com','9090909090'   
-- =============================================================== 
CREATE PROCEDURE [dbo].[ev_usp_AddContactDetails] 
(
	@paramFirstName nvarchar(200),
	@paramLastName nvarchar(200),
	@paramEmail nvarchar(500),
	@paramPhoneNumber nvarchar(200)
)
AS
BEGIN
  SET NOCOUNT ON

  /* Declaration Block */
  DECLARE @varErrorMessage nvarchar(4000)
  DECLARE @varErrorSeverity int
  DECLARE @varErrorState int

  BEGIN TRY

    INSERT INTO ev_tbl_Contacts (FirstName, LastName, IsActive, Email, PhoneNumber,IsDeleted)
      VALUES (@paramFirstName, @paramLastName, 1, @paramEmail, @paramPhoneNumber, 0)

    SELECT
      1
  END
  TRY

  BEGIN CATCH

    SELECT
      0
    SELECT
      @varErrorMessage = 'Error : ' + HOST_NAME() + ' : ' + OBJECT_NAME(@@PROCID) + ' : ' + ERROR_MESSAGE(),
      @varErrorSeverity = ERROR_SEVERITY(),
      @varErrorState = ERROR_STATE();

    RAISERROR (
    @varErrorMessage
    ,-- Message text.
    @varErrorSeverity
    ,-- Severity.
    @varErrorState -- State.
    );
  END CATCH

  SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[ev_usp_DeleteContactRecord]    Script Date: 15-Jun-2018 10:32:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================    
-- Author		: Rajdeepsingh Khamare
-- Create date	: 11-Jun-2018
-- Description	: This procedure use to soft delete Contact record from system
-- Parameters	: @paramId - Contact primary key as ID.
-- Call			: EXEC [dbo].[ev_usp_DeleteContactRecord] 'id'    
-- =============================================================== 
-- ====================== CHANGE LOG =============================    
-- Author			: Rajdeepsingh K.Khamare		
-- Change date		: 12-Jun-2018
-- Change Details	: Added conditon for IsDeleted check
-- Parameters		: No change     
-- =============================================================== 
CREATE PROCEDURE [dbo].[ev_usp_DeleteContactRecord] 
(
	@paramId int
)
AS
BEGIN
  SET NOCOUNT ON

  /* Declaration Block */
  DECLARE @varErrorMessage nvarchar(4000)
  DECLARE @varErrorSeverity int
  DECLARE @varErrorState int

  BEGIN TRY
    UPDATE ev_tbl_Contacts
    SET IsDeleted = 1
    WHERE Id = @paramId

    SELECT
      1
  END TRY

  BEGIN CATCH
    SELECT
      0

    SELECT
      @varErrorMessage = 'Error : ' + HOST_NAME() + ' : ' + OBJECT_NAME(@@PROCID) + ' : ' + ERROR_MESSAGE(),
      @varErrorSeverity = ERROR_SEVERITY(),
      @varErrorState = ERROR_STATE();

    RAISERROR (
    @varErrorMessage
    ,-- Message text.
    @varErrorSeverity
    ,-- Severity.
    @varErrorState -- State.
    );
  END CATCH

  SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[ev_usp_GetContactList]    Script Date: 15-Jun-2018 10:32:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================    
-- Author		: Rajdeepsingh Khamare
-- Create date	: 11-Jun-2018
-- Description	: This procedure use to Get Contact List
-- Parameters	: NONE
-- Call			: EXEC [dbo].[ev_usp_GetContactList]    
-- =============================================================== 

CREATE PROCEDURE [dbo].[ev_usp_GetContactList]
AS
BEGIN
  SET NOCOUNT ON

  /* Declaration Block */
  DECLARE @varErrorMessage nvarchar(4000)
  DECLARE @varErrorSeverity int
  DECLARE @varErrorState int

  BEGIN TRY

    SELECT
      Id,
      FirstName,
      LastName,
      IsActive,
      Email,
      PhoneNumber
    FROM ev_tbl_Contacts
    WHERE IsDeleted = 0
  END
  TRY

  BEGIN CATCH
    SELECT
      @varErrorMessage = 'Error : ' + HOST_NAME() + ' : ' + OBJECT_NAME(@@PROCID) + ' : ' + ERROR_MESSAGE(),
      @varErrorSeverity = ERROR_SEVERITY(),
      @varErrorState = ERROR_STATE();

    RAISERROR (
    @varErrorMessage
    ,-- Message text.
    @varErrorSeverity
    ,-- Severity.
    @varErrorState -- State.
    );
  END CATCH

  SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[ev_usp_UpdateContactDetails]    Script Date: 15-Jun-2018 10:32:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================    
-- Author		: Rajdeepsingh Khamare
-- Create date	: 11-Jun-2018
-- Description	: This procedure use to update Contact details to table
-- Parameters	: @paramFirstName - First Name
--				  @paramLastName - Last Name
--				  @paramEmail - Email Address
--				  @paramPhoneNumber - Phone number 
--				  @paramIsActive - Active/Inactive
-- Call			: EXEC [dbo].[ev_usp_UpdateContactDetails] '5','Amaze','Fit','amaze@fit.com','9090909090','0'   
-- =============================================================== 
CREATE PROCEDURE [dbo].[ev_usp_UpdateContactDetails] 
(
	@paramId int,
	@paramFirstName nvarchar(200),
	@paramLastName nvarchar(200),
	@paramEmail nvarchar(500),
	@paramPhoneNumber nvarchar(200),
	@paramIsActive bit
)
AS
BEGIN
  SET NOCOUNT ON

  /* Declaration Block */
  DECLARE @varErrorMessage nvarchar(4000)
  DECLARE @varErrorSeverity int
  DECLARE @varErrorState int

  BEGIN TRY
    UPDATE ev_tbl_Contacts
    SET FirstName = @paramFirstName,
        LastName = @paramLastName,
        IsActive = @paramIsActive,
        Email = @paramEmail,
        PhoneNumber = @paramPhoneNumber
    WHERE Id = @paramId

    SELECT
      1
  END TRY

  BEGIN CATCH
    SELECT
      0

    SELECT
      @varErrorMessage = 'Error : ' + HOST_NAME() + ' : ' + OBJECT_NAME(@@PROCID) + ' : ' + ERROR_MESSAGE(),
      @varErrorSeverity = ERROR_SEVERITY(),
      @varErrorState = ERROR_STATE();

    RAISERROR (
    @varErrorMessage
    ,-- Message text.
    @varErrorSeverity
    ,-- Severity.
    @varErrorState -- State.
    );
  END CATCH

  SET NOCOUNT OFF
END
GO
/****** Object:  Table [dbo].[ev_tbl_Contacts]    Script Date: 15-Jun-2018 10:32:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ev_tbl_Contacts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](256) NOT NULL,
	[LastName] [nvarchar](256) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[PhoneNumber] [nvarchar](16) NOT NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_Contacts_IsActive]  DEFAULT ((0)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Contacts_IsDeleted]  DEFAULT ((0))
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ev_tbl_Contacts] ON 

INSERT [dbo].[ev_tbl_Contacts] ([Id], [FirstName], [LastName], [Email], [PhoneNumber], [IsActive], [IsDeleted]) VALUES (2, N'Test1', N'User1', N'testUser1@gmail.com', N'9011362101', 1, 1)
INSERT [dbo].[ev_tbl_Contacts] ([Id], [FirstName], [LastName], [Email], [PhoneNumber], [IsActive], [IsDeleted]) VALUES (5, N'Amaze', N'Fit', N'amaze@fit.com', N'9876543210', 1, 0)
INSERT [dbo].[ev_tbl_Contacts] ([Id], [FirstName], [LastName], [Email], [PhoneNumber], [IsActive], [IsDeleted]) VALUES (6, N'Rajdeepsingh', N'Khamare', N'nest@nest.com', N'9090909090', 0, 0)
SET IDENTITY_INSERT [dbo].[ev_tbl_Contacts] OFF
