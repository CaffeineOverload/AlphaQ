# Emergency App
Have your security in your Pockets.
Due to increase in crime rates and insecurities among citizens, We have tried to provide a simple but efficient solution to tackle this. Our App revolves around a straightforward idea where the user can directly contact helpline authorities and their peers with just a touch or a callouts.

## What it does
There are 2 modes, Normal Emergency Mode(Home Page) and Alone Mode(Alone Page). 
- When you click the emergency button on home page, it starts a 5 sec countdown where you can tap the button again if you touched it by mistake. After 5 seconds, it triggers an emergency protocol where the app sends sms to all your emergency contacs informing them about your danger and also calls emergency helpline if enabled. 
- In Alone Mode, After you press the emergency button it will start a 15 min timer and you've have to press the button again to register your presence or else it will trigger emergency protocol. There is also Phrase detection in background after you start timer, it will detect your help callouts.

## Screenshots
<img src="https://i.imgur.com/kq4OU3P.png" height="400"> <img src="https://i.imgur.com/QquclcN.png" height="400"> <img src="hhttps://i.imgur.com/dBTxQBz.png" height="400"><img src="https://i.imgur.com/k5EiMvd.png" height="400"> <img src="https://i.imgur.com/I4PrlFW.jpeg" height="400"> <img src="https://i.imgur.com/TEVKmGo.png" height="400"> <img src="https://i.imgur.com/PYTIzXU.png" height="400"> <img src="https://i.imgur.com/9slCS0A.png" height="400"> <img src="https://i.imgur.com/kogtHg4.png" height="400"> <img src="https://i.imgur.com/nX3qzk2.png" height="400"> <img src="https://i.imgur.com/pkA3GXU.png" height="400">

## Challenges we ran into

- Continous Phrase Detection: It was not working as it stops after a 
certain amount of time. We had to loop the Detector to detect
again if it stops.

- Home screen widget: As flutter currently doeesn’t support Home 
Screen widgets, We had to write the code in Java to support 
homescreen widgets

- Calling Emergency Helpline number: The default URL launcher of 
Flutter directed the user to dialer instead of direct calling, so we had
to use a separate package to make the call happen without user
interaction.
 

## What we have learned

- Storing preferences offline using shared preferences and syncing it to Firebase Database.
- Creating home screen widgets for Flutter Apps .
- Using Voice Commands in application.
- Creating Dynamic Dark Theme so that it switches in real time.

## Built By
- [Deep Rodge](https://github.com/deeprodge)
- [Krishna Patel](https://github.com/krshn-ptl)
- [Harsh Malvi](https://github.com/harshmalvi67)
```
MIT License

Copyright (c) 2021 Caffeine Overflow

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
