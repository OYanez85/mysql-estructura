# mysql-estructura
SQL
Database Project: Entity-Relationship Models for Various Applications
Description
This project models entity-relationship diagrams and databases for three applications: Optics, Pizzeria, and Streaming Platforms (YouTube & Spotify). Each application is divided into levels, with each level introducing new complexity and requirements.

The project includes:

Level 1: An optical store and a pizzeria database
Level 2: A basic YouTube database model
Level 3: A simplified Spotify database model

Each level covers detailed information for each application, specifying unique data requirements and relationships.

# Level 1

## Exercise 1: Optics (Òptica “Cul d'Ampolla”)
The optical store needs a database to manage its customers and eyeglass sales.

Supplier Information: Track each eyeglass supplier, including:

Name, address (street, number, floor, door, city, postal code, country), phone, fax, and tax ID (NIF).
Eyeglass Details: Each pair of glasses is uniquely linked to one supplier and has:

Brand, lens prescription, frame type (rimless, plastic, or metal), frame color, lens color, and price.
Customer Information: Each customer record includes:

Name, postal address, phone, email, registration date, and referral details (if referred by another customer).
Employee Sales: Track which employee sold each pair of glasses.

## Exercise 2: Pizzeria
The pizzeria requires a database for online food delivery orders.

Customer Details: For each customer:

Store a unique ID, name, address, postal code, city, province, and phone number.
City and province data are stored in separate tables, where each city is linked to a single province, but each province may contain multiple cities.
Order Management: Each customer can place multiple orders, but each order is associated with only one customer.

Store details for each order: date/time, delivery or in-store pickup, product quantities, and total price.
Product Catalog: Products include pizzas, burgers, and drinks. Store for each:

Unique ID, name, description, image, and price.
Pizzas are categorized, with each pizza linked to only one category. Categories can vary over time, with each containing multiple pizzas.
Store Information: Each order is handled by a single store, and each store can manage multiple orders.

Store details: unique ID, address, postal code, city, and province.
Employee Information: Each employee works in only one store. For each employee:

Track name, last name, tax ID (NIF), phone, and role (cook or delivery driver).
For delivery orders, record the delivery driver and the date/time of delivery.

# Level 2

## Exercise 1: YouTube

Modeling a basic version of a YouTube database with users, videos, channels, playlists, and comments.

User Information: Each user has a unique ID, email, password, username, date of birth, gender, country, and postal code.

Video Publishing: Users can publish videos. For each video:

Track a unique ID, title, description, file size, file name, duration, thumbnail, views, likes, dislikes, and publish date/time.
Each video can have multiple tags (keywords), but each tag is stored with a unique ID and name.
Channel Management: Users can create channels. For each channel:

Track a unique ID, name, description, and creation date.
Subscription and Likes: Users can subscribe to other channels and like/dislike videos once. For each like/dislike:

Track user, video, and date/time of action.
Playlist Creation: Users can create playlists of their favorite videos. For each playlist:

Track a unique ID, name, creation date, and status (public or private).
Comments and Likes: Users can comment on videos, and each comment can be liked or disliked by others. For each comment:

Store unique ID, text, date/time, and track likes/dislikes with user and date/time.

# Level 3

## Exercise 1: Spotify

This level models a Spotify-like music streaming database with users, subscriptions, playlists, songs, albums, and artists.

User Information: There are two types of users: free and premium. Each user has:

Unique ID, email, password, username, date of birth, gender, country, and postal code.
Subscriptions: Premium users have subscriptions, each with:

Start date, renewal date, and payment method (credit card or PayPal).
For credit cards: card number, expiration month/year, and security code.
For PayPal: PayPal username.
Track all payments made by premium users, including date, unique order number, and total amount.
Playlist Management: Users can create multiple playlists. For each playlist:

Track a unique ID, title, song count, creation date, and deletion status.
Active playlists can be shared with other users, who may add songs. Track who added each song and when.
Song, Album, and Artist Information: Songs belong to one album, while albums are published by a single artist.

For each song: unique ID, title, duration, and play count.
For each album: unique ID, title, release year, and cover image.
For each artist: unique ID, name, and image.
Favorites and Related Artists: Users can follow multiple artists and mark albums/songs as favorites. Artists may be related to others with similar music.

Resources and Verification Queries
To verify database accuracy, execute the following queries:

## Optics:

List the total invoices for a customer within a specific period.
List eyeglass models sold by an employee in a given year.
List suppliers who provided glasses that were successfully sold by the store.

## Pizzeria:

List the number of products from the "Beverages" category sold in a specific city.
List the total orders handled by a specific employee.

## YouTube:

List users who liked a specific video and the date/time of the like.
List public videos posted by a user, including views and tags.

## Spotify:

List playlists created by a user, including active and deleted playlists.
List total play counts for all songs in an album by a specific artist.

## SQL Code

Database Creation and Setup
Each application uses a unique schema defined in the SQL code provided. Follow these steps:

Set up tables and relationships for each level, including unique keys and foreign key constraints.
Insert sample data to test relationships and query functionality.

## Execution

Execute each level’s database creation script.
Run the verification queries to confirm data accuracy and relational integrity.
