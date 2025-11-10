# Software Requirements Specification: Flow State

## Introduction

### Purpose

Every single person will experience some form of anxiety or stress in their life, and around 4% of the population live everyday with a diagnosed anxiety condition. Flow State is a mobile app designed with the aim to help reduce any stress, anxiety, or other negative emotions one might encounter

### Scope

Whether anxiety be a daily occurence or once in a while, or whether you have 15 minutes to practice a guided meditation session or under a minute to lock in before a job interview, Flow State desires to have the perfect meditation exprience for anyone, anytime.

### Definitions, Acronyms, and Abbreviations

## Overview

Flow State desires to have the perfect anxiety/stress combatting technique for everyone no matter who you are or what you can fit in to your timeframe.

### System Features

1. **Secure Login**: Username login system with Hive NoSQL Database, user selects tags to personalize app.
2. **Personalized User Experience**: Depending on user selected tags after login, each user will have a unique selection of stress relief techniques based on the tags that they choose. However, all techniques are always available for users to try out.
3. **Various Meditation Techniques**: Users can choose from multiple different meditation techniques
4. **Achievement System**: Users can start a "streak" after 3 consecutive login days in a row.
5. **Notification System**: Users can set a daily meditation time if they choose to, and the app will notify them at the specified time everyday.
6. **Support for Multiple Languages/App Themes**: Support for the most common languages and a Light/Dark App theme.

## Use Cases
### Use Case 1.1: Login
- **Actors**: User
- **Overview**: User enters their name to access the app
  
**Typical Course of Events**:
1. Prompts for username
2. User enters a username
3. System logs user in
   
**Alternative Courses**:
- **Step 3**: Username is blank
  1. Pop up error
  2. Go back to step 2
 
### Use Case 1.2: Tag Select
- **Actors**: User
- **Overview**: After logging in, user selects "tags" that personalize the meditation techniques based on selected tags.
  
**Typical Course of Events**:
1. Lists out all tags that can be left selected or unselected
2. User selects whichever tags they choose
3. Tags are added as a list to the user's profile in the system to remember what they chose
   
**Alternative Courses**:
- **Step 3**: User selects no tags
  1. Pop up error (Must select at least 1 tag)
  2. Go back to step 2.
