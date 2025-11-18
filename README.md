# Software Requirements Specification: Flow State

## Introduction

### Purpose

Every single person will experience some form of anxiety or stress in their life, and around 4% of the population live everyday with a diagnosed anxiety condition. Flow State is a mobile app designed with the aim to help reduce any stress, anxiety, or other negative emotions one might encounter in their day to day lives.

### Scope

Whether anxiety be a daily occurence or once in a while, or whether you have 15 minutes to practice a guided meditation session or under a minute to lock in before a job interview, Flow State desires to have the perfect anxiety/stress combatting technique for everyone no matter who you are or how long you can put towards mindfulness.

### System Features

1. **User Login**: Username login system with Hive NoSQL Database. User selects tags after login to personalize the app.
2. **Personalized User Experience**: Depending on user selected tags after login, each user will have a unique selection of stress relief techniques based on the tags that they choose. However, all techniques are always available for users to try out.
4. **Achievement System**: Users can start a "streak" after consecutive login days in a row.
5. **Notification System**: Users can set a daily meditation time if they choose to, and the app will notify them at the specified time everyday.
6. **Flow AI**: Flow State includes a built-in LLM to provide support and additional resources using the power of artifical intelligence.

## Use Cases
### Use Case 1.1: Login
- **Actors**: User
- **Overview**: User enters their name to access the app
  
**Typical Course of Events**:
1. Prompts for username
2. User enters a username
3. System logs user in
   
**Alternative Courses**:
- **Step 3**: Username is blank/too short/too long
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

 ### Use Case 2.1: Technique Select
- **Actors**: User
- **Overview**: User is transferred to the home screen where they can select from their personalized meditation techniques, or they can filter to view them all

**Typical Course of Events**:
1. Lists out all meditation techniques to choose from
2. User taps a technique
3. They are brought to the technique page

**Alternative Courses**:
- **Step 2**: User long taps a technique
  1. User can read more about the specific technique and see the tags it has
  2. Tap anywhere on the screen to close
  3. Go back to step 1.

 ### Use Case 2.2: Profile View
- **Actors**: User
- **Overview**: User can view their profile information and set up a meditation time everyday

**Typical Course of Events**:
1. User taps the left side of the bottom nav bar to bring up the profile view
2. User can now view their profile, and can tap the notification setting to change it
3. User sets a time to let the app remind them to meditate everyday

 ### Use Case 2.3: Flow AI
- **Actors**: User, Flow AI LLM
- **Overview**: User can have a conversation with the built in LLM included in the app

**Typical Course of Events**:
1. User taps the right side of the bottom nav bar to bring up the Flow AI view
2. User can send prompts that are within reason to query the AI for information relating to meditation or professional resources
3. Flow AI responds to the user with (hopefully) clean and correct information.

**Alternative Courses**:
- **Step 2**: User sends a bad prompt to the AI
  1. Flow AI lets them know they cannot complete that request
  2. Go back to step 2.