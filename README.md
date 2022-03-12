Unit 8: Group Milestone - README
===

# FRIENDOS

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Creates a profile for a user based on hobbies they enjoy, and connects them with individuals with similar hobbies. Can be used for making new friends who enjoy similar activities.

### App Evaluation
- **Category:** Social Networking / Hobbies
- **Mobile:** This app would be primarily developed for mobile devices.
- **Story:** Analyzes users' hobbies, and connects them to other users with similar choices.
- **Market:** Any individual 17+ could choose to use this app.
- **Habit:** This app could be used as often or unoften as the user wanted depending on how deep their social life is, and what exactly they're looking for.
- **Scope:** First we'll start with connecting people based on their interests, and then as we expand we can allow them to message each other within the app and increase customization options.

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**
### Tier 1

* User logs into app via Facebook API authentication
* User can edit profile screen, including adding interest and a bio
* User can view their own bio
* User can see a list of people using the app
* User can view an individual person's profile, including bio and interests
* User can add comments to a person's profile

### Tier 2

* User can add new interests to their list
* User can add a location to their profile
* User can connect with another individual
* User can edit the background color of their profile
* User can send a referral link to others to invite them to join Friendos

**Optional Nice-to-have Stories**
### Tier 3

* User can create and use a group chat based on Facebook Messenger API
* User can add a story that links keywords
* User can further customize their individual profile

### 2. Screen Archetypes

* Login 
   * User can register and login via Facebook.
* Home Screen
   * Shows other users that match with the user.
* Profile Screen 
   * Allows user to upload a photo, create a bio, and share their interests with others.
* Settings Screen
   * Lets the user change their settings.
* People Profile Screen
   * Shows detailed profiles of other users.
* Connection Request Screen
   * Allows user to request to connect with other users.
* My Requests Screen
   * Allows user to accept or reject requests from other users.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Profile
* My Requests
* Settings

**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Account creation if no log in is available.
* Create Profile or Jumps to Home Page, if user already has an account.
* Profile -> Settings.
* Settings -> Toggle settings.
* Home Page -> Other Profiles.
* Other Profiles -> Connection Request.
* Home Page -> My Requests.

## Wireframes
<img src="https://i.imgur.com/wFyo3PV.jpg" width=800><br>

## Schema

### Models
<img src="https://i.imgur.com/HeoJbKK.png" width=800><br>

### Networking
* Login Screen
* Home Screen
* Profile Screen
* Settings Screen
* People Profile Screen
* Connection Request Screen
* My Requests Screen

