/* Version 0.9.6 */

if exists (select * from sysobjects where id = object_id(N'yaf_Buddy') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table yaf_Buddy
GO

if exists (select * from sysobjects where id = object_id(N'yaf_message_findunread') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_message_findunread
GO

create procedure yaf_message_findunread(@TopicID int,@LastRead datetime) as
begin
	select top 1 MessageID from yaf_Message
	where TopicID=@TopicID and Posted>@LastRead
	order by Posted
end
go

---------------------------------------------------------------
-- yaf_Board
if not exists (select * from sysobjects where id = object_id(N'yaf_Board') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
	CREATE TABLE [yaf_Board] (
		[BoardID]	[int] NOT NULL IDENTITY(1,1),
		[Name]		[varchar](50) NOT NULL
	)
	EXEC('insert into yaf_Board(Name) select Name from yaf_System')
end
GO

if not exists(select * from sysindexes where id=object_id('yaf_Board') and name='PK_Board')
ALTER TABLE [yaf_Board] WITH NOCHECK ADD 
	CONSTRAINT [PK_Board] PRIMARY KEY  CLUSTERED 
	(
		[BoardID]
	)
GO

-- yaf_Category
if not exists(select * from syscolumns where id=object_id('yaf_Category') and name='BoardID')
begin
	alter table yaf_Category add BoardID int null
	EXEC('update yaf_Category set BoardID=(select min(BoardID) from yaf_Board)')
	alter table yaf_Category alter column BoardID int not null
end
GO

if not exists(select * from sysobjects where name='FK_Category_Board' and parent_obj=object_id('yaf_Category') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
ALTER TABLE [yaf_Category] ADD 
	CONSTRAINT [FK_Category_Board] FOREIGN KEY 
	(
		[BoardID]
	) REFERENCES [yaf_Board] (
		[BoardID]
	)
GO

-- yaf_AccessMask
if not exists(select * from syscolumns where id=object_id('yaf_AccessMask') and name='BoardID')
begin
	alter table yaf_AccessMask add BoardID int null
	EXEC('update yaf_AccessMask set BoardID=(select min(BoardID) from yaf_Board)')
	alter table yaf_AccessMask alter column BoardID int not null
end
GO

if not exists(select * from sysobjects where name='FK_AccessMask_Board' and parent_obj=object_id('yaf_AccessMask') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
ALTER TABLE [yaf_AccessMask] ADD 
	CONSTRAINT [FK_AccessMask_Board] FOREIGN KEY 
	(
		[BoardID]
	) REFERENCES [yaf_Board] (
		[BoardID]
	)
GO

-- yaf_Active
if not exists(select * from syscolumns where id=object_id('yaf_Active') and name='BoardID')
begin
	alter table yaf_Active add BoardID int null
	EXEC('update yaf_Active set BoardID=(select min(BoardID) from yaf_Board)')
	alter table yaf_Active alter column BoardID int not null
end
GO

if not exists(select * from sysobjects where name='FK_Active_Board' and parent_obj=object_id('yaf_Active') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
ALTER TABLE [yaf_Active] ADD 
	CONSTRAINT [FK_Active_Board] FOREIGN KEY 
	(
		[BoardID]
	) REFERENCES [yaf_Board] (
		[BoardID]
	)
GO

-- yaf_BannedIP
if not exists(select * from syscolumns where id=object_id('yaf_BannedIP') and name='BoardID')
begin
	alter table yaf_BannedIP add BoardID int null
	EXEC('update yaf_BannedIP set BoardID=(select min(BoardID) from yaf_Board)')
	alter table yaf_BannedIP alter column BoardID int not null
end
GO

if not exists(select * from sysobjects where name='FK_BannedIP_Board' and parent_obj=object_id('yaf_BannedIP') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
ALTER TABLE [yaf_BannedIP] ADD 
	CONSTRAINT [FK_BannedIP_Board] FOREIGN KEY 
	(
		[BoardID]
	) REFERENCES [yaf_Board] (
		[BoardID]
	)
GO

-- yaf_Group
if not exists(select * from syscolumns where id=object_id('yaf_Group') and name='BoardID')
begin
	alter table yaf_Group add BoardID int null
	EXEC('update yaf_Group set BoardID=(select min(BoardID) from yaf_Board)')
	alter table yaf_Group alter column BoardID int not null
end
GO

if not exists(select * from sysobjects where name='FK_Group_Board' and parent_obj=object_id('yaf_Group') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
ALTER TABLE [yaf_Group] ADD 
	CONSTRAINT [FK_Group_Board] FOREIGN KEY 
	(
		[BoardID]
	) REFERENCES [yaf_Board] (
		[BoardID]
	)
GO

-- yaf_NntpServer
if not exists(select * from syscolumns where id=object_id('yaf_NntpServer') and name='BoardID')
begin
	alter table yaf_NntpServer add BoardID int null
	EXEC('update yaf_NntpServer set BoardID=(select min(BoardID) from yaf_Board)')
	alter table yaf_NntpServer alter column BoardID int not null
end
GO

if not exists(select * from sysobjects where name='FK_NntpServer_Board' and parent_obj=object_id('yaf_NntpServer') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
ALTER TABLE [yaf_NntpServer] ADD 
	CONSTRAINT [FK_NntpServer_Board] FOREIGN KEY 
	(
		[BoardID]
	) REFERENCES [yaf_Board] (
		[BoardID]
	)
GO

-- yaf_Rank
if not exists(select * from syscolumns where id=object_id('yaf_Rank') and name='BoardID')
begin
	alter table yaf_Rank add BoardID int null
	EXEC('update yaf_Rank set BoardID=(select min(BoardID) from yaf_Board)')
	alter table yaf_Rank alter column BoardID int not null
end
GO

if not exists(select * from sysobjects where name='FK_Rank_Board' and parent_obj=object_id('yaf_Rank') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
ALTER TABLE [yaf_Rank] ADD 
	CONSTRAINT [FK_Rank_Board] FOREIGN KEY 
	(
		[BoardID]
	) REFERENCES [yaf_Board] (
		[BoardID]
	)
GO

-- yaf_Smiley
if not exists(select * from syscolumns where id=object_id('yaf_Smiley') and name='BoardID')
begin
	alter table yaf_Smiley add BoardID int null
	EXEC('update yaf_Smiley set BoardID=(select min(BoardID) from yaf_Board)')
	alter table yaf_Smiley alter column BoardID int not null
end
GO

if not exists(select * from sysobjects where name='FK_Smiley_Board' and parent_obj=object_id('yaf_Smiley') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
ALTER TABLE [yaf_Smiley] ADD 
	CONSTRAINT [FK_Smiley_Board] FOREIGN KEY 
	(
		[BoardID]
	) REFERENCES [yaf_Board] (
		[BoardID]
	)
GO

-- yaf_User
if not exists(select * from syscolumns where id=object_id('yaf_User') and name='BoardID')
begin
	alter table yaf_User add BoardID int null
	EXEC('update yaf_User set BoardID=(select min(BoardID) from yaf_Board) where BoardID is null')
	alter table yaf_User alter column BoardID int not null
end
GO

if not exists(select * from syscolumns where id=object_id('yaf_User') and name='IsHostAdmin')
begin
	alter table yaf_User add IsHostAdmin bit null
	EXEC('update yaf_User set IsHostAdmin=(select IsAdmin from yaf_vaccess where yaf_vaccess.UserID=yaf_User.UserID and ForumID=0) where IsHostAdmin is null')
	alter table yaf_User alter column IsHostAdmin bit not null
end
GO

if exists(select * from sysindexes where id=object_id('yaf_User') and name='IX_User')
	ALTER TABLE [yaf_User] DROP CONSTRAINT [IX_User]
GO

if not exists(select * from sysindexes where id=object_id('yaf_User') and name='IX_User')
	ALTER TABLE [yaf_User] ADD CONSTRAINT [IX_User] UNIQUE NONCLUSTERED([BoardID],[Name])
GO

if not exists(select * from sysobjects where name='FK_User_Rank' and parent_obj=object_id('yaf_User') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	ALTER TABLE [yaf_User] ADD 
		CONSTRAINT [FK_User_Rank] FOREIGN KEY([RankID]) REFERENCES [yaf_Rank]([RankID])
GO

if not exists(select * from sysobjects where name='FK_User_Board' and parent_obj=object_id('yaf_User') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	ALTER TABLE [yaf_User] ADD 
		CONSTRAINT [FK_User_Board] FOREIGN KEY([BoardID]) REFERENCES [yaf_Board]([BoardID])
GO

-- yaf_System
if exists(select * from syscolumns where id=object_id('yaf_System') and name='Name')
	alter table yaf_System drop column [Name]
GO

-- yaf_Active
if exists(select * from sysindexes where id=object_id('yaf_Active') and name='PK_Active')
	ALTER TABLE yaf_Active DROP CONSTRAINT PK_Active
GO

if not exists(select * from sysindexes where id=object_id('yaf_Active') and name='PK_Active')
ALTER TABLE [yaf_Active] WITH NOCHECK ADD 
	CONSTRAINT [PK_Active] PRIMARY KEY CLUSTERED([SessionID],[BoardID])
GO

-- yaf_Group
if exists(select * from sysindexes where id=object_id('yaf_Group') and name='IX_Group')
	ALTER TABLE [yaf_Group] DROP CONSTRAINT IX_Group
GO

if not exists(select * from sysindexes where id=object_id('yaf_Group') and name='IX_Group')
ALTER TABLE [yaf_Group] ADD 
	CONSTRAINT [IX_Group] UNIQUE NONCLUSTERED([BoardID],[Name])
GO

-- yaf_BannedIP
if exists(select * from sysindexes where id=object_id('yaf_BannedIP') and name='IX_BannedIP')
	ALTER TABLE [yaf_BannedIP] DROP CONSTRAINT IX_BannedIP
GO

if not exists(select * from sysindexes where id=object_id('yaf_BannedIP') and name='IX_BannedIP')
ALTER TABLE [yaf_BannedIP] ADD 
	CONSTRAINT [IX_BannedIP] UNIQUE NONCLUSTERED([BoardID],[Mask])
GO

-- yaf_Smiley
if exists(select * from sysindexes where id=object_id('yaf_Smiley') and name='IX_Smiley')
	ALTER TABLE [yaf_Smiley] DROP CONSTRAINT [IX_Smiley]
GO

if not exists(select * from sysindexes where id=object_id('yaf_Smiley') and name='IX_Smiley')
	ALTER TABLE [yaf_Smiley] ADD 
		CONSTRAINT [IX_Smiley] UNIQUE NONCLUSTERED([BoardID],[Code])
GO

-- yaf_pageload
if exists (select * from sysobjects where id = object_id(N'yaf_pageload') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_pageload
GO

create procedure yaf_pageload(
	@SessionID	varchar(24),
	@BoardID	int,
	@User		varchar(50),
	@IP			varchar(15),
	@Location	varchar(50),
	@Browser	varchar(50),
	@Platform	varchar(50),
	@CategoryID	int = null,
	@ForumID	int = null,
	@TopicID	int = null,
	@MessageID	int = null
) as
begin
	declare @UserID			int
	declare @UserBoardID	int
	declare @IsGuest		tinyint
	
	if @User is null or @User='' 
	begin
		select @UserID = a.UserID from yaf_User a,yaf_UserGroup b,yaf_Group c where a.UserID=b.UserID and b.GroupID=c.GroupID and c.IsGuest=1
		set @IsGuest = 1
		set @UserBoardID = @BoardID
	end else
	begin
		select @UserID = UserID, @UserBoardID = BoardID from yaf_User where Name = @User
		set @IsGuest = 0
	end
	-- Check valid ForumID
	if @ForumID is not null and not exists(select 1 from yaf_Forum where ForumID=@ForumID) begin
		set @ForumID = null
	end
	-- Check valid CategoryID
	if @CategoryID is not null and not exists(select 1 from yaf_Category where CategoryID=@CategoryID) begin
		set @CategoryID = null
	end
	-- Check valid MessageID
	if @MessageID is not null and not exists(select 1 from yaf_Message where MessageID=@MessageID) begin
		set @MessageID = null
	end
	-- Check valid TopicID
	if @TopicID is not null and not exists(select 1 from yaf_Topic where TopicID=@TopicID) begin
		set @TopicID = null
	end

	-- update last visit
	update yaf_User set 
		LastVisit = getdate(),
		IP = @IP
	where UserID = @UserID
	-- find missing ForumID/TopicID
	if @MessageID is not null begin
		select
			@CategoryID = c.CategoryID,
			@ForumID = b.ForumID,
			@TopicID = b.TopicID
		from
			yaf_Message a,
			yaf_Topic b,
			yaf_Forum c,
			yaf_Category d
		where
			a.MessageID = @MessageID and
			b.TopicID = a.TopicID and
			c.ForumID = b.ForumID and
			d.CategoryID = c.CategoryID and
			d.BoardID = @BoardID
	end
	else if @TopicID is not null begin
		select 
			@CategoryID = b.CategoryID,
			@ForumID = a.ForumID 
		from 
			yaf_Topic a,
			yaf_Forum b,
			yaf_Category c
		where 
			a.TopicID = @TopicID and
			b.ForumID = a.ForumID and
			c.CategoryID = b.CategoryID and
			c.BoardID = @BoardID
	end
	else if @ForumID is not null begin
		select
			@CategoryID = a.CategoryID
		from
			yaf_Forum a,
			yaf_Category b
		where
			a.ForumID = @ForumID and
			b.CategoryID = a.CategoryID and
			b.BoardID = @BoardID
	end
	-- update active
	if @UserID is not null and @UserBoardID=@BoardID begin
		if exists(select 1 from yaf_Active where SessionID=@SessionID and BoardID=@BoardID)
		begin
			update yaf_Active set
				UserID = @UserID,
				IP = @IP,
				LastActive = getdate(),
				Location = @Location,
				ForumID = @ForumID,
				TopicID = @TopicID,
				Browser = @Browser,
				Platform = @Platform
			where SessionID = @SessionID
		end
		else begin
			insert into yaf_Active(SessionID,BoardID,UserID,IP,Login,LastActive,Location,ForumID,TopicID,Browser,Platform)
			values(@SessionID,@BoardID,@UserID,@IP,getdate(),getdate(),@Location,@ForumID,@TopicID,@Browser,@Platform)
		end
		-- remove duplicate users
		if @IsGuest=0
			delete from yaf_Active where UserID=@UserID and BoardID=@BoardID and SessionID<>@SessionID
	end
	-- return information
	select
		a.UserID,
		a.IsHostAdmin,
		UserName			= a.Name,
		Suspended			= a.Suspended,
		ThemeFile			= a.ThemeFile,
		LanguageFile		= a.LanguageFile,
		TimeZoneUser		= a.TimeZone,
		x.*,
		CategoryID			= @CategoryID,
		CategoryName		= (select Name from yaf_Category where CategoryID = @CategoryID),
		ForumID				= @ForumID,
		ForumName			= (select Name from yaf_Forum where ForumID = @ForumID),
		TopicID				= @TopicID,
		TopicName			= (select Topic from yaf_Topic where TopicID = @TopicID),
		MailsPending		= (select count(1) from yaf_Mail),
		Incoming			= (select count(1) from yaf_PMessage where ToUserID=a.UserID and IsRead=0)
	from
		yaf_User a,
		yaf_vaccess x
	where
		a.UserID = @UserID and
		x.UserID = a.UserID and
		x.ForumID = IsNull(@ForumID,0)
end
GO

-- yaf_system_list
if exists (select * from sysobjects where id = object_id(N'yaf_system_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_system_list
GO

create procedure yaf_system_list as
begin
	select top 1 
		a.*,
		SQLVersion = @@VERSION
	from 
		yaf_System a
end
GO

-- yaf_forumlayout
if exists (select * from sysobjects where id = object_id(N'yaf_forumlayout') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_forumlayout
GO

-- yaf_board_layout
if exists (select * from sysobjects where id = object_id(N'yaf_board_layout') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_board_layout
GO

create procedure yaf_board_layout(@BoardID int,@UserID int,@CategoryID int=null,@OnlyForum tinyint=0) as
begin
	-- categories	
	if @OnlyForum=0
	select 
		a.CategoryID,
		a.Name
	from 
		yaf_Category a
		join yaf_Forum b on b.CategoryID=a.CategoryID
		join yaf_vaccess v on v.ForumID=b.ForumID
	where
		a.BoardID = @BoardID and
		v.UserID = @UserID and
		(v.ReadAccess <> 0 or b.Hidden = 0) and
		(@CategoryID is null or a.CategoryID = @CategoryID)
	group by
		a.CategoryID,
		a.Name,
		a.SortOrder
	order by 
		a.SortOrder

	-- forums
	select 
		a.CategoryID, 
		Category		= a.Name, 
		ForumID			= b.ForumID,
		Forum			= b.Name, 
		Description,
		Topics			= b.NumTopics,
		Posts			= b.NumPosts,
		LastPosted		= b.LastPosted,
		LastMessageID	= b.LastMessageID,
		LastUserID		= b.LastUserID,
		LastUser		= IsNull(b.LastUserName,(select Name from yaf_User x where x.UserID=b.LastUserID)),
		LastTopicID		= b.LastTopicID,
		LastTopicName	= (select x.Topic from yaf_Topic x where x.TopicID=b.LastTopicID),
		b.Locked,
		b.Moderated,
		Viewing			= (select count(1) from yaf_Active x where x.ForumID=b.ForumID)
	from 
		yaf_Category a, 
		yaf_Forum b,
		yaf_vaccess x
	where 
		a.BoardID = @BoardID and
		a.CategoryID = b.CategoryID and
		(b.Hidden=0 or x.ReadAccess<>0) and
		(@CategoryID is null or a.CategoryID = @CategoryID) and
		x.UserID = @UserID and
		x.ForumID = b.ForumID
	order by
		a.SortOrder,
		b.SortOrder
end
GO

-- yaf_category_list
if exists (select * from sysobjects where id = object_id(N'yaf_category_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_category_list
GO

create procedure yaf_category_list(@BoardID int,@CategoryID int=null) as
begin
	if @CategoryID is null
		select * from yaf_Category where BoardID = @BoardID order by SortOrder
	else
		select * from yaf_Category where BoardID = @BoardID and CategoryID = @CategoryID
end
GO

-- yaf_category_save
if exists (select * from sysobjects where id = object_id(N'yaf_category_save') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_category_save
GO

create procedure yaf_category_save(@BoardID int,@CategoryID int,@Name varchar(50),@SortOrder smallint) as
begin
	if @CategoryID>0 begin
		update yaf_Category set Name=@Name,SortOrder=@SortOrder where CategoryID=@CategoryID
		select CategoryID = @CategoryID
	end
	else begin
		insert into yaf_Category(BoardID,Name,SortOrder) values(@BoardID,@Name,@SortOrder)
		select CategoryID = @@IDENTITY
	end
end
GO

-- yaf_forum_list
if exists (select * from sysobjects where id = object_id(N'yaf_forum_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_forum_list
GO

CREATE  procedure yaf_forum_list(@BoardID int,@ForumID int=null) as
begin
	if @ForumID = 0 set @ForumID = null
	if @ForumID is null
		select a.* from yaf_Forum a join yaf_Category b on b.CategoryID=a.CategoryID where b.BoardID=@BoardID order by a.SortOrder
	else
		select a.* from yaf_Forum a join yaf_Category b on b.CategoryID=a.CategoryID where b.BoardID=@BoardID and a.ForumID = @ForumID
end
GO

-- yaf_board_list
if exists (select * from sysobjects where id = object_id(N'yaf_board_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_board_list
GO

create procedure yaf_board_list(@BoardID int) as
begin
	select top 1 
		a.*,
		b.*,
		SQLVersion = @@VERSION
	from 
		yaf_System a,yaf_Board b
	where
		b.BoardID = @BoardID
end
GO

-- yaf_forum_stats
if exists (select * from sysobjects where id = object_id(N'yaf_forum_stats') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_forum_stats
GO

-- yaf_board_stats
if exists (select * from sysobjects where id = object_id(N'yaf_board_poststats') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_board_poststats
GO

create procedure yaf_board_poststats(@BoardID int) as
begin
	select
		Posts = (select count(1) from yaf_Message a join yaf_Topic b on b.TopicID=a.TopicID join yaf_Forum c on c.ForumID=b.ForumID join yaf_Category d on d.CategoryID=c.CategoryID where d.BoardID=@BoardID),
		Topics = (select count(1) from yaf_Topic a join yaf_Forum b on b.ForumID=a.ForumID join yaf_Category c on c.CategoryID=b.CategoryID where c.BoardID=@BoardID),
		Forums = (select count(1) from yaf_Forum a join yaf_Category b on b.CategoryID=a.CategoryID where b.BoardID=@BoardID),
		Members = (select count(1) from yaf_User a where a.BoardID=@BoardID),
		LastPostInfo.*,
		LastMemberInfo.*
	from
		(
			select top 1 
				LastMemberInfoID= 1,
				LastMemberID	= UserID,
				LastMember	= Name
			from 
				yaf_User 
			where 
				Approved=1 and 
				BoardID=@BoardID 
			order by 
				Joined desc
		) as LastMemberInfo
		left join (
			select top 1 
				LastPostInfoID	= 1,
				LastPost	= a.Posted,
				LastUserID	= a.UserID,
				LastUser	= e.Name
			from 
				yaf_Message a 
				join yaf_Topic b on b.TopicID=a.TopicID 
				join yaf_Forum c on c.ForumID=b.ForumID 
				join yaf_Category d on d.CategoryID=c.CategoryID 
				join yaf_User e on e.UserID=a.UserID
			where 
				d.BoardID=@BoardID
			order by
				a.Posted desc
		) as LastPostInfo
		on LastMemberInfoID=LastPostInfoID
end
GO

-- yaf_accessmask_save
if exists (select * from sysobjects where id = object_id(N'yaf_accessmask_save') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_accessmask_save
GO

create procedure yaf_accessmask_save(
	@AccessMaskID		int=null,
	@BoardID			int,
	@Name				varchar(50),
	@ReadAccess			bit,
	@PostAccess			bit,
	@ReplyAccess		bit,
	@PriorityAccess		bit,
	@PollAccess			bit,
	@VoteAccess			bit,
	@ModeratorAccess	bit,
	@EditAccess			bit,
	@DeleteAccess		bit,
	@UploadAccess		bit
) as
begin
	if @AccessMaskID is null
		insert into yaf_AccessMask([Name],BoardID,ReadAccess,PostAccess,ReplyAccess,PriorityAccess,PollAccess,VoteAccess,ModeratorAccess,EditAccess,DeleteAccess,UploadAccess)
		values(@Name,@BoardID,@ReadAccess,@PostAccess,@ReplyAccess,@PriorityAccess,@PollAccess,@VoteAccess,@ModeratorAccess,@EditAccess,@DeleteAccess,@UploadAccess)
	else
		update yaf_AccessMask set
			[Name]			= @Name,
			ReadAccess		= @ReadAccess,
			PostAccess		= @PostAccess,
			ReplyAccess		= @ReplyAccess,
			PriorityAccess	= @PriorityAccess,
			PollAccess		= @PollAccess,
			VoteAccess		= @VoteAccess,
			ModeratorAccess	= @ModeratorAccess,
			EditAccess		= @EditAccess,
			DeleteAccess	= @DeleteAccess,
			UploadAccess	= @UploadAccess
		where AccessMaskID=@AccessMaskID
end
GO

-- yaf_accessmask_list
if exists (select * from sysobjects where id = object_id(N'yaf_accessmask_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_accessmask_list
GO

create procedure yaf_accessmask_list(@BoardID int,@AccessMaskID int=null) as
begin
	if @AccessMaskID is null
		select 
			a.* 
		from 
			yaf_AccessMask a 
		where
			a.BoardID = @BoardID
		order by 
			a.Name
	else
		select 
			a.* 
		from 
			yaf_AccessMask a 
		where
			a.BoardID = @BoardID and
			a.AccessMaskID = @AccessMaskID
		order by 
			a.Name
end
GO

-- yaf_active_list
if exists (select * from sysobjects where id = object_id(N'yaf_active_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_active_list
GO

create procedure yaf_active_list(@BoardID int,@Guests bit=0) as
begin
	-- delete non-active
	delete from yaf_Active where DATEDIFF(minute,LastActive,getdate())>5
	-- select active
	if @Guests<>0
		select
			a.UserID,
			a.Name,
			a.IP,
			c.SessionID,
			c.ForumID,
			c.TopicID,
			ForumName = (select Name from yaf_Forum x where x.ForumID=c.ForumID),
			TopicName = (select Topic from yaf_Topic x where x.TopicID=c.TopicID),
			IsGuest = (select 1 from yaf_UserGroup x,yaf_Group y where x.UserID=a.UserID and y.GroupID=x.GroupID and y.IsGuest<>0),
			c.Login,
			c.LastActive,
			c.Location,
			Active = DATEDIFF(minute,c.Login,c.LastActive),
			c.Browser,
			c.Platform
		from
			yaf_User a,
			yaf_Active c
		where
			c.UserID = a.UserID and
			c.BoardID = @BoardID
		order by
			c.LastActive desc
	else
		select
			a.UserID,
			a.Name,
			a.IP,
			c.SessionID,
			c.ForumID,
			c.TopicID,
			ForumName = (select Name from yaf_Forum x where x.ForumID=c.ForumID),
			TopicName = (select Topic from yaf_Topic x where x.TopicID=c.TopicID),
			IsGuest = (select 1 from yaf_UserGroup x,yaf_Group y where x.UserID=a.UserID and y.GroupID=x.GroupID and y.IsGuest<>0),
			c.Login,
			c.LastActive,
			c.Location,
			Active = DATEDIFF(minute,c.Login,c.LastActive),
			c.Browser,
			c.Platform
		from
			yaf_User a,
			yaf_Active c
		where
			c.UserID = a.UserID and
			c.BoardID = @BoardID and
			not exists(select 1 from yaf_UserGroup x,yaf_Group y where x.UserID=a.UserID and y.GroupID=x.GroupID and y.IsGuest<>0)
		order by
			c.LastActive desc
end
GO

-- yaf_active_stats
if exists (select * from sysobjects where id = object_id(N'yaf_active_stats') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_active_stats
GO

create procedure yaf_active_stats(@BoardID int) as
begin
	select
		ActiveUsers = (select count(1) from yaf_Active where BoardID=@BoardID),
		ActiveMembers = (select count(1) from yaf_Active x where BoardID=@BoardID and exists(select 1 from yaf_UserGroup y,yaf_Group z where y.UserID=x.UserID and y.GroupID=z.GroupID and z.IsGuest=0)),
		ActiveGuests = (select count(1) from yaf_Active x where BoardID=@BoardID and exists(select 1 from yaf_UserGroup y,yaf_Group z where y.UserID=x.UserID and y.GroupID=z.GroupID and z.IsGuest<>0))
end
GO

-- yaf_group_list
if exists (select * from sysobjects where id = object_id(N'yaf_group_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_group_list
GO

create procedure yaf_group_list(@BoardID int,@GroupID int=null) as
begin
	if @GroupID is null
		select * from yaf_Group where BoardID=@BoardID
	else
		select * from yaf_Group where BoardID=@BoardID and GroupID=@GroupID
end
GO

-- yaf_group_member
if exists (select * from sysobjects where id = object_id(N'yaf_group_member') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_group_member
GO

create procedure yaf_group_member(@BoardID int,@UserID int) as
begin
	select 
		a.GroupID,
		a.Name,
		Member = (select count(1) from yaf_UserGroup x where x.UserID=@UserID and x.GroupID=a.GroupID)
	from
		yaf_Group a
	where
		a.BoardID=@BoardID
	order by
		a.Name
end
GO

-- yaf_group_save
if exists (select * from sysobjects where id = object_id(N'yaf_group_save') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_group_save
GO

create procedure yaf_group_save(
	@GroupID		int,
	@BoardID		int,
	@Name			varchar(50),
	@IsAdmin		bit,
	@IsGuest		bit,
	@IsStart		bit,
	@IsModerator	bit,
	@AccessMaskID	int=null
) as
begin
	if @IsAdmin = 1 update yaf_Group set IsAdmin = 0
	if @IsGuest = 1 update yaf_Group set IsGuest = 0
	if @IsStart = 1 update yaf_Group set IsStart = 0
	if @GroupID>0 begin
		update yaf_Group set
			Name = @Name,
			IsAdmin = @IsAdmin,
			IsGuest = @IsGuest,
			IsStart = @IsStart,
			IsModerator = @IsModerator
		where GroupID = @GroupID
	end
	else begin
		insert into yaf_Group(Name,BoardID,IsAdmin,IsGuest,IsStart,IsModerator)
		values(@Name,@BoardID,@IsAdmin,@IsGuest,@IsStart,@IsModerator);
		set @GroupID = @@IDENTITY
		insert into yaf_ForumAccess(GroupID,ForumID,AccessMaskID)
		select @GroupID,a.ForumID,@AccessMaskID from yaf_Forum a join yaf_Category b on b.CategoryID=a.CategoryID where b.BoardID=@BoardID
	end
	select GroupID = @GroupID
end
GO

-- yaf_bannedip_list
if exists (select * from sysobjects where id = object_id(N'yaf_bannedip_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_bannedip_list
GO

create procedure yaf_bannedip_list(@BoardID int,@ID int=null) as
begin
	if @ID is null
		select * from yaf_BannedIP where BoardID=@BoardID
	else
		select * from yaf_BannedIP where BoardID=@BoardID and ID=@ID
end
GO

-- yaf_bannedip_save
if exists (select * from sysobjects where id = object_id(N'yaf_bannedip_save') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_bannedip_save
GO

create procedure yaf_bannedip_save(@ID int=null,@BoardID int,@Mask varchar(15)) as
begin
	if @ID is null or @ID = 0 begin
		insert into yaf_BannedIP(BoardID,Mask,Since) values(@BoardID,@Mask,getdate())
	end
	else begin
		update yaf_BannedIP set Mask = @Mask where ID = @ID
	end
end
GO

-- yaf_user_save
if exists (select * from sysobjects where id = object_id(N'yaf_user_save') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_user_save
GO

create procedure yaf_user_save(
	@UserID			int,
	@BoardID		int,
	@UserName		varchar(50) = null,
	@Password		varchar(32) = null,
	@Email			varchar(50) = null,
	@Hash			varchar(32) = null,
	@Location		varchar(50) = null,
	@HomePage		varchar(50) = null,
	@TimeZone		int,
	@Avatar			varchar(100) = null,
	@LanguageFile	varchar(50) = null,
	@ThemeFile		varchar(50) = null,
	@Approved		bit = null,
	@MSN			varchar(50) = null,
	@YIM			varchar(30) = null,
	@AIM			varchar(30) = null,
	@ICQ			int = null,
	@RealName		varchar(50) = null,
	@Occupation		varchar(50) = null,
	@Interests		varchar(100) = null,
	@Gender			tinyint = 0,
	@Weblog			varchar(100) = null
) as
begin
	declare @RankID int

	if @Location is not null and @Location = '' set @Location = null
	if @HomePage is not null and @HomePage = '' set @HomePage = null
	if @Avatar is not null and @Avatar = '' set @Avatar = null
	if @MSN is not null and @MSN = '' set @MSN = null
	if @YIM is not null and @YIM = '' set @YIM = null
	if @AIM is not null and @AIM = '' set @AIM = null
	if @ICQ is not null and @ICQ = 0 set @ICQ = null
	if @RealName is not null and @RealName = '' set @RealName = null
	if @Occupation is not null and @Occupation = '' set @Occupation = null
	if @Interests is not null and @Interests = '' set @Interests = null

	if @UserID is null or @UserID<1 begin
		if @Email = '' set @Email = null
		
		select @RankID = RankID from yaf_Rank where IsStart<>0
		
		insert into yaf_User(BoardID,RankID,Name,Password,Email,Joined,LastVisit,NumPosts,Approved,Location,HomePage,TimeZone,Avatar,Gender,IsHostAdmin) 
		values(@BoardID,@RankID,@UserName,@Password,@Email,getdate(),getdate(),0,@Approved,@Location,@HomePage,@TimeZone,@Avatar,@Gender,0)
	
		set @UserID = @@IDENTITY

		insert into yaf_UserGroup(UserID,GroupID) select @UserID,GroupID from yaf_Group where IsStart<>0
		
		if @Hash is not null and @Hash <> '' and @Approved=0 begin
			insert into yaf_CheckEmail(UserID,Email,Created,Hash)
			values(@UserID,@Email,getdate(),@Hash)	
		end
	end
	else begin
		update yaf_User set
			Location = @Location,
			HomePage = @HomePage,
			TimeZone = @TimeZone,
			Avatar = @Avatar,
			LanguageFile = @LanguageFile,
			ThemeFile = @ThemeFile,
			MSN = @MSN,
			YIM = @YIM,
			AIM = @AIM,
			ICQ = @ICQ,
			RealName = @RealName,
			Occupation = @Occupation,
			Interests = @Interests,
			Gender = @Gender,
			Weblog = @Weblog
		where UserID = @UserID
		
		if @Email is not null
			update yaf_User set Email = @Email where UserID = @UserID
	end
end
GO

-- drop procedure yaf_user_list
if exists (select * from sysobjects where id = object_id(N'yaf_user_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_user_list
GO

create procedure yaf_user_list(@BoardID int,@UserID int=null,@Approved bit=null) as
begin
	if @UserID is null
		select 
			a.*,
			a.NumPosts,
			IsAdmin = (select count(1) from yaf_UserGroup x,yaf_Group y where x.UserID=a.UserID and y.GroupID=x.GroupID and y.IsAdmin<>0),
			b.RankID,
			RankName = b.Name
		from 
			yaf_User a
			join yaf_Rank b on b.RankID=a.RankID
		where 
			a.BoardID = @BoardID and
			(@Approved is null or a.Approved = @Approved)
		order by 
			a.Name
	else
		select 
			a.*,
			a.NumPosts,
			b.RankID,
			RankName = b.Name,
			NumDays = datediff(d,a.Joined,getdate())+1,
			NumPostsForum = (select count(1) from yaf_Message x where x.Approved<>0),
			HasAvatarImage = (select count(1) from yaf_User x where x.UserID=a.UserID and AvatarImage is not null),
			c.IsAdmin,
			c.IsGuest,
			c.IsForumModerator,
			c.IsModerator
		from 
			yaf_User a
			join yaf_Rank b on b.RankID=a.RankID
			join yaf_vaccess c on c.UserID=a.UserID
		where 
			a.UserID = @UserID and
			a.BoardID = @BoardID and
			c.ForumID = 0 and
			(@Approved is null or a.Approved = @Approved)
		order by 
			a.Name
end
GO

-- yaf_user_emails
if exists (select * from sysobjects where id = object_id(N'yaf_user_emails') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_user_emails
GO

create procedure yaf_user_emails(@BoardID int,@GroupID int=null) as
begin
	if @GroupID = 0 set @GroupID = null
	if @GroupID is null
		select 
			a.Email 
		from 
			yaf_User a
		where 
			a.Email is not null and 
			a.BoardID = @BoardID and
			a.Email is not null and 
			a.Email<>''
	else
		select 
			a.Email 
		from 
			yaf_User a join yaf_UserGroup b on b.UserID=a.UserID
		where 
			b.GroupID = @GroupID and 
			a.Email is not null and 
			a.Email<>''
end
GO

-- yaf_user_find
if exists (select * from sysobjects where id = object_id(N'yaf_user_find') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_user_find
GO

create procedure yaf_user_find(@BoardID int,@Filter bit,@UserName varchar(50)=null,@Email varchar(50)=null) as
begin
	if @Filter<>0
	begin
		if @UserName is not null
			set @UserName = '%' + @UserName + '%'

		select 
			a.*,
			IsGuest = (select count(1) from yaf_UserGroup x,yaf_Group y where x.UserID=a.UserID and x.GroupID=y.GroupID and y.IsGuest<>0)
		from 
			yaf_User a
		where 
			a.BoardID=@BoardID and
			(@UserName is not null and a.Name like @UserName) or (@Email is not null and Email like @Email)
		order by
			a.Name
	end else
	begin
		select 
			a.UserID,
			IsGuest = (select count(1) from yaf_UserGroup x,yaf_Group y where x.UserID=a.UserID and x.GroupID=y.GroupID and y.IsGuest<>0)
		from 
			yaf_User a
		where 
			a.BoardID=@BoardID and
			(@UserName is not null and a.Name=@UserName) or (@Email is not null and Email=@Email)
	end
end
GO

-- yaf_nntpserver_list
if exists (select * from sysobjects where id = object_id(N'yaf_nntpserver_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_nntpserver_list
GO

create procedure yaf_nntpserver_list(@BoardID int=null,@NntpServerID int=null) as
begin
	if @NntpServerID is null
		select * from yaf_NntpServer where BoardID=@BoardID order by Name
	else
		select * from yaf_NntpServer where NntpServerID=@NntpServerID
end
GO

-- yaf_nntpserver_save
if exists (select * from sysobjects where id = object_id(N'yaf_nntpserver_save') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_nntpserver_save
GO

create procedure yaf_nntpserver_save(
	@NntpServerID 	int=null,
	@BoardID	int,
	@Name		varchar(50),
	@Address	varchar(100),
	@UserName	varchar(50)=null,
	@UserPass	varchar(50)=null
) as begin
	if @NntpServerID is null
		insert into yaf_NntpServer(Name,BoardID,Address,UserName,UserPass)
		values(@Name,@BoardID,@Address,@UserName,@UserPass)
	else
		update yaf_NntpServer set
			Name = @Name,
			Address = @Address,
			UserName = @UserName,
			UserPass = @UserPass
		where NntpServerID = @NntpServerID
end
GO

-- yaf_nntpforum_list
if exists (select * from sysobjects where id = object_id(N'yaf_nntpforum_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_nntpforum_list
GO

create procedure yaf_nntpforum_list(@BoardID int,@Minutes int=null,@NntpForumID int=null) as
begin
	select
		a.Name,
		a.Address,
		a.NntpServerID,
		b.NntpForumID,
		b.GroupName,
		b.ForumID,
		b.LastMessageNo,
		b.LastUpdate,
		ForumName = c.Name
	from
		yaf_NntpServer a,
		yaf_NntpForum b,
		yaf_Forum c
	where
		b.NntpServerID = a.NntpServerID and
		(@Minutes is null or datediff(n,b.LastUpdate,getdate())>@Minutes) and
		(@NntpForumID is null or b.NntpForumID=@NntpForumID) and
		c.ForumID = b.ForumID and
		a.BoardID=@BoardID
	order by
		a.Name,
		b.GroupName
end
GO

-- yaf_smiley_listunique
if exists (select * from sysobjects where id = object_id(N'yaf_smiley_listunique') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_smiley_listunique
GO

create procedure yaf_smiley_listunique(@BoardID int) as
begin
	select 
		Icon, 
		Emoticon,
		Code = (select top 1 Code from yaf_Smiley x where x.Icon=yaf_Smiley.Icon)
	from 
		yaf_Smiley
	where
		BoardID=@BoardID
	group by
		Icon,
		Emoticon
	order by
		Code
end
GO

-- yaf_smiley_list
if exists (select * from sysobjects where id = object_id(N'yaf_smiley_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_smiley_list
GO

create procedure yaf_smiley_list(@BoardID int,@SmileyID int=null) as
begin
	if @SmileyID is null
		select * from yaf_Smiley where BoardID=@BoardID order by LEN(Code) desc
	else
		select * from yaf_Smiley where SmileyID=@SmileyID
end
GO

-- yaf_smiley_save
if exists (select * from sysobjects where id = object_id(N'yaf_smiley_save') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_smiley_save
GO

create procedure yaf_smiley_save(@SmileyID int=null,@BoardID int,@Code varchar(10),@Icon varchar(50),@Emoticon varchar(50),@Replace smallint=0) as begin
	if @SmileyID is not null begin
		update yaf_Smiley set Code = @Code, Icon = @Icon, Emoticon = @Emoticon where SmileyID = @SmileyID
	end
	else begin
		if @Replace>0
			delete from yaf_Smiley where Code=@Code

		if not exists(select 1 from yaf_Smiley where BoardID=@BoardID and Code=@Code)
			insert into yaf_Smiley(BoardID,Code,Icon,Emoticon) values(@BoardID,@Code,@Icon,@Emoticon)
	end
end
GO

-- yaf_post_list
if exists (select * from sysobjects where id = object_id(N'yaf_post_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_post_list
GO

create procedure yaf_post_list(@TopicID int,@UpdateViewCount smallint=1) as
begin
	set nocount on

	if @UpdateViewCount>0
		update yaf_Topic set [Views] = [Views] + 1 where TopicID = @TopicID

	select
		d.TopicID,
		a.MessageID,
		a.Posted,
		Subject = d.Topic,
		a.Message,
		a.UserID,
		UserName	= IsNull(a.UserName,b.Name),
		b.Joined,
		Posts		= b.NumPosts,
		d.Views,
		d.ForumID,
		Avatar = b.Avatar,
		b.Location,
		b.HomePage,
		b.Signature,
		RankName = c.Name,
		c.RankImage,
		HasAttachments	= (select count(1) from yaf_Attachment x where x.MessageID=a.MessageID),
		HasAvatarImage = (select count(1) from yaf_User x where x.UserID=b.UserID and AvatarImage is not null)
	from
		yaf_Message a
		join yaf_User b on b.UserID=a.UserID
		join yaf_Topic d on d.TopicID=a.TopicID
		join yaf_Forum g on g.ForumID=d.ForumID
		join yaf_Category h on h.CategoryID=g.CategoryID
		join yaf_Rank c on c.RankID=b.RankID
	where
		a.Approved <> 0 and
		a.TopicID = @TopicID
	order by
		a.Posted asc
end
GO

-- yaf_user_adminsave
if exists (select * from sysobjects where id = object_id(N'yaf_user_adminsave') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_user_adminsave
GO

create procedure yaf_user_adminsave(@BoardID int,@UserID int,@Name varchar(50),@Email varchar(50),@IsHostAdmin bit,@RankID int) as
begin
	update yaf_User set
		Name = @Name,
		Email = @Email,
		IsHostAdmin = @IsHostAdmin,
		RankID = @RankID
	where UserID = @UserID
	select UserID = @UserID
end
GO

-- yaf_system_save
if exists (select * from sysobjects where id = object_id(N'yaf_system_save') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_system_save
GO

create procedure yaf_system_save(
	@TimeZone			int,
	@SmtpServer			varchar(50),
	@SmtpUserName		varchar(50)=null,
	@SmtpUserPass		varchar(50)=null,
	@ForumEmail			varchar(50),
	@EmailVerification	bit,
	@ShowMoved			bit,
	@BlankLinks			bit,
	@ShowGroups			bit,
	@AvatarWidth		int,
	@AvatarHeight		int,
	@AvatarUpload		bit,
	@AvatarRemote		bit,
	@AvatarSize			int=null,
	@AllowRichEdit		bit,
	@AllowUserTheme		bit,
	@AllowUserLanguage	bit,
	@UseFileTable		bit,
	@MaxFileSize		int=null
) as
begin
	update yaf_System set
		TimeZone = @TimeZone,
		SmtpServer = @SmtpServer,
		SmtpUserName = @SmtpUserName,
		SmtpUserPass = @SmtpUserPass,
		ForumEmail = @ForumEmail,
		EmailVerification = @EmailVerification,
		ShowMoved = @ShowMoved,
		BlankLinks = @BlankLinks,
		ShowGroups = @ShowGroups,
		AvatarWidth = @AvatarWidth,
		AvatarHeight = @AvatarHeight,
		AvatarUpload = @AvatarUpload,
		AvatarRemote = @AvatarRemote,
		AvatarSize = @AvatarSize,
		AllowRichEdit = @AllowRichEdit,
		AllowUserTheme = @AllowUserTheme,
		AllowUserLanguage = @AllowUserLanguage,
		UseFileTable = @UseFileTable,
		MaxFileSize = @MaxFileSize
end
GO

-- yaf_board_save
if exists (select * from sysobjects where id = object_id(N'yaf_board_save') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_board_save
GO

create procedure yaf_board_save(@BoardID int,@Name varchar(50)) as
begin
	update yaf_Board set
		[Name] = @Name
	where BoardID=@BoardID
end
GO

-- yaf_post_last10user
if exists (select * from sysobjects where id = object_id(N'yaf_post_last10user') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_post_last10user
GO

create procedure yaf_post_last10user(@BoardID int,@UserID int,@PageUserID int) as
begin
	set nocount on

	select top 10
		a.Posted,
		Subject = c.Topic,
		a.Message,
		a.UserID,
		UserName = IsNull(a.UserName,b.Name),
		b.Signature,
		c.TopicID
	from
		yaf_Message a
		join yaf_User b on b.UserID=a.UserID
		join yaf_Topic c on c.TopicID=a.TopicID
		join yaf_Forum d on d.ForumID=c.ForumID
		join yaf_Category e on e.CategoryID=d.CategoryID
		join yaf_vaccess x on x.ForumID=d.ForumID
	where
		a.Approved <> 0 and
		a.UserID = @UserID and
		x.UserID = @PageUserID and
		x.ReadAccess <> 0 and
		e.BoardID = @BoardID
	order by
		a.Posted desc
end
GO

-- yaf_topic_active
if exists (select * from sysobjects where id = object_id(N'yaf_topic_active') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_topic_active
GO

create procedure yaf_topic_active(@BoardID int,@UserID int,@Since datetime) as
begin
	select
		c.ForumID,
		c.TopicID,
		c.Posted,
		LinkTopicID = IsNull(c.TopicMovedID,c.TopicID),
		Subject = c.Topic,
		c.UserID,
		Starter = IsNull(c.UserName,b.Name),
		Replies = (select count(1) from yaf_Message x where x.TopicID=c.TopicID) - 1,
		Views = c.Views,
		LastPosted = c.LastPosted,
		LastUserID = c.LastUserID,
		LastUserName = IsNull(c.LastUserName,(select Name from yaf_User x where x.UserID=c.LastUserID)),
		LastMessageID = c.LastMessageID,
		LastTopicID = c.TopicID,
		c.IsLocked,
		c.Priority,
		c.PollID,
		ForumName = d.Name,
		c.TopicMovedID,
		ForumLocked = d.Locked
	from
		yaf_Topic c
		join yaf_User b on b.UserID=c.UserID
		join yaf_Forum d on d.ForumID=c.ForumID
		join yaf_vaccess x on x.ForumID=d.ForumID
		join yaf_Category e on e.CategoryID=d.CategoryID
	where
		@Since < c.LastPosted and
		x.UserID = @UserID and
		x.ReadAccess <> 0 and
		e.BoardID = @BoardID
	order by
		d.Name asc,
		Priority desc,
		LastPosted desc
end
GO

-- yaf_user_accessmasks
if exists (select * from sysobjects where id = object_id(N'yaf_user_accessmasks') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_user_accessmasks
GO

create procedure yaf_user_accessmasks(@BoardID int,@UserID int) as
begin
	select * from(
		select
			AccessMaskID	= e.AccessMaskID,
			AccessMaskName	= e.Name,
			ForumID			= f.ForumID,
			ForumName		= f.Name
		from
			yaf_User a 
			join yaf_UserGroup b on b.UserID=a.UserID
			join yaf_Group c on c.GroupID=b.GroupID
			join yaf_ForumAccess d on d.GroupID=c.GroupID
			join yaf_AccessMask e on e.AccessMaskID=d.AccessMaskID
			join yaf_Forum f on f.ForumID=d.ForumID
		where
			a.UserID=@UserID and
			c.BoardID=@BoardID
		group by
			e.AccessMaskID,
			e.Name,
			f.ForumID,
			f.Name
		
		union
			
		select
			AccessMaskID	= c.AccessMaskID,
			AccessMaskName	= c.Name,
			ForumID			= d.ForumID,
			ForumName		= d.Name
		from
			yaf_User a 
			join yaf_UserForum b on b.UserID=a.UserID
			join yaf_AccessMask c on c.AccessMaskID=b.AccessMaskID
			join yaf_Forum d on d.ForumID=b.ForumID
		where
			a.UserID=@UserID and
			c.BoardID=@BoardID
		group by
			c.AccessMaskID,
			c.Name,
			d.ForumID,
			d.Name
	) as x
	order by
		ForumName, AccessMaskName
end
GO

-- yaf_usergroup_list
if exists (select * from sysobjects where id = object_id(N'yaf_usergroup_list') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_usergroup_list
GO

create procedure yaf_usergroup_list(@BoardID int,@UserID int) as begin
	select 
		b.GroupID,
		b.Name
	from
		yaf_UserGroup a
		join yaf_Group b on b.GroupID=a.GroupID
	where
		a.UserID = @UserID and
		b.BoardID = @BoardID
	order by
		b.Name
end
GO

-- yaf_user_login
if exists (select * from sysobjects where id = object_id(N'yaf_user_login') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_user_login
GO

create procedure yaf_user_login(@BoardID int,@Name varchar(50),@Password varchar(32)) as
begin
	declare @UserID int

	if not exists(select UserID from yaf_User where [Name]=@Name and [Password]=@Password and (BoardID=@BoardID or IsHostAdmin<>0))
		set @UserID=null
	else
		select 
			@UserID=UserID 
		from 
			yaf_User 
		where 
			[Name]=@Name and 
			[Password]=@Password and 
			(BoardID=@BoardID or IsHostAdmin<>0)

	select @UserID
end
GO

-- yaf_system_initialize
if exists (select * from sysobjects where id = object_id(N'yaf_system_initialize') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_system_initialize
GO

create procedure yaf_system_initialize(
	@Name		varchar(50),
	@TimeZone	int,
	@ForumEmail	varchar(50),
	@SmtpServer	varchar(50),
	@User		varchar(50),
	@UserEmail	varchar(50),
	@Password	varchar(32)
) as 
begin
	SET IDENTITY_INSERT yaf_System ON
	insert into yaf_System(SystemID,Version,VersionName,TimeZone,SmtpServer,ForumEmail,AvatarWidth,AvatarHeight,AvatarUpload,AvatarRemote,EmailVerification,ShowMoved,BlankLinks,ShowGroups,AllowRichEdit,AllowUserTheme,AllowUserLanguage,UseFileTable)
	values(1,1,'0.9.5',@TimeZone,@SmtpServer,@ForumEmail,50,80,0,0,1,1,0,1,1,0,0,0)
	SET IDENTITY_INSERT yaf_System OFF

	exec yaf_board_create @Name,@User,@UserEmail,@Password,1
end
GO

-- yaf_board_create
if exists (select * from sysobjects where id = object_id(N'yaf_board_create') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure yaf_board_create
GO

create procedure yaf_board_create(
	@BoardName 		varchar(50),
	@UserName		varchar(50),
	@UserEmail		varchar(50),
	@UserPass		varchar(32),
	@IsHostAdmin	bit
) as 
begin
	declare @BoardID		int
	declare @TimeZone		int
	declare @ForumEmail		varchar(50)
	declare	@GroupIDAdmin		int
	declare	@GroupIDGuest		int
	declare @GroupIDMember		int
	declare	@AccessMaskIDAdmin	int
	declare @AccessMaskIDModerator	int
	declare @AccessMaskIDMember	int
	declare	@AccessMaskIDReadOnly	int
	declare @UserIDAdmin		int
	declare @UserIDGuest		int
	declare @RankIDAdmin		int
	declare @RankIDGuest		int
	declare @RankIDNewbie		int
	declare @RankIDMember		int
	declare @RankIDAdvanced		int
	declare	@CategoryID		int
	declare	@ForumID		int

	select @TimeZone=TimeZone,@ForumEmail=ForumEmail from yaf_System

	-- yaf_Board
	insert into yaf_Board([Name]) values(@BoardName)
	set @BoardID = @@IDENTITY

	-- yaf_Rank
	insert into yaf_Rank(BoardID,Name,IsStart,IsLadder,MinPosts) values(@BoardID,'Administration',0,0,null)
	set @RankIDAdmin = @@IDENTITY
	insert into yaf_Rank(BoardID,Name,IsStart,IsLadder,MinPosts) values(@BoardID,'Guest',0,0,null)
	set @RankIDGuest = @@IDENTITY
	insert into yaf_Rank(BoardID,Name,IsStart,IsLadder,MinPosts) values(@BoardID,'Newbie',1,1,0)
	set @RankIDNewbie = @@IDENTITY
	insert into yaf_Rank(BoardID,Name,IsStart,IsLadder,MinPosts) values(@BoardID,'Member',0,1,10)
	set @RankIDMember = @@IDENTITY
	insert into yaf_Rank(BoardID,Name,IsStart,IsLadder,MinPosts) values(@BoardID,'Advanced Member',0,1,30)
	set @RankIDAdvanced = @@IDENTITY

	-- yaf_AccessMask
	insert into yaf_AccessMask(BoardID,Name,ReadAccess,PostAccess,ReplyAccess,PriorityAccess,PollAccess,VoteAccess,ModeratorAccess,EditAccess,DeleteAccess,UploadAccess)
	values(@BoardID,'Admin Access Mask',1,1,1,1,1,1,1,1,1,1)
	set @AccessMaskIDAdmin = @@IDENTITY
	insert into yaf_AccessMask(BoardID,Name,ReadAccess,PostAccess,ReplyAccess,PriorityAccess,PollAccess,VoteAccess,ModeratorAccess,EditAccess,DeleteAccess,UploadAccess)
	values(@BoardID,'Moderator Access Mask',1,1,1,0,0,1,1,1,1,0)
	set @AccessMaskIDModerator = @@IDENTITY
	insert into yaf_AccessMask(BoardID,Name,ReadAccess,PostAccess,ReplyAccess,PriorityAccess,PollAccess,VoteAccess,ModeratorAccess,EditAccess,DeleteAccess,UploadAccess)
	values(@BoardID,'Member Access Mask',1,1,1,0,0,1,0,1,1,0)
	set @AccessMaskIDMember = @@IDENTITY
	insert into yaf_AccessMask(BoardID,Name,ReadAccess,PostAccess,ReplyAccess,PriorityAccess,PollAccess,VoteAccess,ModeratorAccess,EditAccess,DeleteAccess,UploadAccess)
	values(@BoardID,'Read Only Access Mask',1,0,0,0,0,0,0,0,0,0)
	set @AccessMaskIDReadOnly = @@IDENTITY

	-- yaf_Group
	insert into yaf_Group(BoardID,Name,IsAdmin,IsGuest,IsStart,IsModerator) values(@BoardID,'Administration',1,0,0,0)
	set @GroupIDAdmin = @@IDENTITY
	insert into yaf_Group(BoardID,Name,IsAdmin,IsGuest,IsStart,IsModerator) values(@BoardID,'Guest',0,1,0,0)
	set @GroupIDGuest = @@IDENTITY
	insert into yaf_Group(BoardID,Name,IsAdmin,IsGuest,IsStart,IsModerator) values(@BoardID,'Member',0,0,1,0)
	set @GroupIDMember = @@IDENTITY

	-- yaf_User
	insert into yaf_User(BoardID,RankID,Name,Password,Joined,LastVisit,NumPosts,TimeZone,Approved,Email,Gender,IsHostAdmin)
	values(@BoardID,@RankIDAdmin,@UserName,@UserPass,getdate(),getdate(),0,@TimeZone,1,@UserEmail,0,@IsHostAdmin)
	set @UserIDAdmin = @@IDENTITY

	insert into yaf_User(BoardID,RankID,Name,Password,Joined,LastVisit,NumPosts,TimeZone,Approved,Email,Gender,IsHostAdmin)
	values(@BoardID,@RankIDGuest,'Guest','na',getdate(),getdate(),0,@TimeZone,1,@ForumEmail,0,0)
	set @UserIDGuest = @@IDENTITY

	-- yaf_UserGroup
	insert into yaf_UserGroup(UserID,GroupID) values(@UserIDAdmin,@GroupIDAdmin)
	insert into yaf_UserGroup(UserID,GroupID) values(@UserIDGuest,@GroupIDGuest)

	-- yaf_Category
	insert into yaf_Category(CategoryID,BoardID,Name,SortOrder) values(1,@BoardID,'Test Category',1)
	set @CategoryID = @@IDENTITY
	
	-- yaf_Forum
	insert into yaf_Forum(CategoryID,Name,Description,SortOrder,Locked,Hidden,IsTest,Moderated,NumTopics,NumPosts)
	values(@CategoryID,'Test Forum','A test forum',1,0,0,1,0,0,0)
	set @ForumID = @@IDENTITY

	-- yaf_ForumAccess
	insert into yaf_ForumAccess(GroupID,ForumID,AccessMaskID) values(@GroupIDAdmin,@ForumID,@AccessMaskIDAdmin)
	insert into yaf_ForumAccess(GroupID,ForumID,AccessMaskID) values(@GroupIDGuest,@ForumID,@AccessMaskIDReadOnly)
	insert into yaf_ForumAccess(GroupID,ForumID,AccessMaskID) values(@GroupIDMember,@ForumID,@AccessMaskIDMember)
end
GO
