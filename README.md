# rtl8852ae-bar-controller-pcileech

    393 Addresses
    5582 TLPs
    ~22000 luts  

Requires 75t, or modifications (removing some TLPs)

0x30, this is where the MAC address is being read:

    bit [31:0] rom_0030 [0:2678];

The windows driver is not working that great for me, someone else might have better luck with it.

I intended to get it fully working before I released it, but it was giving me too much issues... 

Special thanks to:

Shockazulu, for giving great advice
Crumpette, testing and sharing knowledge
Clincy, moral support and test runs
