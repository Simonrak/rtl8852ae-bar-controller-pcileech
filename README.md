# rtl8852ae-bar-controller-pcileech

NOTE: this is not a recommended way of manually doing your rom layout, I generated this with a script I specifically made for the purpose of this device. 
   
    393 Addresses
    5582 TLPs
    ~22000 luts  

Requires 75t, or modifications (removing some TLPs)

0x30, this is where the MAC address is being read:

    bit [31:0] rom_0030 [0:2678];

The windows driver is not working that great, someone else might have better luck with it.

I intended to get it fully working before I released it, but it was giving me too much issues... 

Special thanks to:

Shockazulu, for giving great advice
Crumpette, testing and sharing knowledge
Clincy, moral support and test runs

###### BAR sizes
![image](https://github.com/user-attachments/assets/bf66c5a9-d078-483f-b257-c16b0f217873)

