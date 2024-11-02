# rtl8852ae-bar-controller-pcileech

## NOTE: this is not a recommended way of manually doing your rom layout, I generated this with a script I specifically made for the purpose of this device. 
   
    393 Addresses
    5582 TLPs
    ~22000 luts  

Requires 75t, or modifications (removing some TLPs)

0x30, this is where the MAC address is being read:

    bit [31:0] rom_0030 [0:2678];

The windows driver is not working that great, someone else might have better luck with it.

If you're interested in trying it yourself, you could try with different versions of the driver:
                 https://www.catalog.update.microsoft.com/Search.aspx?q=RTL8852AE

I intended to get it fully working before I released it, but it was giving me too much issues... 

Special thanks to:

[Shockazulu](https://github.com/Shocka-Zulu), for giving great advice
 
[Crumpette](https://github.com/Crump3tte), testing and sharing knowledge
 
[Clincy](https://github.com/clincyjones), moral support and test runs

###### BAR sizes
![image](https://github.com/user-attachments/assets/bf66c5a9-d078-483f-b257-c16b0f217873)

