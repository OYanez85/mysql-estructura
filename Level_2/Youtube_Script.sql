CREATE DATABASE YouTubeDB;
USE YouTubeDB;

CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Username VARCHAR(100) NOT NULL,
    BirthDate DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Country VARCHAR(100),
    PostalCode VARCHAR(10)
);

CREATE TABLE Video (
    VideoID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    FileSize DECIMAL(10, 2),
    FileName VARCHAR(255) NOT NULL,
    Duration TIME,
    Thumbnail VARCHAR(255),
    ViewCount INT DEFAULT 0,
    LikeCount INT DEFAULT 0,
    DislikeCount INT DEFAULT 0,
    Status ENUM('Public', 'Hidden', 'Private') NOT NULL,
    PublishDateTime DATETIME NOT NULL,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Tag (
    TagID INT PRIMARY KEY AUTO_INCREMENT,
    TagName VARCHAR(100) NOT NULL
);

CREATE TABLE VideoTag (
    VideoID INT,
    TagID INT,
    PRIMARY KEY (VideoID, TagID),
    FOREIGN KEY (VideoID) REFERENCES Video(VideoID),
    FOREIGN KEY (TagID) REFERENCES Tag(TagID)
);

CREATE TABLE Channel (
    ChannelID INT PRIMARY KEY AUTO_INCREMENT,
    ChannelName VARCHAR(100) NOT NULL,
    Description TEXT,
    CreationDate DATE NOT NULL,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Subscription (
    SubscriberID INT,
    ChannelID INT,
    SubscriptionDate DATETIME NOT NULL,
    PRIMARY KEY (SubscriberID, ChannelID),
    FOREIGN KEY (SubscriberID) REFERENCES User(UserID),
    FOREIGN KEY (ChannelID) REFERENCES Channel(ChannelID)
);

CREATE TABLE VideoReaction (
    ReactionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    VideoID INT NOT NULL,
    ReactionType ENUM('Like', 'Dislike') NOT NULL,
    ReactionDateTime DATETIME NOT NULL,
    UNIQUE (UserID, VideoID, ReactionType),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (VideoID) REFERENCES Video(VideoID)
);

CREATE TABLE Playlist (
    PlaylistID INT PRIMARY KEY AUTO_INCREMENT,
    PlaylistName VARCHAR(100) NOT NULL,
    CreationDate DATE NOT NULL,
    Status ENUM('Public', 'Private') NOT NULL,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE PlaylistVideo (
    PlaylistID INT,
    VideoID INT,
    PRIMARY KEY (PlaylistID, VideoID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID),
    FOREIGN KEY (VideoID) REFERENCES Video(VideoID)
);

CREATE TABLE Comment (
    CommentID INT PRIMARY KEY AUTO_INCREMENT,
    VideoID INT NOT NULL,
    UserID INT NOT NULL,
    CommentText TEXT NOT NULL,
    CommentDateTime DATETIME NOT NULL,
    FOREIGN KEY (VideoID) REFERENCES Video(VideoID),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE CommentReaction (
    ReactionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    CommentID INT NOT NULL,
    ReactionType ENUM('Like', 'Dislike') NOT NULL,
    ReactionDateTime DATETIME NOT NULL,
    UNIQUE (UserID, CommentID, ReactionType),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (CommentID) REFERENCES Comment(CommentID)
);
