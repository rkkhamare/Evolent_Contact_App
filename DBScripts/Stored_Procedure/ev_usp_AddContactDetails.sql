IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ev_usp_AddContactDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ev_usp_AddContactDetails] 
GO
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