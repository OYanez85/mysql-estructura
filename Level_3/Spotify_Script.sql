CREATE DATABASE SpotifyDB;
USE SpotifyDB;

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

CREATE TABLE Song (
    SongID INT PRIMARY KEY AUTO_INCREMENT,
    AlbumID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Duration TIME NOT NULL,
    PlayCount INT DEFAULT 0,
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)
);

CREATE TABLE Album (
    AlbumID INT PRIMARY KEY AUTO_INCREMENT,
    ArtistID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    CoverImage VARCHAR(255),
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID)
);

CREATE TABLE Artist (
    ArtistID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    ArtistImage VARCHAR(255)
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
    FOREIGN KEY (RelatedArtistID) REFERENCES Artist(RelatedArtistID)
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
