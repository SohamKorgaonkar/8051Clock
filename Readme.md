**8051 Clock**

Features and Concepts Used:

1.  **Multiplexing of 7 Segment Display:**

A pair of 7 segment displays are multiplexed for hours and minutes respectively.

2 Seven Segment displays are connected to Port 1 and multiplexed using P0.1
(digit 1) and P0.2(digit 2)

2 Seven Segment displays are connected to Port 2 and multiplexed using P0.3
(digit 3) and P0.4(digit 4)

1.  **Interrupts**

2.  Timer0 overflow interrupt is used to count till 14 and the call the
    subroutine inct (increment time by 1 second)

3.  Hardware interrupt int0 is used to call inct 60 times to increase a min

4.  Hardware interrupt int1 is used to call inct 3600 times to increase an hour.

    The 2 hardware interrupts are used to set time manually

5.  **Timers**

6.  Timer0 is used as stated to call an interrupt

7.  Timer1 is used to create the delay required for multiplexing and is also
    used to wait for a certain amount of time after an interrupt is called to
    not call the interrupt twice due to voltage fluctuations.

8.  **Internet Time Using NodeMCU (ESP8266)**

Digital Pins D1 and D2 are connected to int0 and int1 to increase the time
according to the time received from NTP Server.

**Explanation of the code according to memory location**

1.  0000H

The code jumps to main code using target address main

1.  0003H (IVT for int0)

Calls delay subroutine and also calls incmin sunbroutine to increase time by 1
min

1.  000BH (Timer0 overflow interrupt)

Calls subroutine clksec to increase time by 1 second

1.  0013H

Calls subroutine incmin 60 times to increase time by an hour

1.  0050H

Main Code Goes here

Enables int0 int1 and Timer0 interrupts

Enables Timer0 and Timer1 as 16bit timers

Sets int0 and int1 as edge triggered interrupts

Calls initclk subroutine to initialise all values and variables to 0

Multiplexes and sets values on all four 7 segment displays

1.  00A1H

The database of values required for 7 segment displays

1.  00BCH

disp subroutine is written here

It takes values from R0-R3 and converts them into their respective 7Segment
Display codes

1.  010DH

Inct subroutine is written here

It increases the time by 1 second and sets the other values accordingly

If the values is above 23:59, it calls the initclk subroutine to initialize the
values to 0

1.  0179H

Here the delay subroutine is written using Timer1 of 8051

1.  01AFH

Here the initclk subroutine is written which initializes all the variable and
register values to the required values.

1.  021BH

Here then clksec subroutine is written which increases the value of time by 1
sec and also stores the required values in registers R0-R3 which is then used to
display the time.

1.  026CH

Here the incmin subroutine is written which can be used to increase the time by
1 min

**Schematic Diagram**

![](media/e9f3a85698c2057940baae468c9f10a2.png)

**Hardware Images of the connections**

![](media/20637ccfd999c9bf9ad0a8e1c8001323.jpeg)
