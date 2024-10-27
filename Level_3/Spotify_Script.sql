DROP DATABASE IF EXISTS SpotifyDB;
CREATE DATABASE SpotifyDB;
USE SpotifyDB;

CREATE TABLE Artist (
    ArtistID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    ArtistImage VARCHAR(255)
);

CREATE TABLE Album (
    AlbumID INT PRIMARY KEY AUTO_INCREMENT,
    ArtistID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    CoverImage VARCHAR(255),
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID)
);

CREATE TABLE Song (
    SongID INT PRIMARY KEY AUTO_INCREMENT,
    AlbumID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Duration TIME NOT NULL,
    PlayCount INT DEFAULT 0,
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)
);

CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Username VARCHAR(100) NOT NULL,
    BirthDate DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Country VARCHAR(100),
    PostalCode VARCHAR(10),
    UserType ENUM('Free', 'Premium') NOT NULL
);

CREATE TABLE Subscription (
    SubscriptionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    StartDate DATE NOT NULL,
    RenewalDate DATE NOT NULL,
    PaymentMethod ENUM('CreditCard', 'PayPal') NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE CreditCard (
    CardID INT PRIMARY KEY AUTO_INCREMENT,
    SubscriptionID INT NOT NULL,
    CardNumber VARCHAR(16) NOT NULL,
    ExpiryMonth INT NOT NULL,
    ExpiryYear INT NOT NULL,
    SecurityCode VARCHAR(4) NOT NULL,
    FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID)
);

CREATE TABLE PayPal (
    PayPalID INT PRIMARY KEY AUTO_INCREMENT,
    SubscriptionID INT NOT NULL,
    PayPalUsername VARCHAR(100) NOT NULL,
    FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    SubscriptionID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    OrderNumber VARCHAR(50) UNIQUE NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID)
);

CREATE TABLE Playlist (
    PlaylistID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    SongCount INT DEFAULT 0,
    CreationDate DATE NOT NULL,
    DeletionDate DATE,
    Status ENUM('Active', 'Deleted') NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE PlaylistContribution (
    PlaylistID INT NOT NULL,
    UserID INT NOT NULL,
    SongID INT NOT NULL,
    ContributionDate DATE NOT NULL,
    PRIMARY KEY (PlaylistID, UserID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (SongID) REFERENCES Song(SongID)
);

CREATE TABLE Follower (
    UserID INT NOT NULL,
    ArtistID INT NOT NULL,
    PRIMARY KEY (UserID, ArtistID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID)
);

CREATE TABLE RelatedArtist (
    ArtistID INT NOT NULL,
    RelatedArtistID INT NOT NULL,
    PRIMARY KEY (ArtistID, RelatedArtistID),
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID),
    FOREIGN KEY (RelatedArtistID) REFERENCES Artist(ArtistID)
);

CREATE TABLE FavoriteAlbum (
    UserID INT NOT NULL,
    AlbumID INT NOT NULL,
    PRIMARY KEY (UserID, AlbumID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)
);

CREATE TABLE FavoriteSong (
    UserID INT NOT NULL,
    SongID INT NOT NULL,
    PRIMARY KEY (UserID, SongID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (SongID) REFERENCES Song(SongID)
);

INSERT INTO User (Email, Password, Username, BirthDate, Gender, Country, PostalCode, UserType) VALUES
('user1@example.com', 'password123', 'user1', '1990-01-01', 'Male', 'USA', '12345', 'Free'),
('user2@example.com', 'password456', 'user2', '1985-05-15', 'Female', 'Canada', 'A1B2C3', 'Premium');

INSERT INTO Subscription (UserID, StartDate, RenewalDate, PaymentMethod) VALUES
(2, '2023-01-01', '2024-01-01', 'CreditCard');

INSERT INTO CreditCard (SubscriptionID, CardNumber, ExpiryMonth, ExpiryYear, SecurityCode) VALUES
(1, '1234567812345678', 12, 2025, '123');

INSERT INTO Payment (SubscriptionID, PaymentDate, OrderNumber, Total) VALUES
(1, '2023-01-01', 'ORD001', 9.99);

INSERT INTO Artist (Name, ArtistImage) VALUES
('Artist1', 'artist1.jpg'),
('Artist2', 'artist2.jpg');

INSERT INTO Album (ArtistID, Title, ReleaseYear, CoverImage) VALUES
(1, 'Album1', 2021, 'album1.jpg'),
(2, 'Album2', 2022, 'album2.jpg');

INSERT INTO Song (AlbumID, Title, Duration, PlayCount) VALUES
(1, 'Song1', '00:03:45', 100),
(1, 'Song2', '00:04:20', 200),
(2, 'Song3', '00:02:50', 150);

INSERT INTO Playlist (UserID, Title, SongCount, CreationDate, Status) VALUES
(1, 'My Playlist 1', 2, '2023-01-10', 'Active'),
(2, 'My Playlist 2', 1, '2023-02-15', 'Deleted');

INSERT INTO PlaylistContribution (PlaylistID, UserID, SongID, ContributionDate) VALUES
(1, 1, 1, '2023-01-12'),
(1, 1, 2, '2023-01-13');

INSERT INTO Follower (UserID, ArtistID) VALUES
(1, 1),
(2, 2);

INSERT INTO RelatedArtist (ArtistID, RelatedArtistID) VALUES
(1, 2);

INSERT INTO FavoriteAlbum (UserID, AlbumID) VALUES
(1, 1),
(2, 2);

INSERT INTO FavoriteSong (UserID, SongID) VALUES
(1, 1),
(2, 3);

SELECT 
    User.UserID,
    User.Username,
    Playlist.Title AS PlaylistTitle,
    Playlist.SongCount,
    Playlist.Status
FROM 
    User
JOIN 
    Playlist ON User.UserID = Playlist.UserID;

SELECT 
    Album.Title AS AlbumTitle,
    Artist.Name AS ArtistName,
    Album.ReleaseYear,
    SUM(Song.PlayCount) AS TotalPlayCount
FROM 
    Album
JOIN 
    Artist ON Album.ArtistID = Artist.ArtistID
JOIN 
    Song ON Album.AlbumID = Song.AlbumID
GROUP BY 
    Album.AlbumID, Artist.Name, Album.ReleaseYear;
