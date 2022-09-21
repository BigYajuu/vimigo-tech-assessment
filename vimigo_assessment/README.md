Created by Chuyue Wu (cwuu0034@student.monash.edu)

# vimigo_assessment

This project is meant for entry assessment of Vimigo internship.

## Set Up
Set up your flutter environment, Android emulator as usual.

## Features Implemented
1. [X] Display a contacts list that is sorted based on the time. The time should be displayed in the format of “time ago” eg. 1 minute ago or 1 hour ago. The ordering of the list should be started from the most recent to the oldest.
2. [X] Given an example that you have 30 sets of data and you are only displaying half of it. Users are able to load the remaining data by pulling up the list.
3. [X] Users must be able to pull-to-refresh to generate a set of 5 random contacts data and append to the existing list.
4. [X] If the user has scrolled down the list and reached the end. An indicator should inform the user that “You have reached end of the list”.
5. [X] Users are able to change between the original time format and format “time ago” with a toggle button and keep the changes even if users kill the app.
6. [X] An action button that can allow the user to share the contact information to other installedapplications on the mobile.

## Dependencies Used
- sqflite - Storing local data
- intl - DateTime
- shared_preferences - Storing irrelational data in local (for changing time mode display)
- timeago - For displaying DateTime in 'xx ago' format
- fluttertoast - For showing toast info when scroll reaches to the bottom
- flutter_share - to share contact

## Additional Features
- Uses SQFlite to store all contact entries as local storage, enabling sorting and CRUD operations done to the contactList easily.
- Clear Data button for clearing up all contact entries.

## Key spec of emulator used during the development
- Device - Pixel 4 XL API 30
- Device Name - Android SDK built for x86
- Resolution - 1440 x 3040
- HW RAM - 1536MB
- HW CPU Core - 4
- VM Heap Size - 256
- Android Version - 11
- Date and Time - GMT+00:00
- Light mode

(See pubspec.yaml)
