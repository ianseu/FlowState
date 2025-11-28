# Software Requirements Specification: Flow State

### Key
- App Code Location: `flowstate/lib`
- Package Location: `flowstate/pubspec.yaml`
- Image Location: `flowstate/assets/icons`
- Video Location: Videos are apart of an AWS S3 Bucket and are fetched directly in the app code.

## Introduction

### Purpose

Every single person will experience some form of anxiety or stress in their life, and around 4% of the population live everyday with a diagnosed anxiety condition. Flow State is a mobile app designed with the aim to help reduce any stress, anxiety, or other negative emotions one might encounter in their day to day lives. The top 2 meditation apps have been downloaded over 100 million times, but only around half of users continue to use them after 2 weeks, and only 2-4% after one year. When downloading and trying out the top app, I found it hard find what I was looking for.

### Scope

Whether anxiety be a daily occurence or once in a while, or whether you have 15 minutes to practice a guided meditation session or under a minute to lock in before a job interview, Flow State desires to have the perfect anxiety/stress combatting technique for everyone no matter who you are or how long you can put towards mindfulness. And as a minimalistic person, I need things to be simple, clean, and easily accessible. Searching for stress relief shouldn't add to my stress. This was the starting idea of Flow State; meditation and stress relief practices tailored to each user.

### System Features

1. **User Login**: Username login system with Hive NoSQL Database. User selects tags after login to personalize the app.
2. **Personalized User Experience**: Depending on user selected tags after login, each user will have a unique selection of stress relief techniques based on the tags that they choose. They can also filter to show all techniques.
3. **Favoriting System**: Users can long tap on a technique to add it to a list of their favorites which they can then filter by.
4. **Achievement System**: Users can start a "streak" after consecutive login days in a row.
5. **Notification System**: Users can set a daily meditation time if they choose to, and the app will notify them at the specified time everyday.

## Use Cases
### Use Case 1.1: Login
- **Actors**: User, Hive DB
- **Overview**: User enters their name to access the app.
  
**Typical Course of Events**:
1. Prompts for ausername.
2. User enters a username.
3. System logs user in.
   
**Alternative Courses**:
- **Step 3**: Username is blank/too short/too long.
  1. Pop up error.
  2. Go back to step 2.
 
### Use Case 1.2: Tag Select
- **Actors**: User, Hive DB
- **Overview**: After logging in, user selects "tags" that personalize the meditation techniques based on selected tags.
  
**Typical Course of Events**:
1. Lists out all tags that can be left selected or unselected.
2. User selects whichever tags they choose.
3. Tags are added as a list to the user's profile in the system to remember what they chose.
   
**Alternative Courses**:
- **Step 3**: User selects no tags
  1. Pop up error (Must select at least 1 tag from each category).
  2. Go back to step 2.

### Use Case 2.1: Technique Select
- **Actors**: User
- **Overview**: User is transferred to the home screen where they can select from their personalized meditation techniques, or they can filter to view them all.

**Typical Course of Events**:
1. Lists out all meditation techniques to choose from.
2. User taps a technique.
3. They are brought to the technique page.

### Use Case 2.2: Technique Filter
- **Actors**: User
- **Overview**: User can filter techniques to show all of them, or show only their favorites.

**Typical Course of Events**:
1. Lists out all meditation techniques to choose from.
2. User taps a filter to select or unselect.
3. View is updated with the correct techniques.


### Use Case 2.3: Technique Favorite System
- **Actors**: User, Hive DB
- **Overview**: User can add a technique to a list of their favorites.

**Typical Course of Events**:
1. Lists out all meditation techniques to choose from.
2. User long taps a technique.
3. Technique is brought up with technique tag information.
4. User taps heart icon.
5. Technique is now added to their favorites in the system.

**Alternative Courses**:
- **Step 4**: User taps off screen
  1. User is redirected back to home screen and technique isn't added to favorites.

### Use Case 3.1: Technique Screen
- **Actors**: User
- **Overview**: User views technique video.

**Typical Course of Events**:
1. User is brought to a page where the technique video plays
2. User can interact with the video controller to fullscreen, skip, rewind, etc.
3. Video plays on enter and loops until the user is tired of it.
4. User hits back button to be redirected back to home screen.

### Use Case 4.1: Profile Settings View
- **Actors**: User
- **Overview**: User can view profile settings.

**Typical Course of Events**:
1. On the home screen, user taps the profile button to bring up an options menu.
2. User can set up notifcations, change their tags, or remove their account.

### Use Case 4.2: Notification Settings Screen
- **Actors**: User, Hive DB
- **Overview**: User can set up a daily notification time.

**Typical Course of Events**:
1. User taps notification button on profile view.
2. User taps button to select time from Clock widget.
3. User taps button to save time.
4. System adds user's time to database
5. Redirected back to home screen.

**Alternative Courses**:
- **Step 3**: Disable notifications.
  1. User taps disable notification button.
  2. Notifications are now disabled in the system.
  3. Redirected back to home screen.

### Use Case 4.3: Re-select tags
- **Actors**: User, Hive DB
- **Overview**: User can select new tags.

**Typical Course of Events**:
1. User selects Change Tags button.
2. Brought back to Tag Selection screen.
3. Redirected back to home screen.

### Use Case 4.4: Delete Account
- **Actors**: User, Hive DB
- **Overview**: User can delete their account.

**Typical Course of Events**:
1. User hits Delete Account button.
2. User is prompted if they are sure they want to delete their account.
3. If yes is tapped, user's account is removed from the system and they are brought back to the Welcome page

**Alternative Courses**:
- **Step 3**: User doesn't delete their account.
  1. User taps no and keeps their account.
  2. Continue as normal.

### Use Case 5.1: Streak System
- **Actors**: User
- **Overview**: User gains a streak based on consecutive logged in days.

**Typical Course of Events**:
1. On each consecutive day logged in, the user's streak is updated by 1.

**Alternative Courses**:
- **Step 1**: User misses a day logged in
  1. Streak is reset to 1 on the next login.
