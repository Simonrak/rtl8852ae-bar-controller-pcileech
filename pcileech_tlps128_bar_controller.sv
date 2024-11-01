module pcileech_bar_impl_simonrak(
    input               rst,
    input               clk,
    input [31:0]        wr_addr,
    input [3:0]         wr_be,
    input [31:0]        wr_data,
    input               wr_valid,
    input  [87:0]       rd_req_ctx,
    input  [31:0]       rd_req_addr,
    input               rd_req_valid,
    input  [31:0]       base_address_register,

    output logic [87:0] rd_rsp_ctx,
    output logic [31:0] rd_rsp_data,
    output logic        rd_rsp_valid
);
    bit [87:0]      drd_req_ctx;
    bit [31:0]      drd_req_addr;
    bit             drd_req_valid;

    bit [31:0]      dwr_addr;
    bit [31:0]      dwr_data;
    bit             dwr_valid;

    wire [19:0]     local_addr;

    assign local_addr = ({drd_req_addr[31:24], drd_req_addr[23:16], 
                         drd_req_addr[15:8], drd_req_addr[7:0]} - 
                         base_address_register) & 20'hfffff;

    // 0x00f0
    bit [31:0] rom_00f0 [0:1];

    // 0x02d0
    bit [31:0] rom_02d0 [0:1];

    // 0x03f0
    bit [31:0] rom_03f0 [0:3];
    bit [1:0] counter_03f0;

    // 0x00c4
    bit [31:0] rom_00c4 [0:1];
    bit [0:0] counter_00c4;

    // 0x0004
    bit [31:0] rom_0004 [0:30];
    bit [4:0] counter_0004;

    // 0x0088
    bit [31:0] rom_0088 [0:19];
    bit [4:0] counter_0088;

    // 0x0080
    bit [31:0] rom_0080 [0:5];
    bit [2:0] counter_0080;

    // 0x0024
    bit [31:0] rom_0024 [0:1];
    bit [0:0] counter_0024;

    // 0x02a0
    bit [31:0] rom_02a0 [0:3];
    bit [1:0] counter_02a0;

    // 0x0070
    bit [31:0] rom_0070 [0:12];
    bit [3:0] counter_0070;

    // 0x8380
    bit [31:0] rom_8380 [0:1];
    bit [0:0] counter_8380;

    // 0x8400
    bit [31:0] rom_8400 [0:41];
    bit [5:0] counter_8400;

    // 0x8404
    bit [31:0] rom_8404 [0:2];
    bit [1:0] counter_8404;

    // 0x8c08
    bit [31:0] rom_8c08 [0:2];
    bit [1:0] counter_8c08;

    // 0x9008
    bit [31:0] rom_9008 [0:2];
    bit [1:0] counter_9008;

    // 0x8d00
    bit [31:0] rom_8d00 [0:5];
    bit [2:0] counter_8d00;

    // 0x9100
    bit [31:0] rom_9100 [0:2];
    bit [1:0] counter_9100;

    // 0x8a00
    bit [31:0] rom_8a00 [0:9];
    bit [3:0] counter_8a00;

    // 0x1000
    bit [31:0] rom_1000 [0:24];
    bit [4:0] counter_1000;

    // 0x1008
    bit [31:0] rom_1008 [0:1];
    bit [0:0] counter_1008;

    // 0x10a0
    bit [31:0] rom_10a0 [0:47];
    bit [5:0] counter_10a0;

    // 0x10a4
    bit [31:0] rom_10a4 [0:7];
    bit [2:0] counter_10a4;

    // 0x0074
    bit [31:0] rom_0074 [0:1];
    bit [0:0] counter_0074;

    // 0x13f0
    bit [31:0] rom_13f0 [0:5];
    bit [2:0] counter_13f0;

    // 0x11d8
    bit [31:0] rom_11d8 [0:3];
    bit [1:0] counter_11d8;

    // 0x11c0
    bit [31:0] rom_11c0 [0:1];
    bit [0:0] counter_11c0;

    // 0x1010
    bit [31:0] rom_1010 [0:12];
    bit [3:0] counter_1010;

    // 0x101C
    bit [31:0] rom_101C [0:3];
    bit [1:0] counter_101C;

    // 0x131C
    bit [31:0] rom_131C [0:1];
    bit [0:0] counter_131C;

    // 0x1014
    bit [31:0] rom_1014 [0:2];
    bit [1:0] counter_1014;

    // 0x1314
    bit [31:0] rom_1314 [0:2];
    bit [1:0] counter_1314;

    // 0x1018
    bit [31:0] rom_1018 [0:2];
    bit [1:0] counter_1018;

    // 0x1004
    bit [31:0] rom_1004 [0:3];
    bit [1:0] counter_1004;

    // 0x8810
    bit [31:0] rom_8810 [0:2];
    bit [1:0] counter_8810;

    // 0x9a00
    bit [31:0] rom_9a00 [0:2];
    bit [1:0] counter_9a00;

    // 0x1310
    bit [31:0] rom_1310 [0:2];
    bit [1:0] counter_1310;

    // 0x01e0
    bit [31:0] rom_01e0 [0:38];
    bit [5:0] counter_01e0;

    // 0x0008
    bit [31:0] rom_0008 [0:4];
    bit [2:0] counter_0008;

    // 0x40000
    bit [31:0] rom_40000 [0:1];
    bit [0:0] counter_40000;

    // 0x01e4
    bit [31:0] rom_01e4 [0:1];
    bit [0:0] counter_01e4;

    // 0x1080
    bit [31:0] rom_1080 [0:424];
    bit [8:0] counter_1080;

    // 0x0038
    bit [31:0] rom_0038 [0:2];
    bit [1:0] counter_0038;

    // 0x0030
    bit [31:0] rom_0030 [0:2678];
    bit [11:0] counter_0030;

    // 0x8160
    bit [31:0] rom_8160 [0:4];
    bit [2:0] counter_8160;

    // 0x01f4
    bit [31:0] rom_01f4 [0:9];
    bit [3:0] counter_01f4;

    // 0x8164
    bit [31:0] rom_8164 [0:53];
    bit [5:0] counter_8164;

    // 0x8150
    bit [31:0] rom_8150 [0:4];
    bit [2:0] counter_8150;

    // 0x8154
    bit [31:0] rom_8154 [0:4];
    bit [2:0] counter_8154;

    // 0x8158
    bit [31:0] rom_8158 [0:4];
    bit [2:0] counter_8158;

    // 0x815C
    bit [31:0] rom_815C [0:4];
    bit [2:0] counter_815C;

    // 0x02f0
    bit [31:0] rom_02f0 [0:6];
    bit [2:0] counter_02f0;

    // 0x0000
    bit [31:0] rom_0000 [0:4];
    bit [2:0] counter_0000;

    // 0x0090
    bit [31:0] rom_0090 [0:1];
    bit [0:0] counter_0090;

    // 0x8040
    bit [31:0] rom_8040 [0:2];
    bit [1:0] counter_8040;

    // 0xc004
    bit [31:0] rom_c004 [0:1];

    // 0xc000
    bit [31:0] rom_c000 [0:25];
    bit [4:0] counter_c000;

    // 0x0200
    bit [31:0] rom_0200 [0:1];

    // 0x8a50
    bit [31:0] rom_8a50 [0:1];

    // 0x8a54
    bit [31:0] rom_8a54 [0:1];

    // 0x8a58
    bit [31:0] rom_8a58 [0:1];

    // 0x8a5C
    bit [31:0] rom_8a5C [0:1];

    // 0x8a60
    bit [31:0] rom_8a60 [0:1];

    // 0x8a64
    bit [31:0] rom_8a64 [0:1];

    // 0x8a68
    bit [31:0] rom_8a68 [0:1];

    // 0x8a6C
    bit [31:0] rom_8a6C [0:1];

    // 0x8a70
    bit [31:0] rom_8a70 [0:1];

    // 0x8a74
    bit [31:0] rom_8a74 [0:1];

    // 0x8a78
    bit [31:0] rom_8a78 [0:1];

    // 0x8a7C
    bit [31:0] rom_8a7C [0:1];

    // 0x8a98
    bit [31:0] rom_8a98 [0:1];

    // 0x8a8C
    bit [31:0] rom_8a8C [0:1];

    // 0x8a9C
    bit [31:0] rom_8a9C [0:1];

    // 0x8aa8
    bit [31:0] rom_8aa8 [0:1];

    // 0x8a04
    bit [31:0] rom_8a04 [0:1];

    // 0x8a94
    bit [31:0] rom_8a94 [0:1];

    // 0x8aa0
    bit [31:0] rom_8aa0 [0:1];

    // 0x8aa4
    bit [31:0] rom_8aa4 [0:1];

    // 0x8a90
    bit [31:0] rom_8a90 [0:1];

    // 0x9e10
    bit [31:0] rom_9e10 [0:4];
    bit [2:0] counter_9e10;

    // 0x9c00
    bit [31:0] rom_9c00 [0:1];

    // 0x9d00
    bit [31:0] rom_9d00 [0:1];

    // 0x9d04
    bit [31:0] rom_9d04 [0:1];

    // 0xc33C
    bit [31:0] rom_c33C [0:1];

    // 0xc340
    bit [31:0] rom_c340 [0:6];
    bit [2:0] counter_c340;

    // 0xc338
    bit [31:0] rom_c338 [0:1];

    // 0xce34
    bit [31:0] rom_ce34 [0:2];
    bit [1:0] counter_ce34;

    // 0xce04
    bit [31:0] rom_ce04 [0:3];
    bit [1:0] counter_ce04;

    // 0xc390
    bit [31:0] rom_c390 [0:1];

    // 0xcc00
    bit [31:0] rom_cc00 [0:1];

    // 0xcc04
    bit [31:0] rom_cc04 [0:7];
    bit [2:0] counter_cc04;

    // 0xcc80
    bit [31:0] rom_cc80 [0:1];
    bit [0:0] counter_cc80;

    // 0xce48
    bit [31:0] rom_ce48 [0:5];
    bit [2:0] counter_ce48;

    // 0xcc20
    bit [31:0] rom_cc20 [0:1];

    // 0xca00
    bit [31:0] rom_ca00 [0:1];

    // 0xca1C
    bit [31:0] rom_ca1C [0:1];
    bit [0:0] counter_ca1C;

    // 0xccb0
    bit [31:0] rom_ccb0 [0:1];

    // 0xcc08
    bit [31:0] rom_cc08 [0:1];
    bit [0:0] counter_cc08;

    // 0xce3C
    bit [31:0] rom_ce3C [0:4];
    bit [2:0] counter_ce3C;

    // 0xce00
    bit [31:0] rom_ce00 [0:11];
    bit [3:0] counter_ce00;

    // 0xce20
    bit [31:0] rom_ce20 [0:2];
    bit [1:0] counter_ce20;

    // 0xc088
    bit [31:0] rom_c088 [0:1];

    // 0xc090
    bit [31:0] rom_c090 [0:1];

    // 0xc624
    bit [31:0] rom_c624 [0:1];

    // 0xc6e8
    bit [31:0] rom_c6e8 [0:1];

    // 0xc600
    bit [31:0] rom_c600 [0:5];
    bit [2:0] counter_c600;

    // 0xc660
    bit [31:0] rom_c660 [0:2];
    bit [1:0] counter_c660;

    // 0x9430
    bit [31:0] rom_9430 [0:1];
    bit [0:0] counter_9430;

    // 0x9d1C
    bit [31:0] rom_9d1C [0:1];

    // 0x9bf4
    bit [31:0] rom_9bf4 [0:1];
    bit [0:0] counter_9bf4;

    // 0x9cf4
    bit [31:0] rom_9cf4 [0:1];
    bit [0:0] counter_9cf4;

    // 0x9ef0
    bit [31:0] rom_9ef0 [0:1];
    bit [0:0] counter_9ef0;

    // 0x9f1C
    bit [31:0] rom_9f1C [0:1];
    bit [0:0] counter_9f1C;

    // 0x9f2C
    bit [31:0] rom_9f2C [0:1];
    bit [0:0] counter_9f2C;

    // 0x8c38
    bit [31:0] rom_8c38 [0:1];
    bit [0:0] counter_8c38;

    // 0x9038
    bit [31:0] rom_9038 [0:1];
    bit [0:0] counter_9038;

    // 0x9a20
    bit [31:0] rom_9a20 [0:1];

    // 0x8850
    bit [31:0] rom_8850 [0:1];
    bit [0:0] counter_8850;

    // 0x8854
    bit [31:0] rom_8854 [0:1];
    bit [0:0] counter_8854;

    // 0x8858
    bit [31:0] rom_8858 [0:1];
    bit [0:0] counter_8858;

    // 0x9840
    bit [31:0] rom_9840 [0:1];
    bit [0:0] counter_9840;

    // 0x960C
    bit [31:0] rom_960C [0:1];

    // 0x962C
    bit [31:0] rom_962C [0:1];
    bit [0:0] counter_962C;

    // 0x963C
    bit [31:0] rom_963C [0:1];

    // 0x966C
    bit [31:0] rom_966C [0:1];

    // 0xc3e8
    bit [31:0] rom_c3e8 [0:1];
    bit [0:0] counter_c3e8;

    // 0xc6c0
    bit [31:0] rom_c6c0 [0:1];
    bit [0:0] counter_c6c0;

    // 0xc800
    bit [31:0] rom_c800 [0:1];
    bit [0:0] counter_c800;

    // 0xccfC
    bit [31:0] rom_ccfC [0:1];
    bit [0:0] counter_ccfC;

    // 0xcef4
    bit [31:0] rom_cef4 [0:1];
    bit [0:0] counter_cef4;

    // 0xcceC
    bit [31:0] rom_cceC [0:1];
    bit [0:0] counter_cceC;

    // 0x9408
    bit [31:0] rom_9408 [0:1];

    // 0x9410
    bit [31:0] rom_9410 [0:1];

    // 0x9414
    bit [31:0] rom_9414 [0:1];
    bit [0:0] counter_9414;

    // 0x8410
    bit [31:0] rom_8410 [0:5];
    bit [2:0] counter_8410;

    // 0x8414
    bit [31:0] rom_8414 [0:2];
    bit [1:0] counter_8414;

    // 0x8418
    bit [31:0] rom_8418 [0:1];

    // 0x841C
    bit [31:0] rom_841C [0:1];

    // 0x158dC
    bit [31:0] rom_158dC [0:4];
    bit [2:0] counter_158dC;

    // 0x15818
    bit [31:0] rom_15818 [0:3];
    bit [1:0] counter_15818;

    // 0x178dC
    bit [31:0] rom_178dC [0:4];
    bit [2:0] counter_178dC;

    // 0x17818
    bit [31:0] rom_17818 [0:3];
    bit [1:0] counter_17818;

    // 0x10704
    bit [31:0] rom_10704 [0:7];
    bit [2:0] counter_10704;

    // 0x0040
    bit [31:0] rom_0040 [0:5];
    bit [2:0] counter_0040;

    // 0xda20
    bit [31:0] rom_da20 [0:5];
    bit [2:0] counter_da20;

    // 0xda34
    bit [31:0] rom_da34 [0:5];
    bit [2:0] counter_da34;

    // 0xda40
    bit [31:0] rom_da40 [0:13];
    bit [3:0] counter_da40;

    // 0xdaf0
    bit [31:0] rom_daf0 [0:17];
    bit [4:0] counter_daf0;

    // 0xdaf8
    bit [31:0] rom_daf8 [0:1];
    bit [0:0] counter_daf8;

    // 0xda4C
    bit [31:0] rom_da4C [0:5];
    bit [2:0] counter_da4C;

    // 0xda6C
    bit [31:0] rom_da6C [0:5];
    bit [2:0] counter_da6C;

    // 0xda30
    bit [31:0] rom_da30 [0:1];
    bit [0:0] counter_da30;

    // 0xda10
    bit [31:0] rom_da10 [0:1];
    bit [0:0] counter_da10;

    // 0x1c008
    bit [31:0] rom_1c008 [0:1];
    bit [0:0] counter_1c008;

    // 0x1d008
    bit [31:0] rom_1d008 [0:1];
    bit [0:0] counter_1d008;

    // 0x1c3bC
    bit [31:0] rom_1c3bC [0:7];
    bit [2:0] counter_1c3bC;

    // 0x1c0cC
    bit [31:0] rom_1c0cC [0:3];
    bit [1:0] counter_1c0cC;

    // 0x1c0fC
    bit [31:0] rom_1c0fC [0:3];
    bit [1:0] counter_1c0fC;

    // 0x1d3bC
    bit [31:0] rom_1d3bC [0:7];
    bit [2:0] counter_1d3bC;

    // 0x1d0cC
    bit [31:0] rom_1d0cC [0:3];
    bit [1:0] counter_1d0cC;

    // 0x1d0fC
    bit [31:0] rom_1d0fC [0:3];
    bit [1:0] counter_1d0fC;

    // 0x00aC
    bit [31:0] rom_00aC [0:10];
    bit [3:0] counter_00aC;

    // 0xd200
    bit [31:0] rom_d200 [0:1];
    bit [0:0] counter_d200;

    // 0xd220
    bit [31:0] rom_d220 [0:1];

    // 0xc67C
    bit [31:0] rom_c67C [0:5];
    bit [2:0] counter_c67C;

    // 0x1466C
    bit [31:0] rom_1466C [0:7];
    bit [2:0] counter_1466C;

    // 0x14740
    bit [31:0] rom_14740 [0:7];
    bit [2:0] counter_14740;

    // 0x10980
    bit [31:0] rom_10980 [0:7];
    bit [2:0] counter_10980;

    // 0x14624
    bit [31:0] rom_14624 [0:7];
    bit [2:0] counter_14624;

    // 0x146f8
    bit [31:0] rom_146f8 [0:7];
    bit [2:0] counter_146f8;

    // 0x14674
    bit [31:0] rom_14674 [0:8];
    bit [3:0] counter_14674;

    // 0x14748
    bit [31:0] rom_14748 [0:8];
    bit [3:0] counter_14748;

    // 0x14650
    bit [31:0] rom_14650 [0:8];
    bit [3:0] counter_14650;

    // 0x14724
    bit [31:0] rom_14724 [0:7];
    bit [2:0] counter_14724;

    // 0x14688
    bit [31:0] rom_14688 [0:7];
    bit [2:0] counter_14688;

    // 0x1475C
    bit [31:0] rom_1475C [0:7];
    bit [2:0] counter_1475C;

    // 0x1c108
    bit [31:0] rom_1c108 [0:3];
    bit [1:0] counter_1c108;

    // 0x1d108
    bit [31:0] rom_1d108 [0:3];
    bit [1:0] counter_1d108;

    // 0x10d7C
    bit [31:0] rom_10d7C [0:1];

    // 0x12d7C
    bit [31:0] rom_12d7C [0:1];

    // 0x1000C
    bit [31:0] rom_1000C [0:1];

    // 0x10d84
    bit [31:0] rom_10d84 [0:1];

    // 0x10738
    bit [31:0] rom_10738 [0:2];
    bit [1:0] counter_10738;

    // 0x14404
    bit [31:0] rom_14404 [0:1];

    // 0x1440C
    bit [31:0] rom_1440C [0:1];

    // 0x109a4
    bit [31:0] rom_109a4 [0:1];
    bit [0:0] counter_109a4;

    // 0x10da0
    bit [31:0] rom_10da0 [0:1];

    // 0x10da4
    bit [31:0] rom_10da4 [0:1];

    // 0x10c00
    bit [31:0] rom_10c00 [0:3];
    bit [1:0] counter_10c00;

    // 0x10c2C
    bit [31:0] rom_10c2C [0:2];
    bit [1:0] counter_10c2C;

    // 0x10c30
    bit [31:0] rom_10c30 [0:2];
    bit [1:0] counter_10c30;

    // 0x10c34
    bit [31:0] rom_10c34 [0:2];
    bit [1:0] counter_10c34;

    // 0x10c38
    bit [31:0] rom_10c38 [0:2];
    bit [1:0] counter_10c38;

    // 0x10c28
    bit [31:0] rom_10c28 [0:1];

    // 0x1073C
    bit [31:0] rom_1073C [0:1];

    // 0x10740
    bit [31:0] rom_10740 [0:1];

    // 0x10744
    bit [31:0] rom_10744 [0:1];

    // 0x10748
    bit [31:0] rom_10748 [0:1];

    // 0x1075C
    bit [31:0] rom_1075C [0:1];

    // 0x10764
    bit [31:0] rom_10764 [0:1];
    bit [0:0] counter_10764;

    // 0x10768
    bit [31:0] rom_10768 [0:1];
    bit [0:0] counter_10768;

    // 0x1076C
    bit [31:0] rom_1076C [0:1];
    bit [0:0] counter_1076C;

    // 0x10770
    bit [31:0] rom_10770 [0:2];
    bit [1:0] counter_10770;

    // 0x10774
    bit [31:0] rom_10774 [0:2];
    bit [1:0] counter_10774;

    // 0x14628
    bit [31:0] rom_14628 [0:1];

    // 0x1462C
    bit [31:0] rom_1462C [0:2];
    bit [1:0] counter_1462C;

    // 0x14630
    bit [31:0] rom_14630 [0:2];
    bit [1:0] counter_14630;

    // 0x14634
    bit [31:0] rom_14634 [0:3];
    bit [1:0] counter_14634;

    // 0x14638
    bit [31:0] rom_14638 [0:2];
    bit [1:0] counter_14638;

    // 0x1463C
    bit [31:0] rom_1463C [0:1];

    // 0x14640
    bit [31:0] rom_14640 [0:1];
    bit [0:0] counter_14640;

    // 0x14644
    bit [31:0] rom_14644 [0:2];
    bit [1:0] counter_14644;

    // 0x14668
    bit [31:0] rom_14668 [0:1];

    // 0x1473C
    bit [31:0] rom_1473C [0:1];

    // 0x14658
    bit [31:0] rom_14658 [0:1];

    // 0x1472C
    bit [31:0] rom_1472C [0:1];

    // 0x1481C
    bit [31:0] rom_1481C [0:1];
    bit [0:0] counter_1481C;

    // 0x146a0
    bit [31:0] rom_146a0 [0:1];

    // 0x146a4
    bit [31:0] rom_146a4 [0:1];

    // 0x14774
    bit [31:0] rom_14774 [0:1];

    // 0x14778
    bit [31:0] rom_14778 [0:1];

    // 0x0280
    bit [31:0] rom_0280 [0:3];
    bit [1:0] counter_0280;

    // 0x14494
    bit [31:0] rom_14494 [0:1];

    // 0x14490
    bit [31:0] rom_14490 [0:1];

    // 0x14264
    bit [31:0] rom_14264 [0:1];

    // 0xd248
    bit [31:0] rom_d248 [0:1];

    // 0x10c70
    bit [31:0] rom_10c70 [0:1];

    // 0x10c60
    bit [31:0] rom_10c60 [0:1];

    // 0x10c6C
    bit [31:0] rom_10c6C [0:1];

    // 0x158aC
    bit [31:0] rom_158aC [0:1];

    // 0x178aC
    bit [31:0] rom_178aC [0:1];

    // 0x18080
    bit [31:0] rom_18080 [0:1];

    // 0x1c014
    bit [31:0] rom_1c014 [0:7];
    bit [2:0] counter_1c014;

    // 0x1c000
    bit [31:0] rom_1c000 [0:7];
    bit [2:0] counter_1c000;

    // 0x1c06C
    bit [31:0] rom_1c06C [0:3];
    bit [1:0] counter_1c06C;

    // 0x1c070
    bit [31:0] rom_1c070 [0:2];
    bit [1:0] counter_1c070;

    // 0x1c074
    bit [31:0] rom_1c074 [0:1];
    bit [0:0] counter_1c074;

    // 0x1c3c0
    bit [31:0] rom_1c3c0 [0:1];
    bit [0:0] counter_1c3c0;

    // 0x1d014
    bit [31:0] rom_1d014 [0:7];
    bit [2:0] counter_1d014;

    // 0x1d000
    bit [31:0] rom_1d000 [0:7];
    bit [2:0] counter_1d000;

    // 0x1d06C
    bit [31:0] rom_1d06C [0:3];
    bit [1:0] counter_1d06C;

    // 0x1d070
    bit [31:0] rom_1d070 [0:2];
    bit [1:0] counter_1d070;

    // 0x1d074
    bit [31:0] rom_1d074 [0:1];
    bit [0:0] counter_1d074;

    // 0x1d3c0
    bit [31:0] rom_1d3c0 [0:1];
    bit [0:0] counter_1d3c0;

    // 0x112eC
    bit [31:0] rom_112eC [0:2];
    bit [1:0] counter_112eC;

    // 0x15e00
    bit [31:0] rom_15e00 [0:23];
    bit [4:0] counter_15e00;

    // 0x132eC
    bit [31:0] rom_132eC [0:2];
    bit [1:0] counter_132eC;

    // 0x17e00
    bit [31:0] rom_17e00 [0:23];
    bit [4:0] counter_17e00;

    // 0x112d8
    bit [31:0] rom_112d8 [0:9];
    bit [3:0] counter_112d8;

    // 0x132d8
    bit [31:0] rom_132d8 [0:9];
    bit [3:0] counter_132d8;

    // 0x112b8
    bit [31:0] rom_112b8 [0:6];
    bit [2:0] counter_112b8;

    // 0x1032C
    bit [31:0] rom_1032C [0:27];
    bit [4:0] counter_1032C;

    // 0x1030C
    bit [31:0] rom_1030C [0:13];
    bit [3:0] counter_1030C;

    // 0x112dC
    bit [31:0] rom_112dC [0:3];
    bit [1:0] counter_112dC;

    // 0x120f4
    bit [31:0] rom_120f4 [0:5];
    bit [2:0] counter_120f4;

    // 0x120f8
    bit [31:0] rom_120f8 [0:5];
    bit [2:0] counter_120f8;

    // 0x120f0
    bit [31:0] rom_120f0 [0:23];
    bit [4:0] counter_120f0;

    // 0x11730
    bit [31:0] rom_11730 [0:599];
    bit [9:0] counter_11730;

    // 0x11e00
    bit [31:0] rom_11e00 [0:2];
    bit [1:0] counter_11e00;

    // 0x132b8
    bit [31:0] rom_132b8 [0:6];
    bit [2:0] counter_132b8;

    // 0x132dC
    bit [31:0] rom_132dC [0:3];
    bit [1:0] counter_132dC;

    // 0x13e00
    bit [31:0] rom_13e00 [0:2];
    bit [1:0] counter_13e00;

    // 0x112d4
    bit [31:0] rom_112d4 [0:1];
    bit [0:0] counter_112d4;

    // 0x132d4
    bit [31:0] rom_132d4 [0:1];
    bit [0:0] counter_132d4;

    // 0x1c004
    bit [31:0] rom_1c004 [0:1];

    // 0x1d004
    bit [31:0] rom_1d004 [0:1];

    // 0x15e10
    bit [31:0] rom_15e10 [0:1];
    bit [0:0] counter_15e10;

    // 0x15e50
    bit [31:0] rom_15e50 [0:21];
    bit [4:0] counter_15e50;

    // 0x15e60
    bit [31:0] rom_15e60 [0:1];
    bit [0:0] counter_15e60;

    // 0x112a0
    bit [31:0] rom_112a0 [0:7];
    bit [2:0] counter_112a0;

    // 0x112e0
    bit [31:0] rom_112e0 [0:1];
    bit [0:0] counter_112e0;

    // 0x112e4
    bit [31:0] rom_112e4 [0:1];
    bit [0:0] counter_112e4;

    // 0x15e0C
    bit [31:0] rom_15e0C [0:3];
    bit [1:0] counter_15e0C;

    // 0x15e5C
    bit [31:0] rom_15e5C [0:3];
    bit [1:0] counter_15e5C;

    // 0x15e28
    bit [31:0] rom_15e28 [0:144];
    bit [7:0] counter_15e28;

    // 0x15e78
    bit [31:0] rom_15e78 [0:1];

    // 0x15e48
    bit [31:0] rom_15e48 [0:1];
    bit [0:0] counter_15e48;

    // 0x15e98
    bit [31:0] rom_15e98 [0:5];
    bit [2:0] counter_15e98;

    // 0x112e8
    bit [31:0] rom_112e8 [0:1];
    bit [0:0] counter_112e8;

    // 0x1c23C
    bit [31:0] rom_1c23C [0:1];
    bit [0:0] counter_1c23C;

    // 0x15e44
    bit [31:0] rom_15e44 [0:15];
    bit [3:0] counter_15e44;

    // 0x15e94
    bit [31:0] rom_15e94 [0:15];
    bit [3:0] counter_15e94;

    // 0x15e30
    bit [31:0] rom_15e30 [0:1];

    // 0x15e80
    bit [31:0] rom_15e80 [0:1];

    // 0x15e14
    bit [31:0] rom_15e14 [0:1];

    // 0x15e18
    bit [31:0] rom_15e18 [0:1];

    // 0x15e1C
    bit [31:0] rom_15e1C [0:1];

    // 0x15e20
    bit [31:0] rom_15e20 [0:1];

    // 0x15e64
    bit [31:0] rom_15e64 [0:1];

    // 0x15e68
    bit [31:0] rom_15e68 [0:1];

    // 0x15e6C
    bit [31:0] rom_15e6C [0:1];

    // 0x15e70
    bit [31:0] rom_15e70 [0:1];

    // 0x17e10
    bit [31:0] rom_17e10 [0:1];
    bit [0:0] counter_17e10;

    // 0x17e50
    bit [31:0] rom_17e50 [0:21];
    bit [4:0] counter_17e50;

    // 0x17e60
    bit [31:0] rom_17e60 [0:1];
    bit [0:0] counter_17e60;

    // 0x132a0
    bit [31:0] rom_132a0 [0:7];
    bit [2:0] counter_132a0;

    // 0x132e0
    bit [31:0] rom_132e0 [0:1];
    bit [0:0] counter_132e0;

    // 0x132e4
    bit [31:0] rom_132e4 [0:1];
    bit [0:0] counter_132e4;

    // 0x17e0C
    bit [31:0] rom_17e0C [0:3];
    bit [1:0] counter_17e0C;

    // 0x17e5C
    bit [31:0] rom_17e5C [0:3];
    bit [1:0] counter_17e5C;

    // 0x17e28
    bit [31:0] rom_17e28 [0:152];
    bit [7:0] counter_17e28;

    // 0x17e78
    bit [31:0] rom_17e78 [0:1];

    // 0x17e48
    bit [31:0] rom_17e48 [0:1];
    bit [0:0] counter_17e48;

    // 0x17e98
    bit [31:0] rom_17e98 [0:5];
    bit [2:0] counter_17e98;

    // 0x132e8
    bit [31:0] rom_132e8 [0:1];
    bit [0:0] counter_132e8;

    // 0x1d23C
    bit [31:0] rom_1d23C [0:1];
    bit [0:0] counter_1d23C;

    // 0x17e44
    bit [31:0] rom_17e44 [0:15];
    bit [3:0] counter_17e44;

    // 0x17e94
    bit [31:0] rom_17e94 [0:15];
    bit [3:0] counter_17e94;

    // 0x17e30
    bit [31:0] rom_17e30 [0:1];

    // 0x17e80
    bit [31:0] rom_17e80 [0:1];

    // 0x17e14
    bit [31:0] rom_17e14 [0:1];

    // 0x17e18
    bit [31:0] rom_17e18 [0:1];

    // 0x17e1C
    bit [31:0] rom_17e1C [0:1];

    // 0x17e20
    bit [31:0] rom_17e20 [0:1];

    // 0x17e64
    bit [31:0] rom_17e64 [0:1];

    // 0x17e68
    bit [31:0] rom_17e68 [0:1];

    // 0x17e6C
    bit [31:0] rom_17e6C [0:1];

    // 0x17e70
    bit [31:0] rom_17e70 [0:1];

    // 0xc348
    bit [31:0] rom_c348 [0:3];
    bit [1:0] counter_c348;

    // 0x1c248
    bit [31:0] rom_1c248 [0:5];
    bit [2:0] counter_1c248;

    // 0x1c250
    bit [31:0] rom_1c250 [0:1];

    // 0x1c24C
    bit [31:0] rom_1c24C [0:1];

    // 0x1d248
    bit [31:0] rom_1d248 [0:5];
    bit [2:0] counter_1d248;

    // 0x1d250
    bit [31:0] rom_1d250 [0:1];

    // 0x1d24C
    bit [31:0] rom_1d24C [0:1];

    // 0x15804
    bit [31:0] rom_15804 [0:1];

    // 0x17804
    bit [31:0] rom_17804 [0:1];

    // 0x15808
    bit [31:0] rom_15808 [0:1];

    // 0x17808
    bit [31:0] rom_17808 [0:1];

    // 0x1c10C
    bit [31:0] rom_1c10C [0:1];

    // 0x1d10C
    bit [31:0] rom_1d10C [0:1];

    // 0x1c180
    bit [31:0] rom_1c180 [0:1];
    bit [0:0] counter_1c180;

    // 0x1d180
    bit [31:0] rom_1d180 [0:1];
    bit [0:0] counter_1d180;

    // 0x9c18
    bit [31:0] rom_9c18 [0:1];
    bit [0:0] counter_9c18;

    // 0xc614
    bit [31:0] rom_c614 [0:5];
    bit [2:0] counter_c614;

    // 0x01a4
    bit [31:0] rom_01a4 [0:6];
    bit [2:0] counter_01a4;

    // 0x10b4
    bit [31:0] rom_10b4 [0:6];
    bit [2:0] counter_10b4;

    // 0x13b4
    bit [31:0] rom_13b4 [0:6];
    bit [2:0] counter_13b4;

    // 0x1054
    bit [31:0] rom_1054 [0:6];
    bit [2:0] counter_1054;

    // 0x1050
    bit [31:0] rom_1050 [0:6];
    bit [2:0] counter_1050;

    // 0xc400
    bit [31:0] rom_c400 [0:8];
    bit [3:0] counter_c400;

    // 0xc414
    bit [31:0] rom_c414 [0:1];

    // 0xc590
    bit [31:0] rom_c590 [0:1];

    // 0xca08
    bit [31:0] rom_ca08 [0:2];
    bit [1:0] counter_ca08;

    // 0xc424
    bit [31:0] rom_c424 [0:2];
    bit [1:0] counter_c424;

    // 0xc63C
    bit [31:0] rom_c63C [0:1];

    // 0xc404
    bit [31:0] rom_c404 [0:1];
    bit [0:0] counter_c404;

    // 0xc408
    bit [31:0] rom_c408 [0:1];

    // 0xc40C
    bit [31:0] rom_c40C [0:3];
    bit [1:0] counter_c40C;

    // 0xc6a0
    bit [31:0] rom_c6a0 [0:1];

    // 0xc568
    bit [31:0] rom_c568 [0:1];

    // 0x1d0f8
    bit [31:0] rom_1d0f8 [0:1];
    bit [0:0] counter_1d0f8;

    // 0xce40
    bit [31:0] rom_ce40 [0:1];

    // 0x10000
    bit [31:0] rom_10000 [0:1];
    bit [0:0] counter_10000;

    // 0x120fC
    bit [31:0] rom_120fC [0:1];
    bit [0:0] counter_120fC;

    // 0xc010
    bit [31:0] rom_c010 [0:2];
    bit [1:0] counter_c010;

    // 0xc628
    bit [31:0] rom_c628 [0:2];
    bit [1:0] counter_c628;

    // 0x123b0
    bit [31:0] rom_123b0 [0:1];

    // 0x123b4
    bit [31:0] rom_123b4 [0:1];

    // 0x1c060
    bit [31:0] rom_1c060 [0:3];
    bit [1:0] counter_1c060;

    // 0x1d060
    bit [31:0] rom_1d060 [0:3];
    bit [1:0] counter_1d060;

    // 0x14718
    bit [31:0] rom_14718 [0:1];

    // 0x14974
    bit [31:0] rom_14974 [0:1];
    bit [0:0] counter_14974;

    // 0x14498
    bit [31:0] rom_14498 [0:1];

    // 0x12300
    bit [31:0] rom_12300 [0:1];

    // 0x12304
    bit [31:0] rom_12304 [0:1];

    // 0x12308
    bit [31:0] rom_12308 [0:1];

    // 0x1230C
    bit [31:0] rom_1230C [0:1];

    // 0x12310
    bit [31:0] rom_12310 [0:1];

    // 0x12314
    bit [31:0] rom_12314 [0:1];

    // 0x12318
    bit [31:0] rom_12318 [0:1];

    // 0x1231C
    bit [31:0] rom_1231C [0:1];

    // 0x14978
    bit [31:0] rom_14978 [0:1];
    bit [0:0] counter_14978;

    // 0x112d0
    bit [31:0] rom_112d0 [0:1];

    // 0x132d0
    bit [31:0] rom_132d0 [0:1];

    // 0x12344
    bit [31:0] rom_12344 [0:1];

    // 0x1469C
    bit [31:0] rom_1469C [0:1];

    // 0x14770
    bit [31:0] rom_14770 [0:1];

    // 0x142c4
    bit [31:0] rom_142c4 [0:1];

    // 0x10734
    bit [31:0] rom_10734 [0:1];

    // 0xd204
    bit [31:0] rom_d204 [0:1];

    // 0x1058
    bit [31:0] rom_1058 [0:1];

    // 0x105C
    bit [31:0] rom_105C [0:1];

    // 0x1060
    bit [31:0] rom_1060 [0:1];

    // 0x1064
    bit [31:0] rom_1064 [0:1];

    // 0x1068
    bit [31:0] rom_1068 [0:1];

    // 0x106C
    bit [31:0] rom_106C [0:1];

    // 0x1070
    bit [31:0] rom_1070 [0:1];

    // 0x1074
    bit [31:0] rom_1074 [0:1];

    // 0x1078
    bit [31:0] rom_1078 [0:1];

    // 0x107C
    bit [31:0] rom_107C [0:1];

    // 0x137C
    bit [31:0] rom_137C [0:1];

    // 0x1380
    bit [31:0] rom_1380 [0:1];

    // 0x8430
    bit [31:0] rom_8430 [0:1];

    function rom_addr_check;
        input [19:0] addr;
        begin
            case (addr)
                20'h00f0, 20'h02d0, 20'h03f0, 20'h00c4, 20'h0004, 20'h0088,
                20'h0080, 20'h0024, 20'h02a0, 20'h0070, 20'h8380, 20'h8400,
                20'h8404, 20'h8c08, 20'h9008, 20'h8d00, 20'h9100, 20'h8a00,
                20'h1000, 20'h1008, 20'h10a0, 20'h10a4, 20'h0074, 20'h13f0,
                20'h11d8, 20'h11c0, 20'h1010, 20'h101C, 20'h131C, 20'h1014,
                20'h1314, 20'h1018, 20'h1004, 20'h8810, 20'h9a00, 20'h1310,
                20'h01e0, 20'h0008, 20'h40000, 20'h01e4, 20'h1080, 20'h0038,
                20'h0030, 20'h8160, 20'h01f4, 20'h8164, 20'h8150, 20'h8154,
                20'h8158, 20'h815C, 20'h02f0, 20'h0000, 20'h0090, 20'h8040,
                20'hc004, 20'hc000, 20'h0200, 20'h8a50, 20'h8a54, 20'h8a58,
                20'h8a5C, 20'h8a60, 20'h8a64, 20'h8a68, 20'h8a6C, 20'h8a70,
                20'h8a74, 20'h8a78, 20'h8a7C, 20'h8a98, 20'h8a8C, 20'h8a9C,
                20'h8aa8, 20'h8a04, 20'h8a94, 20'h8aa0, 20'h8aa4, 20'h8a90,
                20'h9e10, 20'h9c00, 20'h9d00, 20'h9d04, 20'hc33C, 20'hc340,
                20'hc338, 20'hce34, 20'hce04, 20'hc390, 20'hcc00, 20'hcc04,
                20'hcc80, 20'hce48, 20'hcc20, 20'hca00, 20'hca1C, 20'hccb0,
                20'hcc08, 20'hce3C, 20'hce00, 20'hce20, 20'hc088, 20'hc090,
                20'hc624, 20'hc6e8, 20'hc600, 20'hc660, 20'h9430, 20'h9d1C,
                20'h9bf4, 20'h9cf4, 20'h9ef0, 20'h9f1C, 20'h9f2C, 20'h8c38,
                20'h9038, 20'h9a20, 20'h8850, 20'h8854, 20'h8858, 20'h9840,
                20'h960C, 20'h962C, 20'h963C, 20'h966C, 20'hc3e8, 20'hc6c0,
                20'hc800, 20'hccfC, 20'hcef4, 20'hcceC, 20'h9408, 20'h9410,
                20'h9414, 20'h8410, 20'h8414, 20'h8418, 20'h841C, 20'h158dC,
                20'h15818, 20'h178dC, 20'h17818, 20'h10704, 20'h0040, 20'hda20,
                20'hda34, 20'hda40, 20'hdaf0, 20'hdaf8, 20'hda4C, 20'hda6C,
                20'hda30, 20'hda10, 20'h1c008, 20'h1d008, 20'h1c3bC, 20'h1c0cC,
                20'h1c0fC, 20'h1d3bC, 20'h1d0cC, 20'h1d0fC, 20'h00aC, 20'hd200,
                20'hd220, 20'hc67C, 20'h1466C, 20'h14740, 20'h10980, 20'h14624,
                20'h146f8, 20'h14674, 20'h14748, 20'h14650, 20'h14724, 20'h14688,
                20'h1475C, 20'h1c108, 20'h1d108, 20'h10d7C, 20'h12d7C, 20'h1000C,
                20'h10d84, 20'h10738, 20'h14404, 20'h1440C, 20'h109a4, 20'h10da0,
                20'h10da4, 20'h10c00, 20'h10c2C, 20'h10c30, 20'h10c34, 20'h10c38,
                20'h10c28, 20'h1073C, 20'h10740, 20'h10744, 20'h10748, 20'h1075C,
                20'h10764, 20'h10768, 20'h1076C, 20'h10770, 20'h10774, 20'h14628,
                20'h1462C, 20'h14630, 20'h14634, 20'h14638, 20'h1463C, 20'h14640,
                20'h14644, 20'h14668, 20'h1473C, 20'h14658, 20'h1472C, 20'h1481C,
                20'h146a0, 20'h146a4, 20'h14774, 20'h14778, 20'h0280, 20'h14494,
                20'h14490, 20'h14264, 20'hd248, 20'h10c70, 20'h10c60, 20'h10c6C,
                20'h158aC, 20'h178aC, 20'h18080, 20'h1c014, 20'h1c000, 20'h1c06C,
                20'h1c070, 20'h1c074, 20'h1c3c0, 20'h1d014, 20'h1d000, 20'h1d06C,
                20'h1d070, 20'h1d074, 20'h1d3c0, 20'h112eC, 20'h15e00, 20'h132eC,
                20'h17e00, 20'h112d8, 20'h132d8, 20'h112b8, 20'h1032C, 20'h1030C,
                20'h112dC, 20'h120f4, 20'h120f8, 20'h120f0, 20'h11730, 20'h11e00,
                20'h132b8, 20'h132dC, 20'h13e00, 20'h112d4, 20'h132d4, 20'h1c004,
                20'h1d004, 20'h15e10, 20'h15e50, 20'h15e60, 20'h112a0, 20'h112e0,
                20'h112e4, 20'h15e0C, 20'h15e5C, 20'h15e28, 20'h15e78, 20'h15e48,
                20'h15e98, 20'h112e8, 20'h1c23C, 20'h15e44, 20'h15e94, 20'h15e30,
                20'h15e80, 20'h15e14, 20'h15e18, 20'h15e1C, 20'h15e20, 20'h15e64,
                20'h15e68, 20'h15e6C, 20'h15e70, 20'h17e10, 20'h17e50, 20'h17e60,
                20'h132a0, 20'h132e0, 20'h132e4, 20'h17e0C, 20'h17e5C, 20'h17e28,
                20'h17e78, 20'h17e48, 20'h17e98, 20'h132e8, 20'h1d23C, 20'h17e44,
                20'h17e94, 20'h17e30, 20'h17e80, 20'h17e14, 20'h17e18, 20'h17e1C,
                20'h17e20, 20'h17e64, 20'h17e68, 20'h17e6C, 20'h17e70, 20'hc348,
                20'h1c248, 20'h1c250, 20'h1c24C, 20'h1d248, 20'h1d250, 20'h1d24C,
                20'h15804, 20'h17804, 20'h15808, 20'h17808, 20'h1c10C, 20'h1d10C,
                20'h1c180, 20'h1d180, 20'h9c18, 20'hc614, 20'h01a4, 20'h10b4,
                20'h13b4, 20'h1054, 20'h1050, 20'hc400, 20'hc414, 20'hc590,
                20'hca08, 20'hc424, 20'hc63C, 20'hc404, 20'hc408, 20'hc40C,
                20'hc6a0, 20'hc568, 20'h1d0f8, 20'hce40, 20'h10000, 20'h120fC,
                20'hc010, 20'hc628, 20'h123b0, 20'h123b4, 20'h1c060, 20'h1d060,
                20'h14718, 20'h14974, 20'h14498, 20'h12300, 20'h12304, 20'h12308,
                20'h1230C, 20'h12310, 20'h12314, 20'h12318, 20'h1231C, 20'h14978,
                20'h112d0, 20'h132d0, 20'h12344, 20'h1469C, 20'h14770, 20'h142c4,
                20'h10734, 20'hd204, 20'h1058, 20'h105C, 20'h1060, 20'h1064,
                20'h1068, 20'h106C, 20'h1070, 20'h1074, 20'h1078, 20'h107C,
                20'h137C, 20'h1380, 20'h8430:
                    rom_addr_check = 1'b1;
                default: rom_addr_check = 1'b0;
            endcase
        end
    endfunction

    always_ff @(posedge clk) begin
        if (rst) begin
            rd_rsp_valid <= 1'b0;
            counter_03f0 <= '0;
            counter_00c4 <= '0;
            counter_0004 <= '0;
            counter_0088 <= '0;
            counter_0080 <= '0;
            counter_0024 <= '0;
            counter_02a0 <= '0;
            counter_0070 <= '0;
            counter_8380 <= '0;
            counter_8400 <= '0;
            counter_8404 <= '0;
            counter_8c08 <= '0;
            counter_9008 <= '0;
            counter_8d00 <= '0;
            counter_9100 <= '0;
            counter_8a00 <= '0;
            counter_1000 <= '0;
            counter_1008 <= '0;
            counter_10a0 <= '0;
            counter_10a4 <= '0;
            counter_0074 <= '0;
            counter_13f0 <= '0;
            counter_11d8 <= '0;
            counter_11c0 <= '0;
            counter_1010 <= '0;
            counter_101C <= '0;
            counter_131C <= '0;
            counter_1014 <= '0;
            counter_1314 <= '0;
            counter_1018 <= '0;
            counter_1004 <= '0;
            counter_8810 <= '0;
            counter_9a00 <= '0;
            counter_1310 <= '0;
            counter_01e0 <= '0;
            counter_0008 <= '0;
            counter_40000 <= '0;
            counter_01e4 <= '0;
            counter_1080 <= '0;
            counter_0038 <= '0;
            counter_0030 <= '0;
            counter_8160 <= '0;
            counter_01f4 <= '0;
            counter_8164 <= '0;
            counter_8150 <= '0;
            counter_8154 <= '0;
            counter_8158 <= '0;
            counter_815C <= '0;
            counter_02f0 <= '0;
            counter_0000 <= '0;
            counter_0090 <= '0;
            counter_8040 <= '0;
            counter_c000 <= '0;
            counter_9e10 <= '0;
            counter_c340 <= '0;
            counter_ce34 <= '0;
            counter_ce04 <= '0;
            counter_cc04 <= '0;
            counter_cc80 <= '0;
            counter_ce48 <= '0;
            counter_ca1C <= '0;
            counter_cc08 <= '0;
            counter_ce3C <= '0;
            counter_ce00 <= '0;
            counter_ce20 <= '0;
            counter_c600 <= '0;
            counter_c660 <= '0;
            counter_9430 <= '0;
            counter_9bf4 <= '0;
            counter_9cf4 <= '0;
            counter_9ef0 <= '0;
            counter_9f1C <= '0;
            counter_9f2C <= '0;
            counter_8c38 <= '0;
            counter_9038 <= '0;
            counter_8850 <= '0;
            counter_8854 <= '0;
            counter_8858 <= '0;
            counter_9840 <= '0;
            counter_962C <= '0;
            counter_c3e8 <= '0;
            counter_c6c0 <= '0;
            counter_c800 <= '0;
            counter_ccfC <= '0;
            counter_cef4 <= '0;
            counter_cceC <= '0;
            counter_9414 <= '0;
            counter_8410 <= '0;
            counter_8414 <= '0;
            counter_158dC <= '0;
            counter_15818 <= '0;
            counter_178dC <= '0;
            counter_17818 <= '0;
            counter_10704 <= '0;
            counter_0040 <= '0;
            counter_da20 <= '0;
            counter_da34 <= '0;
            counter_da40 <= '0;
            counter_daf0 <= '0;
            counter_daf8 <= '0;
            counter_da4C <= '0;
            counter_da6C <= '0;
            counter_da30 <= '0;
            counter_da10 <= '0;
            counter_1c008 <= '0;
            counter_1d008 <= '0;
            counter_1c3bC <= '0;
            counter_1c0cC <= '0;
            counter_1c0fC <= '0;
            counter_1d3bC <= '0;
            counter_1d0cC <= '0;
            counter_1d0fC <= '0;
            counter_00aC <= '0;
            counter_d200 <= '0;
            counter_c67C <= '0;
            counter_1466C <= '0;
            counter_14740 <= '0;
            counter_10980 <= '0;
            counter_14624 <= '0;
            counter_146f8 <= '0;
            counter_14674 <= '0;
            counter_14748 <= '0;
            counter_14650 <= '0;
            counter_14724 <= '0;
            counter_14688 <= '0;
            counter_1475C <= '0;
            counter_1c108 <= '0;
            counter_1d108 <= '0;
            counter_10738 <= '0;
            counter_109a4 <= '0;
            counter_10c00 <= '0;
            counter_10c2C <= '0;
            counter_10c30 <= '0;
            counter_10c34 <= '0;
            counter_10c38 <= '0;
            counter_10764 <= '0;
            counter_10768 <= '0;
            counter_1076C <= '0;
            counter_10770 <= '0;
            counter_10774 <= '0;
            counter_1462C <= '0;
            counter_14630 <= '0;
            counter_14634 <= '0;
            counter_14638 <= '0;
            counter_14640 <= '0;
            counter_14644 <= '0;
            counter_1481C <= '0;
            counter_0280 <= '0;
            counter_1c014 <= '0;
            counter_1c000 <= '0;
            counter_1c06C <= '0;
            counter_1c070 <= '0;
            counter_1c074 <= '0;
            counter_1c3c0 <= '0;
            counter_1d014 <= '0;
            counter_1d000 <= '0;
            counter_1d06C <= '0;
            counter_1d070 <= '0;
            counter_1d074 <= '0;
            counter_1d3c0 <= '0;
            counter_112eC <= '0;
            counter_15e00 <= '0;
            counter_132eC <= '0;
            counter_17e00 <= '0;
            counter_112d8 <= '0;
            counter_132d8 <= '0;
            counter_112b8 <= '0;
            counter_1032C <= '0;
            counter_1030C <= '0;
            counter_112dC <= '0;
            counter_120f4 <= '0;
            counter_120f8 <= '0;
            counter_120f0 <= '0;
            counter_11730 <= '0;
            counter_11e00 <= '0;
            counter_132b8 <= '0;
            counter_132dC <= '0;
            counter_13e00 <= '0;
            counter_112d4 <= '0;
            counter_132d4 <= '0;
            counter_15e10 <= '0;
            counter_15e50 <= '0;
            counter_15e60 <= '0;
            counter_112a0 <= '0;
            counter_112e0 <= '0;
            counter_112e4 <= '0;
            counter_15e0C <= '0;
            counter_15e5C <= '0;
            counter_15e28 <= '0;
            counter_15e48 <= '0;
            counter_15e98 <= '0;
            counter_112e8 <= '0;
            counter_1c23C <= '0;
            counter_15e44 <= '0;
            counter_15e94 <= '0;
            counter_17e10 <= '0;
            counter_17e50 <= '0;
            counter_17e60 <= '0;
            counter_132a0 <= '0;
            counter_132e0 <= '0;
            counter_132e4 <= '0;
            counter_17e0C <= '0;
            counter_17e5C <= '0;
            counter_17e28 <= '0;
            counter_17e48 <= '0;
            counter_17e98 <= '0;
            counter_132e8 <= '0;
            counter_1d23C <= '0;
            counter_17e44 <= '0;
            counter_17e94 <= '0;
            counter_c348 <= '0;
            counter_1c248 <= '0;
            counter_1d248 <= '0;
            counter_1c180 <= '0;
            counter_1d180 <= '0;
            counter_9c18 <= '0;
            counter_c614 <= '0;
            counter_01a4 <= '0;
            counter_10b4 <= '0;
            counter_13b4 <= '0;
            counter_1054 <= '0;
            counter_1050 <= '0;
            counter_c400 <= '0;
            counter_ca08 <= '0;
            counter_c424 <= '0;
            counter_c404 <= '0;
            counter_c40C <= '0;
            counter_1d0f8 <= '0;
            counter_10000 <= '0;
            counter_120fC <= '0;
            counter_c010 <= '0;
            counter_c628 <= '0;
            counter_1c060 <= '0;
            counter_1d060 <= '0;
            counter_14974 <= '0;
            counter_14978 <= '0;

            // 0x00f0
            rom_00f0[0] <= 32'h0c490539;

            // 0x02d0
            rom_02d0[0] <= 32'hffffffff;

            // 0x03f0
            rom_03f0[0] <= 32'h0224000f; // ops_deinit+0x50/0x90 [rtw89pci]
            rom_03f0[1] <= 32'h02200105; // ops_deinit+0x50/0x90 [rtw89pci]
            rom_03f0[2] <= 32'h0224000f; // ops_deinit+0x50/0x90 [rtw89pci]
            rom_03f0[3] <= 32'h02200105; // ops_deinit+0x50/0x90 [rtw89pci]

            // 0x00c4
            rom_00c4[0] <= 32'h00400000;
            rom_00c4[1] <= 32'h00400000;

            // 0x0004
            rom_0004[0] <= 32'h00000400; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[1] <= 32'h00000400; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[2] <= 32'h00000400; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[3] <= 32'h00010000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[4] <= 32'h00010000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[5] <= 32'h00030000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[6] <= 32'h00030000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[7] <= 32'h00000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[8] <= 32'h00000100; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[9] <= 32'h00000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[10] <= 32'h50030082; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[11] <= 32'h00030000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[12] <= 32'h00000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[13] <= 32'h00000200; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[14] <= 32'h00000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[15] <= 32'h00000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[16] <= 32'h00000400; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[17] <= 32'h00000400; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[18] <= 32'h00000400; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[19] <= 32'h00010000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[20] <= 32'h00030000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[21] <= 32'h00030000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[22] <= 32'h00000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[23] <= 32'h00000100; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[24] <= 32'h00000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[25] <= 32'h50030082; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[26] <= 32'h00030000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[27] <= 32'h00000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[28] <= 32'h00000200; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[29] <= 32'h00000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_0004[30] <= 32'h00000000; // check_mdio+0xdb/0x160 [rtw89pci]

            // 0x0088
            rom_0088[0] <= 32'h0000004c; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[1] <= 32'h0000004d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[2] <= 32'h0000004c; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[3] <= 32'h0000004d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[4] <= 32'h0000004c; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[5] <= 32'h0000044d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[6] <= 32'h0000044d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[7] <= 32'h0000044c; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[8] <= 32'h0000044d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[9] <= 32'h0000044d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[10] <= 32'h0000004c; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[11] <= 32'h0000004d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[12] <= 32'h0000004c; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[13] <= 32'h0000004d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[14] <= 32'h0000004c; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[15] <= 32'h0000044d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[16] <= 32'h0000044d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[17] <= 32'h0000044c; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[18] <= 32'h0000044d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]
            rom_0088[19] <= 32'h0000044d; // ops_mac_pre_init_ax+0x5d4/0x16e0 [rtw89pci]

            // 0x0080
            rom_0080[0] <= 32'h80000000;
            rom_0080[1] <= 32'h00000023;
            rom_0080[2] <= 32'h00000000;
            rom_0080[3] <= 32'h80000000;
            rom_0080[4] <= 32'h00000023;
            rom_0080[5] <= 32'h00000000;

            // 0x0024
            rom_0024[0] <= 32'h00000000;
            rom_0024[1] <= 32'h00000000;

            // 0x02a0
            rom_02a0[0] <= 32'h000000f3;
            rom_02a0[1] <= 32'h00010000;
            rom_02a0[2] <= 32'h000000f3;
            rom_02a0[3] <= 32'h00010000;

            // 0x0070
            rom_0070[0] <= 32'h00008000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[1] <= 32'h02008024; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[2] <= 32'h02008024; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[3] <= 32'h00008000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[4] <= 32'h02008024; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[5] <= 32'h02008024; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[6] <= 32'h02000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[7] <= 32'h02000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[8] <= 32'h06000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[9] <= 32'h06000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[10] <= 32'h06000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[11] <= 32'h06000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]
            rom_0070[12] <= 32'h06000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xe52/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe23/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe06/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe6f/0x16e0 [rtw89pci]

            // 0x8380
            rom_8380[0] <= 32'h00000000;
            rom_8380[1] <= 32'h00000000;

            // 0x8400
            rom_8400[0] <= 32'h60440000;
            rom_8400[1] <= 32'h60440000;
            rom_8400[2] <= 32'h60440000;
            rom_8400[3] <= 32'h64c40000;
            rom_8400[4] <= 32'h60440000;
            rom_8400[5] <= 32'h60440000;
            rom_8400[6] <= 32'h60440000;
            rom_8400[7] <= 32'h64c40000;
            rom_8400[8] <= 32'hfb7d0000;
            rom_8400[9] <= 32'hfb7d0000;
            rom_8400[10] <= 32'hfb7d0000;
            rom_8400[11] <= 32'hfffd0000;
            rom_8400[12] <= 32'hfffd0000;
            rom_8400[13] <= 32'hfffd0000;
            rom_8400[14] <= 32'hfffd0000;
            rom_8400[15] <= 32'hfffd0000;
            rom_8400[16] <= 32'hfffd0000;
            rom_8400[17] <= 32'hfffd0000;
            rom_8400[18] <= 32'hfffd0000;
            rom_8400[19] <= 32'hfffd0000;
            rom_8400[20] <= 32'hfffd0000;
            rom_8400[21] <= 32'hfffd0000;
            rom_8400[22] <= 32'hfffd0000;
            rom_8400[23] <= 32'hfffd0000;
            rom_8400[24] <= 32'hfffd0000;
            rom_8400[25] <= 32'hfffd0000;
            rom_8400[26] <= 32'hfffd0000;
            rom_8400[27] <= 32'hfffd0000;
            rom_8400[28] <= 32'hfffd0000;
            rom_8400[29] <= 32'hfffd0000;
            rom_8400[30] <= 32'hfffd0000;
            rom_8400[31] <= 32'hfffd0000;
            rom_8400[32] <= 32'hfffd0000;
            rom_8400[33] <= 32'hfffd0000;
            rom_8400[34] <= 32'hfffd0000;
            rom_8400[35] <= 32'hfffd0000;
            rom_8400[36] <= 32'hfffd0000;
            rom_8400[37] <= 32'hfffd0000;
            rom_8400[38] <= 32'hfffd0000;
            rom_8400[39] <= 32'hfffd0000;
            rom_8400[40] <= 32'hfffd0000;
            rom_8400[41] <= 32'hfffd0000;

            // 0x8404
            rom_8404[0] <= 32'h00040000;
            rom_8404[1] <= 32'h00040000;
            rom_8404[2] <= 32'h0b1f0000;

            // 0x8c08
            rom_8c08[0] <= 32'h00000000;
            rom_8c08[1] <= 32'h00000000;
            rom_8c08[2] <= 32'h00000000;

            // 0x9008
            rom_9008[0] <= 32'h00000000;
            rom_9008[1] <= 32'h00000000;
            rom_9008[2] <= 32'h00402001;

            // 0x8d00
            rom_8d00[0] <= 32'h00000000;
            rom_8d00[1] <= 32'h00000003;
            rom_8d00[2] <= 32'h00000000;
            rom_8d00[3] <= 32'h00000003;
            rom_8d00[4] <= 32'h00000000;
            rom_8d00[5] <= 32'h00000003;

            // 0x9100
            rom_9100[0] <= 32'h00000003;
            rom_9100[1] <= 32'h00000003;
            rom_9100[2] <= 32'h00000003;

            // 0x8a00
            rom_8a00[0] <= 32'h00000000;
            rom_8a00[1] <= 32'h00000000;
            rom_8a00[2] <= 32'h00000000;
            rom_8a00[3] <= 32'h00000000;
            rom_8a00[4] <= 32'h00000000;
            rom_8a00[5] <= 32'h00000000;
            rom_8a00[6] <= 32'h00000008;
            rom_8a00[7] <= 32'h00000000;
            rom_8a00[8] <= 32'h00000010;
            rom_8a00[9] <= 32'h00000019;

            // 0x1000
            rom_1000[0] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[1] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[2] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[3] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[4] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[5] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[6] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[7] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[8] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[9] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[10] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[11] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[12] <= 32'h00c0ff34; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[13] <= 32'h00c0ff34; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[14] <= 32'h00c0ff34; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[15] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[16] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[17] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[18] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[19] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[20] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[21] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[22] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[23] <= 32'h00c0d734; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]
            rom_1000[24] <= 32'h00c0ff34; // ops_mac_pre_init_ax+0x11bb/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xcb6/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x15b8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8dc/0x16e0 [rtw89pci] // ops_reset+0x19f/0x350 [rtw89pci] // ctrl_dma_all+0x55/0x80 [rtw89pci] // ops_mac_pre_init_ax+0xc97/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x8c4/0x16e0 [rtw89pci] // ctrl_dma_all+0x6b/0x80 [rtw89pci] // ops_mac_pre_init_ax+0x46a/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x905/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x89c/0x16e0 [rtw89pci] // clr_idx_all_ax+0xa8/0x100 [rtw89pci] // ops_mac_pre_init_ax+0x132e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x115c/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1179/0x16e0 [rtw89pci] // rst_bdram_ax+0x25/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x11d7/0x16e0 [rtw89pci] // rst_bdram_ax+0x42/0xb0 [rtw89pci] // ops_mac_pre_init_ax+0x10b6/0x16e0 [rtw89pci]

            // 0x1008
            rom_1008[0] <= 32'h00000043; // ops_mac_pre_init_ax+0x1a7/0x16e0 [rtw89pci]
            rom_1008[1] <= 32'h00000043; // ops_mac_pre_init_ax+0x1a7/0x16e0 [rtw89pci]

            // 0x10a0
            rom_10a0[0] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[1] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[2] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[3] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[4] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[5] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[6] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[7] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[8] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[9] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[10] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[11] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[12] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[13] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[14] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[15] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[16] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[17] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[18] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[19] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[20] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[21] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[22] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[23] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[24] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[25] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[26] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[27] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[28] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[29] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[30] <= 32'h00001004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[31] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[32] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[33] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[34] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[35] <= 32'h00003004; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[36] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[37] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[38] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[39] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[40] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[41] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[42] <= 32'h00001006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[43] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[44] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[45] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[46] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]
            rom_10a0[47] <= 32'h00003006; // check_mdio+0xb2/0x160 [rtw89pci] // check_mdio+0x4a/0x160 [rtw89pci] // check_mdio+0xdb/0x160 [rtw89pci] // check_mdio+0x32/0x160 [rtw89pci] // check_mdio+0x7d/0x160 [rtw89pci] // check_mdio+0x95/0x160 [rtw89pci]

            // 0x10a4
            rom_10a4[0] <= 32'h40080000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_10a4[1] <= 32'h40000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_10a4[2] <= 32'h040a0000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_10a4[3] <= 32'h040a0000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_10a4[4] <= 32'h40080000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_10a4[5] <= 32'h40000000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_10a4[6] <= 32'h040a0000; // check_mdio+0xdb/0x160 [rtw89pci]
            rom_10a4[7] <= 32'h040a0000; // check_mdio+0xdb/0x160 [rtw89pci]

            // 0x0074
            rom_0074[0] <= 32'h000004fd; // ops_mac_pre_init_ax+0xea4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe87/0x16e0 [rtw89pci]
            rom_0074[1] <= 32'h000004fd; // ops_mac_pre_init_ax+0xea4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0xe87/0x16e0 [rtw89pci]

            // 0x13f0
            rom_13f0[0] <= 32'h00170000; // ops_mac_pre_init_ax+0x343/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x135f/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x200/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x21d/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x326/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x942/0x16e0 [rtw89pci]
            rom_13f0[1] <= 32'h00170000; // ops_mac_pre_init_ax+0x343/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x135f/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x200/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x21d/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x326/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x942/0x16e0 [rtw89pci]
            rom_13f0[2] <= 32'h00170000; // ops_mac_pre_init_ax+0x343/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x135f/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x200/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x21d/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x326/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x942/0x16e0 [rtw89pci]
            rom_13f0[3] <= 32'h00170000; // ops_mac_pre_init_ax+0x343/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x135f/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x200/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x21d/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x326/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x942/0x16e0 [rtw89pci]
            rom_13f0[4] <= 32'h00170000; // ops_mac_pre_init_ax+0x343/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x135f/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x200/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x21d/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x326/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x942/0x16e0 [rtw89pci]
            rom_13f0[5] <= 32'h00170000; // ops_mac_pre_init_ax+0x343/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x135f/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x200/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x21d/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x326/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x942/0x16e0 [rtw89pci]

            // 0x11d8
            rom_11d8[0] <= 32'h00000081; // ops_mac_pre_init_ax+0x291/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x245/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x262/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x2ca/0x16e0 [rtw89pci]
            rom_11d8[1] <= 32'h00000081; // ops_mac_pre_init_ax+0x291/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x245/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x262/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x2ca/0x16e0 [rtw89pci]
            rom_11d8[2] <= 32'h00000081; // ops_mac_pre_init_ax+0x291/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x245/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x262/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x2ca/0x16e0 [rtw89pci]
            rom_11d8[3] <= 32'h00000081; // ops_mac_pre_init_ax+0x291/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x245/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x262/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x2ca/0x16e0 [rtw89pci]

            // 0x11c0
            rom_11c0[0] <= 32'h00040003; // ops_mac_pre_init_ax+0x2fe/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x2e2/0x16e0 [rtw89pci]
            rom_11c0[1] <= 32'h00040003; // ops_mac_pre_init_ax+0x2fe/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x2e2/0x16e0 [rtw89pci]

            // 0x1010
            rom_1010[0] <= 32'h00100000; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[1] <= 32'h00180000; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[2] <= 32'h00180000; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[3] <= 32'h001fff00; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[4] <= 32'h001bff00; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[5] <= 32'h000bff00; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[6] <= 32'h000bff00; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[7] <= 32'h001bff00; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[8] <= 32'h001fff00; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[9] <= 32'h001bff00; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[10] <= 32'h000bff00; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[11] <= 32'h00080000; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]
            rom_1010[12] <= 32'h00000000; // rst_bdram_ax+0x6e/0xb0 [rtw89pci] // ops_mac_post_init_ax+0x5b/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x3c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x3a8/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x390/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x5c4/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x371/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x58c/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x13c/0x150 [rtw89pci] // ops_deinit+0x8b/0x90 [rtw89pci]

            // 0x101C
            rom_101C[0] <= 32'h00000000; // poll_txdma_ch_idle_ax+0xce/0x120 [rtw89pci] // ops_mac_pre_init_ax+0x3d1/0x16e0 [rtw89pci] // ctrl_dma_trx+0x5a/0x70 [rtw89pci]
            rom_101C[1] <= 32'h00000000; // poll_txdma_ch_idle_ax+0xce/0x120 [rtw89pci] // ops_mac_pre_init_ax+0x3d1/0x16e0 [rtw89pci] // ctrl_dma_trx+0x5a/0x70 [rtw89pci]
            rom_101C[2] <= 32'h00000000; // poll_txdma_ch_idle_ax+0xce/0x120 [rtw89pci] // ops_mac_pre_init_ax+0x3d1/0x16e0 [rtw89pci] // ctrl_dma_trx+0x5a/0x70 [rtw89pci]
            rom_101C[3] <= 32'h00000000; // poll_txdma_ch_idle_ax+0xce/0x120 [rtw89pci] // ops_mac_pre_init_ax+0x3d1/0x16e0 [rtw89pci] // ctrl_dma_trx+0x5a/0x70 [rtw89pci]

            // 0x131C
            rom_131C[0] <= 32'h00000000; // poll_txdma_ch_idle_ax+0x51/0x120 [rtw89pci]
            rom_131C[1] <= 32'h00000000; // poll_txdma_ch_idle_ax+0x51/0x120 [rtw89pci]

            // 0x1014
            rom_1014[0] <= 32'hdeadbeef; // ops_deinit+0x3d/0x90 [rtw89pci] // ops_mac_pre_init_ax+0x411/0x16e0 [rtw89pci]
            rom_1014[1] <= 32'hdeadbeef; // ops_deinit+0x3d/0x90 [rtw89pci] // ops_mac_pre_init_ax+0x411/0x16e0 [rtw89pci]
            rom_1014[2] <= 32'hdeadbeef; // ops_deinit+0x3d/0x90 [rtw89pci] // ops_mac_pre_init_ax+0x411/0x16e0 [rtw89pci]

            // 0x1314
            rom_1314[0] <= 32'hdeadbeef; // clr_idx_all_ax+0x62/0x100 [rtw89pci] // clr_idx_all_ax+0x43/0x100 [rtw89pci]
            rom_1314[1] <= 32'hdeadbeef; // clr_idx_all_ax+0x62/0x100 [rtw89pci] // clr_idx_all_ax+0x43/0x100 [rtw89pci]
            rom_1314[2] <= 32'hdeadbeef; // clr_idx_all_ax+0x62/0x100 [rtw89pci] // clr_idx_all_ax+0x43/0x100 [rtw89pci]

            // 0x1018
            rom_1018[0] <= 32'hdeadbeef; // clr_idx_all_ax+0x93/0x100 [rtw89pci] // clr_idx_all_ax+0x78/0x100 [rtw89pci]
            rom_1018[1] <= 32'hdeadbeef; // clr_idx_all_ax+0x93/0x100 [rtw89pci] // clr_idx_all_ax+0x78/0x100 [rtw89pci]
            rom_1018[2] <= 32'hdeadbeef; // clr_idx_all_ax+0x93/0x100 [rtw89pci] // clr_idx_all_ax+0x78/0x100 [rtw89pci]

            // 0x1004
            rom_1004[0] <= 32'h01010000; // ops_mac_pre_init_ax+0x51b/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x53e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1296/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x126d/0x16e0 [rtw89pci]
            rom_1004[1] <= 32'h01010000; // ops_mac_pre_init_ax+0x51b/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x53e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1296/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x126d/0x16e0 [rtw89pci]
            rom_1004[2] <= 32'h01010000; // ops_mac_pre_init_ax+0x51b/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x53e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1296/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x126d/0x16e0 [rtw89pci]
            rom_1004[3] <= 32'h01010000; // ops_mac_pre_init_ax+0x51b/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x53e/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x1296/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x126d/0x16e0 [rtw89pci]

            // 0x8810
            rom_8810[0] <= 32'h00000101; // ops_mac_post_init_ax+0xd2/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x12d7/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x12ae/0x16e0 [rtw89pci]
            rom_8810[1] <= 32'h00000101; // ops_mac_post_init_ax+0xd2/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x12d7/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x12ae/0x16e0 [rtw89pci]
            rom_8810[2] <= 32'h00000101; // ops_mac_post_init_ax+0xd2/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x12d7/0x16e0 [rtw89pci] // ops_mac_pre_init_ax+0x12ae/0x16e0 [rtw89pci]

            // 0x9a00
            rom_9a00[0] <= 32'h00000000; // ops_mac_pre_init_ax+0x1316/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x107/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x12f9/0x16e0 [rtw89pci]
            rom_9a00[1] <= 32'h00000000; // ops_mac_pre_init_ax+0x1316/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x107/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x12f9/0x16e0 [rtw89pci]
            rom_9a00[2] <= 32'h00000000; // ops_mac_pre_init_ax+0x1316/0x16e0 [rtw89pci] // ops_mac_post_init_ax+0x107/0x150 [rtw89pci] // ops_mac_pre_init_ax+0x12f9/0x16e0 [rtw89pci]

            // 0x1310
            rom_1310[0] <= 32'h00000000; // ctrl_txdma_ch_ax+0x51/0xf0 [rtw89pci] // ctrl_txdma_ch_ax+0x83/0xf0 [rtw89pci]
            rom_1310[1] <= 32'h00000003; // ctrl_txdma_ch_ax+0x51/0xf0 [rtw89pci] // ctrl_txdma_ch_ax+0x83/0xf0 [rtw89pci]
            rom_1310[2] <= 32'h00000003; // ctrl_txdma_ch_ax+0x51/0xf0 [rtw89pci] // ctrl_txdma_ch_ax+0x83/0xf0 [rtw89pci]

            // 0x01e0
            rom_01e0[0] <= 32'h000000e2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[1] <= 32'h000000e0; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[2] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[3] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[4] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[5] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[6] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[7] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[8] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[9] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[10] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[11] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[12] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[13] <= 32'h00000023; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[14] <= 32'h00000023; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[15] <= 32'h00000023; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[16] <= 32'h00000027; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[17] <= 32'h000000c3; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[18] <= 32'h000000e2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[19] <= 32'h000000e2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[20] <= 32'h000000e0; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[21] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[22] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[23] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[24] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[25] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[26] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[27] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[28] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[29] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[30] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[31] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[32] <= 32'h00000001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[33] <= 32'h00000023; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[34] <= 32'h00000023; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[35] <= 32'h00000023; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[36] <= 32'h00000027; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[37] <= 32'h000000c3; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_01e0[38] <= 32'h000000e2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]

            // 0x0008
            rom_0008[0] <= 32'h0020ac21;
            rom_0008[1] <= 32'h0020ac21;
            rom_0008[2] <= 32'h00200000;
            rom_0008[3] <= 32'h0020ac21;
            rom_0008[4] <= 32'h0020ac21;

            // 0x40000
            rom_40000[0] <= 32'h00000000;
            rom_40000[1] <= 32'h00000000;

            // 0x01e4
            rom_01e4[0] <= 32'h00000000;
            rom_01e4[1] <= 32'h00000000;

            // 0x1080
            rom_1080[0] <= 32'h00000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[1] <= 32'h00010001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[2] <= 32'h00010002; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[3] <= 32'h00020003; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[4] <= 32'h00030004; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[5] <= 32'h00040005; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[6] <= 32'h00050006; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[7] <= 32'h00060007; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[8] <= 32'h00080008; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[9] <= 32'h00090009; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[10] <= 32'h0009000a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[11] <= 32'h000a000b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[12] <= 32'h000b000c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[13] <= 32'h000c000d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[14] <= 32'h000d000e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[15] <= 32'h000e000f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[16] <= 32'h000f0010; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[17] <= 32'h00100011; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[18] <= 32'h00110012; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[19] <= 32'h00120013; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[20] <= 32'h00130014; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[21] <= 32'h00140015; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[22] <= 32'h00150016; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[23] <= 32'h00160017; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[24] <= 32'h00170018; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[25] <= 32'h00180019; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[26] <= 32'h0019001a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[27] <= 32'h001a001b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[28] <= 32'h001b001c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[29] <= 32'h001c001d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[30] <= 32'h001d001e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[31] <= 32'h001e001f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[32] <= 32'h001f0020; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[33] <= 32'h00200021; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[34] <= 32'h00210022; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[35] <= 32'h00220023; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[36] <= 32'h00230024; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[37] <= 32'h00240025; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[38] <= 32'h00250026; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[39] <= 32'h00260027; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[40] <= 32'h00270028; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[41] <= 32'h00280029; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[42] <= 32'h0029002a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[43] <= 32'h002a002b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[44] <= 32'h002b002c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[45] <= 32'h002c002d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[46] <= 32'h002d002e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[47] <= 32'h002e002f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[48] <= 32'h002f0030; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[49] <= 32'h00300031; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[50] <= 32'h00310032; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[51] <= 32'h00320033; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[52] <= 32'h00330034; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[53] <= 32'h00340035; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[54] <= 32'h00350036; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[55] <= 32'h00360037; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[56] <= 32'h00370038; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[57] <= 32'h00380039; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[58] <= 32'h0039003a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[59] <= 32'h003a003b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[60] <= 32'h003b003c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[61] <= 32'h003c003d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[62] <= 32'h003d003e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[63] <= 32'h003e003f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[64] <= 32'h003f0040; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[65] <= 32'h00400041; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[66] <= 32'h00410042; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[67] <= 32'h00420043; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[68] <= 32'h00440044; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[69] <= 32'h00440045; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[70] <= 32'h00450046; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[71] <= 32'h00460047; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[72] <= 32'h00470048; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[73] <= 32'h00480049; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[74] <= 32'h0049004a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[75] <= 32'h004b004b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[76] <= 32'h004c004c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[77] <= 32'h004d004d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[78] <= 32'h004e004e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[79] <= 32'h004f004f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[80] <= 32'h00500050; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[81] <= 32'h00510051; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[82] <= 32'h00520052; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[83] <= 32'h00530053; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[84] <= 32'h00540054; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[85] <= 32'h00550055; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[86] <= 32'h00560056; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[87] <= 32'h00570057; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[88] <= 32'h00580058; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[89] <= 32'h00590059; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[90] <= 32'h005a005a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[91] <= 32'h005b005b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[92] <= 32'h005c005c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[93] <= 32'h005d005d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[94] <= 32'h005e005e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[95] <= 32'h005f005f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[96] <= 32'h00600060; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[97] <= 32'h00610061; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[98] <= 32'h00620062; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[99] <= 32'h00630063; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[100] <= 32'h00640064; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[101] <= 32'h00650065; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[102] <= 32'h00660066; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[103] <= 32'h00670067; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[104] <= 32'h00680068; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[105] <= 32'h00690069; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[106] <= 32'h006a006a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[107] <= 32'h006a006b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[108] <= 32'h006b006c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[109] <= 32'h006c006d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[110] <= 32'h006d006e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[111] <= 32'h006e006f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[112] <= 32'h006f0070; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[113] <= 32'h00700071; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[114] <= 32'h00710072; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[115] <= 32'h00720073; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[116] <= 32'h00730074; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[117] <= 32'h00740075; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[118] <= 32'h00750076; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[119] <= 32'h00760077; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[120] <= 32'h00770078; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[121] <= 32'h00780079; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[122] <= 32'h0079007a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[123] <= 32'h007a007b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[124] <= 32'h007b007c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[125] <= 32'h007c007d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[126] <= 32'h007d007e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[127] <= 32'h007e007f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[128] <= 32'h007f0080; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[129] <= 32'h00800081; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[130] <= 32'h00810082; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[131] <= 32'h00820083; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[132] <= 32'h00830084; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[133] <= 32'h00840085; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[134] <= 32'h00850086; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[135] <= 32'h00860087; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[136] <= 32'h00870088; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[137] <= 32'h00880089; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[138] <= 32'h0089008a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[139] <= 32'h008a008b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[140] <= 32'h008b008c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[141] <= 32'h008c008d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[142] <= 32'h008d008e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[143] <= 32'h008e008f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[144] <= 32'h008f0090; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[145] <= 32'h00900091; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[146] <= 32'h00910092; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[147] <= 32'h00920093; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[148] <= 32'h00930094; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[149] <= 32'h00940095; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[150] <= 32'h00950096; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[151] <= 32'h00960097; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[152] <= 32'h00970098; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[153] <= 32'h00980099; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[154] <= 32'h0099009a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[155] <= 32'h009a009b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[156] <= 32'h009b009c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[157] <= 32'h009c009d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[158] <= 32'h009d009e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[159] <= 32'h009e009f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[160] <= 32'h009f00a0; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[161] <= 32'h00a000a1; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[162] <= 32'h00a100a2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[163] <= 32'h00a200a3; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[164] <= 32'h00a300a4; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[165] <= 32'h00a400a5; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[166] <= 32'h00a500a6; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[167] <= 32'h00a600a7; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[168] <= 32'h00a700a8; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[169] <= 32'h00a800a9; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[170] <= 32'h00a900aa; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[171] <= 32'h00ab00ab; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[172] <= 32'h00ac00ac; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[173] <= 32'h00ad00ad; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[174] <= 32'h00ae00ae; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[175] <= 32'h00af00af; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[176] <= 32'h00b000b0; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[177] <= 32'h00b100b1; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[178] <= 32'h00b200b2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[179] <= 32'h00b300b3; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[180] <= 32'h00b300b4; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[181] <= 32'h00b400b5; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[182] <= 32'h00b500b6; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[183] <= 32'h00b600b7; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[184] <= 32'h00b700b8; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[185] <= 32'h00b800b9; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[186] <= 32'h00b900ba; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[187] <= 32'h00ba00bb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[188] <= 32'h00bb00bc; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[189] <= 32'h00bc00bd; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[190] <= 32'h00bd00be; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[191] <= 32'h00be00bf; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[192] <= 32'h00bf00c0; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[193] <= 32'h00c000c1; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[194] <= 32'h00000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[195] <= 32'h00010001; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[196] <= 32'h00020002; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[197] <= 32'h00030003; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[198] <= 32'h00040004; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[199] <= 32'h00050005; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[200] <= 32'h00060006; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[201] <= 32'h00060007; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[202] <= 32'h00070008; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[203] <= 32'h00080009; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[204] <= 32'h0009000a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[205] <= 32'h000a000b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[206] <= 32'h000b000c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[207] <= 32'h000c000d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[208] <= 32'h000d000e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[209] <= 32'h000e000f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[210] <= 32'h000f0010; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[211] <= 32'h00100011; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[212] <= 32'h00110012; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[213] <= 32'h00120013; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[214] <= 32'h00130014; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[215] <= 32'h00140015; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[216] <= 32'h00150016; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[217] <= 32'h00160017; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[218] <= 32'h00170018; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[219] <= 32'h00180019; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[220] <= 32'h0019001a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[221] <= 32'h001a001b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[222] <= 32'h001b001c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[223] <= 32'h001c001d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[224] <= 32'h001d001e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[225] <= 32'h001e001f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[226] <= 32'h001f0020; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[227] <= 32'h00200021; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[228] <= 32'h00210022; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[229] <= 32'h00220023; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[230] <= 32'h00230024; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[231] <= 32'h00240025; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[232] <= 32'h00250026; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[233] <= 32'h00260027; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[234] <= 32'h00270028; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[235] <= 32'h00280029; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[236] <= 32'h0029002a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[237] <= 32'h002a002b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[238] <= 32'h002b002c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[239] <= 32'h002c002d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[240] <= 32'h002d002e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[241] <= 32'h002e002f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[242] <= 32'h002f0030; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[243] <= 32'h00300031; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[244] <= 32'h00310032; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[245] <= 32'h00320033; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[246] <= 32'h00330034; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[247] <= 32'h00340035; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[248] <= 32'h00350036; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[249] <= 32'h00360037; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[250] <= 32'h00380038; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[251] <= 32'h00380039; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[252] <= 32'h0039003a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[253] <= 32'h003a003b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[254] <= 32'h003b003c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[255] <= 32'h003c003d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[256] <= 32'h003d003e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[257] <= 32'h003e003f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[258] <= 32'h003f0040; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[259] <= 32'h00400041; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[260] <= 32'h00410042; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[261] <= 32'h00430043; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[262] <= 32'h00440044; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[263] <= 32'h00450045; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[264] <= 32'h00450046; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[265] <= 32'h00470047; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[266] <= 32'h00470048; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[267] <= 32'h00480049; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[268] <= 32'h0049004a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[269] <= 32'h004a004b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[270] <= 32'h004b004c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[271] <= 32'h004c004d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[272] <= 32'h004d004e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[273] <= 32'h004e004f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[274] <= 32'h004f0050; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[275] <= 32'h00500051; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[276] <= 32'h00510052; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[277] <= 32'h00520053; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[278] <= 32'h00530054; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[279] <= 32'h00540055; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[280] <= 32'h00550056; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[281] <= 32'h00560057; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[282] <= 32'h00570058; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[283] <= 32'h00580059; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[284] <= 32'h0059005a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[285] <= 32'h005a005b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[286] <= 32'h005b005c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[287] <= 32'h005c005d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[288] <= 32'h005d005e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[289] <= 32'h005e005f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[290] <= 32'h005f0060; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[291] <= 32'h00600061; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[292] <= 32'h00610062; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[293] <= 32'h00620063; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[294] <= 32'h00630064; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[295] <= 32'h00640065; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[296] <= 32'h00650066; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[297] <= 32'h00660067; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[298] <= 32'h00670068; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[299] <= 32'h00680069; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[300] <= 32'h0069006a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[301] <= 32'h006a006b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[302] <= 32'h006b006c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[303] <= 32'h006c006d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[304] <= 32'h006e006e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[305] <= 32'h006e006f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[306] <= 32'h006f0070; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[307] <= 32'h00700071; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[308] <= 32'h00710072; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[309] <= 32'h00720073; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[310] <= 32'h00730074; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[311] <= 32'h00740075; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[312] <= 32'h00750076; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[313] <= 32'h00760077; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[314] <= 32'h00770078; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[315] <= 32'h00780079; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[316] <= 32'h0079007a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[317] <= 32'h007a007b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[318] <= 32'h007b007c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[319] <= 32'h007c007d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[320] <= 32'h007d007e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[321] <= 32'h007e007f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[322] <= 32'h007f0080; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[323] <= 32'h00800081; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[324] <= 32'h00810082; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[325] <= 32'h00820083; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[326] <= 32'h00830084; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[327] <= 32'h00840085; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[328] <= 32'h00850086; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[329] <= 32'h00860087; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[330] <= 32'h00870088; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[331] <= 32'h00880089; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[332] <= 32'h0089008a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[333] <= 32'h008a008b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[334] <= 32'h008b008c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[335] <= 32'h008c008d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[336] <= 32'h008d008e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[337] <= 32'h008e008f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[338] <= 32'h008f0090; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[339] <= 32'h00900091; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[340] <= 32'h00910092; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[341] <= 32'h00920093; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[342] <= 32'h00930094; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[343] <= 32'h00940095; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[344] <= 32'h00950096; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[345] <= 32'h00960097; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[346] <= 32'h00970098; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[347] <= 32'h00980099; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[348] <= 32'h0099009a; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[349] <= 32'h009a009b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[350] <= 32'h009b009c; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[351] <= 32'h009c009d; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[352] <= 32'h009d009e; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[353] <= 32'h009e009f; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[354] <= 32'h009f00a0; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[355] <= 32'h00a000a1; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[356] <= 32'h00a100a2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[357] <= 32'h00a200a3; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[358] <= 32'h00a300a4; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[359] <= 32'h00a500a5; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[360] <= 32'h00a600a6; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[361] <= 32'h00a700a7; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[362] <= 32'h00a800a8; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[363] <= 32'h00a900a9; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[364] <= 32'h00aa00aa; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[365] <= 32'h00ab00ab; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[366] <= 32'h00ac00ac; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[367] <= 32'h00ad00ad; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[368] <= 32'h00ae00ae; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[369] <= 32'h00af00af; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[370] <= 32'h00b000b0; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[371] <= 32'h00b100b1; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[372] <= 32'h00b200b2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[373] <= 32'h00b300b3; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[374] <= 32'h00b300b4; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[375] <= 32'h00b400b5; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[376] <= 32'h00b500b6; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[377] <= 32'h00b600b7; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[378] <= 32'h00b700b8; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[379] <= 32'h00b800b9; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[380] <= 32'h00b900ba; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[381] <= 32'h00ba00bb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[382] <= 32'h00bb00bc; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[383] <= 32'h00bc00bd; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[384] <= 32'h00bd00be; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[385] <= 32'h00be00bf; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[386] <= 32'h00bf00c0; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[387] <= 32'h00c000c1; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[388] <= 32'h00c200c2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[389] <= 32'h00c300c3; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[390] <= 32'h00c300c4; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[391] <= 32'h00c400c5; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[392] <= 32'h00c500c6; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[393] <= 32'h00c600c7; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[394] <= 32'h00c800c8; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[395] <= 32'h00c900c9; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[396] <= 32'h00c900ca; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[397] <= 32'h00ca00cb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[398] <= 32'h00cc00cc; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[399] <= 32'h00cd00cd; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[400] <= 32'h00ce00ce; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[401] <= 32'h00cf00cf; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[402] <= 32'h00d000d0; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[403] <= 32'h00d100d1; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[404] <= 32'h00d100d2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[405] <= 32'h00d200d3; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[406] <= 32'h00d300d4; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[407] <= 32'h00d400d5; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[408] <= 32'h00d500d6; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[409] <= 32'h00d600d7; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[410] <= 32'h00d800d8; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[411] <= 32'h00d900d9; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[412] <= 32'h00d900da; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[413] <= 32'h00da00db; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[414] <= 32'h00db00dc; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[415] <= 32'h00dd00dd; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[416] <= 32'h00dd00de; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[417] <= 32'h00de00df; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[418] <= 32'h00df00e0; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[419] <= 32'h00e100e1; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[420] <= 32'h00e100e2; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[421] <= 32'h00e200e3; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[422] <= 32'h00e400e4; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[423] <= 32'h00e500e5; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1080[424] <= 32'h00e600e6; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // disable_intr+0x3b/0x60 [rtw89pci] // ops_mac_post_init_ax+0x90/0x150 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci]

            // 0x0038
            rom_0038[0] <= 32'h31600000;
            rom_0038[1] <= 32'h31600000;
            rom_0038[2] <= 32'h31600000;

            // 0x0030
            rom_0030[0] <= 32'h00000000;
            rom_0030[1] <= 32'h200000ff;
            rom_0030[2] <= 32'h00010000;
            rom_0030[3] <= 32'h200100ff;
            rom_0030[4] <= 32'h00020000;
            rom_0030[5] <= 32'h200200ff;
            rom_0030[6] <= 32'h00030000;
            rom_0030[7] <= 32'h200300ff;
            rom_0030[8] <= 32'h00040000;
            rom_0030[9] <= 32'h20040030;
            rom_0030[10] <= 32'h00050000;
            rom_0030[11] <= 32'h200500dd;
            rom_0030[12] <= 32'h00060000;
            rom_0030[13] <= 32'h20060045;
            rom_0030[14] <= 32'h00070000;
            rom_0030[15] <= 32'h200700b0;
            rom_0030[16] <= 32'h00080000;
            rom_0030[17] <= 32'h20080030;
            rom_0030[18] <= 32'h00090000;
            rom_0030[19] <= 32'h200900eb;
            rom_0030[20] <= 32'h000a0000;
            rom_0030[21] <= 32'h200a00fd;
            rom_0030[22] <= 32'h000b0000;
            rom_0030[23] <= 32'h200b0004;
            rom_0030[24] <= 32'h000c0000;
            rom_0030[25] <= 32'h200c0030;
            rom_0030[26] <= 32'h000d0000;
            rom_0030[27] <= 32'h200d00fd;
            rom_0030[28] <= 32'h000e0000;
            rom_0030[29] <= 32'h200e0027;
            rom_0030[30] <= 32'h000f0000;
            rom_0030[31] <= 32'h200f0000;
            rom_0030[32] <= 32'h00100000;
            rom_0030[33] <= 32'h20100031;
            rom_0030[34] <= 32'h00110000;
            rom_0030[35] <= 32'h201100fe;
            rom_0030[36] <= 32'h00120000;
            rom_0030[37] <= 32'h20120029;
            rom_0030[38] <= 32'h00130000;
            rom_0030[39] <= 32'h20130081;
            rom_0030[40] <= 32'h00140000;
            rom_0030[41] <= 32'h20140032;
            rom_0030[42] <= 32'h00150000;
            rom_0030[43] <= 32'h2015004e;
            rom_0030[44] <= 32'h00160000;
            rom_0030[45] <= 32'h201600db;
            rom_0030[46] <= 32'h00170000;
            rom_0030[47] <= 32'h20170098;
            rom_0030[48] <= 32'h00180000;
            rom_0030[49] <= 32'h20180033;
            rom_0030[50] <= 32'h00190000;
            rom_0030[51] <= 32'h2019000c;
            rom_0030[52] <= 32'h001a0000;
            rom_0030[53] <= 32'h201a00ff;
            rom_0030[54] <= 32'h001b0000;
            rom_0030[55] <= 32'h201b0003;
            rom_0030[56] <= 32'h001c0000;
            rom_0030[57] <= 32'h201c0081;
            rom_0030[58] <= 32'h001d0000;
            rom_0030[59] <= 32'h201d0000;
            rom_0030[60] <= 32'h001e0000;
            rom_0030[61] <= 32'h201e0033;
            rom_0030[62] <= 32'h001f0000;
            rom_0030[63] <= 32'h201f005b;
            rom_0030[64] <= 32'h00200000;
            rom_0030[65] <= 32'h202000ff;
            rom_0030[66] <= 32'h00210000;
            rom_0030[67] <= 32'h202100ff;
            rom_0030[68] <= 32'h00220000;
            rom_0030[69] <= 32'h20220033;
            rom_0030[70] <= 32'h00230000;
            rom_0030[71] <= 32'h202300ce;
            rom_0030[72] <= 32'h00240000;
            rom_0030[73] <= 32'h20240000;
            rom_0030[74] <= 32'h00250000;
            rom_0030[75] <= 32'h2025000a;
            rom_0030[76] <= 32'h00260000;
            rom_0030[77] <= 32'h20260038;
            rom_0030[78] <= 32'h00270000;
            rom_0030[79] <= 32'h20270026;
            rom_0030[80] <= 32'h00280000;
            rom_0030[81] <= 32'h20280081;
            rom_0030[82] <= 32'h00290000;
            rom_0030[83] <= 32'h2029008d;
            rom_0030[84] <= 32'h002a0000;
            rom_0030[85] <= 32'h202a0011;
            rom_0030[86] <= 32'h002b0000;
            rom_0030[87] <= 32'h202b006c;
            rom_0030[88] <= 32'h002c0000;
            rom_0030[89] <= 32'h202c0039;
            rom_0030[90] <= 32'h002d0000;
            rom_0030[91] <= 32'h202d0013;
            rom_0030[92] <= 32'h002e0000;
            rom_0030[93] <= 32'h202e000f;
            rom_0030[94] <= 32'h002f0000;
            rom_0030[95] <= 32'h202f0000;
            rom_0030[96] <= 32'h00300000;
            rom_0030[97] <= 32'h20300020;
            rom_0030[98] <= 32'h00310000;
            rom_0030[99] <= 32'h2031002e;
            rom_0030[100] <= 32'h00320000;
            rom_0030[101] <= 32'h20320039;
            rom_0030[102] <= 32'h00330000;
            rom_0030[103] <= 32'h2033002b;
            rom_0030[104] <= 32'h00340000;
            rom_0030[105] <= 32'h2034004b;
            rom_0030[106] <= 32'h00350000;
            rom_0030[107] <= 32'h20350006;
            rom_0030[108] <= 32'h00360000;
            rom_0030[109] <= 32'h20360039;
            rom_0030[110] <= 32'h00370000;
            rom_0030[111] <= 32'h20370067;
            rom_0030[112] <= 32'h00380000;
            rom_0030[113] <= 32'h203800a1;
            rom_0030[114] <= 32'h00390000;
            rom_0030[115] <= 32'h2039000a;
            rom_0030[116] <= 32'h003a0000;
            rom_0030[117] <= 32'h203a0039;
            rom_0030[118] <= 32'h003b0000;
            rom_0030[119] <= 32'h203b0077;
            rom_0030[120] <= 32'h003c0000;
            rom_0030[121] <= 32'h203c00cc;
            rom_0030[122] <= 32'h003d0000;
            rom_0030[123] <= 32'h203d00c4;
            rom_0030[124] <= 32'h003e0000;
            rom_0030[125] <= 32'h203e0039;
            rom_0030[126] <= 32'h003f0000;
            rom_0030[127] <= 32'h203f0086;
            rom_0030[128] <= 32'h00400000;
            rom_0030[129] <= 32'h204000cc;
            rom_0030[130] <= 32'h00410000;
            rom_0030[131] <= 32'h20410099;
            rom_0030[132] <= 32'h00420000;
            rom_0030[133] <= 32'h20420008;
            rom_0030[134] <= 32'h00430000;
            rom_0030[135] <= 32'h2043004b;
            rom_0030[136] <= 32'h00440000;
            rom_0030[137] <= 32'h20440039;
            rom_0030[138] <= 32'h00450000;
            rom_0030[139] <= 32'h20450097;
            rom_0030[140] <= 32'h00460000;
            rom_0030[141] <= 32'h20460002;
            rom_0030[142] <= 32'h00470000;
            rom_0030[143] <= 32'h204700f8;
            rom_0030[144] <= 32'h00480000;
            rom_0030[145] <= 32'h20480039;
            rom_0030[146] <= 32'h00490000;
            rom_0030[147] <= 32'h204900d7;
            rom_0030[148] <= 32'h004a0000;
            rom_0030[149] <= 32'h204a000f;
            rom_0030[150] <= 32'h004b0000;
            rom_0030[151] <= 32'h204b0000;
            rom_0030[152] <= 32'h004c0000;
            rom_0030[153] <= 32'h204c0039;
            rom_0030[154] <= 32'h004d0000;
            rom_0030[155] <= 32'h204d00e6;
            rom_0030[156] <= 32'h004e0000;
            rom_0030[157] <= 32'h204e0020;
            rom_0030[158] <= 32'h004f0000;
            rom_0030[159] <= 32'h204f002e;
            rom_0030[160] <= 32'h00500000;
            rom_0030[161] <= 32'h2050004b;
            rom_0030[162] <= 32'h00510000;
            rom_0030[163] <= 32'h20510006;
            rom_0030[164] <= 32'h00520000;
            rom_0030[165] <= 32'h2052003a;
            rom_0030[166] <= 32'h00530000;
            rom_0030[167] <= 32'h2053003e;
            rom_0030[168] <= 32'h00540000;
            rom_0030[169] <= 32'h205400a1;
            rom_0030[170] <= 32'h00550000;
            rom_0030[171] <= 32'h2055000a;
            rom_0030[172] <= 32'h00560000;
            rom_0030[173] <= 32'h2056003a;
            rom_0030[174] <= 32'h00570000;
            rom_0030[175] <= 32'h2057005e;
            rom_0030[176] <= 32'h00580000;
            rom_0030[177] <= 32'h20580000;
            rom_0030[178] <= 32'h00590000;
            rom_0030[179] <= 32'h2059004b;
            rom_0030[180] <= 32'h005a0000;
            rom_0030[181] <= 32'h205a003a;
            rom_0030[182] <= 32'h005b0000;
            rom_0030[183] <= 32'h205b006e;
            rom_0030[184] <= 32'h005c0000;
            rom_0030[185] <= 32'h205c0002;
            rom_0030[186] <= 32'h005d0000;
            rom_0030[187] <= 32'h205d00f8;
            rom_0030[188] <= 32'h005e0000;
            rom_0030[189] <= 32'h205e003a;
            rom_0030[190] <= 32'h005f0000;
            rom_0030[191] <= 32'h205f00ab;
            rom_0030[192] <= 32'h00600000;
            rom_0030[193] <= 32'h2060009b;
            rom_0030[194] <= 32'h00610000;
            rom_0030[195] <= 32'h2061000f;
            rom_0030[196] <= 32'h00620000;
            rom_0030[197] <= 32'h2062003a;
            rom_0030[198] <= 32'h00630000;
            rom_0030[199] <= 32'h206300bc;
            rom_0030[200] <= 32'h00640000;
            rom_0030[201] <= 32'h20640098;
            rom_0030[202] <= 32'h00650000;
            rom_0030[203] <= 32'h20650009;
            rom_0030[204] <= 32'h00660000;
            rom_0030[205] <= 32'h206600d3;
            rom_0030[206] <= 32'h00670000;
            rom_0030[207] <= 32'h20670071;
            rom_0030[208] <= 32'h00680000;
            rom_0030[209] <= 32'h20680039;
            rom_0030[210] <= 32'h00690000;
            rom_0030[211] <= 32'h20690027;
            rom_0030[212] <= 32'h006a0000;
            rom_0030[213] <= 32'h206a000d;
            rom_0030[214] <= 32'h006b0000;
            rom_0030[215] <= 32'h206b00ff;
            rom_0030[216] <= 32'h006c0000;
            rom_0030[217] <= 32'h206c0039;
            rom_0030[218] <= 32'h006d0000;
            rom_0030[219] <= 32'h206d0027;
            rom_0030[220] <= 32'h006e0000;
            rom_0030[221] <= 32'h206e000d;
            rom_0030[222] <= 32'h006f0000;
            rom_0030[223] <= 32'h206f00b9;
            rom_0030[224] <= 32'h00700000;
            rom_0030[225] <= 32'h20700039;
            rom_0030[226] <= 32'h00710000;
            rom_0030[227] <= 32'h207100fe;
            rom_0030[228] <= 32'h00720000;
            rom_0030[229] <= 32'h2072000d;
            rom_0030[230] <= 32'h00730000;
            rom_0030[231] <= 32'h207300ff;
            rom_0030[232] <= 32'h00740000;
            rom_0030[233] <= 32'h20740039;
            rom_0030[234] <= 32'h00750000;
            rom_0030[235] <= 32'h207500fe;
            rom_0030[236] <= 32'h00760000;
            rom_0030[237] <= 32'h2076000d;
            rom_0030[238] <= 32'h00770000;
            rom_0030[239] <= 32'h207700b9;
            rom_0030[240] <= 32'h00780000;
            rom_0030[241] <= 32'h20780030;
            rom_0030[242] <= 32'h00790000;
            rom_0030[243] <= 32'h207900fd;
            rom_0030[244] <= 32'h007a0000;
            rom_0030[245] <= 32'h207a0027;
            rom_0030[246] <= 32'h007b0000;
            rom_0030[247] <= 32'h207b0000;
            rom_0030[248] <= 32'h007c0000;
            rom_0030[249] <= 32'h207c0032;
            rom_0030[250] <= 32'h007d0000;
            rom_0030[251] <= 32'h207d000c;
            rom_0030[252] <= 32'h007e0000;
            rom_0030[253] <= 32'h207e00db;
            rom_0030[254] <= 32'h007f0000;
            rom_0030[255] <= 32'h207f0098;
            rom_0030[256] <= 32'h00800000;
            rom_0030[257] <= 32'h2080006d;
            rom_0030[258] <= 32'h00810000;
            rom_0030[259] <= 32'h208100fd;
            rom_0030[260] <= 32'h00820000;
            rom_0030[261] <= 32'h20820032;
            rom_0030[262] <= 32'h00830000;
            rom_0030[263] <= 32'h2083004c;
            rom_0030[264] <= 32'h00840000;
            rom_0030[265] <= 32'h208400db;
            rom_0030[266] <= 32'h00850000;
            rom_0030[267] <= 32'h20850098;
            rom_0030[268] <= 32'h00860000;
            rom_0030[269] <= 32'h2086006d;
            rom_0030[270] <= 32'h00870000;
            rom_0030[271] <= 32'h208700bb;
            rom_0030[272] <= 32'h00880000;
            rom_0030[273] <= 32'h20880033;
            rom_0030[274] <= 32'h00890000;
            rom_0030[275] <= 32'h2089000c;
            rom_0030[276] <= 32'h008a0000;
            rom_0030[277] <= 32'h208a00ff;
            rom_0030[278] <= 32'h008b0000;
            rom_0030[279] <= 32'h208b00df;
            rom_0030[280] <= 32'h008c0000;
            rom_0030[281] <= 32'h208c006e;
            rom_0030[282] <= 32'h008d0000;
            rom_0030[283] <= 32'h208d0000;
            rom_0030[284] <= 32'h008e0000;
            rom_0030[285] <= 32'h208e0034;
            rom_0030[286] <= 32'h008f0000;
            rom_0030[287] <= 32'h208f0020;
            rom_0030[288] <= 32'h00900000;
            rom_0030[289] <= 32'h209000fa;
            rom_0030[290] <= 32'h00910000;
            rom_0030[291] <= 32'h209100f9;
            rom_0030[292] <= 32'h00920000;
            rom_0030[293] <= 32'h209200f7;
            rom_0030[294] <= 32'h00930000;
            rom_0030[295] <= 32'h209300f6;
            rom_0030[296] <= 32'h00940000;
            rom_0030[297] <= 32'h209400f6;
            rom_0030[298] <= 32'h00950000;
            rom_0030[299] <= 32'h209500f6;
            rom_0030[300] <= 32'h00960000;
            rom_0030[301] <= 32'h209600fb;
            rom_0030[302] <= 32'h00970000;
            rom_0030[303] <= 32'h209700fb;
            rom_0030[304] <= 32'h00980000;
            rom_0030[305] <= 32'h20980034;
            rom_0030[306] <= 32'h00990000;
            rom_0030[307] <= 32'h2099003c;
            rom_0030[308] <= 32'h009a0000;
            rom_0030[309] <= 32'h209a00f6;
            rom_0030[310] <= 32'h009b0000;
            rom_0030[311] <= 32'h209b00f8;
            rom_0030[312] <= 32'h009c0000;
            rom_0030[313] <= 32'h209c00f8;
            rom_0030[314] <= 32'h009d0000;
            rom_0030[315] <= 32'h209d00ff;
            rom_0030[316] <= 32'h009e0000;
            rom_0030[317] <= 32'h209e0034;
            rom_0030[318] <= 32'h009f0000;
            rom_0030[319] <= 32'h209f0041;
            rom_0030[320] <= 32'h00a00000;
            rom_0030[321] <= 32'h20a00008;
            rom_0030[322] <= 32'h00a10000;
            rom_0030[323] <= 32'h20a1000c;
            rom_0030[324] <= 32'h00a20000;
            rom_0030[325] <= 32'h20a20008;
            rom_0030[326] <= 32'h00a30000;
            rom_0030[327] <= 32'h20a3000c;
            rom_0030[328] <= 32'h00a40000;
            rom_0030[329] <= 32'h20a40009;
            rom_0030[330] <= 32'h00a50000;
            rom_0030[331] <= 32'h20a5000a;
            rom_0030[332] <= 32'h00a60000;
            rom_0030[333] <= 32'h20a60034;
            rom_0030[334] <= 32'h00a70000;
            rom_0030[335] <= 32'h20a70050;
            rom_0030[336] <= 32'h00a80000;
            rom_0030[337] <= 32'h20a8000b;
            rom_0030[338] <= 32'h00a90000;
            rom_0030[339] <= 32'h20a9000c;
            rom_0030[340] <= 32'h00aa0000;
            rom_0030[341] <= 32'h20aa000d;
            rom_0030[342] <= 32'h00ab0000;
            rom_0030[343] <= 32'h20ab000e;
            rom_0030[344] <= 32'h00ac0000;
            rom_0030[345] <= 32'h20ac0010;
            rom_0030[346] <= 32'h00ad0000;
            rom_0030[347] <= 32'h20ad0010;
            rom_0030[348] <= 32'h00ae0000;
            rom_0030[349] <= 32'h20ae0010;
            rom_0030[350] <= 32'h00af0000;
            rom_0030[351] <= 32'h20af0010;
            rom_0030[352] <= 32'h00b00000;
            rom_0030[353] <= 32'h20b00034;
            rom_0030[354] <= 32'h00b10000;
            rom_0030[355] <= 32'h20b10071;
            rom_0030[356] <= 32'h00b20000;
            rom_0030[357] <= 32'h20b20000;
            rom_0030[358] <= 32'h00b30000;
            rom_0030[359] <= 32'h20b300ff;
            rom_0030[360] <= 32'h00b40000;
            rom_0030[361] <= 32'h20b400ff;
            rom_0030[362] <= 32'h00b50000;
            rom_0030[363] <= 32'h20b500fe;
            rom_0030[364] <= 32'h00b60000;
            rom_0030[365] <= 32'h20b600fe;
            rom_0030[366] <= 32'h00b70000;
            rom_0030[367] <= 32'h20b700fe;
            rom_0030[368] <= 32'h00b80000;
            rom_0030[369] <= 32'h20b80034;
            rom_0030[370] <= 32'h00b90000;
            rom_0030[371] <= 32'h20b90088;
            rom_0030[372] <= 32'h00ba0000;
            rom_0030[373] <= 32'h20ba0002;
            rom_0030[374] <= 32'h00bb0000;
            rom_0030[375] <= 32'h20bb0002;
            rom_0030[376] <= 32'h00bc0000;
            rom_0030[377] <= 32'h20bc00fd;
            rom_0030[378] <= 32'h00bd0000;
            rom_0030[379] <= 32'h20bd00ff;
            rom_0030[380] <= 32'h00be0000;
            rom_0030[381] <= 32'h20be00ff;
            rom_0030[382] <= 32'h00bf0000;
            rom_0030[383] <= 32'h20bf00ff;
            rom_0030[384] <= 32'h00c00000;
            rom_0030[385] <= 32'h20c00034;
            rom_0030[386] <= 32'h00c10000;
            rom_0030[387] <= 32'h20c10093;
            rom_0030[388] <= 32'h00c20000;
            rom_0030[389] <= 32'h20c20009;
            rom_0030[390] <= 32'h00c30000;
            rom_0030[391] <= 32'h20c3000c;
            rom_0030[392] <= 32'h00c40000;
            rom_0030[393] <= 32'h20c40005;
            rom_0030[394] <= 32'h00c50000;
            rom_0030[395] <= 32'h20c50008;
            rom_0030[396] <= 32'h00c60000;
            rom_0030[397] <= 32'h20c60034;
            rom_0030[398] <= 32'h00c70000;
            rom_0030[399] <= 32'h20c700a0;
            rom_0030[400] <= 32'h00c80000;
            rom_0030[401] <= 32'h20c8000d;
            rom_0030[402] <= 32'h00c90000;
            rom_0030[403] <= 32'h20c9000d;
            rom_0030[404] <= 32'h00ca0000;
            rom_0030[405] <= 32'h20ca000d;
            rom_0030[406] <= 32'h00cb0000;
            rom_0030[407] <= 32'h20cb000d;
            rom_0030[408] <= 32'h00cc0000;
            rom_0030[409] <= 32'h20cc000d;
            rom_0030[410] <= 32'h00cd0000;
            rom_0030[411] <= 32'h20cd000d;
            rom_0030[412] <= 32'h00ce0000;
            rom_0030[413] <= 32'h20ce000b;
            rom_0030[414] <= 32'h00cf0000;
            rom_0030[415] <= 32'h20cf000b;
            rom_0030[416] <= 32'h00d00000;
            rom_0030[417] <= 32'h20d00034;
            rom_0030[418] <= 32'h00d10000;
            rom_0030[419] <= 32'h20d100be;
            rom_0030[420] <= 32'h00d20000;
            rom_0030[421] <= 32'h20d2000c;
            rom_0030[422] <= 32'h00d30000;
            rom_0030[423] <= 32'h20d3000c;
            rom_0030[424] <= 32'h00d40000;
            rom_0030[425] <= 32'h20d40035;
            rom_0030[426] <= 32'h00d50000;
            rom_0030[427] <= 32'h20d5006d;
            rom_0030[428] <= 32'h00d60000;
            rom_0030[429] <= 32'h20d600ff;
            rom_0030[430] <= 32'h00d70000;
            rom_0030[431] <= 32'h20d700ff;
            rom_0030[432] <= 32'h00d80000;
            rom_0030[433] <= 32'h20d80035;
            rom_0030[434] <= 32'h00d90000;
            rom_0030[435] <= 32'h20d9007c;
            rom_0030[436] <= 32'h00da0000;
            rom_0030[437] <= 32'h20da007f;
            rom_0030[438] <= 32'h00db0000;
            rom_0030[439] <= 32'h20db0037;
            rom_0030[440] <= 32'h00dc0000;
            rom_0030[441] <= 32'h20dc00ff;
            rom_0030[442] <= 32'h00dd0000;
            rom_0030[443] <= 32'h20dd0000;
            rom_0030[444] <= 32'h00de0000;
            rom_0030[445] <= 32'h20de0035;
            rom_0030[446] <= 32'h00df0000;
            rom_0030[447] <= 32'h20df0080;
            rom_0030[448] <= 32'h00e00000;
            rom_0030[449] <= 32'h20e000ff;
            rom_0030[450] <= 32'h00e10000;
            rom_0030[451] <= 32'h20e10021;
            rom_0030[452] <= 32'h00e20000;
            rom_0030[453] <= 32'h20e20000;
            rom_0030[454] <= 32'h00e30000;
            rom_0030[455] <= 32'h20e30011;
            rom_0030[456] <= 32'h00e40000;
            rom_0030[457] <= 32'h20e40000;
            rom_0030[458] <= 32'h00e50000;
            rom_0030[459] <= 32'h20e50000;
            rom_0030[460] <= 32'h00e60000;
            rom_0030[461] <= 32'h20e60000;
            rom_0030[462] <= 32'h00e70000;
            rom_0030[463] <= 32'h20e70000;
            rom_0030[464] <= 32'h00e80000;
            rom_0030[465] <= 32'h20e80035;
            rom_0030[466] <= 32'h00e90000;
            rom_0030[467] <= 32'h20e90098;
            rom_0030[468] <= 32'h00ea0000;
            rom_0030[469] <= 32'h20ea0040;
            rom_0030[470] <= 32'h00eb0000;
            rom_0030[471] <= 32'h20eb0033;
            rom_0030[472] <= 32'h00ec0000;
            rom_0030[473] <= 32'h20ec0001;
            rom_0030[474] <= 32'h00ed0000;
            rom_0030[475] <= 32'h20ed00ff;
            rom_0030[476] <= 32'h00ee0000;
            rom_0030[477] <= 32'h20ee00ff;
            rom_0030[478] <= 32'h00ef0000;
            rom_0030[479] <= 32'h20ef00ff;
            rom_0030[480] <= 32'h00f00000;
            rom_0030[481] <= 32'h20f00035;
            rom_0030[482] <= 32'h00f10000;
            rom_0030[483] <= 32'h20f100a2;
            rom_0030[484] <= 32'h00f20000;
            rom_0030[485] <= 32'h20f2001c;
            rom_0030[486] <= 32'h00f30000;
            rom_0030[487] <= 32'h20f3001d;
            rom_0030[488] <= 32'h00f40000;
            rom_0030[489] <= 32'h20f40000;
            rom_0030[490] <= 32'h00f50000;
            rom_0030[491] <= 32'h20f500ff;
            rom_0030[492] <= 32'h00f60000;
            rom_0030[493] <= 32'h20f60000;
            rom_0030[494] <= 32'h00f70000;
            rom_0030[495] <= 32'h20f700ff;
            rom_0030[496] <= 32'h00f80000;
            rom_0030[497] <= 32'h20f80035;
            rom_0030[498] <= 32'h00f90000;
            rom_0030[499] <= 32'h20f900b8;
            rom_0030[500] <= 32'h00fa0000;
            rom_0030[501] <= 32'h20fa0000;
            rom_0030[502] <= 32'h00fb0000;
            rom_0030[503] <= 32'h20fb00ff;
            rom_0030[504] <= 32'h00fc0000;
            rom_0030[505] <= 32'h20fc0001;
            rom_0030[506] <= 32'h00fd0000;
            rom_0030[507] <= 32'h20fd00ff;
            rom_0030[508] <= 32'h00fe0000;
            rom_0030[509] <= 32'h20fe0001;
            rom_0030[510] <= 32'h00ff0000;
            rom_0030[511] <= 32'h20ff00ff;
            rom_0030[512] <= 32'h01000000;
            rom_0030[513] <= 32'h21000038;
            rom_0030[514] <= 32'h01010000;
            rom_0030[515] <= 32'h21010000;
            rom_0030[516] <= 32'h01020000;
            rom_0030[517] <= 32'h21020014;
            rom_0030[518] <= 32'h2103005a;
            rom_0030[519] <= 32'h01040000;
            rom_0030[520] <= 32'h210400fc;
            rom_0030[521] <= 32'h01050000;
            rom_0030[522] <= 32'h2105006b;
            rom_0030[523] <= 32'h01060000;
            rom_0030[524] <= 32'h21060079;
            rom_0030[525] <= 32'h01070000;
            rom_0030[526] <= 32'h21070015;
            rom_0030[527] <= 32'h01080000;
            rom_0030[528] <= 32'h210800ec;
            rom_0030[529] <= 32'h01090000;
            rom_0030[530] <= 32'h21090010;
            rom_0030[531] <= 32'h010a0000;
            rom_0030[532] <= 32'h210a0038;
            rom_0030[533] <= 32'h010b0000;
            rom_0030[534] <= 32'h210b0018;
            rom_0030[535] <= 32'h010c0000;
            rom_0030[536] <= 32'h210c0052;
            rom_0030[537] <= 32'h010d0000;
            rom_0030[538] <= 32'h210d0088;
            rom_0030[539] <= 32'h010e0000;
            rom_0030[540] <= 32'h210e003e;
            rom_0030[541] <= 32'h010f0000;
            rom_0030[542] <= 32'h210f001d;
            rom_0030[543] <= 32'h01100000;
            rom_0030[544] <= 32'h21100025;
            rom_0030[545] <= 32'h01110000;
            rom_0030[546] <= 32'h211100c8;
            rom_0030[547] <= 32'h01120000;
            rom_0030[548] <= 32'h21120038;
            rom_0030[549] <= 32'h01130000;
            rom_0030[550] <= 32'h21130051;
            rom_0030[551] <= 32'h01140000;
            rom_0030[552] <= 32'h2114001f;
            rom_0030[553] <= 32'h01150000;
            rom_0030[554] <= 32'h2115001e;
            rom_0030[555] <= 32'h01160000;
            rom_0030[556] <= 32'h211600f0;
            rom_0030[557] <= 32'h01170000;
            rom_0030[558] <= 32'h21170000;
            rom_0030[559] <= 32'h01180000;
            rom_0030[560] <= 32'h21180000;
            rom_0030[561] <= 32'h01190000;
            rom_0030[562] <= 32'h21190028;
            rom_0030[563] <= 32'h011a0000;
            rom_0030[564] <= 32'h211a0038;
            rom_0030[565] <= 32'h011b0000;
            rom_0030[566] <= 32'h211b0060;
            rom_0030[567] <= 32'h011c0000;
            rom_0030[568] <= 32'h211c00b8;
            rom_0030[569] <= 32'h011d0000;
            rom_0030[570] <= 32'h211d000c;
            rom_0030[571] <= 32'h011e0000;
            rom_0030[572] <= 32'h211e0049;
            rom_0030[573] <= 32'h011f0000;
            rom_0030[574] <= 32'h211f00c5;
            rom_0030[575] <= 32'h01200000;
            rom_0030[576] <= 32'h212000eb;
            rom_0030[577] <= 32'h01210000;
            rom_0030[578] <= 32'h2121006f;
            rom_0030[579] <= 32'h01220000;
            rom_0030[580] <= 32'h21220007;
            rom_0030[581] <= 32'h01230000;
            rom_0030[582] <= 32'h212300ff;
            rom_0030[583] <= 32'h01240000;
            rom_0030[584] <= 32'h21240038;
            rom_0030[585] <= 32'h01250000;
            rom_0030[586] <= 32'h21250078;
            rom_0030[587] <= 32'h01260000;
            rom_0030[588] <= 32'h21260000;
            rom_0030[589] <= 32'h01270000;
            rom_0030[590] <= 32'h212700e0;
            rom_0030[591] <= 32'h01280000;
            rom_0030[592] <= 32'h2128004c;
            rom_0030[593] <= 32'h01290000;
            rom_0030[594] <= 32'h21290088;
            rom_0030[595] <= 32'h012a0000;
            rom_0030[596] <= 32'h212a0052;
            rom_0030[597] <= 32'h212b0001;
            rom_0030[598] <= 32'h012c0000;
            rom_0030[599] <= 32'h212c0038;
            rom_0030[600] <= 32'h012d0000;
            rom_0030[601] <= 32'h212d00e2;
            rom_0030[602] <= 32'h012e0000;
            rom_0030[603] <= 32'h212e00c1;
            rom_0030[604] <= 32'h012f0000;
            rom_0030[605] <= 32'h212f00fe;
            rom_0030[606] <= 32'h01300000;
            rom_0030[607] <= 32'h21300000;
            rom_0030[608] <= 32'h01310000;
            rom_0030[609] <= 32'h213100ff;
            rom_0030[610] <= 32'h01320000;
            rom_0030[611] <= 32'h21320000;
            rom_0030[612] <= 32'h01330000;
            rom_0030[613] <= 32'h213300cf;
            rom_0030[614] <= 32'h01340000;
            rom_0030[615] <= 32'h213400ff;
            rom_0030[616] <= 32'h01350000;
            rom_0030[617] <= 32'h213500ff;
            rom_0030[618] <= 32'h01360000;
            rom_0030[619] <= 32'h213600ff;
            rom_0030[620] <= 32'h01370000;
            rom_0030[621] <= 32'h213700ff;
            rom_0030[622] <= 32'h01380000;
            rom_0030[623] <= 32'h213800ff;
            rom_0030[624] <= 32'h01390000;
            rom_0030[625] <= 32'h213900ff;
            rom_0030[626] <= 32'h013a0000;
            rom_0030[627] <= 32'h213a00ff;
            rom_0030[628] <= 32'h013b0000;
            rom_0030[629] <= 32'h213b00ff;
            rom_0030[630] <= 32'h013c0000;
            rom_0030[631] <= 32'h213c00ff;
            rom_0030[632] <= 32'h013d0000;
            rom_0030[633] <= 32'h213d00ff;
            rom_0030[634] <= 32'h013e0000;
            rom_0030[635] <= 32'h213e00ff;
            rom_0030[636] <= 32'h013f0000;
            rom_0030[637] <= 32'h213f00ff;
            rom_0030[638] <= 32'h01400000;
            rom_0030[639] <= 32'h214000ff;
            rom_0030[640] <= 32'h01410000;
            rom_0030[641] <= 32'h214100ff;
            rom_0030[642] <= 32'h01420000;
            rom_0030[643] <= 32'h214200ff;
            rom_0030[644] <= 32'h01430000;
            rom_0030[645] <= 32'h214300ff;
            rom_0030[646] <= 32'h01440000;
            rom_0030[647] <= 32'h214400ff;
            rom_0030[648] <= 32'h01450000;
            rom_0030[649] <= 32'h214500ff;
            rom_0030[650] <= 32'h01460000;
            rom_0030[651] <= 32'h214600ff;
            rom_0030[652] <= 32'h01470000;
            rom_0030[653] <= 32'h214700ff;
            rom_0030[654] <= 32'h01480000;
            rom_0030[655] <= 32'h214800ff;
            rom_0030[656] <= 32'h01490000;
            rom_0030[657] <= 32'h214900ff;
            rom_0030[658] <= 32'h014a0000;
            rom_0030[659] <= 32'h214a00ff;
            rom_0030[660] <= 32'h014b0000;
            rom_0030[661] <= 32'h214b00ff;
            rom_0030[662] <= 32'h014c0000;
            rom_0030[663] <= 32'h214c00ff;
            rom_0030[664] <= 32'h014d0000;
            rom_0030[665] <= 32'h214d00ff;
            rom_0030[666] <= 32'h014e0000;
            rom_0030[667] <= 32'h214e00ff;
            rom_0030[668] <= 32'h014f0000;
            rom_0030[669] <= 32'h214f00ff;
            rom_0030[670] <= 32'h01500000;
            rom_0030[671] <= 32'h215000ff;
            rom_0030[672] <= 32'h01510000;
            rom_0030[673] <= 32'h215100ff;
            rom_0030[674] <= 32'h01520000;
            rom_0030[675] <= 32'h215200ff;
            rom_0030[676] <= 32'h01530000;
            rom_0030[677] <= 32'h215300ff;
            rom_0030[678] <= 32'h01540000;
            rom_0030[679] <= 32'h215400ff;
            rom_0030[680] <= 32'h01550000;
            rom_0030[681] <= 32'h215500ff;
            rom_0030[682] <= 32'h01560000;
            rom_0030[683] <= 32'h215600ff;
            rom_0030[684] <= 32'h01570000;
            rom_0030[685] <= 32'h215700ff;
            rom_0030[686] <= 32'h01580000;
            rom_0030[687] <= 32'h215800ff;
            rom_0030[688] <= 32'h01590000;
            rom_0030[689] <= 32'h215900ff;
            rom_0030[690] <= 32'h015a0000;
            rom_0030[691] <= 32'h215a00ff;
            rom_0030[692] <= 32'h015b0000;
            rom_0030[693] <= 32'h215b00ff;
            rom_0030[694] <= 32'h015c0000;
            rom_0030[695] <= 32'h215c00ff;
            rom_0030[696] <= 32'h015d0000;
            rom_0030[697] <= 32'h215d00ff;
            rom_0030[698] <= 32'h015e0000;
            rom_0030[699] <= 32'h215e00ff;
            rom_0030[700] <= 32'h015f0000;
            rom_0030[701] <= 32'h215f00ff;
            rom_0030[702] <= 32'h01600000;
            rom_0030[703] <= 32'h216000ff;
            rom_0030[704] <= 32'h01610000;
            rom_0030[705] <= 32'h216100ff;
            rom_0030[706] <= 32'h01620000;
            rom_0030[707] <= 32'h216200ff;
            rom_0030[708] <= 32'h01630000;
            rom_0030[709] <= 32'h216300ff;
            rom_0030[710] <= 32'h01640000;
            rom_0030[711] <= 32'h216400ff;
            rom_0030[712] <= 32'h01650000;
            rom_0030[713] <= 32'h216500ff;
            rom_0030[714] <= 32'h01660000;
            rom_0030[715] <= 32'h216600ff;
            rom_0030[716] <= 32'h01670000;
            rom_0030[717] <= 32'h216700ff;
            rom_0030[718] <= 32'h01680000;
            rom_0030[719] <= 32'h216800ff;
            rom_0030[720] <= 32'h01690000;
            rom_0030[721] <= 32'h216900ff;
            rom_0030[722] <= 32'h016a0000;
            rom_0030[723] <= 32'h216a00ff;
            rom_0030[724] <= 32'h016b0000;
            rom_0030[725] <= 32'h216b00ff;
            rom_0030[726] <= 32'h016c0000;
            rom_0030[727] <= 32'h216c00ff;
            rom_0030[728] <= 32'h016d0000;
            rom_0030[729] <= 32'h216d00ff;
            rom_0030[730] <= 32'h016e0000;
            rom_0030[731] <= 32'h216e00ff;
            rom_0030[732] <= 32'h016f0000;
            rom_0030[733] <= 32'h216f00ff;
            rom_0030[734] <= 32'h01700000;
            rom_0030[735] <= 32'h217000ff;
            rom_0030[736] <= 32'h01710000;
            rom_0030[737] <= 32'h217100ff;
            rom_0030[738] <= 32'h01720000;
            rom_0030[739] <= 32'h217200ff;
            rom_0030[740] <= 32'h01730000;
            rom_0030[741] <= 32'h217300ff;
            rom_0030[742] <= 32'h01740000;
            rom_0030[743] <= 32'h217400ff;
            rom_0030[744] <= 32'h01750000;
            rom_0030[745] <= 32'h217500ff;
            rom_0030[746] <= 32'h01760000;
            rom_0030[747] <= 32'h217600ff;
            rom_0030[748] <= 32'h01770000;
            rom_0030[749] <= 32'h217700ff;
            rom_0030[750] <= 32'h01780000;
            rom_0030[751] <= 32'h217800ff;
            rom_0030[752] <= 32'h01790000;
            rom_0030[753] <= 32'h217900ff;
            rom_0030[754] <= 32'h017a0000;
            rom_0030[755] <= 32'h217a00ff;
            rom_0030[756] <= 32'h017b0000;
            rom_0030[757] <= 32'h217b00ff;
            rom_0030[758] <= 32'h017c0000;
            rom_0030[759] <= 32'h217c00ff;
            rom_0030[760] <= 32'h017d0000;
            rom_0030[761] <= 32'h217d00ff;
            rom_0030[762] <= 32'h017e0000;
            rom_0030[763] <= 32'h217e00ff;
            rom_0030[764] <= 32'h017f0000;
            rom_0030[765] <= 32'h217f00ff;
            rom_0030[766] <= 32'h01800000;
            rom_0030[767] <= 32'h218000ff;
            rom_0030[768] <= 32'h01810000;
            rom_0030[769] <= 32'h218100ff;
            rom_0030[770] <= 32'h01820000;
            rom_0030[771] <= 32'h218200ff;
            rom_0030[772] <= 32'h01830000;
            rom_0030[773] <= 32'h218300ff;
            rom_0030[774] <= 32'h01840000;
            rom_0030[775] <= 32'h218400ff;
            rom_0030[776] <= 32'h01850000;
            rom_0030[777] <= 32'h218500ff;
            rom_0030[778] <= 32'h01860000;
            rom_0030[779] <= 32'h218600ff;
            rom_0030[780] <= 32'h01870000;
            rom_0030[781] <= 32'h218700ff;
            rom_0030[782] <= 32'h01880000;
            rom_0030[783] <= 32'h218800ff;
            rom_0030[784] <= 32'h01890000;
            rom_0030[785] <= 32'h218900ff;
            rom_0030[786] <= 32'h018a0000;
            rom_0030[787] <= 32'h218a00ff;
            rom_0030[788] <= 32'h018b0000;
            rom_0030[789] <= 32'h218b00ff;
            rom_0030[790] <= 32'h018c0000;
            rom_0030[791] <= 32'h218c00ff;
            rom_0030[792] <= 32'h018d0000;
            rom_0030[793] <= 32'h218d00ff;
            rom_0030[794] <= 32'h018e0000;
            rom_0030[795] <= 32'h218e00ff;
            rom_0030[796] <= 32'h018f0000;
            rom_0030[797] <= 32'h218f00ff;
            rom_0030[798] <= 32'h01900000;
            rom_0030[799] <= 32'h219000ff;
            rom_0030[800] <= 32'h01910000;
            rom_0030[801] <= 32'h219100ff;
            rom_0030[802] <= 32'h01920000;
            rom_0030[803] <= 32'h219200ff;
            rom_0030[804] <= 32'h01930000;
            rom_0030[805] <= 32'h219300ff;
            rom_0030[806] <= 32'h01940000;
            rom_0030[807] <= 32'h219400ff;
            rom_0030[808] <= 32'h01950000;
            rom_0030[809] <= 32'h219500ff;
            rom_0030[810] <= 32'h01960000;
            rom_0030[811] <= 32'h219600ff;
            rom_0030[812] <= 32'h01970000;
            rom_0030[813] <= 32'h219700ff;
            rom_0030[814] <= 32'h01980000;
            rom_0030[815] <= 32'h219800ff;
            rom_0030[816] <= 32'h01990000;
            rom_0030[817] <= 32'h219900ff;
            rom_0030[818] <= 32'h019a0000;
            rom_0030[819] <= 32'h219a00ff;
            rom_0030[820] <= 32'h019b0000;
            rom_0030[821] <= 32'h219b00ff;
            rom_0030[822] <= 32'h019c0000;
            rom_0030[823] <= 32'h219c00ff;
            rom_0030[824] <= 32'h019d0000;
            rom_0030[825] <= 32'h219d00ff;
            rom_0030[826] <= 32'h019e0000;
            rom_0030[827] <= 32'h219e00ff;
            rom_0030[828] <= 32'h019f0000;
            rom_0030[829] <= 32'h219f00ff;
            rom_0030[830] <= 32'h01a00000;
            rom_0030[831] <= 32'h21a000ff;
            rom_0030[832] <= 32'h01a10000;
            rom_0030[833] <= 32'h21a100ff;
            rom_0030[834] <= 32'h01a20000;
            rom_0030[835] <= 32'h21a200ff;
            rom_0030[836] <= 32'h01a30000;
            rom_0030[837] <= 32'h21a300ff;
            rom_0030[838] <= 32'h01a40000;
            rom_0030[839] <= 32'h21a400ff;
            rom_0030[840] <= 32'h01a50000;
            rom_0030[841] <= 32'h21a500ff;
            rom_0030[842] <= 32'h01a60000;
            rom_0030[843] <= 32'h21a600ff;
            rom_0030[844] <= 32'h01a70000;
            rom_0030[845] <= 32'h21a700ff;
            rom_0030[846] <= 32'h01a80000;
            rom_0030[847] <= 32'h21a800ff;
            rom_0030[848] <= 32'h01a90000;
            rom_0030[849] <= 32'h21a900ff;
            rom_0030[850] <= 32'h01aa0000;
            rom_0030[851] <= 32'h21aa00ff;
            rom_0030[852] <= 32'h01ab0000;
            rom_0030[853] <= 32'h21ab00ff;
            rom_0030[854] <= 32'h01ac0000;
            rom_0030[855] <= 32'h21ac00ff;
            rom_0030[856] <= 32'h01ad0000;
            rom_0030[857] <= 32'h21ad00ff;
            rom_0030[858] <= 32'h01ae0000;
            rom_0030[859] <= 32'h21ae00ff;
            rom_0030[860] <= 32'h01af0000;
            rom_0030[861] <= 32'h21af00ff;
            rom_0030[862] <= 32'h01b00000;
            rom_0030[863] <= 32'h21b000ff;
            rom_0030[864] <= 32'h01b10000;
            rom_0030[865] <= 32'h21b100ff;
            rom_0030[866] <= 32'h01b20000;
            rom_0030[867] <= 32'h21b200ff;
            rom_0030[868] <= 32'h01b30000;
            rom_0030[869] <= 32'h21b300ff;
            rom_0030[870] <= 32'h01b40000;
            rom_0030[871] <= 32'h21b400ff;
            rom_0030[872] <= 32'h01b50000;
            rom_0030[873] <= 32'h21b500ff;
            rom_0030[874] <= 32'h21b600ff;
            rom_0030[875] <= 32'h01b70000;
            rom_0030[876] <= 32'h21b700ff;
            rom_0030[877] <= 32'h01b80000;
            rom_0030[878] <= 32'h21b800ff;
            rom_0030[879] <= 32'h01b90000;
            rom_0030[880] <= 32'h21b900ff;
            rom_0030[881] <= 32'h01ba0000;
            rom_0030[882] <= 32'h21ba00ff;
            rom_0030[883] <= 32'h01bb0000;
            rom_0030[884] <= 32'h21bb00ff;
            rom_0030[885] <= 32'h01bc0000;
            rom_0030[886] <= 32'h21bc00ff;
            rom_0030[887] <= 32'h01bd0000;
            rom_0030[888] <= 32'h21bd00ff;
            rom_0030[889] <= 32'h01be0000;
            rom_0030[890] <= 32'h21be00ff;
            rom_0030[891] <= 32'h01bf0000;
            rom_0030[892] <= 32'h21bf00ff;
            rom_0030[893] <= 32'h01c00000;
            rom_0030[894] <= 32'h21c000ff;
            rom_0030[895] <= 32'h01c10000;
            rom_0030[896] <= 32'h21c100ff;
            rom_0030[897] <= 32'h01c20000;
            rom_0030[898] <= 32'h21c200ff;
            rom_0030[899] <= 32'h01c30000;
            rom_0030[900] <= 32'h21c300ff;
            rom_0030[901] <= 32'h01c40000;
            rom_0030[902] <= 32'h21c400ff;
            rom_0030[903] <= 32'h01c50000;
            rom_0030[904] <= 32'h21c500ff;
            rom_0030[905] <= 32'h01c60000;
            rom_0030[906] <= 32'h21c600ff;
            rom_0030[907] <= 32'h01c70000;
            rom_0030[908] <= 32'h21c700ff;
            rom_0030[909] <= 32'h01c80000;
            rom_0030[910] <= 32'h21c800ff;
            rom_0030[911] <= 32'h01c90000;
            rom_0030[912] <= 32'h21c900ff;
            rom_0030[913] <= 32'h01ca0000;
            rom_0030[914] <= 32'h21ca00ff;
            rom_0030[915] <= 32'h01cb0000;
            rom_0030[916] <= 32'h21cb00ff;
            rom_0030[917] <= 32'h01cc0000;
            rom_0030[918] <= 32'h21cc00ff;
            rom_0030[919] <= 32'h01cd0000;
            rom_0030[920] <= 32'h21cd00ff;
            rom_0030[921] <= 32'h01ce0000;
            rom_0030[922] <= 32'h21ce00ff;
            rom_0030[923] <= 32'h01cf0000;
            rom_0030[924] <= 32'h21cf00ff;
            rom_0030[925] <= 32'h01d00000;
            rom_0030[926] <= 32'h21d000ff;
            rom_0030[927] <= 32'h01d10000;
            rom_0030[928] <= 32'h21d100ff;
            rom_0030[929] <= 32'h01d20000;
            rom_0030[930] <= 32'h21d200ff;
            rom_0030[931] <= 32'h01d30000;
            rom_0030[932] <= 32'h21d300ff;
            rom_0030[933] <= 32'h01d40000;
            rom_0030[934] <= 32'h21d400ff;
            rom_0030[935] <= 32'h01d50000;
            rom_0030[936] <= 32'h21d500ff;
            rom_0030[937] <= 32'h01d60000;
            rom_0030[938] <= 32'h21d600ff;
            rom_0030[939] <= 32'h01d70000;
            rom_0030[940] <= 32'h21d700ff;
            rom_0030[941] <= 32'h01d80000;
            rom_0030[942] <= 32'h21d800ff;
            rom_0030[943] <= 32'h01d90000;
            rom_0030[944] <= 32'h21d900ff;
            rom_0030[945] <= 32'h01da0000;
            rom_0030[946] <= 32'h21da00ff;
            rom_0030[947] <= 32'h01db0000;
            rom_0030[948] <= 32'h21db00ff;
            rom_0030[949] <= 32'h01dc0000;
            rom_0030[950] <= 32'h21dc00ff;
            rom_0030[951] <= 32'h01dd0000;
            rom_0030[952] <= 32'h21dd00ff;
            rom_0030[953] <= 32'h01de0000;
            rom_0030[954] <= 32'h21de00ff;
            rom_0030[955] <= 32'h01df0000;
            rom_0030[956] <= 32'h21df00ff;
            rom_0030[957] <= 32'h01e00000;
            rom_0030[958] <= 32'h21e000ff;
            rom_0030[959] <= 32'h21e100ff;
            rom_0030[960] <= 32'h01e20000;
            rom_0030[961] <= 32'h21e200ff;
            rom_0030[962] <= 32'h01e30000;
            rom_0030[963] <= 32'h21e300ff;
            rom_0030[964] <= 32'h01e40000;
            rom_0030[965] <= 32'h21e400ff;
            rom_0030[966] <= 32'h01e50000;
            rom_0030[967] <= 32'h21e500ff;
            rom_0030[968] <= 32'h01e60000;
            rom_0030[969] <= 32'h21e600ff;
            rom_0030[970] <= 32'h01e70000;
            rom_0030[971] <= 32'h21e700ff;
            rom_0030[972] <= 32'h01e80000;
            rom_0030[973] <= 32'h21e800ff;
            rom_0030[974] <= 32'h01e90000;
            rom_0030[975] <= 32'h21e900ff;
            rom_0030[976] <= 32'h01ea0000;
            rom_0030[977] <= 32'h21ea00ff;
            rom_0030[978] <= 32'h01eb0000;
            rom_0030[979] <= 32'h21eb00ff;
            rom_0030[980] <= 32'h01ec0000;
            rom_0030[981] <= 32'h21ec00ff;
            rom_0030[982] <= 32'h01ed0000;
            rom_0030[983] <= 32'h21ed00ff;
            rom_0030[984] <= 32'h01ee0000;
            rom_0030[985] <= 32'h21ee00ff;
            rom_0030[986] <= 32'h01ef0000;
            rom_0030[987] <= 32'h21ef00ff;
            rom_0030[988] <= 32'h01f00000;
            rom_0030[989] <= 32'h21f000ff;
            rom_0030[990] <= 32'h01f10000;
            rom_0030[991] <= 32'h21f100ff;
            rom_0030[992] <= 32'h01f20000;
            rom_0030[993] <= 32'h21f200ff;
            rom_0030[994] <= 32'h01f30000;
            rom_0030[995] <= 32'h21f300ff;
            rom_0030[996] <= 32'h01f40000;
            rom_0030[997] <= 32'h21f400ff;
            rom_0030[998] <= 32'h01f50000;
            rom_0030[999] <= 32'h21f500ff;
            rom_0030[1000] <= 32'h01f60000;
            rom_0030[1001] <= 32'h21f600ff;
            rom_0030[1002] <= 32'h01f70000;
            rom_0030[1003] <= 32'h21f700ff;
            rom_0030[1004] <= 32'h01f80000;
            rom_0030[1005] <= 32'h21f800ff;
            rom_0030[1006] <= 32'h01f90000;
            rom_0030[1007] <= 32'h21f900ff;
            rom_0030[1008] <= 32'h01fa0000;
            rom_0030[1009] <= 32'h21fa00ff;
            rom_0030[1010] <= 32'h01fb0000;
            rom_0030[1011] <= 32'h21fb00ff;
            rom_0030[1012] <= 32'h01fc0000;
            rom_0030[1013] <= 32'h21fc00ff;
            rom_0030[1014] <= 32'h01fd0000;
            rom_0030[1015] <= 32'h21fd00ff;
            rom_0030[1016] <= 32'h01fe0000;
            rom_0030[1017] <= 32'h21fe00ff;
            rom_0030[1018] <= 32'h01ff0000;
            rom_0030[1019] <= 32'h21ff00ff;
            rom_0030[1020] <= 32'h02000000;
            rom_0030[1021] <= 32'h220000ff;
            rom_0030[1022] <= 32'h02010000;
            rom_0030[1023] <= 32'h220100ff;
            rom_0030[1024] <= 32'h02020000;
            rom_0030[1025] <= 32'h220200ff;
            rom_0030[1026] <= 32'h02030000;
            rom_0030[1027] <= 32'h220300ff;
            rom_0030[1028] <= 32'h02040000;
            rom_0030[1029] <= 32'h220400ff;
            rom_0030[1030] <= 32'h02050000;
            rom_0030[1031] <= 32'h220500ff;
            rom_0030[1032] <= 32'h02060000;
            rom_0030[1033] <= 32'h220600ff;
            rom_0030[1034] <= 32'h02070000;
            rom_0030[1035] <= 32'h220700ff;
            rom_0030[1036] <= 32'h02080000;
            rom_0030[1037] <= 32'h220800ff;
            rom_0030[1038] <= 32'h02090000;
            rom_0030[1039] <= 32'h220900ff;
            rom_0030[1040] <= 32'h020a0000;
            rom_0030[1041] <= 32'h220a00ff;
            rom_0030[1042] <= 32'h020b0000;
            rom_0030[1043] <= 32'h220b00ff;
            rom_0030[1044] <= 32'h020c0000;
            rom_0030[1045] <= 32'h220c00ff;
            rom_0030[1046] <= 32'h020d0000;
            rom_0030[1047] <= 32'h220d00ff;
            rom_0030[1048] <= 32'h020e0000;
            rom_0030[1049] <= 32'h220e00ff;
            rom_0030[1050] <= 32'h020f0000;
            rom_0030[1051] <= 32'h220f00ff;
            rom_0030[1052] <= 32'h02100000;
            rom_0030[1053] <= 32'h221000ff;
            rom_0030[1054] <= 32'h02110000;
            rom_0030[1055] <= 32'h221100ff;
            rom_0030[1056] <= 32'h02120000;
            rom_0030[1057] <= 32'h221200ff;
            rom_0030[1058] <= 32'h02130000;
            rom_0030[1059] <= 32'h221300ff;
            rom_0030[1060] <= 32'h02140000;
            rom_0030[1061] <= 32'h221400ff;
            rom_0030[1062] <= 32'h02150000;
            rom_0030[1063] <= 32'h221500ff;
            rom_0030[1064] <= 32'h02160000;
            rom_0030[1065] <= 32'h221600ff;
            rom_0030[1066] <= 32'h02170000;
            rom_0030[1067] <= 32'h221700ff;
            rom_0030[1068] <= 32'h02180000;
            rom_0030[1069] <= 32'h221800ff;
            rom_0030[1070] <= 32'h02190000;
            rom_0030[1071] <= 32'h221900ff;
            rom_0030[1072] <= 32'h021a0000;
            rom_0030[1073] <= 32'h221a00ff;
            rom_0030[1074] <= 32'h021b0000;
            rom_0030[1075] <= 32'h221b00ff;
            rom_0030[1076] <= 32'h021c0000;
            rom_0030[1077] <= 32'h221c00ff;
            rom_0030[1078] <= 32'h021d0000;
            rom_0030[1079] <= 32'h221d00ff;
            rom_0030[1080] <= 32'h021e0000;
            rom_0030[1081] <= 32'h221e00ff;
            rom_0030[1082] <= 32'h021f0000;
            rom_0030[1083] <= 32'h221f00ff;
            rom_0030[1084] <= 32'h02200000;
            rom_0030[1085] <= 32'h222000ff;
            rom_0030[1086] <= 32'h02210000;
            rom_0030[1087] <= 32'h222100ff;
            rom_0030[1088] <= 32'h02220000;
            rom_0030[1089] <= 32'h222200ff;
            rom_0030[1090] <= 32'h02230000;
            rom_0030[1091] <= 32'h222300ff;
            rom_0030[1092] <= 32'h02240000;
            rom_0030[1093] <= 32'h222400ff;
            rom_0030[1094] <= 32'h02250000;
            rom_0030[1095] <= 32'h222500ff;
            rom_0030[1096] <= 32'h02260000;
            rom_0030[1097] <= 32'h222600ff;
            rom_0030[1098] <= 32'h02270000;
            rom_0030[1099] <= 32'h222700ff;
            rom_0030[1100] <= 32'h02280000;
            rom_0030[1101] <= 32'h222800ff;
            rom_0030[1102] <= 32'h02290000;
            rom_0030[1103] <= 32'h222900ff;
            rom_0030[1104] <= 32'h022a0000;
            rom_0030[1105] <= 32'h222a00ff;
            rom_0030[1106] <= 32'h022b0000;
            rom_0030[1107] <= 32'h222b00ff;
            rom_0030[1108] <= 32'h022c0000;
            rom_0030[1109] <= 32'h222c00ff;
            rom_0030[1110] <= 32'h022d0000;
            rom_0030[1111] <= 32'h222d00ff;
            rom_0030[1112] <= 32'h022e0000;
            rom_0030[1113] <= 32'h222e00ff;
            rom_0030[1114] <= 32'h022f0000;
            rom_0030[1115] <= 32'h222f00ff;
            rom_0030[1116] <= 32'h02300000;
            rom_0030[1117] <= 32'h223000ff;
            rom_0030[1118] <= 32'h02310000;
            rom_0030[1119] <= 32'h223100ff;
            rom_0030[1120] <= 32'h02320000;
            rom_0030[1121] <= 32'h223200ff;
            rom_0030[1122] <= 32'h02330000;
            rom_0030[1123] <= 32'h223300ff;
            rom_0030[1124] <= 32'h02340000;
            rom_0030[1125] <= 32'h223400ff;
            rom_0030[1126] <= 32'h02350000;
            rom_0030[1127] <= 32'h223500ff;
            rom_0030[1128] <= 32'h02360000;
            rom_0030[1129] <= 32'h223600ff;
            rom_0030[1130] <= 32'h02370000;
            rom_0030[1131] <= 32'h223700ff;
            rom_0030[1132] <= 32'h02380000;
            rom_0030[1133] <= 32'h223800ff;
            rom_0030[1134] <= 32'h02390000;
            rom_0030[1135] <= 32'h223900ff;
            rom_0030[1136] <= 32'h023a0000;
            rom_0030[1137] <= 32'h223a00ff;
            rom_0030[1138] <= 32'h023b0000;
            rom_0030[1139] <= 32'h223b00ff;
            rom_0030[1140] <= 32'h023c0000;
            rom_0030[1141] <= 32'h223c00ff;
            rom_0030[1142] <= 32'h023d0000;
            rom_0030[1143] <= 32'h223d00ff;
            rom_0030[1144] <= 32'h023e0000;
            rom_0030[1145] <= 32'h223e00ff;
            rom_0030[1146] <= 32'h023f0000;
            rom_0030[1147] <= 32'h223f00ff;
            rom_0030[1148] <= 32'h02400000;
            rom_0030[1149] <= 32'h224000ff;
            rom_0030[1150] <= 32'h02410000;
            rom_0030[1151] <= 32'h224100ff;
            rom_0030[1152] <= 32'h02420000;
            rom_0030[1153] <= 32'h224200ff;
            rom_0030[1154] <= 32'h02430000;
            rom_0030[1155] <= 32'h224300ff;
            rom_0030[1156] <= 32'h02440000;
            rom_0030[1157] <= 32'h224400ff;
            rom_0030[1158] <= 32'h02450000;
            rom_0030[1159] <= 32'h224500ff;
            rom_0030[1160] <= 32'h02460000;
            rom_0030[1161] <= 32'h224600ff;
            rom_0030[1162] <= 32'h02470000;
            rom_0030[1163] <= 32'h224700ff;
            rom_0030[1164] <= 32'h02480000;
            rom_0030[1165] <= 32'h224800ff;
            rom_0030[1166] <= 32'h02490000;
            rom_0030[1167] <= 32'h224900ff;
            rom_0030[1168] <= 32'h024a0000;
            rom_0030[1169] <= 32'h224a00ff;
            rom_0030[1170] <= 32'h024b0000;
            rom_0030[1171] <= 32'h224b00ff;
            rom_0030[1172] <= 32'h024c0000;
            rom_0030[1173] <= 32'h224c00ff;
            rom_0030[1174] <= 32'h024d0000;
            rom_0030[1175] <= 32'h224d00ff;
            rom_0030[1176] <= 32'h024e0000;
            rom_0030[1177] <= 32'h224e00ff;
            rom_0030[1178] <= 32'h024f0000;
            rom_0030[1179] <= 32'h224f00ff;
            rom_0030[1180] <= 32'h02500000;
            rom_0030[1181] <= 32'h225000ff;
            rom_0030[1182] <= 32'h02510000;
            rom_0030[1183] <= 32'h225100ff;
            rom_0030[1184] <= 32'h02520000;
            rom_0030[1185] <= 32'h225200ff;
            rom_0030[1186] <= 32'h02530000;
            rom_0030[1187] <= 32'h225300ff;
            rom_0030[1188] <= 32'h02540000;
            rom_0030[1189] <= 32'h225400ff;
            rom_0030[1190] <= 32'h02550000;
            rom_0030[1191] <= 32'h225500ff;
            rom_0030[1192] <= 32'h02560000;
            rom_0030[1193] <= 32'h225600ff;
            rom_0030[1194] <= 32'h02570000;
            rom_0030[1195] <= 32'h225700ff;
            rom_0030[1196] <= 32'h02580000;
            rom_0030[1197] <= 32'h225800ff;
            rom_0030[1198] <= 32'h02590000;
            rom_0030[1199] <= 32'h225900ff;
            rom_0030[1200] <= 32'h025a0000;
            rom_0030[1201] <= 32'h225a00ff;
            rom_0030[1202] <= 32'h025b0000;
            rom_0030[1203] <= 32'h225b00ff;
            rom_0030[1204] <= 32'h025c0000;
            rom_0030[1205] <= 32'h225c00ff;
            rom_0030[1206] <= 32'h025d0000;
            rom_0030[1207] <= 32'h225d00ff;
            rom_0030[1208] <= 32'h025e0000;
            rom_0030[1209] <= 32'h225e00ff;
            rom_0030[1210] <= 32'h025f0000;
            rom_0030[1211] <= 32'h225f00ff;
            rom_0030[1212] <= 32'h02600000;
            rom_0030[1213] <= 32'h226000ff;
            rom_0030[1214] <= 32'h02610000;
            rom_0030[1215] <= 32'h226100ff;
            rom_0030[1216] <= 32'h02620000;
            rom_0030[1217] <= 32'h226200ff;
            rom_0030[1218] <= 32'h02630000;
            rom_0030[1219] <= 32'h226300ff;
            rom_0030[1220] <= 32'h02640000;
            rom_0030[1221] <= 32'h226400ff;
            rom_0030[1222] <= 32'h02650000;
            rom_0030[1223] <= 32'h226500ff;
            rom_0030[1224] <= 32'h02660000;
            rom_0030[1225] <= 32'h226600ff;
            rom_0030[1226] <= 32'h02670000;
            rom_0030[1227] <= 32'h226700ff;
            rom_0030[1228] <= 32'h02680000;
            rom_0030[1229] <= 32'h226800ff;
            rom_0030[1230] <= 32'h02690000;
            rom_0030[1231] <= 32'h226900ff;
            rom_0030[1232] <= 32'h026a0000;
            rom_0030[1233] <= 32'h226a00ff;
            rom_0030[1234] <= 32'h026b0000;
            rom_0030[1235] <= 32'h226b00ff;
            rom_0030[1236] <= 32'h026c0000;
            rom_0030[1237] <= 32'h226c00ff;
            rom_0030[1238] <= 32'h026d0000;
            rom_0030[1239] <= 32'h226d00ff;
            rom_0030[1240] <= 32'h026e0000;
            rom_0030[1241] <= 32'h226e00ff;
            rom_0030[1242] <= 32'h026f0000;
            rom_0030[1243] <= 32'h226f00ff;
            rom_0030[1244] <= 32'h02700000;
            rom_0030[1245] <= 32'h227000ff;
            rom_0030[1246] <= 32'h02710000;
            rom_0030[1247] <= 32'h227100ff;
            rom_0030[1248] <= 32'h02720000;
            rom_0030[1249] <= 32'h227200ff;
            rom_0030[1250] <= 32'h02730000;
            rom_0030[1251] <= 32'h227300ff;
            rom_0030[1252] <= 32'h02740000;
            rom_0030[1253] <= 32'h227400ff;
            rom_0030[1254] <= 32'h02750000;
            rom_0030[1255] <= 32'h227500ff;
            rom_0030[1256] <= 32'h02760000;
            rom_0030[1257] <= 32'h227600ff;
            rom_0030[1258] <= 32'h02770000;
            rom_0030[1259] <= 32'h227700ff;
            rom_0030[1260] <= 32'h02780000;
            rom_0030[1261] <= 32'h227800ff;
            rom_0030[1262] <= 32'h02790000;
            rom_0030[1263] <= 32'h227900ff;
            rom_0030[1264] <= 32'h027a0000;
            rom_0030[1265] <= 32'h227a00ff;
            rom_0030[1266] <= 32'h027b0000;
            rom_0030[1267] <= 32'h227b00ff;
            rom_0030[1268] <= 32'h027c0000;
            rom_0030[1269] <= 32'h227c00ff;
            rom_0030[1270] <= 32'h027d0000;
            rom_0030[1271] <= 32'h227d00ff;
            rom_0030[1272] <= 32'h027e0000;
            rom_0030[1273] <= 32'h227e00ff;
            rom_0030[1274] <= 32'h027f0000;
            rom_0030[1275] <= 32'h227f00ff;
            rom_0030[1276] <= 32'h02800000;
            rom_0030[1277] <= 32'h228000ff;
            rom_0030[1278] <= 32'h02810000;
            rom_0030[1279] <= 32'h228100ff;
            rom_0030[1280] <= 32'h02820000;
            rom_0030[1281] <= 32'h228200ff;
            rom_0030[1282] <= 32'h02830000;
            rom_0030[1283] <= 32'h228300ff;
            rom_0030[1284] <= 32'h02840000;
            rom_0030[1285] <= 32'h228400ff;
            rom_0030[1286] <= 32'h02850000;
            rom_0030[1287] <= 32'h228500ff;
            rom_0030[1288] <= 32'h02860000;
            rom_0030[1289] <= 32'h228600ff;
            rom_0030[1290] <= 32'h02870000;
            rom_0030[1291] <= 32'h228700ff;
            rom_0030[1292] <= 32'h02880000;
            rom_0030[1293] <= 32'h228800ff;
            rom_0030[1294] <= 32'h02890000;
            rom_0030[1295] <= 32'h228900ff;
            rom_0030[1296] <= 32'h028a0000;
            rom_0030[1297] <= 32'h228a00ff;
            rom_0030[1298] <= 32'h028b0000;
            rom_0030[1299] <= 32'h228b00ff;
            rom_0030[1300] <= 32'h028c0000;
            rom_0030[1301] <= 32'h228c00ff;
            rom_0030[1302] <= 32'h028d0000;
            rom_0030[1303] <= 32'h228d00ff;
            rom_0030[1304] <= 32'h028e0000;
            rom_0030[1305] <= 32'h228e00ff;
            rom_0030[1306] <= 32'h028f0000;
            rom_0030[1307] <= 32'h228f00ff;
            rom_0030[1308] <= 32'h02900000;
            rom_0030[1309] <= 32'h229000ff;
            rom_0030[1310] <= 32'h02910000;
            rom_0030[1311] <= 32'h229100ff;
            rom_0030[1312] <= 32'h02920000;
            rom_0030[1313] <= 32'h229200ff;
            rom_0030[1314] <= 32'h02930000;
            rom_0030[1315] <= 32'h229300ff;
            rom_0030[1316] <= 32'h02940000;
            rom_0030[1317] <= 32'h229400ff;
            rom_0030[1318] <= 32'h02950000;
            rom_0030[1319] <= 32'h229500ff;
            rom_0030[1320] <= 32'h02960000;
            rom_0030[1321] <= 32'h229600ff;
            rom_0030[1322] <= 32'h02970000;
            rom_0030[1323] <= 32'h229700ff;
            rom_0030[1324] <= 32'h02980000;
            rom_0030[1325] <= 32'h229800ff;
            rom_0030[1326] <= 32'h02990000;
            rom_0030[1327] <= 32'h229900ff;
            rom_0030[1328] <= 32'h029a0000;
            rom_0030[1329] <= 32'h229a00ff;
            rom_0030[1330] <= 32'h029b0000;
            rom_0030[1331] <= 32'h229b00ff;
            rom_0030[1332] <= 32'h029c0000;
            rom_0030[1333] <= 32'h229c00ff;
            rom_0030[1334] <= 32'h029d0000;
            rom_0030[1335] <= 32'h229d00ff;
            rom_0030[1336] <= 32'h029e0000;
            rom_0030[1337] <= 32'h229e00ff;
            rom_0030[1338] <= 32'h029f0000;
            rom_0030[1339] <= 32'h229f00ff;
            rom_0030[1340] <= 32'h02a00000;
            rom_0030[1341] <= 32'h22a000ff;
            rom_0030[1342] <= 32'h02a10000;
            rom_0030[1343] <= 32'h22a100ff;
            rom_0030[1344] <= 32'h02a20000;
            rom_0030[1345] <= 32'h22a200ff;
            rom_0030[1346] <= 32'h02a30000;
            rom_0030[1347] <= 32'h22a300ff;
            rom_0030[1348] <= 32'h02a40000;
            rom_0030[1349] <= 32'h22a400ff;
            rom_0030[1350] <= 32'h02a50000;
            rom_0030[1351] <= 32'h22a500ff;
            rom_0030[1352] <= 32'h02a60000;
            rom_0030[1353] <= 32'h22a600ff;
            rom_0030[1354] <= 32'h02a70000;
            rom_0030[1355] <= 32'h22a700ff;
            rom_0030[1356] <= 32'h02a80000;
            rom_0030[1357] <= 32'h22a800ff;
            rom_0030[1358] <= 32'h02a90000;
            rom_0030[1359] <= 32'h22a900ff;
            rom_0030[1360] <= 32'h02aa0000;
            rom_0030[1361] <= 32'h22aa00ff;
            rom_0030[1362] <= 32'h02ab0000;
            rom_0030[1363] <= 32'h22ab00ff;
            rom_0030[1364] <= 32'h02ac0000;
            rom_0030[1365] <= 32'h22ac00ff;
            rom_0030[1366] <= 32'h02ad0000;
            rom_0030[1367] <= 32'h22ad00ff;
            rom_0030[1368] <= 32'h02ae0000;
            rom_0030[1369] <= 32'h22ae00ff;
            rom_0030[1370] <= 32'h02af0000;
            rom_0030[1371] <= 32'h22af00ff;
            rom_0030[1372] <= 32'h02b00000;
            rom_0030[1373] <= 32'h22b000ff;
            rom_0030[1374] <= 32'h02b10000;
            rom_0030[1375] <= 32'h22b100ff;
            rom_0030[1376] <= 32'h02b20000;
            rom_0030[1377] <= 32'h22b200ff;
            rom_0030[1378] <= 32'h02b30000;
            rom_0030[1379] <= 32'h22b300ff;
            rom_0030[1380] <= 32'h02b40000;
            rom_0030[1381] <= 32'h22b400ff;
            rom_0030[1382] <= 32'h02b50000;
            rom_0030[1383] <= 32'h22b500ff;
            rom_0030[1384] <= 32'h02b60000;
            rom_0030[1385] <= 32'h22b600ff;
            rom_0030[1386] <= 32'h02b70000;
            rom_0030[1387] <= 32'h22b700ff;
            rom_0030[1388] <= 32'h02b80000;
            rom_0030[1389] <= 32'h22b800ff;
            rom_0030[1390] <= 32'h02b90000;
            rom_0030[1391] <= 32'h22b900ff;
            rom_0030[1392] <= 32'h02ba0000;
            rom_0030[1393] <= 32'h22ba00ff;
            rom_0030[1394] <= 32'h02bb0000;
            rom_0030[1395] <= 32'h22bb00ff;
            rom_0030[1396] <= 32'h02bc0000;
            rom_0030[1397] <= 32'h22bc00ff;
            rom_0030[1398] <= 32'h02bd0000;
            rom_0030[1399] <= 32'h22bd00ff;
            rom_0030[1400] <= 32'h02be0000;
            rom_0030[1401] <= 32'h22be00ff;
            rom_0030[1402] <= 32'h02bf0000;
            rom_0030[1403] <= 32'h22bf00ff;
            rom_0030[1404] <= 32'h02c00000;
            rom_0030[1405] <= 32'h22c000ff;
            rom_0030[1406] <= 32'h02c10000;
            rom_0030[1407] <= 32'h22c100ff;
            rom_0030[1408] <= 32'h02c20000;
            rom_0030[1409] <= 32'h22c200ff;
            rom_0030[1410] <= 32'h02c30000;
            rom_0030[1411] <= 32'h22c300ff;
            rom_0030[1412] <= 32'h02c40000;
            rom_0030[1413] <= 32'h22c400ff;
            rom_0030[1414] <= 32'h02c50000;
            rom_0030[1415] <= 32'h22c500ff;
            rom_0030[1416] <= 32'h02c60000;
            rom_0030[1417] <= 32'h22c600ff;
            rom_0030[1418] <= 32'h02c70000;
            rom_0030[1419] <= 32'h22c700ff;
            rom_0030[1420] <= 32'h02c80000;
            rom_0030[1421] <= 32'h22c800ff;
            rom_0030[1422] <= 32'h02c90000;
            rom_0030[1423] <= 32'h22c900ff;
            rom_0030[1424] <= 32'h02ca0000;
            rom_0030[1425] <= 32'h22ca00ff;
            rom_0030[1426] <= 32'h02cb0000;
            rom_0030[1427] <= 32'h22cb00ff;
            rom_0030[1428] <= 32'h02cc0000;
            rom_0030[1429] <= 32'h22cc00ff;
            rom_0030[1430] <= 32'h02cd0000;
            rom_0030[1431] <= 32'h22cd00ff;
            rom_0030[1432] <= 32'h02ce0000;
            rom_0030[1433] <= 32'h22ce00ff;
            rom_0030[1434] <= 32'h02cf0000;
            rom_0030[1435] <= 32'h22cf00ff;
            rom_0030[1436] <= 32'h02d00000;
            rom_0030[1437] <= 32'h22d000ff;
            rom_0030[1438] <= 32'h02d10000;
            rom_0030[1439] <= 32'h22d100ff;
            rom_0030[1440] <= 32'h02d20000;
            rom_0030[1441] <= 32'h22d200ff;
            rom_0030[1442] <= 32'h02d30000;
            rom_0030[1443] <= 32'h22d300ff;
            rom_0030[1444] <= 32'h02d40000;
            rom_0030[1445] <= 32'h22d400ff;
            rom_0030[1446] <= 32'h02d50000;
            rom_0030[1447] <= 32'h22d500ff;
            rom_0030[1448] <= 32'h02d60000;
            rom_0030[1449] <= 32'h22d600ff;
            rom_0030[1450] <= 32'h02d70000;
            rom_0030[1451] <= 32'h22d700ff;
            rom_0030[1452] <= 32'h02d80000;
            rom_0030[1453] <= 32'h22d800ff;
            rom_0030[1454] <= 32'h02d90000;
            rom_0030[1455] <= 32'h22d900ff;
            rom_0030[1456] <= 32'h02da0000;
            rom_0030[1457] <= 32'h22da00ff;
            rom_0030[1458] <= 32'h02db0000;
            rom_0030[1459] <= 32'h22db00ff;
            rom_0030[1460] <= 32'h02dc0000;
            rom_0030[1461] <= 32'h22dc00ff;
            rom_0030[1462] <= 32'h02dd0000;
            rom_0030[1463] <= 32'h22dd00ff;
            rom_0030[1464] <= 32'h02de0000;
            rom_0030[1465] <= 32'h22de00ff;
            rom_0030[1466] <= 32'h02df0000;
            rom_0030[1467] <= 32'h22df00ff;
            rom_0030[1468] <= 32'h02e00000;
            rom_0030[1469] <= 32'h22e000ff;
            rom_0030[1470] <= 32'h02e10000;
            rom_0030[1471] <= 32'h22e100ff;
            rom_0030[1472] <= 32'h02e20000;
            rom_0030[1473] <= 32'h22e200ff;
            rom_0030[1474] <= 32'h02e30000;
            rom_0030[1475] <= 32'h22e300ff;
            rom_0030[1476] <= 32'h02e40000;
            rom_0030[1477] <= 32'h22e400ff;
            rom_0030[1478] <= 32'h02e50000;
            rom_0030[1479] <= 32'h22e500ff;
            rom_0030[1480] <= 32'h02e60000;
            rom_0030[1481] <= 32'h22e600ff;
            rom_0030[1482] <= 32'h02e70000;
            rom_0030[1483] <= 32'h22e700ff;
            rom_0030[1484] <= 32'h02e80000;
            rom_0030[1485] <= 32'h22e800ff;
            rom_0030[1486] <= 32'h02e90000;
            rom_0030[1487] <= 32'h22e900ff;
            rom_0030[1488] <= 32'h02ea0000;
            rom_0030[1489] <= 32'h22ea00ff;
            rom_0030[1490] <= 32'h02eb0000;
            rom_0030[1491] <= 32'h22eb00ff;
            rom_0030[1492] <= 32'h02ec0000;
            rom_0030[1493] <= 32'h22ec00ff;
            rom_0030[1494] <= 32'h02ed0000;
            rom_0030[1495] <= 32'h22ed00ff;
            rom_0030[1496] <= 32'h02ee0000;
            rom_0030[1497] <= 32'h22ee00ff;
            rom_0030[1498] <= 32'h02ef0000;
            rom_0030[1499] <= 32'h22ef00ff;
            rom_0030[1500] <= 32'h02f00000;
            rom_0030[1501] <= 32'h22f000ff;
            rom_0030[1502] <= 32'h02f10000;
            rom_0030[1503] <= 32'h22f100ff;
            rom_0030[1504] <= 32'h02f20000;
            rom_0030[1505] <= 32'h22f200ff;
            rom_0030[1506] <= 32'h02f30000;
            rom_0030[1507] <= 32'h22f300ff;
            rom_0030[1508] <= 32'h02f40000;
            rom_0030[1509] <= 32'h22f400ff;
            rom_0030[1510] <= 32'h02f50000;
            rom_0030[1511] <= 32'h22f500ff;
            rom_0030[1512] <= 32'h02f60000;
            rom_0030[1513] <= 32'h22f600ff;
            rom_0030[1514] <= 32'h02f70000;
            rom_0030[1515] <= 32'h22f700ff;
            rom_0030[1516] <= 32'h02f80000;
            rom_0030[1517] <= 32'h22f800ff;
            rom_0030[1518] <= 32'h02f90000;
            rom_0030[1519] <= 32'h22f900ff;
            rom_0030[1520] <= 32'h02fa0000;
            rom_0030[1521] <= 32'h22fa00ff;
            rom_0030[1522] <= 32'h02fb0000;
            rom_0030[1523] <= 32'h22fb00ff;
            rom_0030[1524] <= 32'h02fc0000;
            rom_0030[1525] <= 32'h22fc00ff;
            rom_0030[1526] <= 32'h02fd0000;
            rom_0030[1527] <= 32'h22fd00ff;
            rom_0030[1528] <= 32'h02fe0000;
            rom_0030[1529] <= 32'h22fe00ff;
            rom_0030[1530] <= 32'h02ff0000;
            rom_0030[1531] <= 32'h22ff00ff;
            rom_0030[1532] <= 32'h03000000;
            rom_0030[1533] <= 32'h230000ff;
            rom_0030[1534] <= 32'h03010000;
            rom_0030[1535] <= 32'h230100ff;
            rom_0030[1536] <= 32'h03020000;
            rom_0030[1537] <= 32'h230200ff;
            rom_0030[1538] <= 32'h03030000;
            rom_0030[1539] <= 32'h230300ff;
            rom_0030[1540] <= 32'h03040000;
            rom_0030[1541] <= 32'h230400ff;
            rom_0030[1542] <= 32'h03050000;
            rom_0030[1543] <= 32'h230500ff;
            rom_0030[1544] <= 32'h03060000;
            rom_0030[1545] <= 32'h230600ff;
            rom_0030[1546] <= 32'h03070000;
            rom_0030[1547] <= 32'h230700ff;
            rom_0030[1548] <= 32'h03080000;
            rom_0030[1549] <= 32'h230800ff;
            rom_0030[1550] <= 32'h03090000;
            rom_0030[1551] <= 32'h230900ff;
            rom_0030[1552] <= 32'h030a0000;
            rom_0030[1553] <= 32'h230a00ff;
            rom_0030[1554] <= 32'h030b0000;
            rom_0030[1555] <= 32'h230b00ff;
            rom_0030[1556] <= 32'h030c0000;
            rom_0030[1557] <= 32'h230c00ff;
            rom_0030[1558] <= 32'h030d0000;
            rom_0030[1559] <= 32'h230d00ff;
            rom_0030[1560] <= 32'h030e0000;
            rom_0030[1561] <= 32'h230e00ff;
            rom_0030[1562] <= 32'h030f0000;
            rom_0030[1563] <= 32'h230f00ff;
            rom_0030[1564] <= 32'h03100000;
            rom_0030[1565] <= 32'h231000ff;
            rom_0030[1566] <= 32'h03110000;
            rom_0030[1567] <= 32'h231100ff;
            rom_0030[1568] <= 32'h03120000;
            rom_0030[1569] <= 32'h231200ff;
            rom_0030[1570] <= 32'h03130000;
            rom_0030[1571] <= 32'h231300ff;
            rom_0030[1572] <= 32'h03140000;
            rom_0030[1573] <= 32'h231400ff;
            rom_0030[1574] <= 32'h03150000;
            rom_0030[1575] <= 32'h231500ff;
            rom_0030[1576] <= 32'h03160000;
            rom_0030[1577] <= 32'h231600ff;
            rom_0030[1578] <= 32'h03170000;
            rom_0030[1579] <= 32'h231700ff;
            rom_0030[1580] <= 32'h03180000;
            rom_0030[1581] <= 32'h231800ff;
            rom_0030[1582] <= 32'h03190000;
            rom_0030[1583] <= 32'h231900ff;
            rom_0030[1584] <= 32'h031a0000;
            rom_0030[1585] <= 32'h231a00ff;
            rom_0030[1586] <= 32'h031b0000;
            rom_0030[1587] <= 32'h231b00ff;
            rom_0030[1588] <= 32'h031c0000;
            rom_0030[1589] <= 32'h231c00ff;
            rom_0030[1590] <= 32'h031d0000;
            rom_0030[1591] <= 32'h231d00ff;
            rom_0030[1592] <= 32'h031e0000;
            rom_0030[1593] <= 32'h231e00ff;
            rom_0030[1594] <= 32'h031f0000;
            rom_0030[1595] <= 32'h231f00ff;
            rom_0030[1596] <= 32'h03200000;
            rom_0030[1597] <= 32'h232000ff;
            rom_0030[1598] <= 32'h03210000;
            rom_0030[1599] <= 32'h232100ff;
            rom_0030[1600] <= 32'h03220000;
            rom_0030[1601] <= 32'h232200ff;
            rom_0030[1602] <= 32'h03230000;
            rom_0030[1603] <= 32'h232300ff;
            rom_0030[1604] <= 32'h03240000;
            rom_0030[1605] <= 32'h232400ff;
            rom_0030[1606] <= 32'h03250000;
            rom_0030[1607] <= 32'h232500ff;
            rom_0030[1608] <= 32'h03260000;
            rom_0030[1609] <= 32'h232600ff;
            rom_0030[1610] <= 32'h03270000;
            rom_0030[1611] <= 32'h232700ff;
            rom_0030[1612] <= 32'h03280000;
            rom_0030[1613] <= 32'h232800ff;
            rom_0030[1614] <= 32'h03290000;
            rom_0030[1615] <= 32'h232900ff;
            rom_0030[1616] <= 32'h032a0000;
            rom_0030[1617] <= 32'h232a00ff;
            rom_0030[1618] <= 32'h032b0000;
            rom_0030[1619] <= 32'h232b00ff;
            rom_0030[1620] <= 32'h032c0000;
            rom_0030[1621] <= 32'h232c00ff;
            rom_0030[1622] <= 32'h032d0000;
            rom_0030[1623] <= 32'h232d00ff;
            rom_0030[1624] <= 32'h032e0000;
            rom_0030[1625] <= 32'h232e00ff;
            rom_0030[1626] <= 32'h032f0000;
            rom_0030[1627] <= 32'h232f00ff;
            rom_0030[1628] <= 32'h03300000;
            rom_0030[1629] <= 32'h233000ff;
            rom_0030[1630] <= 32'h03310000;
            rom_0030[1631] <= 32'h233100ff;
            rom_0030[1632] <= 32'h03320000;
            rom_0030[1633] <= 32'h233200ff;
            rom_0030[1634] <= 32'h03330000;
            rom_0030[1635] <= 32'h233300ff;
            rom_0030[1636] <= 32'h03340000;
            rom_0030[1637] <= 32'h233400ff;
            rom_0030[1638] <= 32'h03350000;
            rom_0030[1639] <= 32'h233500ff;
            rom_0030[1640] <= 32'h03360000;
            rom_0030[1641] <= 32'h233600ff;
            rom_0030[1642] <= 32'h03370000;
            rom_0030[1643] <= 32'h233700ff;
            rom_0030[1644] <= 32'h03380000;
            rom_0030[1645] <= 32'h233800ff;
            rom_0030[1646] <= 32'h03390000;
            rom_0030[1647] <= 32'h233900ff;
            rom_0030[1648] <= 32'h033a0000;
            rom_0030[1649] <= 32'h233a00ff;
            rom_0030[1650] <= 32'h033b0000;
            rom_0030[1651] <= 32'h233b00ff;
            rom_0030[1652] <= 32'h033c0000;
            rom_0030[1653] <= 32'h233c00ff;
            rom_0030[1654] <= 32'h033d0000;
            rom_0030[1655] <= 32'h233d00ff;
            rom_0030[1656] <= 32'h033e0000;
            rom_0030[1657] <= 32'h233e00ff;
            rom_0030[1658] <= 32'h033f0000;
            rom_0030[1659] <= 32'h233f00ff;
            rom_0030[1660] <= 32'h03400000;
            rom_0030[1661] <= 32'h234000ff;
            rom_0030[1662] <= 32'h03410000;
            rom_0030[1663] <= 32'h234100ff;
            rom_0030[1664] <= 32'h03420000;
            rom_0030[1665] <= 32'h234200ff;
            rom_0030[1666] <= 32'h03430000;
            rom_0030[1667] <= 32'h234300ff;
            rom_0030[1668] <= 32'h03440000;
            rom_0030[1669] <= 32'h234400ff;
            rom_0030[1670] <= 32'h03450000;
            rom_0030[1671] <= 32'h234500ff;
            rom_0030[1672] <= 32'h03460000;
            rom_0030[1673] <= 32'h234600ff;
            rom_0030[1674] <= 32'h03470000;
            rom_0030[1675] <= 32'h234700ff;
            rom_0030[1676] <= 32'h03480000;
            rom_0030[1677] <= 32'h234800ff;
            rom_0030[1678] <= 32'h03490000;
            rom_0030[1679] <= 32'h234900ff;
            rom_0030[1680] <= 32'h034a0000;
            rom_0030[1681] <= 32'h234a00ff;
            rom_0030[1682] <= 32'h034b0000;
            rom_0030[1683] <= 32'h234b00ff;
            rom_0030[1684] <= 32'h034c0000;
            rom_0030[1685] <= 32'h234c00ff;
            rom_0030[1686] <= 32'h034d0000;
            rom_0030[1687] <= 32'h234d00ff;
            rom_0030[1688] <= 32'h034e0000;
            rom_0030[1689] <= 32'h234e00ff;
            rom_0030[1690] <= 32'h034f0000;
            rom_0030[1691] <= 32'h234f00ff;
            rom_0030[1692] <= 32'h03500000;
            rom_0030[1693] <= 32'h235000ff;
            rom_0030[1694] <= 32'h03510000;
            rom_0030[1695] <= 32'h235100ff;
            rom_0030[1696] <= 32'h03520000;
            rom_0030[1697] <= 32'h235200ff;
            rom_0030[1698] <= 32'h03530000;
            rom_0030[1699] <= 32'h235300ff;
            rom_0030[1700] <= 32'h03540000;
            rom_0030[1701] <= 32'h235400ff;
            rom_0030[1702] <= 32'h03550000;
            rom_0030[1703] <= 32'h235500ff;
            rom_0030[1704] <= 32'h03560000;
            rom_0030[1705] <= 32'h235600ff;
            rom_0030[1706] <= 32'h03570000;
            rom_0030[1707] <= 32'h235700ff;
            rom_0030[1708] <= 32'h03580000;
            rom_0030[1709] <= 32'h235800ff;
            rom_0030[1710] <= 32'h03590000;
            rom_0030[1711] <= 32'h235900ff;
            rom_0030[1712] <= 32'h035a0000;
            rom_0030[1713] <= 32'h235a00ff;
            rom_0030[1714] <= 32'h035b0000;
            rom_0030[1715] <= 32'h235b00ff;
            rom_0030[1716] <= 32'h035c0000;
            rom_0030[1717] <= 32'h235c00ff;
            rom_0030[1718] <= 32'h035d0000;
            rom_0030[1719] <= 32'h235d00ff;
            rom_0030[1720] <= 32'h035e0000;
            rom_0030[1721] <= 32'h235e00ff;
            rom_0030[1722] <= 32'h035f0000;
            rom_0030[1723] <= 32'h235f00ff;
            rom_0030[1724] <= 32'h03600000;
            rom_0030[1725] <= 32'h236000ff;
            rom_0030[1726] <= 32'h03610000;
            rom_0030[1727] <= 32'h236100ff;
            rom_0030[1728] <= 32'h03620000;
            rom_0030[1729] <= 32'h236200ff;
            rom_0030[1730] <= 32'h03630000;
            rom_0030[1731] <= 32'h236300ff;
            rom_0030[1732] <= 32'h03640000;
            rom_0030[1733] <= 32'h236400ff;
            rom_0030[1734] <= 32'h03650000;
            rom_0030[1735] <= 32'h236500ff;
            rom_0030[1736] <= 32'h03660000;
            rom_0030[1737] <= 32'h236600ff;
            rom_0030[1738] <= 32'h03670000;
            rom_0030[1739] <= 32'h236700ff;
            rom_0030[1740] <= 32'h03680000;
            rom_0030[1741] <= 32'h236800ff;
            rom_0030[1742] <= 32'h03690000;
            rom_0030[1743] <= 32'h236900ff;
            rom_0030[1744] <= 32'h036a0000;
            rom_0030[1745] <= 32'h236a00ff;
            rom_0030[1746] <= 32'h036b0000;
            rom_0030[1747] <= 32'h236b00ff;
            rom_0030[1748] <= 32'h036c0000;
            rom_0030[1749] <= 32'h236c00ff;
            rom_0030[1750] <= 32'h036d0000;
            rom_0030[1751] <= 32'h236d00ff;
            rom_0030[1752] <= 32'h036e0000;
            rom_0030[1753] <= 32'h236e00ff;
            rom_0030[1754] <= 32'h036f0000;
            rom_0030[1755] <= 32'h236f00ff;
            rom_0030[1756] <= 32'h03700000;
            rom_0030[1757] <= 32'h237000ff;
            rom_0030[1758] <= 32'h03710000;
            rom_0030[1759] <= 32'h237100ff;
            rom_0030[1760] <= 32'h03720000;
            rom_0030[1761] <= 32'h237200ff;
            rom_0030[1762] <= 32'h03730000;
            rom_0030[1763] <= 32'h237300ff;
            rom_0030[1764] <= 32'h03740000;
            rom_0030[1765] <= 32'h237400ff;
            rom_0030[1766] <= 32'h03750000;
            rom_0030[1767] <= 32'h237500ff;
            rom_0030[1768] <= 32'h03760000;
            rom_0030[1769] <= 32'h237600ff;
            rom_0030[1770] <= 32'h03770000;
            rom_0030[1771] <= 32'h237700ff;
            rom_0030[1772] <= 32'h03780000;
            rom_0030[1773] <= 32'h237800ff;
            rom_0030[1774] <= 32'h03790000;
            rom_0030[1775] <= 32'h237900ff;
            rom_0030[1776] <= 32'h037a0000;
            rom_0030[1777] <= 32'h237a00ff;
            rom_0030[1778] <= 32'h037b0000;
            rom_0030[1779] <= 32'h237b00ff;
            rom_0030[1780] <= 32'h037c0000;
            rom_0030[1781] <= 32'h237c00ff;
            rom_0030[1782] <= 32'h037d0000;
            rom_0030[1783] <= 32'h237d00ff;
            rom_0030[1784] <= 32'h037e0000;
            rom_0030[1785] <= 32'h237e00ff;
            rom_0030[1786] <= 32'h037f0000;
            rom_0030[1787] <= 32'h237f00ff;
            rom_0030[1788] <= 32'h03800000;
            rom_0030[1789] <= 32'h238000ff;
            rom_0030[1790] <= 32'h03810000;
            rom_0030[1791] <= 32'h238100ff;
            rom_0030[1792] <= 32'h03820000;
            rom_0030[1793] <= 32'h238200ff;
            rom_0030[1794] <= 32'h03830000;
            rom_0030[1795] <= 32'h238300ff;
            rom_0030[1796] <= 32'h03840000;
            rom_0030[1797] <= 32'h238400ff;
            rom_0030[1798] <= 32'h03850000;
            rom_0030[1799] <= 32'h238500ff;
            rom_0030[1800] <= 32'h03860000;
            rom_0030[1801] <= 32'h238600ff;
            rom_0030[1802] <= 32'h03870000;
            rom_0030[1803] <= 32'h238700ff;
            rom_0030[1804] <= 32'h03880000;
            rom_0030[1805] <= 32'h238800ff;
            rom_0030[1806] <= 32'h03890000;
            rom_0030[1807] <= 32'h238900ff;
            rom_0030[1808] <= 32'h038a0000;
            rom_0030[1809] <= 32'h238a00ff;
            rom_0030[1810] <= 32'h038b0000;
            rom_0030[1811] <= 32'h238b00ff;
            rom_0030[1812] <= 32'h038c0000;
            rom_0030[1813] <= 32'h238c00ff;
            rom_0030[1814] <= 32'h038d0000;
            rom_0030[1815] <= 32'h238d00ff;
            rom_0030[1816] <= 32'h038e0000;
            rom_0030[1817] <= 32'h238e00ff;
            rom_0030[1818] <= 32'h038f0000;
            rom_0030[1819] <= 32'h238f00ff;
            rom_0030[1820] <= 32'h03900000;
            rom_0030[1821] <= 32'h239000ff;
            rom_0030[1822] <= 32'h03910000;
            rom_0030[1823] <= 32'h239100ff;
            rom_0030[1824] <= 32'h03920000;
            rom_0030[1825] <= 32'h239200ff;
            rom_0030[1826] <= 32'h03930000;
            rom_0030[1827] <= 32'h239300ff;
            rom_0030[1828] <= 32'h03940000;
            rom_0030[1829] <= 32'h239400ff;
            rom_0030[1830] <= 32'h03950000;
            rom_0030[1831] <= 32'h239500ff;
            rom_0030[1832] <= 32'h03960000;
            rom_0030[1833] <= 32'h239600ff;
            rom_0030[1834] <= 32'h03970000;
            rom_0030[1835] <= 32'h239700ff;
            rom_0030[1836] <= 32'h03980000;
            rom_0030[1837] <= 32'h239800ff;
            rom_0030[1838] <= 32'h03990000;
            rom_0030[1839] <= 32'h239900ff;
            rom_0030[1840] <= 32'h039a0000;
            rom_0030[1841] <= 32'h239a00ff;
            rom_0030[1842] <= 32'h039b0000;
            rom_0030[1843] <= 32'h239b00ff;
            rom_0030[1844] <= 32'h039c0000;
            rom_0030[1845] <= 32'h239c00ff;
            rom_0030[1846] <= 32'h039d0000;
            rom_0030[1847] <= 32'h239d00ff;
            rom_0030[1848] <= 32'h039e0000;
            rom_0030[1849] <= 32'h239e00ff;
            rom_0030[1850] <= 32'h039f0000;
            rom_0030[1851] <= 32'h239f00ff;
            rom_0030[1852] <= 32'h03a00000;
            rom_0030[1853] <= 32'h23a000ff;
            rom_0030[1854] <= 32'h03a10000;
            rom_0030[1855] <= 32'h23a100ff;
            rom_0030[1856] <= 32'h03a20000;
            rom_0030[1857] <= 32'h23a200ff;
            rom_0030[1858] <= 32'h03a30000;
            rom_0030[1859] <= 32'h23a300ff;
            rom_0030[1860] <= 32'h03a40000;
            rom_0030[1861] <= 32'h23a400ff;
            rom_0030[1862] <= 32'h03a50000;
            rom_0030[1863] <= 32'h23a500ff;
            rom_0030[1864] <= 32'h03a60000;
            rom_0030[1865] <= 32'h23a600ff;
            rom_0030[1866] <= 32'h03a70000;
            rom_0030[1867] <= 32'h23a700ff;
            rom_0030[1868] <= 32'h03a80000;
            rom_0030[1869] <= 32'h23a800ff;
            rom_0030[1870] <= 32'h03a90000;
            rom_0030[1871] <= 32'h23a900ff;
            rom_0030[1872] <= 32'h03aa0000;
            rom_0030[1873] <= 32'h23aa00ff;
            rom_0030[1874] <= 32'h03ab0000;
            rom_0030[1875] <= 32'h23ab00ff;
            rom_0030[1876] <= 32'h03ac0000;
            rom_0030[1877] <= 32'h23ac00ff;
            rom_0030[1878] <= 32'h03ad0000;
            rom_0030[1879] <= 32'h23ad00ff;
            rom_0030[1880] <= 32'h03ae0000;
            rom_0030[1881] <= 32'h23ae00ff;
            rom_0030[1882] <= 32'h03af0000;
            rom_0030[1883] <= 32'h23af00ff;
            rom_0030[1884] <= 32'h03b00000;
            rom_0030[1885] <= 32'h23b000ff;
            rom_0030[1886] <= 32'h03b10000;
            rom_0030[1887] <= 32'h23b100ff;
            rom_0030[1888] <= 32'h03b20000;
            rom_0030[1889] <= 32'h23b200ff;
            rom_0030[1890] <= 32'h03b30000;
            rom_0030[1891] <= 32'h23b300ff;
            rom_0030[1892] <= 32'h03b40000;
            rom_0030[1893] <= 32'h23b400ff;
            rom_0030[1894] <= 32'h03b50000;
            rom_0030[1895] <= 32'h23b500ff;
            rom_0030[1896] <= 32'h03b60000;
            rom_0030[1897] <= 32'h23b600ff;
            rom_0030[1898] <= 32'h03b70000;
            rom_0030[1899] <= 32'h23b700ff;
            rom_0030[1900] <= 32'h03b80000;
            rom_0030[1901] <= 32'h23b800ff;
            rom_0030[1902] <= 32'h03b90000;
            rom_0030[1903] <= 32'h23b900ff;
            rom_0030[1904] <= 32'h03ba0000;
            rom_0030[1905] <= 32'h23ba00ff;
            rom_0030[1906] <= 32'h03bb0000;
            rom_0030[1907] <= 32'h23bb00ff;
            rom_0030[1908] <= 32'h03bc0000;
            rom_0030[1909] <= 32'h23bc00ff;
            rom_0030[1910] <= 32'h03bd0000;
            rom_0030[1911] <= 32'h23bd00ff;
            rom_0030[1912] <= 32'h03be0000;
            rom_0030[1913] <= 32'h23be00ff;
            rom_0030[1914] <= 32'h03bf0000;
            rom_0030[1915] <= 32'h23bf00ff;
            rom_0030[1916] <= 32'h03c00000;
            rom_0030[1917] <= 32'h23c000ff;
            rom_0030[1918] <= 32'h03c10000;
            rom_0030[1919] <= 32'h23c100ff;
            rom_0030[1920] <= 32'h03c20000;
            rom_0030[1921] <= 32'h23c200ff;
            rom_0030[1922] <= 32'h03c30000;
            rom_0030[1923] <= 32'h23c300ff;
            rom_0030[1924] <= 32'h03c40000;
            rom_0030[1925] <= 32'h23c400ff;
            rom_0030[1926] <= 32'h03c50000;
            rom_0030[1927] <= 32'h23c500ff;
            rom_0030[1928] <= 32'h03c60000;
            rom_0030[1929] <= 32'h23c600ff;
            rom_0030[1930] <= 32'h03c70000;
            rom_0030[1931] <= 32'h23c700ff;
            rom_0030[1932] <= 32'h03c80000;
            rom_0030[1933] <= 32'h23c800ff;
            rom_0030[1934] <= 32'h03c90000;
            rom_0030[1935] <= 32'h23c900ff;
            rom_0030[1936] <= 32'h03ca0000;
            rom_0030[1937] <= 32'h23ca00ff;
            rom_0030[1938] <= 32'h03cb0000;
            rom_0030[1939] <= 32'h23cb00ff;
            rom_0030[1940] <= 32'h03cc0000;
            rom_0030[1941] <= 32'h23cc00ff;
            rom_0030[1942] <= 32'h03cd0000;
            rom_0030[1943] <= 32'h23cd00ff;
            rom_0030[1944] <= 32'h03ce0000;
            rom_0030[1945] <= 32'h23ce00ff;
            rom_0030[1946] <= 32'h03cf0000;
            rom_0030[1947] <= 32'h23cf00ff;
            rom_0030[1948] <= 32'h03d00000;
            rom_0030[1949] <= 32'h23d000ff;
            rom_0030[1950] <= 32'h03d10000;
            rom_0030[1951] <= 32'h23d100ff;
            rom_0030[1952] <= 32'h03d20000;
            rom_0030[1953] <= 32'h23d200ff;
            rom_0030[1954] <= 32'h03d30000;
            rom_0030[1955] <= 32'h23d300ff;
            rom_0030[1956] <= 32'h03d40000;
            rom_0030[1957] <= 32'h23d400ff;
            rom_0030[1958] <= 32'h03d50000;
            rom_0030[1959] <= 32'h23d500ff;
            rom_0030[1960] <= 32'h03d60000;
            rom_0030[1961] <= 32'h23d600ff;
            rom_0030[1962] <= 32'h03d70000;
            rom_0030[1963] <= 32'h23d700ff;
            rom_0030[1964] <= 32'h03d80000;
            rom_0030[1965] <= 32'h23d800ff;
            rom_0030[1966] <= 32'h03d90000;
            rom_0030[1967] <= 32'h23d900ff;
            rom_0030[1968] <= 32'h03da0000;
            rom_0030[1969] <= 32'h23da00ff;
            rom_0030[1970] <= 32'h03db0000;
            rom_0030[1971] <= 32'h23db00ff;
            rom_0030[1972] <= 32'h03dc0000;
            rom_0030[1973] <= 32'h23dc00ff;
            rom_0030[1974] <= 32'h03dd0000;
            rom_0030[1975] <= 32'h23dd00ff;
            rom_0030[1976] <= 32'h03de0000;
            rom_0030[1977] <= 32'h23de00ff;
            rom_0030[1978] <= 32'h03df0000;
            rom_0030[1979] <= 32'h23df00ff;
            rom_0030[1980] <= 32'h03e00000;
            rom_0030[1981] <= 32'h23e000ff;
            rom_0030[1982] <= 32'h03e10000;
            rom_0030[1983] <= 32'h23e100ff;
            rom_0030[1984] <= 32'h03e20000;
            rom_0030[1985] <= 32'h23e200ff;
            rom_0030[1986] <= 32'h03e30000;
            rom_0030[1987] <= 32'h23e300ff;
            rom_0030[1988] <= 32'h03e40000;
            rom_0030[1989] <= 32'h23e400ff;
            rom_0030[1990] <= 32'h03e50000;
            rom_0030[1991] <= 32'h23e500ff;
            rom_0030[1992] <= 32'h03e60000;
            rom_0030[1993] <= 32'h23e600ff;
            rom_0030[1994] <= 32'h03e70000;
            rom_0030[1995] <= 32'h23e700ff;
            rom_0030[1996] <= 32'h03e80000;
            rom_0030[1997] <= 32'h23e800ff;
            rom_0030[1998] <= 32'h03e90000;
            rom_0030[1999] <= 32'h23e900ff;
            rom_0030[2000] <= 32'h03ea0000;
            rom_0030[2001] <= 32'h23ea00ff;
            rom_0030[2002] <= 32'h03eb0000;
            rom_0030[2003] <= 32'h23eb00ff;
            rom_0030[2004] <= 32'h03ec0000;
            rom_0030[2005] <= 32'h23ec00ff;
            rom_0030[2006] <= 32'h03ed0000;
            rom_0030[2007] <= 32'h23ed00ff;
            rom_0030[2008] <= 32'h03ee0000;
            rom_0030[2009] <= 32'h23ee00ff;
            rom_0030[2010] <= 32'h03ef0000;
            rom_0030[2011] <= 32'h23ef00ff;
            rom_0030[2012] <= 32'h03f00000;
            rom_0030[2013] <= 32'h23f000ff;
            rom_0030[2014] <= 32'h03f10000;
            rom_0030[2015] <= 32'h23f100ff;
            rom_0030[2016] <= 32'h03f20000;
            rom_0030[2017] <= 32'h23f200ff;
            rom_0030[2018] <= 32'h03f30000;
            rom_0030[2019] <= 32'h23f300ff;
            rom_0030[2020] <= 32'h03f40000;
            rom_0030[2021] <= 32'h23f400ff;
            rom_0030[2022] <= 32'h03f50000;
            rom_0030[2023] <= 32'h23f500ff;
            rom_0030[2024] <= 32'h03f60000;
            rom_0030[2025] <= 32'h23f600ff;
            rom_0030[2026] <= 32'h03f70000;
            rom_0030[2027] <= 32'h23f700ff;
            rom_0030[2028] <= 32'h03f80000;
            rom_0030[2029] <= 32'h23f800ff;
            rom_0030[2030] <= 32'h03f90000;
            rom_0030[2031] <= 32'h23f900ff;
            rom_0030[2032] <= 32'h03fa0000;
            rom_0030[2033] <= 32'h23fa00ff;
            rom_0030[2034] <= 32'h03fb0000;
            rom_0030[2035] <= 32'h23fb00ff;
            rom_0030[2036] <= 32'h03fc0000;
            rom_0030[2037] <= 32'h23fc00ff;
            rom_0030[2038] <= 32'h03fd0000;
            rom_0030[2039] <= 32'h23fd00ff;
            rom_0030[2040] <= 32'h03fe0000;
            rom_0030[2041] <= 32'h23fe00ff;
            rom_0030[2042] <= 32'h03ff0000;
            rom_0030[2043] <= 32'h23ff00ff;
            rom_0030[2044] <= 32'h04000000;
            rom_0030[2045] <= 32'h240000ff;
            rom_0030[2046] <= 32'h04010000;
            rom_0030[2047] <= 32'h240100ff;
            rom_0030[2048] <= 32'h04020000;
            rom_0030[2049] <= 32'h240200ff;
            rom_0030[2050] <= 32'h04030000;
            rom_0030[2051] <= 32'h240300ff;
            rom_0030[2052] <= 32'h04040000;
            rom_0030[2053] <= 32'h240400ff;
            rom_0030[2054] <= 32'h04050000;
            rom_0030[2055] <= 32'h240500ff;
            rom_0030[2056] <= 32'h04060000;
            rom_0030[2057] <= 32'h240600ff;
            rom_0030[2058] <= 32'h04070000;
            rom_0030[2059] <= 32'h240700ff;
            rom_0030[2060] <= 32'h240800ff;
            rom_0030[2061] <= 32'h04090000;
            rom_0030[2062] <= 32'h240900ff;
            rom_0030[2063] <= 32'h040a0000;
            rom_0030[2064] <= 32'h240a00ff;
            rom_0030[2065] <= 32'h040b0000;
            rom_0030[2066] <= 32'h240b00ff;
            rom_0030[2067] <= 32'h040c0000;
            rom_0030[2068] <= 32'h240c00ff;
            rom_0030[2069] <= 32'h040d0000;
            rom_0030[2070] <= 32'h240d00ff;
            rom_0030[2071] <= 32'h040e0000;
            rom_0030[2072] <= 32'h240e00ff;
            rom_0030[2073] <= 32'h040f0000;
            rom_0030[2074] <= 32'h240f00ff;
            rom_0030[2075] <= 32'h04100000;
            rom_0030[2076] <= 32'h241000ff;
            rom_0030[2077] <= 32'h04110000;
            rom_0030[2078] <= 32'h241100ff;
            rom_0030[2079] <= 32'h04120000;
            rom_0030[2080] <= 32'h241200ff;
            rom_0030[2081] <= 32'h241300ff;
            rom_0030[2082] <= 32'h04140000;
            rom_0030[2083] <= 32'h241400ff;
            rom_0030[2084] <= 32'h04150000;
            rom_0030[2085] <= 32'h241500ff;
            rom_0030[2086] <= 32'h04160000;
            rom_0030[2087] <= 32'h241600ff;
            rom_0030[2088] <= 32'h04170000;
            rom_0030[2089] <= 32'h241700ff;
            rom_0030[2090] <= 32'h04180000;
            rom_0030[2091] <= 32'h241800ff;
            rom_0030[2092] <= 32'h04190000;
            rom_0030[2093] <= 32'h241900ff;
            rom_0030[2094] <= 32'h041a0000;
            rom_0030[2095] <= 32'h241a00ff;
            rom_0030[2096] <= 32'h041b0000;
            rom_0030[2097] <= 32'h241b00ff;
            rom_0030[2098] <= 32'h041c0000;
            rom_0030[2099] <= 32'h241c00ff;
            rom_0030[2100] <= 32'h041d0000;
            rom_0030[2101] <= 32'h241d00ff;
            rom_0030[2102] <= 32'h041e0000;
            rom_0030[2103] <= 32'h241e00ff;
            rom_0030[2104] <= 32'h041f0000;
            rom_0030[2105] <= 32'h241f00ff;
            rom_0030[2106] <= 32'h04200000;
            rom_0030[2107] <= 32'h242000ff;
            rom_0030[2108] <= 32'h04210000;
            rom_0030[2109] <= 32'h242100ff;
            rom_0030[2110] <= 32'h04220000;
            rom_0030[2111] <= 32'h242200ff;
            rom_0030[2112] <= 32'h04230000;
            rom_0030[2113] <= 32'h242300ff;
            rom_0030[2114] <= 32'h04240000;
            rom_0030[2115] <= 32'h242400ff;
            rom_0030[2116] <= 32'h04250000;
            rom_0030[2117] <= 32'h242500ff;
            rom_0030[2118] <= 32'h04260000;
            rom_0030[2119] <= 32'h242600ff;
            rom_0030[2120] <= 32'h04270000;
            rom_0030[2121] <= 32'h242700ff;
            rom_0030[2122] <= 32'h04280000;
            rom_0030[2123] <= 32'h242800ff;
            rom_0030[2124] <= 32'h04290000;
            rom_0030[2125] <= 32'h242900ff;
            rom_0030[2126] <= 32'h042a0000;
            rom_0030[2127] <= 32'h242a00ff;
            rom_0030[2128] <= 32'h242b00ff;
            rom_0030[2129] <= 32'h042c0000;
            rom_0030[2130] <= 32'h242c00ff;
            rom_0030[2131] <= 32'h242d00ff;
            rom_0030[2132] <= 32'h042e0000;
            rom_0030[2133] <= 32'h242e00ff;
            rom_0030[2134] <= 32'h242f00ff;
            rom_0030[2135] <= 32'h04300000;
            rom_0030[2136] <= 32'h243000ff;
            rom_0030[2137] <= 32'h04310000;
            rom_0030[2138] <= 32'h243100ff;
            rom_0030[2139] <= 32'h04320000;
            rom_0030[2140] <= 32'h243200ff;
            rom_0030[2141] <= 32'h04330000;
            rom_0030[2142] <= 32'h243300ff;
            rom_0030[2143] <= 32'h04340000;
            rom_0030[2144] <= 32'h243400ff;
            rom_0030[2145] <= 32'h04350000;
            rom_0030[2146] <= 32'h243500ff;
            rom_0030[2147] <= 32'h04360000;
            rom_0030[2148] <= 32'h243600ff;
            rom_0030[2149] <= 32'h04370000;
            rom_0030[2150] <= 32'h243700ff;
            rom_0030[2151] <= 32'h04380000;
            rom_0030[2152] <= 32'h243800ff;
            rom_0030[2153] <= 32'h04390000;
            rom_0030[2154] <= 32'h243900ff;
            rom_0030[2155] <= 32'h043a0000;
            rom_0030[2156] <= 32'h243a00ff;
            rom_0030[2157] <= 32'h043b0000;
            rom_0030[2158] <= 32'h243b00ff;
            rom_0030[2159] <= 32'h043c0000;
            rom_0030[2160] <= 32'h243c00ff;
            rom_0030[2161] <= 32'h043d0000;
            rom_0030[2162] <= 32'h243d00ff;
            rom_0030[2163] <= 32'h043e0000;
            rom_0030[2164] <= 32'h243e00ff;
            rom_0030[2165] <= 32'h043f0000;
            rom_0030[2166] <= 32'h243f00ff;
            rom_0030[2167] <= 32'h04400000;
            rom_0030[2168] <= 32'h244000ff;
            rom_0030[2169] <= 32'h04410000;
            rom_0030[2170] <= 32'h244100ff;
            rom_0030[2171] <= 32'h04420000;
            rom_0030[2172] <= 32'h244200ff;
            rom_0030[2173] <= 32'h04430000;
            rom_0030[2174] <= 32'h244300ff;
            rom_0030[2175] <= 32'h04440000;
            rom_0030[2176] <= 32'h244400ff;
            rom_0030[2177] <= 32'h04450000;
            rom_0030[2178] <= 32'h244500ff;
            rom_0030[2179] <= 32'h04460000;
            rom_0030[2180] <= 32'h244600ff;
            rom_0030[2181] <= 32'h04470000;
            rom_0030[2182] <= 32'h244700ff;
            rom_0030[2183] <= 32'h04480000;
            rom_0030[2184] <= 32'h244800ff;
            rom_0030[2185] <= 32'h04490000;
            rom_0030[2186] <= 32'h244900ff;
            rom_0030[2187] <= 32'h044a0000;
            rom_0030[2188] <= 32'h244a00ff;
            rom_0030[2189] <= 32'h044b0000;
            rom_0030[2190] <= 32'h244b00ff;
            rom_0030[2191] <= 32'h044c0000;
            rom_0030[2192] <= 32'h244c00ff;
            rom_0030[2193] <= 32'h044d0000;
            rom_0030[2194] <= 32'h244d00ff;
            rom_0030[2195] <= 32'h044e0000;
            rom_0030[2196] <= 32'h244e00ff;
            rom_0030[2197] <= 32'h044f0000;
            rom_0030[2198] <= 32'h244f00ff;
            rom_0030[2199] <= 32'h04500000;
            rom_0030[2200] <= 32'h245000ff;
            rom_0030[2201] <= 32'h04510000;
            rom_0030[2202] <= 32'h245100ff;
            rom_0030[2203] <= 32'h04520000;
            rom_0030[2204] <= 32'h245200ff;
            rom_0030[2205] <= 32'h04530000;
            rom_0030[2206] <= 32'h245300ff;
            rom_0030[2207] <= 32'h04540000;
            rom_0030[2208] <= 32'h245400ff;
            rom_0030[2209] <= 32'h04550000;
            rom_0030[2210] <= 32'h245500ff;
            rom_0030[2211] <= 32'h04560000;
            rom_0030[2212] <= 32'h245600ff;
            rom_0030[2213] <= 32'h04570000;
            rom_0030[2214] <= 32'h245700ff;
            rom_0030[2215] <= 32'h04580000;
            rom_0030[2216] <= 32'h245800ff;
            rom_0030[2217] <= 32'h04590000;
            rom_0030[2218] <= 32'h245900ff;
            rom_0030[2219] <= 32'h045a0000;
            rom_0030[2220] <= 32'h245a00ff;
            rom_0030[2221] <= 32'h045b0000;
            rom_0030[2222] <= 32'h245b00ff;
            rom_0030[2223] <= 32'h045c0000;
            rom_0030[2224] <= 32'h245c00ff;
            rom_0030[2225] <= 32'h045d0000;
            rom_0030[2226] <= 32'h245d00ff;
            rom_0030[2227] <= 32'h045e0000;
            rom_0030[2228] <= 32'h245e00ff;
            rom_0030[2229] <= 32'h045f0000;
            rom_0030[2230] <= 32'h245f00ff;
            rom_0030[2231] <= 32'h04600000;
            rom_0030[2232] <= 32'h246000ff;
            rom_0030[2233] <= 32'h04610000;
            rom_0030[2234] <= 32'h246100ff;
            rom_0030[2235] <= 32'h04620000;
            rom_0030[2236] <= 32'h246200ff;
            rom_0030[2237] <= 32'h04630000;
            rom_0030[2238] <= 32'h246300ff;
            rom_0030[2239] <= 32'h04640000;
            rom_0030[2240] <= 32'h246400ff;
            rom_0030[2241] <= 32'h04650000;
            rom_0030[2242] <= 32'h246500ff;
            rom_0030[2243] <= 32'h04660000;
            rom_0030[2244] <= 32'h246600ff;
            rom_0030[2245] <= 32'h04670000;
            rom_0030[2246] <= 32'h246700ff;
            rom_0030[2247] <= 32'h04680000;
            rom_0030[2248] <= 32'h246800ff;
            rom_0030[2249] <= 32'h04690000;
            rom_0030[2250] <= 32'h246900ff;
            rom_0030[2251] <= 32'h046a0000;
            rom_0030[2252] <= 32'h246a00ff;
            rom_0030[2253] <= 32'h046b0000;
            rom_0030[2254] <= 32'h246b00ff;
            rom_0030[2255] <= 32'h046c0000;
            rom_0030[2256] <= 32'h246c00ff;
            rom_0030[2257] <= 32'h046d0000;
            rom_0030[2258] <= 32'h246d00ff;
            rom_0030[2259] <= 32'h046e0000;
            rom_0030[2260] <= 32'h246e00ff;
            rom_0030[2261] <= 32'h046f0000;
            rom_0030[2262] <= 32'h246f00ff;
            rom_0030[2263] <= 32'h04700000;
            rom_0030[2264] <= 32'h247000ff;
            rom_0030[2265] <= 32'h04710000;
            rom_0030[2266] <= 32'h247100ff;
            rom_0030[2267] <= 32'h04720000;
            rom_0030[2268] <= 32'h247200ff;
            rom_0030[2269] <= 32'h04730000;
            rom_0030[2270] <= 32'h247300ff;
            rom_0030[2271] <= 32'h04740000;
            rom_0030[2272] <= 32'h247400ff;
            rom_0030[2273] <= 32'h04750000;
            rom_0030[2274] <= 32'h247500ff;
            rom_0030[2275] <= 32'h04760000;
            rom_0030[2276] <= 32'h247600ff;
            rom_0030[2277] <= 32'h04770000;
            rom_0030[2278] <= 32'h247700ff;
            rom_0030[2279] <= 32'h04780000;
            rom_0030[2280] <= 32'h247800ff;
            rom_0030[2281] <= 32'h04790000;
            rom_0030[2282] <= 32'h247900ff;
            rom_0030[2283] <= 32'h047a0000;
            rom_0030[2284] <= 32'h247a00ff;
            rom_0030[2285] <= 32'h047b0000;
            rom_0030[2286] <= 32'h247b00ff;
            rom_0030[2287] <= 32'h047c0000;
            rom_0030[2288] <= 32'h247c00ff;
            rom_0030[2289] <= 32'h047d0000;
            rom_0030[2290] <= 32'h247d00ff;
            rom_0030[2291] <= 32'h047e0000;
            rom_0030[2292] <= 32'h247e00ff;
            rom_0030[2293] <= 32'h047f0000;
            rom_0030[2294] <= 32'h247f00ff;
            rom_0030[2295] <= 32'h04800000;
            rom_0030[2296] <= 32'h248000ff;
            rom_0030[2297] <= 32'h04810000;
            rom_0030[2298] <= 32'h248100ff;
            rom_0030[2299] <= 32'h04820000;
            rom_0030[2300] <= 32'h248200ff;
            rom_0030[2301] <= 32'h04830000;
            rom_0030[2302] <= 32'h248300ff;
            rom_0030[2303] <= 32'h04840000;
            rom_0030[2304] <= 32'h248400ff;
            rom_0030[2305] <= 32'h04850000;
            rom_0030[2306] <= 32'h248500ff;
            rom_0030[2307] <= 32'h04860000;
            rom_0030[2308] <= 32'h248600ff;
            rom_0030[2309] <= 32'h04870000;
            rom_0030[2310] <= 32'h248700ff;
            rom_0030[2311] <= 32'h04880000;
            rom_0030[2312] <= 32'h248800ff;
            rom_0030[2313] <= 32'h04890000;
            rom_0030[2314] <= 32'h248900ff;
            rom_0030[2315] <= 32'h048a0000;
            rom_0030[2316] <= 32'h248a00ff;
            rom_0030[2317] <= 32'h048b0000;
            rom_0030[2318] <= 32'h248b00ff;
            rom_0030[2319] <= 32'h048c0000;
            rom_0030[2320] <= 32'h248c00ff;
            rom_0030[2321] <= 32'h048d0000;
            rom_0030[2322] <= 32'h248d00ff;
            rom_0030[2323] <= 32'h048e0000;
            rom_0030[2324] <= 32'h248e00ff;
            rom_0030[2325] <= 32'h048f0000;
            rom_0030[2326] <= 32'h248f00ff;
            rom_0030[2327] <= 32'h04900000;
            rom_0030[2328] <= 32'h249000ff;
            rom_0030[2329] <= 32'h04910000;
            rom_0030[2330] <= 32'h249100ff;
            rom_0030[2331] <= 32'h04920000;
            rom_0030[2332] <= 32'h249200ff;
            rom_0030[2333] <= 32'h04930000;
            rom_0030[2334] <= 32'h249300ff;
            rom_0030[2335] <= 32'h04940000;
            rom_0030[2336] <= 32'h249400ff;
            rom_0030[2337] <= 32'h04950000;
            rom_0030[2338] <= 32'h249500ff;
            rom_0030[2339] <= 32'h04960000;
            rom_0030[2340] <= 32'h249600ff;
            rom_0030[2341] <= 32'h04970000;
            rom_0030[2342] <= 32'h249700ff;
            rom_0030[2343] <= 32'h04980000;
            rom_0030[2344] <= 32'h249800ff;
            rom_0030[2345] <= 32'h04990000;
            rom_0030[2346] <= 32'h249900ff;
            rom_0030[2347] <= 32'h049a0000;
            rom_0030[2348] <= 32'h249a00ff;
            rom_0030[2349] <= 32'h049b0000;
            rom_0030[2350] <= 32'h249b00ff;
            rom_0030[2351] <= 32'h049c0000;
            rom_0030[2352] <= 32'h249c00ff;
            rom_0030[2353] <= 32'h049d0000;
            rom_0030[2354] <= 32'h249d00ff;
            rom_0030[2355] <= 32'h049e0000;
            rom_0030[2356] <= 32'h249e00ff;
            rom_0030[2357] <= 32'h049f0000;
            rom_0030[2358] <= 32'h249f00ff;
            rom_0030[2359] <= 32'h04a00000;
            rom_0030[2360] <= 32'h24a000ff;
            rom_0030[2361] <= 32'h04a10000;
            rom_0030[2362] <= 32'h24a100ff;
            rom_0030[2363] <= 32'h04a20000;
            rom_0030[2364] <= 32'h24a200ff;
            rom_0030[2365] <= 32'h04a30000;
            rom_0030[2366] <= 32'h24a300ff;
            rom_0030[2367] <= 32'h04a40000;
            rom_0030[2368] <= 32'h24a400ff;
            rom_0030[2369] <= 32'h04a50000;
            rom_0030[2370] <= 32'h24a500ff;
            rom_0030[2371] <= 32'h04a60000;
            rom_0030[2372] <= 32'h24a600ff;
            rom_0030[2373] <= 32'h04a70000;
            rom_0030[2374] <= 32'h24a700ff;
            rom_0030[2375] <= 32'h04a80000;
            rom_0030[2376] <= 32'h24a800ff;
            rom_0030[2377] <= 32'h04a90000;
            rom_0030[2378] <= 32'h24a900ff;
            rom_0030[2379] <= 32'h04aa0000;
            rom_0030[2380] <= 32'h24aa00ff;
            rom_0030[2381] <= 32'h04ab0000;
            rom_0030[2382] <= 32'h24ab00ff;
            rom_0030[2383] <= 32'h04ac0000;
            rom_0030[2384] <= 32'h24ac00ff;
            rom_0030[2385] <= 32'h04ad0000;
            rom_0030[2386] <= 32'h24ad00ff;
            rom_0030[2387] <= 32'h04ae0000;
            rom_0030[2388] <= 32'h24ae00ff;
            rom_0030[2389] <= 32'h04af0000;
            rom_0030[2390] <= 32'h24af00ff;
            rom_0030[2391] <= 32'h04b00000;
            rom_0030[2392] <= 32'h24b000ff;
            rom_0030[2393] <= 32'h04b10000;
            rom_0030[2394] <= 32'h24b100ff;
            rom_0030[2395] <= 32'h04b20000;
            rom_0030[2396] <= 32'h24b200ff;
            rom_0030[2397] <= 32'h04b30000;
            rom_0030[2398] <= 32'h24b300ff;
            rom_0030[2399] <= 32'h04b40000;
            rom_0030[2400] <= 32'h24b400ff;
            rom_0030[2401] <= 32'h04b50000;
            rom_0030[2402] <= 32'h24b500ff;
            rom_0030[2403] <= 32'h04b60000;
            rom_0030[2404] <= 32'h24b600ff;
            rom_0030[2405] <= 32'h04b70000;
            rom_0030[2406] <= 32'h24b700ff;
            rom_0030[2407] <= 32'h04b80000;
            rom_0030[2408] <= 32'h24b800ff;
            rom_0030[2409] <= 32'h04b90000;
            rom_0030[2410] <= 32'h24b900ff;
            rom_0030[2411] <= 32'h04ba0000;
            rom_0030[2412] <= 32'h24ba00ff;
            rom_0030[2413] <= 32'h04bb0000;
            rom_0030[2414] <= 32'h24bb00ff;
            rom_0030[2415] <= 32'h04bc0000;
            rom_0030[2416] <= 32'h24bc00ff;
            rom_0030[2417] <= 32'h04bd0000;
            rom_0030[2418] <= 32'h24bd00ff;
            rom_0030[2419] <= 32'h04be0000;
            rom_0030[2420] <= 32'h24be00ff;
            rom_0030[2421] <= 32'h04bf0000;
            rom_0030[2422] <= 32'h24bf00ff;
            rom_0030[2423] <= 32'h05800000;
            rom_0030[2424] <= 32'h258000ff;
            rom_0030[2425] <= 32'h05810000;
            rom_0030[2426] <= 32'h258100ff;
            rom_0030[2427] <= 32'h05820000;
            rom_0030[2428] <= 32'h258200ff;
            rom_0030[2429] <= 32'h05830000;
            rom_0030[2430] <= 32'h258300ff;
            rom_0030[2431] <= 32'h05840000;
            rom_0030[2432] <= 32'h258400ff;
            rom_0030[2433] <= 32'h05850000;
            rom_0030[2434] <= 32'h258500ff;
            rom_0030[2435] <= 32'h05860000;
            rom_0030[2436] <= 32'h258600ff;
            rom_0030[2437] <= 32'h05870000;
            rom_0030[2438] <= 32'h258700ff;
            rom_0030[2439] <= 32'h05880000;
            rom_0030[2440] <= 32'h258800ff;
            rom_0030[2441] <= 32'h05890000;
            rom_0030[2442] <= 32'h258900ff;
            rom_0030[2443] <= 32'h058a0000;
            rom_0030[2444] <= 32'h258a00ff;
            rom_0030[2445] <= 32'h058b0000;
            rom_0030[2446] <= 32'h258b00ff;
            rom_0030[2447] <= 32'h058c0000;
            rom_0030[2448] <= 32'h258c00ff;
            rom_0030[2449] <= 32'h058d0000;
            rom_0030[2450] <= 32'h258d0011;
            rom_0030[2451] <= 32'h058e0000;
            rom_0030[2452] <= 32'h258e0021;
            rom_0030[2453] <= 32'h058f0000;
            rom_0030[2454] <= 32'h258f0011;
            rom_0030[2455] <= 32'h05900000;
            rom_0030[2456] <= 32'h25900001;
            rom_0030[2457] <= 32'h05910000;
            rom_0030[2458] <= 32'h259100ff;
            rom_0030[2459] <= 32'h05920000;
            rom_0030[2460] <= 32'h259200ff;
            rom_0030[2461] <= 32'h05930000;
            rom_0030[2462] <= 32'h259300ff;
            rom_0030[2463] <= 32'h05940000;
            rom_0030[2464] <= 32'h259400ff;
            rom_0030[2465] <= 32'h05950000;
            rom_0030[2466] <= 32'h259500ff;
            rom_0030[2467] <= 32'h05960000;
            rom_0030[2468] <= 32'h259600ff;
            rom_0030[2469] <= 32'h05970000;
            rom_0030[2470] <= 32'h259700ff;
            rom_0030[2471] <= 32'h05980000;
            rom_0030[2472] <= 32'h259800ff;
            rom_0030[2473] <= 32'h05990000;
            rom_0030[2474] <= 32'h259900ff;
            rom_0030[2475] <= 32'h059a0000;
            rom_0030[2476] <= 32'h259a00ff;
            rom_0030[2477] <= 32'h059b0000;
            rom_0030[2478] <= 32'h259b00ff;
            rom_0030[2479] <= 32'h059c0000;
            rom_0030[2480] <= 32'h259c00ff;
            rom_0030[2481] <= 32'h059d0000;
            rom_0030[2482] <= 32'h259d00ff;
            rom_0030[2483] <= 32'h059e0000;
            rom_0030[2484] <= 32'h259e00ff;
            rom_0030[2485] <= 32'h059f0000;
            rom_0030[2486] <= 32'h259f00ff;
            rom_0030[2487] <= 32'h05a00000;
            rom_0030[2488] <= 32'h25a000ff;
            rom_0030[2489] <= 32'h05a10000;
            rom_0030[2490] <= 32'h25a100ff;
            rom_0030[2491] <= 32'h05a20000;
            rom_0030[2492] <= 32'h25a200ff;
            rom_0030[2493] <= 32'h05a30000;
            rom_0030[2494] <= 32'h25a300ff;
            rom_0030[2495] <= 32'h05a40000;
            rom_0030[2496] <= 32'h25a40006;
            rom_0030[2497] <= 32'h05a50000;
            rom_0030[2498] <= 32'h25a50003;
            rom_0030[2499] <= 32'h05a60000;
            rom_0030[2500] <= 32'h25a60004;
            rom_0030[2501] <= 32'h05a70000;
            rom_0030[2502] <= 32'h25a70001;
            rom_0030[2503] <= 32'h05a80000;
            rom_0030[2504] <= 32'h25a80002;
            rom_0030[2505] <= 32'h05a90000;
            rom_0030[2506] <= 32'h25a90000;
            rom_0030[2507] <= 32'h05aa0000;
            rom_0030[2508] <= 32'h25aa0004;
            rom_0030[2509] <= 32'h05ab0000;
            rom_0030[2510] <= 32'h25ab0004;
            rom_0030[2511] <= 32'h05ac0000;
            rom_0030[2512] <= 32'h25ac00ff;
            rom_0030[2513] <= 32'h05ad0000;
            rom_0030[2514] <= 32'h25ad00ff;
            rom_0030[2515] <= 32'h05ae0000;
            rom_0030[2516] <= 32'h25ae00ff;
            rom_0030[2517] <= 32'h05af0000;
            rom_0030[2518] <= 32'h25af00ff;
            rom_0030[2519] <= 32'h05b00000;
            rom_0030[2520] <= 32'h25b000ff;
            rom_0030[2521] <= 32'h05b10000;
            rom_0030[2522] <= 32'h25b100ff;
            rom_0030[2523] <= 32'h05b20000;
            rom_0030[2524] <= 32'h25b200ff;
            rom_0030[2525] <= 32'h05b30000;
            rom_0030[2526] <= 32'h25b300ff;
            rom_0030[2527] <= 32'h05b40000;
            rom_0030[2528] <= 32'h25b400ff;
            rom_0030[2529] <= 32'h05b50000;
            rom_0030[2530] <= 32'h25b500ff;
            rom_0030[2531] <= 32'h05b60000;
            rom_0030[2532] <= 32'h25b600ff;
            rom_0030[2533] <= 32'h05b70000;
            rom_0030[2534] <= 32'h25b700ff;
            rom_0030[2535] <= 32'h05b80000;
            rom_0030[2536] <= 32'h25b80001;
            rom_0030[2537] <= 32'h05b90000;
            rom_0030[2538] <= 32'h25b90021;
            rom_0030[2539] <= 32'h05ba0000;
            rom_0030[2540] <= 32'h25ba0011;
            rom_0030[2541] <= 32'h05bb0000;
            rom_0030[2542] <= 32'h25bb0000;
            rom_0030[2543] <= 32'h05bc0000;
            rom_0030[2544] <= 32'h25bc00ff;
            rom_0030[2545] <= 32'h05bd0000;
            rom_0030[2546] <= 32'h25bd00ff;
            rom_0030[2547] <= 32'h05be0000;
            rom_0030[2548] <= 32'h25be00ff;
            rom_0030[2549] <= 32'h05bf0000;
            rom_0030[2550] <= 32'h25bf00ff;
            rom_0030[2551] <= 32'h05c00000;
            rom_0030[2552] <= 32'h25c000ff;
            rom_0030[2553] <= 32'h05c10000;
            rom_0030[2554] <= 32'h25c100ff;
            rom_0030[2555] <= 32'h05c20000;
            rom_0030[2556] <= 32'h25c200ff;
            rom_0030[2557] <= 32'h05c30000;
            rom_0030[2558] <= 32'h25c300ff;
            rom_0030[2559] <= 32'h05c40000;
            rom_0030[2560] <= 32'h25c400ff;
            rom_0030[2561] <= 32'h05c50000;
            rom_0030[2562] <= 32'h25c500ff;
            rom_0030[2563] <= 32'h05c60000;
            rom_0030[2564] <= 32'h25c600ff;
            rom_0030[2565] <= 32'h05c70000;
            rom_0030[2566] <= 32'h25c700ff;
            rom_0030[2567] <= 32'h05c80000;
            rom_0030[2568] <= 32'h25c800ff;
            rom_0030[2569] <= 32'h05c90000;
            rom_0030[2570] <= 32'h25c900ff;
            rom_0030[2571] <= 32'h05ca0000;
            rom_0030[2572] <= 32'h25ca00ff;
            rom_0030[2573] <= 32'h05cb0000;
            rom_0030[2574] <= 32'h25cb00ff;
            rom_0030[2575] <= 32'h05cc0000;
            rom_0030[2576] <= 32'h25cc00ff;
            rom_0030[2577] <= 32'h05cd0000;
            rom_0030[2578] <= 32'h25cd00ff;
            rom_0030[2579] <= 32'h05ce0000;
            rom_0030[2580] <= 32'h25ce00ff;
            rom_0030[2581] <= 32'h05cf0000;
            rom_0030[2582] <= 32'h25cf0006;
            rom_0030[2583] <= 32'h05d00000;
            rom_0030[2584] <= 32'h25d00004;
            rom_0030[2585] <= 32'h05d10000;
            rom_0030[2586] <= 32'h25d10004;
            rom_0030[2587] <= 32'h05d20000;
            rom_0030[2588] <= 32'h25d20005;
            rom_0030[2589] <= 32'h05d30000;
            rom_0030[2590] <= 32'h25d30005;
            rom_0030[2591] <= 32'h05d40000;
            rom_0030[2592] <= 32'h25d40006;
            rom_0030[2593] <= 32'h05d50000;
            rom_0030[2594] <= 32'h25d50001;
            rom_0030[2595] <= 32'h05d60000;
            rom_0030[2596] <= 32'h25d60001;
            rom_0030[2597] <= 32'h05d70000;
            rom_0030[2598] <= 32'h25d700ff;
            rom_0030[2599] <= 32'h05d80000;
            rom_0030[2600] <= 32'h25d800ff;
            rom_0030[2601] <= 32'h05d90000;
            rom_0030[2602] <= 32'h25d900ff;
            rom_0030[2603] <= 32'h05da0000;
            rom_0030[2604] <= 32'h25da00ff;
            rom_0030[2605] <= 32'h05db0000;
            rom_0030[2606] <= 32'h25db0023;
            rom_0030[2607] <= 32'h05dc0000;
            rom_0030[2608] <= 32'h25dc0025;
            rom_0030[2609] <= 32'h05dd0000;
            rom_0030[2610] <= 32'h25dd00ff;
            rom_0030[2611] <= 32'h05de0000;
            rom_0030[2612] <= 32'h25de0023;
            rom_0030[2613] <= 32'h05df0000;
            rom_0030[2614] <= 32'h25df0023;
            rom_0030[2615] <= 32'h05e00000;
            rom_0030[2616] <= 32'h25e000ff;
            rom_0030[2617] <= 32'h05e10000;
            rom_0030[2618] <= 32'h25e100ff;
            rom_0030[2619] <= 32'h05e20000;
            rom_0030[2620] <= 32'h25e200f8;
            rom_0030[2621] <= 32'h05e30000;
            rom_0030[2622] <= 32'h25e300cc;
            rom_0030[2623] <= 32'h05e40000;
            rom_0030[2624] <= 32'h25e4000b;
            rom_0030[2625] <= 32'h05e50000;
            rom_0030[2626] <= 32'h25e50011;
            rom_0030[2627] <= 32'h05e60000;
            rom_0030[2628] <= 32'h25e600f5;
            rom_0030[2629] <= 32'h05e70000;
            rom_0030[2630] <= 32'h25e70036;
            rom_0030[2631] <= 32'h05e80000;
            rom_0030[2632] <= 32'h25e800ff;
            rom_0030[2633] <= 32'h05e90000;
            rom_0030[2634] <= 32'h25e900ff;
            rom_0030[2635] <= 32'h05ea0000;
            rom_0030[2636] <= 32'h25ea00ff;
            rom_0030[2637] <= 32'h05eb0000;
            rom_0030[2638] <= 32'h25eb00ff;
            rom_0030[2639] <= 32'h05ec0000;
            rom_0030[2640] <= 32'h25ec00ff;
            rom_0030[2641] <= 32'h05ed0000;
            rom_0030[2642] <= 32'h25ed00ff;
            rom_0030[2643] <= 32'h05ee0000;
            rom_0030[2644] <= 32'h25ee00ff;
            rom_0030[2645] <= 32'h05ef0000;
            rom_0030[2646] <= 32'h25ef00ff;
            rom_0030[2647] <= 32'h05f00000;
            rom_0030[2648] <= 32'h25f000ff;
            rom_0030[2649] <= 32'h05f10000;
            rom_0030[2650] <= 32'h25f100ff;
            rom_0030[2651] <= 32'h05f20000;
            rom_0030[2652] <= 32'h25f200ff;
            rom_0030[2653] <= 32'h05f30000;
            rom_0030[2654] <= 32'h25f300ff;
            rom_0030[2655] <= 32'h05f40000;
            rom_0030[2656] <= 32'h25f400ff;
            rom_0030[2657] <= 32'h05f50000;
            rom_0030[2658] <= 32'h25f500ff;
            rom_0030[2659] <= 32'h05f60000;
            rom_0030[2660] <= 32'h25f600af;
            rom_0030[2661] <= 32'h05f70000;
            rom_0030[2662] <= 32'h25f700ff;
            rom_0030[2663] <= 32'h05f80000;
            rom_0030[2664] <= 32'h25f800f4;
            rom_0030[2665] <= 32'h05f90000;
            rom_0030[2666] <= 32'h25f900ff;
            rom_0030[2667] <= 32'h05fa0000;
            rom_0030[2668] <= 32'h25fa00ae;
            rom_0030[2669] <= 32'h05fb0000;
            rom_0030[2670] <= 32'h25fb00ff;
            rom_0030[2671] <= 32'h05fc0000;
            rom_0030[2672] <= 32'h25fc00aa;
            rom_0030[2673] <= 32'h05fd0000;
            rom_0030[2674] <= 32'h25fd00ff;
            rom_0030[2675] <= 32'h05fe0000;
            rom_0030[2676] <= 32'h25fe000c;
            rom_0030[2677] <= 32'h05ff0000;
            rom_0030[2678] <= 32'h25ff0000;

            // 0x8160
            rom_8160[0] <= 32'h00000000;
            rom_8160[1] <= 32'h00000000;
            rom_8160[2] <= 32'h00000000;
            rom_8160[3] <= 32'h00000000;
            rom_8160[4] <= 32'h00000000;

            // 0x01f4
            rom_01f4[0] <= 32'h00000000;
            rom_01f4[1] <= 32'h00000100;
            rom_01f4[2] <= 32'h00000000;
            rom_01f4[3] <= 32'h00000100;
            rom_01f4[4] <= 32'h00001100;
            rom_01f4[5] <= 32'h00001200;
            rom_01f4[6] <= 32'h00002200;
            rom_01f4[7] <= 32'h00002300;
            rom_01f4[8] <= 32'h00003300;
            rom_01f4[9] <= 32'h00003400;

            // 0x8164
            rom_8164[0] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[1] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[2] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[3] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[4] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[5] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[6] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[7] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[8] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[9] <= 32'h00000001; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[10] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[11] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[12] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[13] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[14] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[15] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[16] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[17] <= 32'h00000001; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[18] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[19] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[20] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[21] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[22] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[23] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[24] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[25] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[26] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[27] <= 32'h00000001; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[28] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[29] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[30] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[31] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[32] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[33] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[34] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[35] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[36] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[37] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[38] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[39] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[40] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[41] <= 32'h00000001; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[42] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[43] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[44] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[45] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[46] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[47] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[48] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[49] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[50] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[51] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[52] <= 32'h00000000; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]
            rom_8164[53] <= 32'h00000001; // recognize_intrs+0x28/0xe0 [rtw89pci] // napi_poll+0xd5/0x160 [rtw89pci] // recognize_intrs+0xaf/0xe0 [rtw89pci] // disable_intr+0x21/0x60 [rtw89pci] // enable_intr+0x29/0x70 [rtw89pci]

            // 0x8150
            rom_8150[0] <= 32'h06020303; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_8150[1] <= 32'h00000204; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_8150[2] <= 32'hffff0204; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_8150[3] <= 32'h00000204; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_8150[4] <= 32'hffff0204; // napi_poll+0x14d/0x160 [rtw89pci]

            // 0x8154
            rom_8154[0] <= 32'h0f030302;
            rom_8154[1] <= 32'h00000010;
            rom_8154[2] <= 32'h00000010;
            rom_8154[3] <= 32'h00000010;
            rom_8154[4] <= 32'h00000010;

            // 0x8158
            rom_8158[0] <= 32'h0000000f;
            rom_8158[1] <= 32'h00000000;
            rom_8158[2] <= 32'h00000000;
            rom_8158[3] <= 32'h00000000;
            rom_8158[4] <= 32'h00000000;

            // 0x815C
            rom_815C[0] <= 32'h00000000;
            rom_815C[1] <= 32'h00000000;
            rom_815C[2] <= 32'h00000000;
            rom_815C[3] <= 32'h00000000;
            rom_815C[4] <= 32'h00000000;

            // 0x02f0
            rom_02f0[0] <= 32'h00000000;
            rom_02f0[1] <= 32'h00000000;
            rom_02f0[2] <= 32'h00000000;
            rom_02f0[3] <= 32'h00008282;
            rom_02f0[4] <= 32'h00000000;
            rom_02f0[5] <= 32'h00000082;
            rom_02f0[6] <= 32'h00008200;

            // 0x0000
            rom_0000[0] <= 32'h00dc0000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_0000[1] <= 32'h00dc0000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_0000[2] <= 32'h00df0000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_0000[3] <= 32'h00dc0000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_0000[4] <= 32'h00df0000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]

            // 0x0090
            rom_0090[0] <= 32'h0000a000;
            rom_0090[1] <= 32'h0000a000;

            // 0x8040
            rom_8040[0] <= 32'h00000008;
            rom_8040[1] <= 32'h00000008;
            rom_8040[2] <= 32'h00000000;

            // 0xc004
            rom_c004[0] <= 32'hffffffff;

            // 0xc000
            rom_c000[0] <= 32'h7000003f;
            rom_c000[1] <= 32'hf000003f;
            rom_c000[2] <= 32'hf000003f;
            rom_c000[3] <= 32'hf000003f;
            rom_c000[4] <= 32'hf000003f;
            rom_c000[5] <= 32'hf000003f;
            rom_c000[6] <= 32'hf000003f;
            rom_c000[7] <= 32'hf000003f;
            rom_c000[8] <= 32'hf000003f;
            rom_c000[9] <= 32'hf000003f;
            rom_c000[10] <= 32'hf000003f;
            rom_c000[11] <= 32'hf000003f;
            rom_c000[12] <= 32'hf000003f;
            rom_c000[13] <= 32'hf000003f;
            rom_c000[14] <= 32'hf000003f;
            rom_c000[15] <= 32'hf000003f;
            rom_c000[16] <= 32'hf000003f;
            rom_c000[17] <= 32'hf000003f;
            rom_c000[18] <= 32'hf000003f;
            rom_c000[19] <= 32'hf000003f;
            rom_c000[20] <= 32'hf000003f;
            rom_c000[21] <= 32'hf000003f;
            rom_c000[22] <= 32'hf000003f;
            rom_c000[23] <= 32'hf000003f;
            rom_c000[24] <= 32'hf000003f;
            rom_c000[25] <= 32'hf000003f;

            // 0x0200
            rom_0200[0] <= 32'hf76df8db;

            // 0x8a50
            rom_8a50[0] <= 32'h00800000;

            // 0x8a54
            rom_8a54[0] <= 32'h00800000;

            // 0x8a58
            rom_8a58[0] <= 32'h00800000;

            // 0x8a5C
            rom_8a5C[0] <= 32'h00800000;

            // 0x8a60
            rom_8a60[0] <= 32'h00800000;

            // 0x8a64
            rom_8a64[0] <= 32'h00800000;

            // 0x8a68
            rom_8a68[0] <= 32'h00800000;

            // 0x8a6C
            rom_8a6C[0] <= 32'h00800000;

            // 0x8a70
            rom_8a70[0] <= 32'h00200000;

            // 0x8a74
            rom_8a74[0] <= 32'h00800000;

            // 0x8a78
            rom_8a78[0] <= 32'h00200000;

            // 0x8a7C
            rom_8a7C[0] <= 32'h00800000;

            // 0x8a98
            rom_8a98[0] <= 32'h02a002a0;

            // 0x8a8C
            rom_8a8C[0] <= 32'h04c804c8;

            // 0x8a9C
            rom_8a9C[0] <= 32'h00000990;

            // 0x8aa8
            rom_8aa8[0] <= 32'h02100000;

            // 0x8a04
            rom_8a04[0] <= 32'h00280002;

            // 0x8a94
            rom_8a94[0] <= 32'h00000ed0;

            // 0x8aa0
            rom_8aa0[0] <= 32'h00000000;

            // 0x8aa4
            rom_8aa4[0] <= 32'h00000000;

            // 0x8a90
            rom_8a90[0] <= 32'h07680768;

            // 0x9e10
            rom_9e10[0] <= 32'h00000000;
            rom_9e10[1] <= 32'h00e40001;
            rom_9e10[2] <= 32'h80e40001;
            rom_9e10[3] <= 32'h80e40001;
            rom_9e10[4] <= 32'ha0e40001;

            // 0x9c00
            rom_9c00[0] <= 32'h00000000;

            // 0x9d00
            rom_9d00[0] <= 32'h80002800;

            // 0x9d04
            rom_9d04[0] <= 32'h00000000;

            // 0xc33C
            rom_c33C[0] <= 32'h75462c4b;

            // 0xc340
            rom_c340[0] <= 32'h750002ff; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c340[1] <= 32'h750002df; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c340[2] <= 32'h000002df; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c340[3] <= 32'h750002df; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c340[4] <= 32'h750000ff; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c340[5] <= 32'h000000ff; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c340[6] <= 32'h750000ff; // ops_read16+0x6d/0xf0 [rtw89pci]

            // 0xc338
            rom_c338[0] <= 32'h083c0209;

            // 0xce34
            rom_ce34[0] <= 32'h007f0000; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce34[1] <= 32'h007f0001; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce34[2] <= 32'h00000001; // ops_read16+0x6d/0xf0 [rtw89pci]

            // 0xce04
            rom_ce04[0] <= 32'h000c007f; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce04[1] <= 32'h000c007f; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce04[2] <= 32'h0000007f; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce04[3] <= 32'h000c007f; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xc390
            rom_c390[0] <= 32'hff3f01ff;

            // 0xcc00
            rom_cc00[0] <= 32'h60384040;

            // 0xcc04
            rom_cc04[0] <= 32'h1f800000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_cc04[1] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_cc04[2] <= 32'h0000150a; // ops_read8+0x72/0x110 [rtw89pci]
            rom_cc04[3] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_cc04[4] <= 32'h0000150a; // ops_read8+0x72/0x110 [rtw89pci]
            rom_cc04[5] <= 32'h0000150a; // ops_read8+0x72/0x110 [rtw89pci]
            rom_cc04[6] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_cc04[7] <= 32'h0000150a; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xcc80
            rom_cc80[0] <= 32'h00240000;
            rom_cc80[1] <= 32'h04270000;

            // 0xce48
            rom_ce48[0] <= 32'h00070000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce48[1] <= 32'h00070000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce48[2] <= 32'h00070000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce48[3] <= 32'h00060000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce48[4] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce48[5] <= 32'h00060000; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xcc20
            rom_cc20[0] <= 32'h00502804;

            // 0xca00
            rom_ca00[0] <= 32'h10840110;

            // 0xca1C
            rom_ca1C[0] <= 32'h0e0a5592;
            rom_ca1C[1] <= 32'h0e0a7592;

            // 0xccb0
            rom_ccb0[0] <= 32'h00000000;

            // 0xcc08
            rom_cc08[0] <= 32'h11051204;
            rom_cc08[1] <= 32'h11051004;

            // 0xce3C
            rom_ce3C[0] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce3C[1] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce3C[2] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce3C[3] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ce3C[4] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xce00
            rom_ce00[0] <= 32'h20f1000f; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[1] <= 32'h20f10000; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[2] <= 32'h20f1000f; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[3] <= 32'h20f1000f; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[4] <= 32'h0000000f; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[5] <= 32'h20f1000f; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[6] <= 32'h20f10001; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[7] <= 32'h20f10000; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[8] <= 32'h20f10001; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[9] <= 32'h00f10001; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[10] <= 32'h00000001; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_ce00[11] <= 32'h00f10001; // ops_read8+0x72/0x110 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]

            // 0xce20
            rom_ce20[0] <= 32'h030044be; // ops_reset+0x19f/0x350 [rtw89pci]
            rom_ce20[1] <= 32'heaeaeaea; // ops_reset+0x19f/0x350 [rtw89pci]
            rom_ce20[2] <= 32'heaeaeaea; // ops_reset+0x19f/0x350 [rtw89pci]

            // 0xc088
            rom_c088[0] <= 32'h00000444;

            // 0xc090
            rom_c090[0] <= 32'h00000105;

            // 0xc624
            rom_c624[0] <= 32'h10001010;

            // 0xc6e8
            rom_c6e8[0] <= 32'h60606043;

            // 0xc600
            rom_c600[0] <= 32'h00004003; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c600[1] <= 32'h00000003; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c600[2] <= 32'h00004003; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c600[3] <= 32'h00004003; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c600[4] <= 32'h00000003; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c600[5] <= 32'h00004003; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xc660
            rom_c660[0] <= 32'h0000a104; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c660[1] <= 32'h00000004; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c660[2] <= 32'h0000a104; // ops_read8+0x72/0x110 [rtw89pci]

            // 0x9430
            rom_9430[0] <= 32'hffffffff;
            rom_9430[1] <= 32'hffffccc8;

            // 0x9d1C
            rom_9d1C[0] <= 32'h00000118;

            // 0x9bf4
            rom_9bf4[0] <= 32'h00000000;
            rom_9bf4[1] <= 32'h00000000;

            // 0x9cf4
            rom_9cf4[0] <= 32'h00000000;
            rom_9cf4[1] <= 32'h00000000;

            // 0x9ef0
            rom_9ef0[0] <= 32'h00000007;
            rom_9ef0[1] <= 32'h00000000;

            // 0x9f1C
            rom_9f1C[0] <= 32'h0000fff3;
            rom_9f1C[1] <= 32'h0000fcf0;

            // 0x9f2C
            rom_9f2C[0] <= 32'h0000fff3;
            rom_9f2C[1] <= 32'h0000fcf0;

            // 0x8c38
            rom_8c38[0] <= 32'hffffffff;
            rom_8c38[1] <= 32'hf8f00f00;

            // 0x9038
            rom_9038[0] <= 32'hffffffff;
            rom_9038[1] <= 32'hf8f00f00;

            // 0x9a20
            rom_9a20[0] <= 32'h000000ff;

            // 0x8850
            rom_8850[0] <= 32'h0c0000c4;
            rom_8850[1] <= 32'h00000000;

            // 0x8854
            rom_8854[0] <= 32'h06000062;
            rom_8854[1] <= 32'h00000000;

            // 0x8858
            rom_8858[0] <= 32'h00000000;
            rom_8858[1] <= 32'h00000000;

            // 0x9840
            rom_9840[0] <= 32'hffffffff;
            rom_9840[1] <= 32'hffffeeee;

            // 0x960C
            rom_960C[0] <= 32'h0000ffff;

            // 0x962C
            rom_962C[0] <= 32'h0000ffff;
            rom_962C[1] <= 32'h0000ff00;

            // 0x963C
            rom_963C[0] <= 32'h0000ffff;

            // 0x966C
            rom_966C[0] <= 32'h0000ffff;

            // 0xc3e8
            rom_c3e8[0] <= 32'h00000001;
            rom_c3e8[1] <= 32'h00000000;

            // 0xc6c0
            rom_c6c0[0] <= 32'hffff7fff;
            rom_c6c0[1] <= 32'h007f20fe;

            // 0xc800
            rom_c800[0] <= 32'h0000c001;
            rom_c800[1] <= 32'h00000001;

            // 0xccfC
            rom_ccfC[0] <= 32'h00000020;
            rom_ccfC[1] <= 32'h00000020;

            // 0xcef4
            rom_cef4[0] <= 32'h0003f000;
            rom_cef4[1] <= 32'h00000000;

            // 0xcceC
            rom_cceC[0] <= 32'h000007a0;
            rom_cceC[1] <= 32'h00000020;

            // 0x9408
            rom_9408[0] <= 32'h00004000;

            // 0x9410
            rom_9410[0] <= 32'h0f070001;

            // 0x9414
            rom_9414[0] <= 32'h00000001;
            rom_9414[1] <= 32'h0000001e;

            // 0x8410
            rom_8410[0] <= 32'h00002501; // ltr_set+0x12d/0x230 [rtw89pci] // ltr_set+0x213/0x230 [rtw89pci] // ops_stop+0x4c/0x80 [rtw89pci] // ltr_set+0xf5/0x230 [rtw89pci] // ltr_set+0xac/0x230 [rtw89pci]
            rom_8410[1] <= 32'h00002501; // ltr_set+0x12d/0x230 [rtw89pci] // ltr_set+0x213/0x230 [rtw89pci] // ops_stop+0x4c/0x80 [rtw89pci] // ltr_set+0xf5/0x230 [rtw89pci] // ltr_set+0xac/0x230 [rtw89pci]
            rom_8410[2] <= 32'h00002543; // ltr_set+0x12d/0x230 [rtw89pci] // ltr_set+0x213/0x230 [rtw89pci] // ops_stop+0x4c/0x80 [rtw89pci] // ltr_set+0xf5/0x230 [rtw89pci] // ltr_set+0xac/0x230 [rtw89pci]
            rom_8410[3] <= 32'h00002543; // ltr_set+0x12d/0x230 [rtw89pci] // ltr_set+0x213/0x230 [rtw89pci] // ops_stop+0x4c/0x80 [rtw89pci] // ltr_set+0xf5/0x230 [rtw89pci] // ltr_set+0xac/0x230 [rtw89pci]
            rom_8410[4] <= 32'h00002743; // ltr_set+0x12d/0x230 [rtw89pci] // ltr_set+0x213/0x230 [rtw89pci] // ops_stop+0x4c/0x80 [rtw89pci] // ltr_set+0xf5/0x230 [rtw89pci] // ltr_set+0xac/0x230 [rtw89pci]
            rom_8410[5] <= 32'h00002743; // ltr_set+0x12d/0x230 [rtw89pci] // ltr_set+0x213/0x230 [rtw89pci] // ops_stop+0x4c/0x80 [rtw89pci] // ltr_set+0xf5/0x230 [rtw89pci] // ltr_set+0xac/0x230 [rtw89pci]

            // 0x8414
            rom_8414[0] <= 32'h00280028; // ltr_set+0x162/0x230 [rtw89pci] // ltr_set+0x19c/0x230 [rtw89pci] // ltr_set+0x28/0x230 [rtw89pci]
            rom_8414[1] <= 32'h00280028; // ltr_set+0x162/0x230 [rtw89pci] // ltr_set+0x19c/0x230 [rtw89pci] // ltr_set+0x28/0x230 [rtw89pci]
            rom_8414[2] <= 32'h00280028; // ltr_set+0x162/0x230 [rtw89pci] // ltr_set+0x19c/0x230 [rtw89pci] // ltr_set+0x28/0x230 [rtw89pci]

            // 0x8418
            rom_8418[0] <= 32'h88e088e0; // ltr_set+0x54/0x230 [rtw89pci]
            // 0x841C
            rom_841C[0] <= 32'h880b880b; // ltr_set+0x80/0x230 [rtw89pci]
            // 0x158dC
            rom_158dC[0] <= 32'h8000807f;
            rom_158dC[1] <= 32'hc000807f;
            rom_158dC[2] <= 32'h8000807f;
            rom_158dC[3] <= 32'hc000807f;
            rom_158dC[4] <= 32'hc000807f;

            // 0x15818
            rom_15818[0] <= 32'h002c1800;
            rom_15818[1] <= 32'h402c1800;
            rom_15818[2] <= 32'h002c1800;
            rom_15818[3] <= 32'h402c1800;

            // 0x178dC
            rom_178dC[0] <= 32'h8000807f;
            rom_178dC[1] <= 32'hc000807f;
            rom_178dC[2] <= 32'h8000807f;
            rom_178dC[3] <= 32'hc000807f;
            rom_178dC[4] <= 32'hc000807f;

            // 0x17818
            rom_17818[0] <= 32'h002c1800;
            rom_17818[1] <= 32'h402c1800;
            rom_17818[2] <= 32'h002c1800;
            rom_17818[3] <= 32'h402c1800;

            // 0x10704
            rom_10704[0] <= 32'h601c01ff;
            rom_10704[1] <= 32'h601c01ff;
            rom_10704[2] <= 32'h601c01fd;
            rom_10704[3] <= 32'h601c01ff;
            rom_10704[4] <= 32'h601c01fd;
            rom_10704[5] <= 32'h601c01ff;
            rom_10704[6] <= 32'h601c01fd;
            rom_10704[7] <= 32'h601c01ff;

            // 0x0040
            rom_0040[0] <= 32'h00000020; // disable_intr+0x3b/0x60 [rtw89pci]
            rom_0040[1] <= 32'h00000020; // disable_intr+0x3b/0x60 [rtw89pci]
            rom_0040[2] <= 32'h00000200; // disable_intr+0x3b/0x60 [rtw89pci]
            rom_0040[3] <= 32'h00000020; // disable_intr+0x3b/0x60 [rtw89pci]
            rom_0040[4] <= 32'h00000020; // disable_intr+0x3b/0x60 [rtw89pci]
            rom_0040[5] <= 32'h00000200; // disable_intr+0x3b/0x60 [rtw89pci]

            // 0xda20
            rom_da20[0] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci] // napi_poll+0x5e/0x160 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci] // recognize_intrs+0x94/0xe0 [rtw89pci]
            rom_da20[1] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci] // napi_poll+0x5e/0x160 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci] // recognize_intrs+0x94/0xe0 [rtw89pci]
            rom_da20[2] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci] // napi_poll+0x5e/0x160 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci] // recognize_intrs+0x94/0xe0 [rtw89pci]
            rom_da20[3] <= 32'h00000002; // ops_read8+0x72/0x110 [rtw89pci] // napi_poll+0x5e/0x160 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci] // recognize_intrs+0x94/0xe0 [rtw89pci]
            rom_da20[4] <= 32'h00000002; // ops_read8+0x72/0x110 [rtw89pci] // napi_poll+0x5e/0x160 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci] // recognize_intrs+0x94/0xe0 [rtw89pci]
            rom_da20[5] <= 32'h00000002; // ops_read8+0x72/0x110 [rtw89pci] // napi_poll+0x5e/0x160 [rtw89pci] // napi_poll+0x14d/0x160 [rtw89pci] // recognize_intrs+0x94/0xe0 [rtw89pci]

            // 0xda34
            rom_da34[0] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da34[1] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da34[2] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da34[3] <= 32'h00000100; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da34[4] <= 32'h00000100; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da34[5] <= 32'h00000100; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xda40
            rom_da40[0] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[1] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[2] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[3] <= 32'h0000000c; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[4] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[5] <= 32'h0000000c; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[6] <= 32'h0001000c; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[7] <= 32'h0001000c; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[8] <= 32'h0000000c; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[9] <= 32'h0001000c; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[10] <= 32'h0001000c; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[11] <= 32'h00010000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[12] <= 32'h0001000c; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da40[13] <= 32'h0001000c; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xdaf0
            rom_daf0[0] <= 32'h20000000; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[1] <= 32'h20000000; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[2] <= 32'h200f003c; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[3] <= 32'h20000000; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[4] <= 32'h600f003c; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[5] <= 32'h60000000; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[6] <= 32'h600f0038; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[7] <= 32'h60000000; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[8] <= 32'h600f0038; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[9] <= 32'h60000000; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[10] <= 32'h600f0038; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[11] <= 32'h60000000; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[12] <= 32'h600f0038; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[13] <= 32'h60000000; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[14] <= 32'h600f0038; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[15] <= 32'h60000000; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[16] <= 32'h200f003c; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_daf0[17] <= 32'h20000000; // ops_read8+0x72/0x110 [rtw89pci] // ops_tx_kick_off+0x6e/0x80 [rtw89pci]

            // 0xdaf8
            rom_daf8[0] <= 32'h0000015d;
            rom_daf8[1] <= 32'h00000100;

            // 0xda4C
            rom_da4C[0] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da4C[1] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da4C[2] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da4C[3] <= 32'h00000001; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da4C[4] <= 32'h00000001; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da4C[5] <= 32'h00000001; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xda6C
            rom_da6C[0] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da6C[1] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da6C[2] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da6C[3] <= 32'h00000005; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da6C[4] <= 32'h00000005; // ops_read8+0x72/0x110 [rtw89pci]
            rom_da6C[5] <= 32'h00000005; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xda30
            rom_da30[0] <= 32'h00000000;
            rom_da30[1] <= 32'h00000008;

            // 0xda10
            rom_da10[0] <= 32'h00000000;
            rom_da10[1] <= 32'h00000100;

            // 0x1c008
            rom_1c008[0] <= 32'h00000018;
            rom_1c008[1] <= 32'h00000011;

            // 0x1d008
            rom_1d008[0] <= 32'h00000018;
            rom_1d008[1] <= 32'h00000011;

            // 0x1c3bC
            rom_1c3bC[0] <= 32'h00000000;
            rom_1c3bC[1] <= 32'h00020000;
            rom_1c3bC[2] <= 32'h00000000;
            rom_1c3bC[3] <= 32'h00020000;
            rom_1c3bC[4] <= 32'h00000000;
            rom_1c3bC[5] <= 32'h00020000;
            rom_1c3bC[6] <= 32'h00000000;
            rom_1c3bC[7] <= 32'h00020000;

            // 0x1c0cC
            rom_1c0cC[0] <= 32'h00000000;
            rom_1c0cC[1] <= 32'h00000000;
            rom_1c0cC[2] <= 32'h00000002;
            rom_1c0cC[3] <= 32'h00000000;

            // 0x1c0fC
            rom_1c0fC[0] <= 32'h00000000;
            rom_1c0fC[1] <= 32'h000005ff;
            rom_1c0fC[2] <= 32'h000005ff;
            rom_1c0fC[3] <= 32'h000005ff;

            // 0x1d3bC
            rom_1d3bC[0] <= 32'h00000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_1d3bC[1] <= 32'h00020000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_1d3bC[2] <= 32'h00000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_1d3bC[3] <= 32'h00020000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_1d3bC[4] <= 32'h00000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_1d3bC[5] <= 32'h00080000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_1d3bC[6] <= 32'h00000000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_1d3bC[7] <= 32'h00080000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // recognize_intrs+0x4b/0xe0 [rtw89pci]

            // 0x1d0cC
            rom_1d0cC[0] <= 32'h00000000; // rxbd_recalc+0x1d/0x60 [rtw89pci]
            rom_1d0cC[1] <= 32'h00000000; // rxbd_recalc+0x1d/0x60 [rtw89pci]
            rom_1d0cC[2] <= 32'h00000000; // rxbd_recalc+0x1d/0x60 [rtw89pci]
            rom_1d0cC[3] <= 32'h00000001; // rxbd_recalc+0x1d/0x60 [rtw89pci]

            // 0x1d0fC
            rom_1d0fC[0] <= 32'h00000000;
            rom_1d0fC[1] <= 32'h000005ff;
            rom_1d0fC[2] <= 32'h000005ff;
            rom_1d0fC[3] <= 32'h000a2d7c;

            // 0x00aC
            rom_00aC[0] <= 32'h4000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]
            rom_00aC[1] <= 32'h4000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]
            rom_00aC[2] <= 32'hc000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]
            rom_00aC[3] <= 32'hc000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]
            rom_00aC[4] <= 32'h4000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]
            rom_00aC[5] <= 32'hc000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]
            rom_00aC[6] <= 32'hc000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]
            rom_00aC[7] <= 32'h4000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]
            rom_00aC[8] <= 32'hc000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]
            rom_00aC[9] <= 32'hc000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]
            rom_00aC[10] <= 32'h4000208b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_start+0x48/0x70 [rtw89pci]

            // 0xd200
            rom_d200[0] <= 32'h02010000;
            rom_d200[1] <= 32'h02010000;

            // 0xd220
            rom_d220[0] <= 32'h01ebf004;

            // 0xc67C
            rom_c67C[0] <= 32'h00000000;
            rom_c67C[1] <= 32'h00000166;
            rom_c67C[2] <= 32'h00000100;
            rom_c67C[3] <= 32'h00000166;
            rom_c67C[4] <= 32'h00000100;
            rom_c67C[5] <= 32'h00000166;

            // 0x1466C
            rom_1466C[0] <= 32'h54d89adb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_1466C[1] <= 32'h54da9adb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_1466C[2] <= 32'h54da9adb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_1466C[3] <= 32'h54da9adb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_1466C[4] <= 32'h54da9adb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_1466C[5] <= 32'h54da9adb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_1466C[6] <= 32'h54da9adb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_1466C[7] <= 32'h54da9adb; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]

            // 0x14740
            rom_14740[0] <= 32'h54d89adb;
            rom_14740[1] <= 32'h54de9adb;
            rom_14740[2] <= 32'h54de9adb;
            rom_14740[3] <= 32'h54de9adb;
            rom_14740[4] <= 32'h54de9adb;
            rom_14740[5] <= 32'h54de9adb;
            rom_14740[6] <= 32'h54de9adb;
            rom_14740[7] <= 32'h54de9adb;

            // 0x10980
            rom_10980[0] <= 32'h10002250;
            rom_10980[1] <= 32'h10002250;
            rom_10980[2] <= 32'h10002250;
            rom_10980[3] <= 32'h10002250;
            rom_10980[4] <= 32'h10002250;
            rom_10980[5] <= 32'h10002250;
            rom_10980[6] <= 32'h10002250;
            rom_10980[7] <= 32'h10002250;

            // 0x14624
            rom_14624[0] <= 32'ha8068010;
            rom_14624[1] <= 32'ha8068010;
            rom_14624[2] <= 32'ha8068010;
            rom_14624[3] <= 32'ha8068010;
            rom_14624[4] <= 32'ha8068010;
            rom_14624[5] <= 32'ha8068010;
            rom_14624[6] <= 32'ha8068010;
            rom_14624[7] <= 32'ha8068010;

            // 0x146f8
            rom_146f8[0] <= 32'ha8068010;
            rom_146f8[1] <= 32'ha8068010;
            rom_146f8[2] <= 32'ha8068010;
            rom_146f8[3] <= 32'ha8068010;
            rom_146f8[4] <= 32'ha8068010;
            rom_146f8[5] <= 32'ha8068010;
            rom_146f8[6] <= 32'ha8068010;
            rom_146f8[7] <= 32'ha8068010;

            // 0x14674
            rom_14674[0] <= 32'h002acc30;
            rom_14674[1] <= 32'h002acc30;
            rom_14674[2] <= 32'h002acc30;
            rom_14674[3] <= 32'h002acc30;
            rom_14674[4] <= 32'h002acc30;
            rom_14674[5] <= 32'h002acc30;
            rom_14674[6] <= 32'h002acc30;
            rom_14674[7] <= 32'h002acc30;
            rom_14674[8] <= 32'h002acc30;

            // 0x14748
            rom_14748[0] <= 32'h002acc30;
            rom_14748[1] <= 32'h002acc30;
            rom_14748[2] <= 32'h002acc30;
            rom_14748[3] <= 32'h002acc30;
            rom_14748[4] <= 32'h002acc30;
            rom_14748[5] <= 32'h002acc30;
            rom_14748[6] <= 32'h002acc30;
            rom_14748[7] <= 32'h002acc30;
            rom_14748[8] <= 32'h002acc30;

            // 0x14650
            rom_14650[0] <= 32'h9084c800;
            rom_14650[1] <= 32'h9084c800;
            rom_14650[2] <= 32'h9084c800;
            rom_14650[3] <= 32'h9084c800;
            rom_14650[4] <= 32'h9084c800;
            rom_14650[5] <= 32'h9084c800;
            rom_14650[6] <= 32'h9084c800;
            rom_14650[7] <= 32'h9084c800;
            rom_14650[8] <= 32'h9084c800;

            // 0x14724
            rom_14724[0] <= 32'h9084c800; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_14724[1] <= 32'h9084c800; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_14724[2] <= 32'h9084c800; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_14724[3] <= 32'h9084c800; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_14724[4] <= 32'h9084c800; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_14724[5] <= 32'h9084c800; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_14724[6] <= 32'h9084c800; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_14724[7] <= 32'h9084c800; // recognize_intrs+0x28/0xe0 [rtw89pci]

            // 0x14688
            rom_14688[0] <= 32'h00000000; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_14688[1] <= 32'h00000000; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_14688[2] <= 32'h00000000; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_14688[3] <= 32'h00000000; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_14688[4] <= 32'h00000000; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_14688[5] <= 32'h00000000; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_14688[6] <= 32'h00000000; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_14688[7] <= 32'h00000000; // napi_poll+0xd5/0x160 [rtw89pci]

            // 0x1475C
            rom_1475C[0] <= 32'h00000000; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1475C[1] <= 32'h00000000; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1475C[2] <= 32'h00000000; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1475C[3] <= 32'h00000000; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1475C[4] <= 32'h00000000; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1475C[5] <= 32'h00000000; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1475C[6] <= 32'h00000000; // napi_poll+0x14d/0x160 [rtw89pci]
            rom_1475C[7] <= 32'h00000000; // napi_poll+0x14d/0x160 [rtw89pci]

            // 0x1c108
            rom_1c108[0] <= 32'h00008040;
            rom_1c108[1] <= 32'h000c8040;
            rom_1c108[2] <= 32'h00000000;
            rom_1c108[3] <= 32'h00000000;

            // 0x1d108
            rom_1d108[0] <= 32'h00008040;
            rom_1d108[1] <= 32'h000c8040;
            rom_1d108[2] <= 32'h00000000;
            rom_1d108[3] <= 32'h00000000;

            // 0x10d7C
            rom_10d7C[0] <= 32'h001d050c;

            // 0x12d7C
            rom_12d7C[0] <= 32'h739c0408;

            // 0x1000C
            rom_1000C[0] <= 32'h00000000;

            // 0x10d84
            rom_10d84[0] <= 32'h00006207;

            // 0x10738
            rom_10738[0] <= 32'h004100cc;
            rom_10738[1] <= 32'h004f00cc;
            rom_10738[2] <= 32'h004f00cc;

            // 0x14404
            rom_14404[0] <= 32'h10c61c22;

            // 0x1440C
            rom_1440C[0] <= 32'h10c61c22;

            // 0x109a4
            rom_109a4[0] <= 32'h0000001c;
            rom_109a4[1] <= 32'h00000000;

            // 0x10da0
            rom_10da0[0] <= 32'h000003ff;

            // 0x10da4
            rom_10da4[0] <= 32'h00000000;

            // 0x10c00
            rom_10c00[0] <= 32'h00000000;
            rom_10c00[1] <= 32'h00000001;
            rom_10c00[2] <= 32'h00000003;
            rom_10c00[3] <= 32'h00000007;

            // 0x10c2C
            rom_10c2C[0] <= 32'h00000000;
            rom_10c2C[1] <= 32'h00000000;
            rom_10c2C[2] <= 32'h00020000;

            // 0x10c30
            rom_10c30[0] <= 32'h00000000;
            rom_10c30[1] <= 32'h00000003;
            rom_10c30[2] <= 32'h00080003;

            // 0x10c34
            rom_10c34[0] <= 32'h00000000;
            rom_10c34[1] <= 32'h00000009;
            rom_10c34[2] <= 32'h00200009;

            // 0x10c38
            rom_10c38[0] <= 32'h00000000;
            rom_10c38[1] <= 32'h00000021;
            rom_10c38[2] <= 32'h00800021;

            // 0x10c28
            rom_10c28[0] <= 32'h00000000;

            // 0x1073C
            rom_1073C[0] <= 32'h00000000;

            // 0x10740
            rom_10740[0] <= 32'h00000000;

            // 0x10744
            rom_10744[0] <= 32'h00000000;

            // 0x10748
            rom_10748[0] <= 32'h00000000;

            // 0x1075C
            rom_1075C[0] <= 32'h00000000;

            // 0x10764
            rom_10764[0] <= 32'h00000001;
            rom_10764[1] <= 32'h00000201;

            // 0x10768
            rom_10768[0] <= 32'h00000002;
            rom_10768[1] <= 32'h00000202;

            // 0x1076C
            rom_1076C[0] <= 32'h00000002;
            rom_1076C[1] <= 32'h00000202;

            // 0x10770
            rom_10770[0] <= 32'h00000002;
            rom_10770[1] <= 32'h00000202;
            rom_10770[2] <= 32'h01000202;

            // 0x10774
            rom_10774[0] <= 32'h00000006;
            rom_10774[1] <= 32'h00000206;
            rom_10774[2] <= 32'h01000206;

            // 0x14628
            rom_14628[0] <= 32'h4602ca80;

            // 0x1462C
            rom_1462C[0] <= 32'h76067e8c;
            rom_1462C[1] <= 32'h76067e8c;
            rom_1462C[2] <= 32'h76067e8c;

            // 0x14630
            rom_14630[0] <= 32'h8ea350e8;
            rom_14630[1] <= 32'h8ea350e8;
            rom_14630[2] <= 32'h8ea350e8;

            // 0x14634
            rom_14634[0] <= 32'hb3b8d8f5;
            rom_14634[1] <= 32'hb3b8d8f5;
            rom_14634[2] <= 32'hb3b8d8f5;
            rom_14634[3] <= 32'hb3b8d8f5;

            // 0x14638
            rom_14638[0] <= 32'h6fff0c06;
            rom_14638[1] <= 32'h6fff0c06;
            rom_14638[2] <= 32'h6fff0c06;

            // 0x1463C
            rom_1463C[0] <= 32'hb8fa4435;

            // 0x14640
            rom_14640[0] <= 32'hb7c4fef8;
            rom_14640[1] <= 32'hb7c4fef8;

            // 0x14644
            rom_14644[0] <= 32'h2a72ad07;
            rom_14644[1] <= 32'h2a72ad07;
            rom_14644[2] <= 32'h2a72ad07;

            // 0x14668
            rom_14668[0] <= 32'h56452994;

            // 0x1473C
            rom_1473C[0] <= 32'h56452994;

            // 0x14658
            rom_14658[0] <= 32'h5ecc3ff4;

            // 0x1472C
            rom_1472C[0] <= 32'h5ecc3ff4;

            // 0x1481C
            rom_1481C[0] <= 32'h576df814;
            rom_1481C[1] <= 32'h576df814;

            // 0x146a0
            rom_146a0[0] <= 32'h00000498;

            // 0x146a4
            rom_146a4[0] <= 32'h00000498;

            // 0x14774
            rom_14774[0] <= 32'h00000498;

            // 0x14778
            rom_14778[0] <= 32'h00000498;

            // 0x0280
            rom_0280[0] <= 32'h000003ff;
            rom_0280[1] <= 32'h000003ff;
            rom_0280[2] <= 32'h000003ff;
            rom_0280[3] <= 32'h000003ff;

            // 0x14494
            rom_14494[0] <= 32'h10000000;

            // 0x14490
            rom_14490[0] <= 32'h80000000;

            // 0x14264
            rom_14264[0] <= 32'h00000000;

            // 0xd248
            rom_d248[0] <= 32'h07763333;

            // 0x10c70
            rom_10c70[0] <= 32'h00000660;

            // 0x10c60
            rom_10c60[0] <= 32'h017ffff3;

            // 0x10c6C
            rom_10c6C[0] <= 32'h10001021;

            // 0x158aC
            rom_158aC[0] <= 32'h08000000;

            // 0x178aC
            rom_178aC[0] <= 32'h08000000;

            // 0x18080
            rom_18080[0] <= 32'h00000004;

            // 0x1c014
            rom_1c014[0] <= 32'h00000000;
            rom_1c014[1] <= 32'h00000000;
            rom_1c014[2] <= 32'h00000000;
            rom_1c014[3] <= 32'h00000000;
            rom_1c014[4] <= 32'h00000000;
            rom_1c014[5] <= 32'h00000001;
            rom_1c014[6] <= 32'h00000001;
            rom_1c014[7] <= 32'h00000000;

            // 0x1c000
            rom_1c000[0] <= 32'h00000003;
            rom_1c000[1] <= 32'h00030003;
            rom_1c000[2] <= 32'h00030003;
            rom_1c000[3] <= 32'h00030003;
            rom_1c000[4] <= 32'h00030001;
            rom_1c000[5] <= 32'h00040001;
            rom_1c000[6] <= 32'h000337e1;
            rom_1c000[7] <= 32'h00030003;

            // 0x1c06C
            rom_1c06C[0] <= 32'h00003a00;
            rom_1c06C[1] <= 32'h00004240;
            rom_1c06C[2] <= 32'h00004240;
            rom_1c06C[3] <= 32'h00004010;

            // 0x1c070
            rom_1c070[0] <= 32'h00073900;
            rom_1c070[1] <= 32'h00084008;
            rom_1c070[2] <= 32'h00084008;

            // 0x1c074
            rom_1c074[0] <= 32'h00080000;
            rom_1c074[1] <= 32'h00060800;

            // 0x1c3c0
            rom_1c3c0[0] <= 32'h00008000;
            rom_1c3c0[1] <= 32'h00008002;

            // 0x1d014
            rom_1d014[0] <= 32'h00000000;
            rom_1d014[1] <= 32'h00000000;
            rom_1d014[2] <= 32'h00000000;
            rom_1d014[3] <= 32'h00000000;
            rom_1d014[4] <= 32'h00000000;
            rom_1d014[5] <= 32'h00000001;
            rom_1d014[6] <= 32'h00000001;
            rom_1d014[7] <= 32'h00000000;

            // 0x1d000
            rom_1d000[0] <= 32'h00000003;
            rom_1d000[1] <= 32'h00030003;
            rom_1d000[2] <= 32'h00030003;
            rom_1d000[3] <= 32'h00030003;
            rom_1d000[4] <= 32'h00030001;
            rom_1d000[5] <= 32'h00040001;
            rom_1d000[6] <= 32'h000377e1;
            rom_1d000[7] <= 32'h00030003;

            // 0x1d06C
            rom_1d06C[0] <= 32'h00003a00;
            rom_1d06C[1] <= 32'h00004640;
            rom_1d06C[2] <= 32'h00004640;
            rom_1d06C[3] <= 32'h00004411;

            // 0x1d070
            rom_1d070[0] <= 32'h00073900;
            rom_1d070[1] <= 32'h0008c408;
            rom_1d070[2] <= 32'h0008c408;

            // 0x1d074
            rom_1d074[0] <= 32'h00088000;
            rom_1d074[1] <= 32'h00068800;

            // 0x1d3c0
            rom_1d3c0[0] <= 32'h00008000;
            rom_1d3c0[1] <= 32'h00008002;

            // 0x112eC
            rom_112eC[0] <= 32'h888ca72b;
            rom_112eC[1] <= 32'h888c272b;
            rom_112eC[2] <= 32'h888ca72b;

            // 0x15e00
            rom_15e00[0] <= 32'h0030eb49;
            rom_15e00[1] <= 32'h0030eb48;
            rom_15e00[2] <= 32'h0030eb49;
            rom_15e00[3] <= 32'h0030eb49;
            rom_15e00[4] <= 32'h0030eb49;
            rom_15e00[5] <= 32'h0030eb49;
            rom_15e00[6] <= 32'h0030eb49;
            rom_15e00[7] <= 32'h0030eb49;
            rom_15e00[8] <= 32'h1030eb49;
            rom_15e00[9] <= 32'h2030eb49;
            rom_15e00[10] <= 32'h3030eb49;
            rom_15e00[11] <= 32'h4030eb49;
            rom_15e00[12] <= 32'h5030eb49;
            rom_15e00[13] <= 32'h6030eb49;
            rom_15e00[14] <= 32'h7030eb49;
            rom_15e00[15] <= 32'h8030eb49;
            rom_15e00[16] <= 32'h9030eb49;
            rom_15e00[17] <= 32'ha030eb49;
            rom_15e00[18] <= 32'hb030eb49;
            rom_15e00[19] <= 32'hc030eb49;
            rom_15e00[20] <= 32'hd030eb49;
            rom_15e00[21] <= 32'he030eb49;
            rom_15e00[22] <= 32'hf030eb49;
            rom_15e00[23] <= 32'hf030eb49;

            // 0x132eC
            rom_132eC[0] <= 32'h888ca72b;
            rom_132eC[1] <= 32'h888c272b;
            rom_132eC[2] <= 32'h888ca72b;

            // 0x17e00
            rom_17e00[0] <= 32'h0030eb49;
            rom_17e00[1] <= 32'h0030eb48;
            rom_17e00[2] <= 32'h0030eb49;
            rom_17e00[3] <= 32'h0030eb49;
            rom_17e00[4] <= 32'h0030eb49;
            rom_17e00[5] <= 32'h0030eb49;
            rom_17e00[6] <= 32'h0030eb49;
            rom_17e00[7] <= 32'h0030eb49;
            rom_17e00[8] <= 32'h1030eb49;
            rom_17e00[9] <= 32'h2030eb49;
            rom_17e00[10] <= 32'h3030eb49;
            rom_17e00[11] <= 32'h4030eb49;
            rom_17e00[12] <= 32'h5030eb49;
            rom_17e00[13] <= 32'h6030eb49;
            rom_17e00[14] <= 32'h7030eb49;
            rom_17e00[15] <= 32'h8030eb49;
            rom_17e00[16] <= 32'h9030eb49;
            rom_17e00[17] <= 32'ha030eb49;
            rom_17e00[18] <= 32'hb030eb49;
            rom_17e00[19] <= 32'hc030eb49;
            rom_17e00[20] <= 32'hd030eb49;
            rom_17e00[21] <= 32'he030eb49;
            rom_17e00[22] <= 32'hf030eb49;
            rom_17e00[23] <= 32'hf030eb49;

            // 0x112d8
            rom_112d8[0] <= 32'h00000040;
            rom_112d8[1] <= 32'h00000040;
            rom_112d8[2] <= 32'h000000c0;
            rom_112d8[3] <= 32'h000008c0;
            rom_112d8[4] <= 32'h000000c0;
            rom_112d8[5] <= 32'h000001c0;
            rom_112d8[6] <= 32'h000000c0;
            rom_112d8[7] <= 32'h000000c0;
            rom_112d8[8] <= 32'h000000f0;
            rom_112d8[9] <= 32'h000000f0;

            // 0x132d8
            rom_132d8[0] <= 32'h00000040;
            rom_132d8[1] <= 32'h00000040;
            rom_132d8[2] <= 32'h000000c0;
            rom_132d8[3] <= 32'h000008c0;
            rom_132d8[4] <= 32'h000000c0;
            rom_132d8[5] <= 32'h000001c0;
            rom_132d8[6] <= 32'h000000c0;
            rom_132d8[7] <= 32'h000000cf;
            rom_132d8[8] <= 32'h000000ff;
            rom_132d8[9] <= 32'h000000ff;

            // 0x112b8
            rom_112b8[0] <= 32'h30020000;
            rom_112b8[1] <= 32'h70020000;
            rom_112b8[2] <= 32'h30020000;
            rom_112b8[3] <= 32'h70020000;
            rom_112b8[4] <= 32'h70020000;
            rom_112b8[5] <= 32'h30020000;
            rom_112b8[6] <= 32'h70020000;

            // 0x1032C
            rom_1032C[0] <= 32'he000e000;
            rom_1032C[1] <= 32'ha000e000;
            rom_1032C[2] <= 32'ha000e000;
            rom_1032C[3] <= 32'ha040e000;
            rom_1032C[4] <= 32'ha040e000;
            rom_1032C[5] <= 32'ha041e000;
            rom_1032C[6] <= 32'he041e000;
            rom_1032C[7] <= 32'ha041e000;
            rom_1032C[8] <= 32'ha001e000;
            rom_1032C[9] <= 32'ha041e000;
            rom_1032C[10] <= 32'ha040e000;
            rom_1032C[11] <= 32'ha041e000;
            rom_1032C[12] <= 32'he041e000;
            rom_1032C[13] <= 32'h6041e000;
            rom_1032C[14] <= 32'h2041e000;
            rom_1032C[15] <= 32'h2040e000;
            rom_1032C[16] <= 32'h2041e000;
            rom_1032C[17] <= 32'h2041e000;
            rom_1032C[18] <= 32'h2041e000;
            rom_1032C[19] <= 32'h2040e000;
            rom_1032C[20] <= 32'h2041e000;
            rom_1032C[21] <= 32'h2041e000;
            rom_1032C[22] <= 32'h2001e000;
            rom_1032C[23] <= 32'h2041e000;
            rom_1032C[24] <= 32'h2041e000;
            rom_1032C[25] <= 32'h2041e000;
            rom_1032C[26] <= 32'h2001e000;
            rom_1032C[27] <= 32'h2041e000;

            // 0x1030C
            rom_1030C[0] <= 32'h0c0c0c0c;
            rom_1030C[1] <= 32'h0f0c0c0c;
            rom_1030C[2] <= 32'h030c0c0c;
            rom_1030C[3] <= 32'h0c0c0c0c;
            rom_1030C[4] <= 32'h0f0c0c0c;
            rom_1030C[5] <= 32'h030c0c0c;
            rom_1030C[6] <= 32'h0c0c0c0c;
            rom_1030C[7] <= 32'h1c0c0c0c;
            rom_1030C[8] <= 32'h1f0c0c0c;
            rom_1030C[9] <= 32'h130c0c0c;
            rom_1030C[10] <= 32'h130c0c0c;
            rom_1030C[11] <= 32'h1f0c0c0c;
            rom_1030C[12] <= 32'h130c0c0c;
            rom_1030C[13] <= 32'h130c0c0c;

            // 0x112dC
            rom_112dC[0] <= 32'h4486888c;
            rom_112dC[1] <= 32'h4486888e;
            rom_112dC[2] <= 32'h4486888c;
            rom_112dC[3] <= 32'h4486888d;

            // 0x120f4
            rom_120f4[0] <= 32'h00000000;
            rom_120f4[1] <= 32'h00000000;
            rom_120f4[2] <= 32'h00000000;
            rom_120f4[3] <= 32'h00000000;
            rom_120f4[4] <= 32'h00000000;
            rom_120f4[5] <= 32'h00000000;

            // 0x120f8
            rom_120f8[0] <= 32'h00000000;
            rom_120f8[1] <= 32'h80000000;
            rom_120f8[2] <= 32'h80000000;
            rom_120f8[3] <= 32'h80000000;
            rom_120f8[4] <= 32'h80000000;
            rom_120f8[5] <= 32'h80000000;

            // 0x120f0
            rom_120f0[0] <= 32'h00000000;
            rom_120f0[1] <= 32'h00010000;
            rom_120f0[2] <= 32'h00010200;
            rom_120f0[3] <= 32'h00010200;
            rom_120f0[4] <= 32'h00010280;
            rom_120f0[5] <= 32'h00010280;
            rom_120f0[6] <= 32'h00010280;
            rom_120f0[7] <= 32'h00010280;
            rom_120f0[8] <= 32'h00010280;
            rom_120f0[9] <= 32'h00010280;
            rom_120f0[10] <= 32'h00010280;
            rom_120f0[11] <= 32'h00010280;
            rom_120f0[12] <= 32'h000102c0;
            rom_120f0[13] <= 32'h000102c0;
            rom_120f0[14] <= 32'h000102c0;
            rom_120f0[15] <= 32'h000102c0;
            rom_120f0[16] <= 32'h000102c0;
            rom_120f0[17] <= 32'h000102c0;
            rom_120f0[18] <= 32'h000102c0;
            rom_120f0[19] <= 32'h000102c0;
            rom_120f0[20] <= 32'h00010280;
            rom_120f0[21] <= 32'h00010280;
            rom_120f0[22] <= 32'h00010280;
            rom_120f0[23] <= 32'h00010280;

            // 0x11730
            rom_11730[0] <= 32'h00ff9ffa;
            rom_11730[1] <= 32'h00003ff2;
            rom_11730[2] <= 32'h0000bff7;
            rom_11730[3] <= 32'h00ff2ff8;
            rom_11730[4] <= 32'h00000ff0;
            rom_11730[5] <= 32'h00007ffc;
            rom_11730[6] <= 32'h00ffe005;
            rom_11730[7] <= 32'h00fffffa;
            rom_11730[8] <= 32'h00002fe7;
            rom_11730[9] <= 32'h00ffefea;
            rom_11730[10] <= 32'h00ff7ff6;
            rom_11730[11] <= 32'h0000effc;
            rom_11730[12] <= 32'h00ff7ff7;
            rom_11730[13] <= 32'h00febfff;
            rom_11730[14] <= 32'h00ff3ffb;
            rom_11730[15] <= 32'h00ff0ff2;
            rom_11730[16] <= 32'h00007fff;
            rom_11730[17] <= 32'h00ff6fee;
            rom_11730[18] <= 32'h00002ff6;
            rom_11730[19] <= 32'h00ffdff1;
            rom_11730[20] <= 32'h00ffbffe;
            rom_11730[21] <= 32'h00ffaff5;
            rom_11730[22] <= 32'h00002ff7;
            rom_11730[23] <= 32'h00ff9ff7;
            rom_11730[24] <= 32'h00001ffd;
            rom_11730[25] <= 32'h00feb007;
            rom_11730[26] <= 32'h00ffeff5;
            rom_11730[27] <= 32'h00ff2000;
            rom_11730[28] <= 32'h00ffeff5;
            rom_11730[29] <= 32'h00ff3fe4;
            rom_11730[30] <= 32'h00002ff0;
            rom_11730[31] <= 32'h00ff7ffa;
            rom_11730[32] <= 32'h00feeff1;
            rom_11730[33] <= 32'h00ffaff3;
            rom_11730[34] <= 32'h00ff3ff6;
            rom_11730[35] <= 32'h00ffcfee;
            rom_11730[36] <= 32'h00003ff1;
            rom_11730[37] <= 32'h00fe9ff7;
            rom_11730[38] <= 32'h00ff6ff9;
            rom_11730[39] <= 32'h00ff8ffa;
            rom_11730[40] <= 32'h00ffdff9;
            rom_11730[41] <= 32'h00ffb000;
            rom_11730[42] <= 32'h00002ffd;
            rom_11730[43] <= 32'h00ffeff5;
            rom_11730[44] <= 32'h00ffbff2;
            rom_11730[45] <= 32'h00ffa000;
            rom_11730[46] <= 32'h00fffff3;
            rom_11730[47] <= 32'h00ffffee;
            rom_11730[48] <= 32'h00ff9ff0;
            rom_11730[49] <= 32'h00ffaff4;
            rom_11730[50] <= 32'h00ff3ffc;
            rom_11730[51] <= 32'h00ffafef;
            rom_11730[52] <= 32'h00ffafea;
            rom_11730[53] <= 32'h00ff6007;
            rom_11730[54] <= 32'h00ff3ff2;
            rom_11730[55] <= 32'h00ff4009;
            rom_11730[56] <= 32'h0000bff2;
            rom_11730[57] <= 32'h00000ff7;
            rom_11730[58] <= 32'h00ff3ff4;
            rom_11730[59] <= 32'h00002008;
            rom_11730[60] <= 32'h0000fff9;
            rom_11730[61] <= 32'h00fffffd;
            rom_11730[62] <= 32'h00002ff9;
            rom_11730[63] <= 32'h00ffbff3;
            rom_11730[64] <= 32'h00ffc003;
            rom_11730[65] <= 32'h0000bff4;
            rom_11730[66] <= 32'h00fed001;
            rom_11730[67] <= 32'h00ffbff7;
            rom_11730[68] <= 32'h00ff8ff9;
            rom_11730[69] <= 32'h00000002;
            rom_11730[70] <= 32'h00ff7000;
            rom_11730[71] <= 32'h00ff6ffb;
            rom_11730[72] <= 32'h00ffdfe7;
            rom_11730[73] <= 32'h00ffe000;
            rom_11730[74] <= 32'h00000fee;
            rom_11730[75] <= 32'h00fffff9;
            rom_11730[76] <= 32'h00ffafff;
            rom_11730[77] <= 32'h00ffbff9;
            rom_11730[78] <= 32'h00fffffb;
            rom_11730[79] <= 32'h00ffdffd;
            rom_11730[80] <= 32'h00ffbff7;
            rom_11730[81] <= 32'h00007fff;
            rom_11730[82] <= 32'h00004ff0;
            rom_11730[83] <= 32'h00ffdff9;
            rom_11730[84] <= 32'h00ffeff7;
            rom_11730[85] <= 32'h00ff7fe7;
            rom_11730[86] <= 32'h00fffff3;
            rom_11730[87] <= 32'h00005ff4;
            rom_11730[88] <= 32'h00ff200b;
            rom_11730[89] <= 32'h00ffeffc;
            rom_11730[90] <= 32'h00ffdff7;
            rom_11730[91] <= 32'h00ffaffa;
            rom_11730[92] <= 32'h00ffdff5;
            rom_11730[93] <= 32'h00ff6ff9;
            rom_11730[94] <= 32'h00ffbff4;
            rom_11730[95] <= 32'h00ffeffc;
            rom_11730[96] <= 32'h00ff3ff9;
            rom_11730[97] <= 32'h00ffaff5;
            rom_11730[98] <= 32'h00feefee;
            rom_11730[99] <= 32'h00febffa;
            rom_11730[100] <= 32'h00ffd005;
            rom_11730[101] <= 32'h00002ff9;
            rom_11730[102] <= 32'h00006ffc;
            rom_11730[103] <= 32'h00ffe007;
            rom_11730[104] <= 32'h00003006;
            rom_11730[105] <= 32'h00ffaff2;
            rom_11730[106] <= 32'h00ff0006;
            rom_11730[107] <= 32'h00ffb011;
            rom_11730[108] <= 32'h00002ffb;
            rom_11730[109] <= 32'h00002001;
            rom_11730[110] <= 32'h00002ffe;
            rom_11730[111] <= 32'h00002fff;
            rom_11730[112] <= 32'h00ffe000;
            rom_11730[113] <= 32'h00ffeffb;
            rom_11730[114] <= 32'h00ffeffd;
            rom_11730[115] <= 32'h00ff8002;
            rom_11730[116] <= 32'h00000ff8;
            rom_11730[117] <= 32'h00001003;
            rom_11730[118] <= 32'h00009ffc;
            rom_11730[119] <= 32'h00002ffe;
            rom_11730[120] <= 32'h00003001;
            rom_11730[121] <= 32'h0000300c;
            rom_11730[122] <= 32'h00007001;
            rom_11730[123] <= 32'h0000cff5;
            rom_11730[124] <= 32'h00fff007;
            rom_11730[125] <= 32'h00ffaffb;
            rom_11730[126] <= 32'h00fffff7;
            rom_11730[127] <= 32'h00fff000;
            rom_11730[128] <= 32'h00002003;
            rom_11730[129] <= 32'h00006002;
            rom_11730[130] <= 32'h00002002;
            rom_11730[131] <= 32'h00003000;
            rom_11730[132] <= 32'h00005ffb;
            rom_11730[133] <= 32'h00ffd001;
            rom_11730[134] <= 32'h00004007;
            rom_11730[135] <= 32'h00fff012;
            rom_11730[136] <= 32'h00001ff7;
            rom_11730[137] <= 32'h00ffaff8;
            rom_11730[138] <= 32'h0000a005;
            rom_11730[139] <= 32'h00ff8ffd;
            rom_11730[140] <= 32'h00006002;
            rom_11730[141] <= 32'h00006ff7;
            rom_11730[142] <= 32'h00ffaffd;
            rom_11730[143] <= 32'h00003ff6;
            rom_11730[144] <= 32'h00ffb001;
            rom_11730[145] <= 32'h0000600d;
            rom_11730[146] <= 32'h00008003;
            rom_11730[147] <= 32'h00004ff9;
            rom_11730[148] <= 32'h0000b008;
            rom_11730[149] <= 32'h00000009;
            rom_11730[150] <= 32'h00001001;
            rom_11730[151] <= 32'h0000fffa;
            rom_11730[152] <= 32'h00002fed;
            rom_11730[153] <= 32'h00002003;
            rom_11730[154] <= 32'h00010ff2;
            rom_11730[155] <= 32'h00000ff5;
            rom_11730[156] <= 32'h0000dff9;
            rom_11730[157] <= 32'h00ffe00b;
            rom_11730[158] <= 32'h00ffb008;
            rom_11730[159] <= 32'h00ffaff1;
            rom_11730[160] <= 32'h00007fff;
            rom_11730[161] <= 32'h00ffb001;
            rom_11730[162] <= 32'h00002001;
            rom_11730[163] <= 32'h00006000;
            rom_11730[164] <= 32'h00003001;
            rom_11730[165] <= 32'h00fee002;
            rom_11730[166] <= 32'h00004008;
            rom_11730[167] <= 32'h00ff0002;
            rom_11730[168] <= 32'h00002ffc;
            rom_11730[169] <= 32'h00006ffa;
            rom_11730[170] <= 32'h00fff00b;
            rom_11730[171] <= 32'h00fff006;
            rom_11730[172] <= 32'h00ffc003;
            rom_11730[173] <= 32'h00fff004;
            rom_11730[174] <= 32'h00009002;
            rom_11730[175] <= 32'h00003ffc;
            rom_11730[176] <= 32'h00002000;
            rom_11730[177] <= 32'h00002ff3;
            rom_11730[178] <= 32'h00002005;
            rom_11730[179] <= 32'h00ffb010;
            rom_11730[180] <= 32'h00ffafff;
            rom_11730[181] <= 32'h00fffff5;
            rom_11730[182] <= 32'h0000eff7;
            rom_11730[183] <= 32'h00fff002;
            rom_11730[184] <= 32'h00ff4006;
            rom_11730[185] <= 32'h00ffd004;
            rom_11730[186] <= 32'h00006ffe;
            rom_11730[187] <= 32'h00009ff3;
            rom_11730[188] <= 32'h00006ff8;
            rom_11730[189] <= 32'h00005006;
            rom_11730[190] <= 32'h00004007;
            rom_11730[191] <= 32'h00003006;
            rom_11730[192] <= 32'h0000f002;
            rom_11730[193] <= 32'h00ffcffd;
            rom_11730[194] <= 32'h00ffbffd;
            rom_11730[195] <= 32'h00ffd00d;
            rom_11730[196] <= 32'h00006ffa;
            rom_11730[197] <= 32'h00ff0001;
            rom_11730[198] <= 32'h00001fff;
            rom_11730[199] <= 32'h00003ff5;
            rom_11730[200] <= 32'h0001600a;
            rom_11730[201] <= 32'h00013006;
            rom_11730[202] <= 32'h0001a015;
            rom_11730[203] <= 32'h0000b00f;
            rom_11730[204] <= 32'h0001700c;
            rom_11730[205] <= 32'h0000a00c;
            rom_11730[206] <= 32'h0000c015;
            rom_11730[207] <= 32'h00013004;
            rom_11730[208] <= 32'h0001b015;
            rom_11730[209] <= 32'h0000e00c;
            rom_11730[210] <= 32'h0000d00e;
            rom_11730[211] <= 32'h0000c00c;
            rom_11730[212] <= 32'h0000b006;
            rom_11730[213] <= 32'h0000f01e;
            rom_11730[214] <= 32'h0000a011;
            rom_11730[215] <= 32'h00000011;
            rom_11730[216] <= 32'h0000e00f;
            rom_11730[217] <= 32'h0000e011;
            rom_11730[218] <= 32'h0000e00b;
            rom_11730[219] <= 32'h0000200a;
            rom_11730[220] <= 32'h00013011;
            rom_11730[221] <= 32'h0000e00f;
            rom_11730[222] <= 32'h00ffe00a;
            rom_11730[223] <= 32'h0001f019;
            rom_11730[224] <= 32'h00fff008;
            rom_11730[225] <= 32'h0000f014;
            rom_11730[226] <= 32'h0000a012;
            rom_11730[227] <= 32'h0001700c;
            rom_11730[228] <= 32'h0000600d;
            rom_11730[229] <= 32'h00fff015;
            rom_11730[230] <= 32'h0000e00a;
            rom_11730[231] <= 32'h00fff018;
            rom_11730[232] <= 32'h0000e00c;
            rom_11730[233] <= 32'h0001c012;
            rom_11730[234] <= 32'h0000b01e;
            rom_11730[235] <= 32'h00012009;
            rom_11730[236] <= 32'h0001700e;
            rom_11730[237] <= 32'h00013014;
            rom_11730[238] <= 32'h00014016;
            rom_11730[239] <= 32'h0000701c;
            rom_11730[240] <= 32'h0001800b;
            rom_11730[241] <= 32'h0000b014;
            rom_11730[242] <= 32'h0001300a;
            rom_11730[243] <= 32'h00002013;
            rom_11730[244] <= 32'h00016006;
            rom_11730[245] <= 32'h0000700f;
            rom_11730[246] <= 32'h0000f00c;
            rom_11730[247] <= 32'h0000b003;
            rom_11730[248] <= 32'h0001200a;
            rom_11730[249] <= 32'h0000b012;
            rom_11730[250] <= 32'h0000c015;
            rom_11730[251] <= 32'h0000f017;
            rom_11730[252] <= 32'h00007012;
            rom_11730[253] <= 32'h00ffa00f;
            rom_11730[254] <= 32'h0000b016;
            rom_11730[255] <= 32'h00012019;
            rom_11730[256] <= 32'h0000900d;
            rom_11730[257] <= 32'h00010013;
            rom_11730[258] <= 32'h0000e00b;
            rom_11730[259] <= 32'h0002000a;
            rom_11730[260] <= 32'h0000a001;
            rom_11730[261] <= 32'h00017019;
            rom_11730[262] <= 32'h00017008;
            rom_11730[263] <= 32'h0000f010;
            rom_11730[264] <= 32'h00014014;
            rom_11730[265] <= 32'h0000f00b;
            rom_11730[266] <= 32'h0000b014;
            rom_11730[267] <= 32'h00ffe00d;
            rom_11730[268] <= 32'h0001b014;
            rom_11730[269] <= 32'h0001501c;
            rom_11730[270] <= 32'h0000e015;
            rom_11730[271] <= 32'h0000b018;
            rom_11730[272] <= 32'h0000b00f;
            rom_11730[273] <= 32'h00013013;
            rom_11730[274] <= 32'h0000f00e;
            rom_11730[275] <= 32'h00003005;
            rom_11730[276] <= 32'h0000a00f;
            rom_11730[277] <= 32'h0000f012;
            rom_11730[278] <= 32'h00012007;
            rom_11730[279] <= 32'h00017011;
            rom_11730[280] <= 32'h00013012;
            rom_11730[281] <= 32'h0001100a;
            rom_11730[282] <= 32'h0000b003;
            rom_11730[283] <= 32'h00003010;
            rom_11730[284] <= 32'h0001a002;
            rom_11730[285] <= 32'h00010020;
            rom_11730[286] <= 32'h0000a012;
            rom_11730[287] <= 32'h00014012;
            rom_11730[288] <= 32'h0000e015;
            rom_11730[289] <= 32'h00015016;
            rom_11730[290] <= 32'h0000e010;
            rom_11730[291] <= 32'h00000015;
            rom_11730[292] <= 32'h00023010;
            rom_11730[293] <= 32'h0001b006;
            rom_11730[294] <= 32'h0001200d;
            rom_11730[295] <= 32'h0001d00a;
            rom_11730[296] <= 32'h00009011;
            rom_11730[297] <= 32'h0001300f;
            rom_11730[298] <= 32'h0000c013;
            rom_11730[299] <= 32'h0000f014;
            rom_11730[300] <= 32'h00ff8004;
            rom_11730[301] <= 32'h00ff2ffa;
            rom_11730[302] <= 32'h00011ff5;
            rom_11730[303] <= 32'h00ffc00b;
            rom_11730[304] <= 32'h0000d00a;
            rom_11730[305] <= 32'h00002006;
            rom_11730[306] <= 32'h0000a00f;
            rom_11730[307] <= 32'h00003002;
            rom_11730[308] <= 32'h00ffeffa;
            rom_11730[309] <= 32'h00003004;
            rom_11730[310] <= 32'h00005003;
            rom_11730[311] <= 32'h00ffdffb;
            rom_11730[312] <= 32'h00006006;
            rom_11730[313] <= 32'h00ff7003;
            rom_11730[314] <= 32'h0000effd;
            rom_11730[315] <= 32'h00ff2004;
            rom_11730[316] <= 32'h00013005;
            rom_11730[317] <= 32'h00ff7ffe;
            rom_11730[318] <= 32'h00003ff9;
            rom_11730[319] <= 32'h00fffffc;
            rom_11730[320] <= 32'h0000a00b;
            rom_11730[321] <= 32'h00ffb006;
            rom_11730[322] <= 32'h00fff002;
            rom_11730[323] <= 32'h00ffaff9;
            rom_11730[324] <= 32'h00ffdffe;
            rom_11730[325] <= 32'h0000dffa;
            rom_11730[326] <= 32'h00002feb;
            rom_11730[327] <= 32'h00005ffd;
            rom_11730[328] <= 32'h00ff3ffc;
            rom_11730[329] <= 32'h00009005;
            rom_11730[330] <= 32'h00006ff8;
            rom_11730[331] <= 32'h00ffb00b;
            rom_11730[332] <= 32'h00ffb00a;
            rom_11730[333] <= 32'h00001005;
            rom_11730[334] <= 32'h00004008;
            rom_11730[335] <= 32'h0000300d;
            rom_11730[336] <= 32'h00002000;
            rom_11730[337] <= 32'h00005001;
            rom_11730[338] <= 32'h00003002;
            rom_11730[339] <= 32'h00ff800b;
            rom_11730[340] <= 32'h00feb004;
            rom_11730[341] <= 32'h00ff1ffd;
            rom_11730[342] <= 32'h00007fef;
            rom_11730[343] <= 32'h00ff3004;
            rom_11730[344] <= 32'h00ffbffc;
            rom_11730[345] <= 32'h00fffff8;
            rom_11730[346] <= 32'h0000e005;
            rom_11730[347] <= 32'h00ffbffc;
            rom_11730[348] <= 32'h00fff006;
            rom_11730[349] <= 32'h00ffa009;
            rom_11730[350] <= 32'h00013ffe;
            rom_11730[351] <= 32'h00000000;
            rom_11730[352] <= 32'h00ffe007;
            rom_11730[353] <= 32'h00003ffd;
            rom_11730[354] <= 32'h00002002;
            rom_11730[355] <= 32'h00ffeff9;
            rom_11730[356] <= 32'h00ffeff8;
            rom_11730[357] <= 32'h00fff009;
            rom_11730[358] <= 32'h0000afff;
            rom_11730[359] <= 32'h00003ffc;
            rom_11730[360] <= 32'h00013ff8;
            rom_11730[361] <= 32'h0000fff7;
            rom_11730[362] <= 32'h00003001;
            rom_11730[363] <= 32'h00fecffe;
            rom_11730[364] <= 32'h00fff001;
            rom_11730[365] <= 32'h0000bffb;
            rom_11730[366] <= 32'h00ff3002;
            rom_11730[367] <= 32'h00002009;
            rom_11730[368] <= 32'h00000ffd;
            rom_11730[369] <= 32'h00ff6001;
            rom_11730[370] <= 32'h0000b00b;
            rom_11730[371] <= 32'h00007009;
            rom_11730[372] <= 32'h0000affa;
            rom_11730[373] <= 32'h00007ffe;
            rom_11730[374] <= 32'h00ffbffc;
            rom_11730[375] <= 32'h00ffc00c;
            rom_11730[376] <= 32'h00ff8004;
            rom_11730[377] <= 32'h00ffbffe;
            rom_11730[378] <= 32'h00002006;
            rom_11730[379] <= 32'h00002ffd;
            rom_11730[380] <= 32'h00000001;
            rom_11730[381] <= 32'h00000ffe;
            rom_11730[382] <= 32'h00007ffa;
            rom_11730[383] <= 32'h00007fff;
            rom_11730[384] <= 32'h00ffa004;
            rom_11730[385] <= 32'h0000300b;
            rom_11730[386] <= 32'h00ffaff5;
            rom_11730[387] <= 32'h00ff6ffd;
            rom_11730[388] <= 32'h00004001;
            rom_11730[389] <= 32'h00ffeffe;
            rom_11730[390] <= 32'h00007002;
            rom_11730[391] <= 32'h00ff700a;
            rom_11730[392] <= 32'h00ffcffa;
            rom_11730[393] <= 32'h00003008;
            rom_11730[394] <= 32'h0000600c;
            rom_11730[395] <= 32'h00007003;
            rom_11730[396] <= 32'h00012012;
            rom_11730[397] <= 32'h00006ffb;
            rom_11730[398] <= 32'h00ffbfe9;
            rom_11730[399] <= 32'h00fff001;
            rom_11730[400] <= 32'h00006000;
            rom_11730[401] <= 32'h00006008;
            rom_11730[402] <= 32'h0000000c;
            rom_11730[403] <= 32'h00008004;
            rom_11730[404] <= 32'h0000a007;
            rom_11730[405] <= 32'h00ffe003;
            rom_11730[406] <= 32'h00003012;
            rom_11730[407] <= 32'h00ffa000;
            rom_11730[408] <= 32'h00001007;
            rom_11730[409] <= 32'h0000e004;
            rom_11730[410] <= 32'h00000004;
            rom_11730[411] <= 32'h0001b000;
            rom_11730[412] <= 32'h00fff012;
            rom_11730[413] <= 32'h00ffa005;
            rom_11730[414] <= 32'h0000600c;
            rom_11730[415] <= 32'h00003008;
            rom_11730[416] <= 32'h00001000;
            rom_11730[417] <= 32'h00ffaffb;
            rom_11730[418] <= 32'h00012011;
            rom_11730[419] <= 32'h00002005;
            rom_11730[420] <= 32'h0000a003;
            rom_11730[421] <= 32'h00003015;
            rom_11730[422] <= 32'h00006008;
            rom_11730[423] <= 32'h00001012;
            rom_11730[424] <= 32'h0000200c;
            rom_11730[425] <= 32'h0000300d;
            rom_11730[426] <= 32'h0000bff8;
            rom_11730[427] <= 32'h00000007;
            rom_11730[428] <= 32'h0000a00c;
            rom_11730[429] <= 32'h00017ff9;
            rom_11730[430] <= 32'h00007006;
            rom_11730[431] <= 32'h0000500b;
            rom_11730[432] <= 32'h0000400b;
            rom_11730[433] <= 32'h0000f007;
            rom_11730[434] <= 32'h00ffaffe;
            rom_11730[435] <= 32'h0001200b;
            rom_11730[436] <= 32'h00fff00b;
            rom_11730[437] <= 32'h00002007;
            rom_11730[438] <= 32'h0000700a;
            rom_11730[439] <= 32'h0001300b;
            rom_11730[440] <= 32'h0000200c;
            rom_11730[441] <= 32'h00008006;
            rom_11730[442] <= 32'h0000b002;
            rom_11730[443] <= 32'h00006007;
            rom_11730[444] <= 32'h00016002;
            rom_11730[445] <= 32'h0000b00c;
            rom_11730[446] <= 32'h0000200b;
            rom_11730[447] <= 32'h00ffa00a;
            rom_11730[448] <= 32'h00008009;
            rom_11730[449] <= 32'h00016fff;
            rom_11730[450] <= 32'h0000300d;
            rom_11730[451] <= 32'h00000007;
            rom_11730[452] <= 32'h00fef005;
            rom_11730[453] <= 32'h00ffaffd;
            rom_11730[454] <= 32'h00002006;
            rom_11730[455] <= 32'h0000a003;
            rom_11730[456] <= 32'h0000a003;
            rom_11730[457] <= 32'h0000500a;
            rom_11730[458] <= 32'h00006001;
            rom_11730[459] <= 32'h0000bfed;
            rom_11730[460] <= 32'h00005003;
            rom_11730[461] <= 32'h0000700b;
            rom_11730[462] <= 32'h00002004;
            rom_11730[463] <= 32'h00004007;
            rom_11730[464] <= 32'h0000700c;
            rom_11730[465] <= 32'h00ffa002;
            rom_11730[466] <= 32'h0000a007;
            rom_11730[467] <= 32'h00005ffd;
            rom_11730[468] <= 32'h00006005;
            rom_11730[469] <= 32'h00006ffe;
            rom_11730[470] <= 32'h00000000;
            rom_11730[471] <= 32'h0000d006;
            rom_11730[472] <= 32'h0001eff8;
            rom_11730[473] <= 32'h00ffbfff;
            rom_11730[474] <= 32'h00013007;
            rom_11730[475] <= 32'h00006002;
            rom_11730[476] <= 32'h0000800c;
            rom_11730[477] <= 32'h0000c000;
            rom_11730[478] <= 32'h00002008;
            rom_11730[479] <= 32'h00fff005;
            rom_11730[480] <= 32'h00007000;
            rom_11730[481] <= 32'h0000a005;
            rom_11730[482] <= 32'h0000f006;
            rom_11730[483] <= 32'h00010ffc;
            rom_11730[484] <= 32'h00002005;
            rom_11730[485] <= 32'h0000400c;
            rom_11730[486] <= 32'h00006011;
            rom_11730[487] <= 32'h0000b009;
            rom_11730[488] <= 32'h00002ffb;
            rom_11730[489] <= 32'h00002005;
            rom_11730[490] <= 32'h0000a00c;
            rom_11730[491] <= 32'h00004006;
            rom_11730[492] <= 32'h00008003;
            rom_11730[493] <= 32'h00005007;
            rom_11730[494] <= 32'h00fffffe;
            rom_11730[495] <= 32'h00004001;
            rom_11730[496] <= 32'h00006002;
            rom_11730[497] <= 32'h00fffffd;
            rom_11730[498] <= 32'h0000300a;
            rom_11730[499] <= 32'h00ff600a;
            rom_11730[500] <= 32'h0000e007;
            rom_11730[501] <= 32'h00016011;
            rom_11730[502] <= 32'h0001400e;
            rom_11730[503] <= 32'h0000d00f;
            rom_11730[504] <= 32'h00ff8011;
            rom_11730[505] <= 32'h0000000a;
            rom_11730[506] <= 32'h0001600a;
            rom_11730[507] <= 32'h00007ff8;
            rom_11730[508] <= 32'h00015000;
            rom_11730[509] <= 32'h00ff9010;
            rom_11730[510] <= 32'h00ffe00b;
            rom_11730[511] <= 32'h00014003;
            rom_11730[512] <= 32'h0000f003;
            rom_11730[513] <= 32'h00012006;
            rom_11730[514] <= 32'h0001aff9;
            rom_11730[515] <= 32'h0000b012;
            rom_11730[516] <= 32'h00007012;
            rom_11730[517] <= 32'h00012006;
            rom_11730[518] <= 32'h0000dffc;
            rom_11730[519] <= 32'h00fff009;
            rom_11730[520] <= 32'h00ffe00b;
            rom_11730[521] <= 32'h00005ffb;
            rom_11730[522] <= 32'h0000c005;
            rom_11730[523] <= 32'h0000500d;
            rom_11730[524] <= 32'h00007003;
            rom_11730[525] <= 32'h0000e009;
            rom_11730[526] <= 32'h0000a009;
            rom_11730[527] <= 32'h00ff2002;
            rom_11730[528] <= 32'h0000e011;
            rom_11730[529] <= 32'h00004010;
            rom_11730[530] <= 32'h00fff000;
            rom_11730[531] <= 32'h0000500a;
            rom_11730[532] <= 32'h0001200b;
            rom_11730[533] <= 32'h00000007;
            rom_11730[534] <= 32'h0001f00a;
            rom_11730[535] <= 32'h00003007;
            rom_11730[536] <= 32'h00007ffc;
            rom_11730[537] <= 32'h00015003;
            rom_11730[538] <= 32'h00ffefff;
            rom_11730[539] <= 32'h00006008;
            rom_11730[540] <= 32'h0000f008;
            rom_11730[541] <= 32'h00007015;
            rom_11730[542] <= 32'h0000700c;
            rom_11730[543] <= 32'h00ff4005;
            rom_11730[544] <= 32'h0000b00c;
            rom_11730[545] <= 32'h00ff700a;
            rom_11730[546] <= 32'h0000cfff;
            rom_11730[547] <= 32'h0000500a;
            rom_11730[548] <= 32'h0000f009;
            rom_11730[549] <= 32'h0001700c;
            rom_11730[550] <= 32'h00011006;
            rom_11730[551] <= 32'h00005004;
            rom_11730[552] <= 32'h0000c004;
            rom_11730[553] <= 32'h0001bffa;
            rom_11730[554] <= 32'h00009014;
            rom_11730[555] <= 32'h0000f00a;
            rom_11730[556] <= 32'h0001300a;
            rom_11730[557] <= 32'h0000300d;
            rom_11730[558] <= 32'h00013015;
            rom_11730[559] <= 32'h00015006;
            rom_11730[560] <= 32'h00009fff;
            rom_11730[561] <= 32'h0000200a;
            rom_11730[562] <= 32'h0000a00a;
            rom_11730[563] <= 32'h0000c008;
            rom_11730[564] <= 32'h0000f008;
            rom_11730[565] <= 32'h00008001;
            rom_11730[566] <= 32'h0000b013;
            rom_11730[567] <= 32'h00fff013;
            rom_11730[568] <= 32'h00fff007;
            rom_11730[569] <= 32'h00002001;
            rom_11730[570] <= 32'h00009013;
            rom_11730[571] <= 32'h00ffe00d;
            rom_11730[572] <= 32'h0000e000;
            rom_11730[573] <= 32'h0000b00b;
            rom_11730[574] <= 32'h00009000;
            rom_11730[575] <= 32'h00013008;
            rom_11730[576] <= 32'h0000e002;
            rom_11730[577] <= 32'h0000e001;
            rom_11730[578] <= 32'h00ffa003;
            rom_11730[579] <= 32'h00013006;
            rom_11730[580] <= 32'h00006001;
            rom_11730[581] <= 32'h00fffffd;
            rom_11730[582] <= 32'h00006011;
            rom_11730[583] <= 32'h00000ff0;
            rom_11730[584] <= 32'h0000a00c;
            rom_11730[585] <= 32'h00015fff;
            rom_11730[586] <= 32'h0000300f;
            rom_11730[587] <= 32'h00010fff;
            rom_11730[588] <= 32'h0000fffd;
            rom_11730[589] <= 32'h0000000c;
            rom_11730[590] <= 32'h0000a00b;
            rom_11730[591] <= 32'h00003003;
            rom_11730[592] <= 32'h00023008;
            rom_11730[593] <= 32'h0000000a;
            rom_11730[594] <= 32'h00007ff9;
            rom_11730[595] <= 32'h00009005;
            rom_11730[596] <= 32'h00013006;
            rom_11730[597] <= 32'h00002001;
            rom_11730[598] <= 32'h0000e009;
            rom_11730[599] <= 32'h0000e005;

            // 0x11e00
            rom_11e00[0] <= 32'h0000ff71;
            rom_11e00[1] <= 32'h00001809;
            rom_11e00[2] <= 32'h00001809;

            // 0x132b8
            rom_132b8[0] <= 32'h30000000;
            rom_132b8[1] <= 32'h70000000;
            rom_132b8[2] <= 32'h30000000;
            rom_132b8[3] <= 32'h70000000;
            rom_132b8[4] <= 32'h70000000;
            rom_132b8[5] <= 32'h30000000;
            rom_132b8[6] <= 32'h70000000;

            // 0x132dC
            rom_132dC[0] <= 32'h4486888c;
            rom_132dC[1] <= 32'h4486888e;
            rom_132dC[2] <= 32'h4486888c;
            rom_132dC[3] <= 32'h4486888d;

            // 0x13e00
            rom_13e00[0] <= 32'h00000101;
            rom_13e00[1] <= 32'h000fc7f0;
            rom_13e00[2] <= 32'h000fc7f0;

            // 0x112d4
            rom_112d4[0] <= 32'h00000000;
            rom_112d4[1] <= 32'h00060000;

            // 0x132d4
            rom_132d4[0] <= 32'h00000000;
            rom_132d4[1] <= 32'h03f10000;

            // 0x1c004
            rom_1c004[0] <= 32'h00000000;

            // 0x1d004
            rom_1d004[0] <= 32'h00000000;

            // 0x15e10
            rom_15e10[0] <= 32'h22000001;
            rom_15e10[1] <= 32'h22000001;

            // 0x15e50
            rom_15e50[0] <= 32'h0030eb49;
            rom_15e50[1] <= 32'h0030eb49;
            rom_15e50[2] <= 32'h0030eb49;
            rom_15e50[3] <= 32'h0030eb49;
            rom_15e50[4] <= 32'h0030eb49;
            rom_15e50[5] <= 32'h0030eb49;
            rom_15e50[6] <= 32'h1030eb49;
            rom_15e50[7] <= 32'h2030eb49;
            rom_15e50[8] <= 32'h3030eb49;
            rom_15e50[9] <= 32'h4030eb49;
            rom_15e50[10] <= 32'h5030eb49;
            rom_15e50[11] <= 32'h6030eb49;
            rom_15e50[12] <= 32'h7030eb49;
            rom_15e50[13] <= 32'h8030eb49;
            rom_15e50[14] <= 32'h9030eb49;
            rom_15e50[15] <= 32'ha030eb49;
            rom_15e50[16] <= 32'hb030eb49;
            rom_15e50[17] <= 32'hc030eb49;
            rom_15e50[18] <= 32'hd030eb49;
            rom_15e50[19] <= 32'he030eb49;
            rom_15e50[20] <= 32'hf030eb49;
            rom_15e50[21] <= 32'hf030eb49;

            // 0x15e60
            rom_15e60[0] <= 32'h22000001;
            rom_15e60[1] <= 32'h22000001;

            // 0x112a0
            rom_112a0[0] <= 32'h24903156;
            rom_112a0[1] <= 32'h2490b156;
            rom_112a0[2] <= 32'h2490b156;
            rom_112a0[3] <= 32'h24903156;
            rom_112a0[4] <= 32'h24907156;
            rom_112a0[5] <= 32'h24907156;
            rom_112a0[6] <= 32'h24987156;
            rom_112a0[7] <= 32'h249b7156;

            // 0x112e0
            rom_112e0[0] <= 32'hc43a10e1;
            rom_112e0[1] <= 32'hc43b10e1;

            // 0x112e4
            rom_112e4[0] <= 32'h30d52c68;
            rom_112e4[1] <= 32'h3cd52c68;

            // 0x15e0C
            rom_15e0C[0] <= 32'h0000001c;
            rom_15e0C[1] <= 32'h00000014;
            rom_15e0C[2] <= 32'h00000015;
            rom_15e0C[3] <= 32'h0000001d;

            // 0x15e5C
            rom_15e5C[0] <= 32'h0000001c;
            rom_15e5C[1] <= 32'h00000014;
            rom_15e5C[2] <= 32'h00000015;
            rom_15e5C[3] <= 32'h0000001d;

            // 0x15e28
            rom_15e28[0] <= 32'h00000001;
            rom_15e28[1] <= 32'h88000001;
            rom_15e28[2] <= 32'h83000001;
            rom_15e28[3] <= 32'h836f0001;
            rom_15e28[4] <= 32'h837d0001;
            rom_15e28[5] <= 32'ha0000003;
            rom_15e28[6] <= 32'h8c000003;
            rom_15e28[7] <= 32'h8b000003;
            rom_15e28[8] <= 32'h8b870003;
            rom_15e28[9] <= 32'h8b800003;
            rom_15e28[10] <= 32'h90000007;
            rom_15e28[11] <= 32'h96000007;
            rom_15e28[12] <= 32'h97bf0007;
            rom_15e28[13] <= 32'h97830007;
            rom_15e28[14] <= 32'h0000000f;
            rom_15e28[15] <= 32'h9000000f;
            rom_15e28[16] <= 32'h8b00000f;
            rom_15e28[17] <= 32'h8b5f000f;
            rom_15e28[18] <= 32'h8b7b000f;
            rom_15e28[19] <= 32'hc000001f;
            rom_15e28[20] <= 32'h8800001f;
            rom_15e28[21] <= 32'h8b00001f;
            rom_15e28[22] <= 32'h8b6f001f;
            rom_15e28[23] <= 32'h8b7d001f;
            rom_15e28[24] <= 32'ha000003f;
            rom_15e28[25] <= 32'h8c00003f;
            rom_15e28[26] <= 32'h8b00003f;
            rom_15e28[27] <= 32'h8b7b003f;
            rom_15e28[28] <= 32'h0000007f;
            rom_15e28[29] <= 32'h8800007f;
            rom_15e28[30] <= 32'h8d00007f;
            rom_15e28[31] <= 32'h8d5f007f;
            rom_15e28[32] <= 32'h8d7d007f;
            rom_15e28[33] <= 32'hc00000ff;
            rom_15e28[34] <= 32'h880000ff;
            rom_15e28[35] <= 32'h8b0000ff;
            rom_15e28[36] <= 32'h8b6f00ff;
            rom_15e28[37] <= 32'h8b7c00ff;
            rom_15e28[38] <= 32'ha00001ff;
            rom_15e28[39] <= 32'h840001ff;
            rom_15e28[40] <= 32'h843f01ff;
            rom_15e28[41] <= 32'h847701ff;
            rom_15e28[42] <= 32'h847401ff;
            rom_15e28[43] <= 32'h900003ff;
            rom_15e28[44] <= 32'h820003ff;
            rom_15e28[45] <= 32'h813f03ff;
            rom_15e28[46] <= 32'h816b03ff;
            rom_15e28[47] <= 32'h000007ff;
            rom_15e28[48] <= 32'h700007ff;
            rom_15e28[49] <= 32'h7b0007ff;
            rom_15e28[50] <= 32'h7b5f07ff;
            rom_15e28[51] <= 32'h7b7307ff;
            rom_15e28[52] <= 32'hc0000fff;
            rom_15e28[53] <= 32'h88000fff;
            rom_15e28[54] <= 32'h89000fff;
            rom_15e28[55] <= 32'h896f0fff;
            rom_15e28[56] <= 32'h89750fff;
            rom_15e28[57] <= 32'ha0001fff;
            rom_15e28[58] <= 32'h84001fff;
            rom_15e28[59] <= 32'h83001fff;
            rom_15e28[60] <= 32'h83771fff;
            rom_15e28[61] <= 32'h83741fff;
            rom_15e28[62] <= 32'ha0003fff;
            rom_15e28[63] <= 32'h86003fff;
            rom_15e28[64] <= 32'h843f3fff;
            rom_15e28[65] <= 32'h84773fff;
            rom_15e28[66] <= 32'h81740000;
            rom_15e28[67] <= 32'h81740000;
            rom_15e28[68] <= 32'h81740000;
            rom_15e28[69] <= 32'h81740000;
            rom_15e28[70] <= 32'h81740000;
            rom_15e28[71] <= 32'h81740000;
            rom_15e28[72] <= 32'h81740000;
            rom_15e28[73] <= 32'h81740000;
            rom_15e28[74] <= 32'h81740000;
            rom_15e28[75] <= 32'h81740000;
            rom_15e28[76] <= 32'h81740000;
            rom_15e28[77] <= 32'h81740000;
            rom_15e28[78] <= 32'h407c0001;
            rom_15e28[79] <= 32'h787c0001;
            rom_15e28[80] <= 32'h7b7c0001;
            rom_15e28[81] <= 32'h7b8f0001;
            rom_15e28[82] <= 32'h7b810001;
            rom_15e28[83] <= 32'ha0800003;
            rom_15e28[84] <= 32'h84800003;
            rom_15e28[85] <= 32'h83800003;
            rom_15e28[86] <= 32'h83870003;
            rom_15e28[87] <= 32'h83860003;
            rom_15e28[88] <= 32'ha0840007;
            rom_15e28[89] <= 32'h92840007;
            rom_15e28[90] <= 32'h91bf0007;
            rom_15e28[91] <= 32'h91870007;
            rom_15e28[92] <= 32'h8b78000f;
            rom_15e28[93] <= 32'h9078000f;
            rom_15e28[94] <= 32'h8278000f;
            rom_15e28[95] <= 32'h835f000f;
            rom_15e28[96] <= 32'h837b000f;
            rom_15e28[97] <= 32'hc07e001f;
            rom_15e28[98] <= 32'h887e001f;
            rom_15e28[99] <= 32'h857e001f;
            rom_15e28[100] <= 32'h848f001f;
            rom_15e28[101] <= 32'h8485001f;
            rom_15e28[102] <= 32'h907c003f;
            rom_15e28[103] <= 32'h867c003f;
            rom_15e28[104] <= 32'h849f003f;
            rom_15e28[105] <= 32'h8483003f;
            rom_15e28[106] <= 32'h8d7e007f;
            rom_15e28[107] <= 32'h887e007f;
            rom_15e28[108] <= 32'h857e007f;
            rom_15e28[109] <= 32'h859f007f;
            rom_15e28[110] <= 32'h8585007f;
            rom_15e28[111] <= 32'hc07d00ff;
            rom_15e28[112] <= 32'h847d00ff;
            rom_15e28[113] <= 32'h837d00ff;
            rom_15e28[114] <= 32'h838f00ff;
            rom_15e28[115] <= 32'h838400ff;
            rom_15e28[116] <= 32'h607401ff;
            rom_15e28[117] <= 32'h7c7401ff;
            rom_15e28[118] <= 32'h7d3f01ff;
            rom_15e28[119] <= 32'h7d7701ff;
            rom_15e28[120] <= 32'h7d7c01ff;
            rom_15e28[121] <= 32'h706a03ff;
            rom_15e28[122] <= 32'h7a6a03ff;
            rom_15e28[123] <= 32'h793f03ff;
            rom_15e28[124] <= 32'h797303ff;
            rom_15e28[125] <= 32'h7b7507ff;
            rom_15e28[126] <= 32'h707507ff;
            rom_15e28[127] <= 32'h757507ff;
            rom_15e28[128] <= 32'h755f07ff;
            rom_15e28[129] <= 32'h757d07ff;
            rom_15e28[130] <= 32'hc0740fff;
            rom_15e28[131] <= 32'h88740fff;
            rom_15e28[132] <= 32'h82740fff;
            rom_15e28[133] <= 32'h826f0fff;
            rom_15e28[134] <= 32'h827d0fff;
            rom_15e28[135] <= 32'h60741fff;
            rom_15e28[136] <= 32'h7c741fff;
            rom_15e28[137] <= 32'h7b741fff;
            rom_15e28[138] <= 32'h7b771fff;
            rom_15e28[139] <= 32'h7b7c1fff;
            rom_15e28[140] <= 32'h60743fff;
            rom_15e28[141] <= 32'h7e743fff;
            rom_15e28[142] <= 32'h7d3f3fff;
            rom_15e28[143] <= 32'h7d773fff;
            rom_15e28[144] <= 32'h7b7cffff;

            // 0x15e78
            rom_15e78[0] <= 32'h7974ffff;

            // 0x15e48
            rom_15e48[0] <= 32'h00038b40;
            rom_15e48[1] <= 32'h00038b40;

            // 0x15e98
            rom_15e98[0] <= 32'h000d9000;
            rom_15e98[1] <= 32'h000d8600;
            rom_15e98[2] <= 32'h000da000;
            rom_15e98[3] <= 32'h000d8400;
            rom_15e98[4] <= 32'h00038400;
            rom_15e98[5] <= 32'h00038400;

            // 0x112e8
            rom_112e8[0] <= 32'h02024128;
            rom_112e8[1] <= 32'h0202412c;

            // 0x1c23C
            rom_1c23C[0] <= 32'h000d174a;
            rom_1c23C[1] <= 32'h000d374a;

            // 0x15e44
            rom_15e44[0] <= 32'h005e76f6;
            rom_15e44[1] <= 32'h005e76f6;
            rom_15e44[2] <= 32'h005e70f0;
            rom_15e44[3] <= 32'h005e6eee;
            rom_15e44[4] <= 32'h005e74f4;
            rom_15e44[5] <= 32'h005e7afa;
            rom_15e44[6] <= 32'h005e7afa;
            rom_15e44[7] <= 32'h005e7afa;
            rom_15e44[8] <= 32'h005e7afa;
            rom_15e44[9] <= 32'h005e7afa;
            rom_15e44[10] <= 32'h005e7cfc;
            rom_15e44[11] <= 32'h005e8606;
            rom_15e44[12] <= 32'h005e8000;
            rom_15e44[13] <= 32'h005e8606;
            rom_15e44[14] <= 32'h005e8606;
            rom_15e44[15] <= 32'h005e8a0a;

            // 0x15e94
            rom_15e94[0] <= 32'h006f67e7;
            rom_15e94[1] <= 32'h006f6ded;
            rom_15e94[2] <= 32'h006f6beb;
            rom_15e94[3] <= 32'h006f71f1;
            rom_15e94[4] <= 32'h006f73f3;
            rom_15e94[5] <= 32'h006f79f9;
            rom_15e94[6] <= 32'h006f79f9;
            rom_15e94[7] <= 32'h006f8303;
            rom_15e94[8] <= 32'h006f8505;
            rom_15e94[9] <= 32'h006f8909;
            rom_15e94[10] <= 32'h006f8909;
            rom_15e94[11] <= 32'h006f8d0d;
            rom_15e94[12] <= 32'h006f8909;
            rom_15e94[13] <= 32'h006f9313;
            rom_15e94[14] <= 32'h006f9313;
            rom_15e94[15] <= 32'h006f9919;

            // 0x15e30
            rom_15e30[0] <= 32'h03c37f00;

            // 0x15e80
            rom_15e80[0] <= 32'h03c38f00;

            // 0x15e14
            rom_15e14[0] <= 32'h8a868680;

            // 0x15e18
            rom_15e18[0] <= 32'h867c7a7a;

            // 0x15e1C
            rom_15e1C[0] <= 32'h7a7a7a74;

            // 0x15e20
            rom_15e20[0] <= 32'h6e707676;

            // 0x15e64
            rom_15e64[0] <= 32'h99939389;

            // 0x15e68
            rom_15e68[0] <= 32'h8d898985;

            // 0x15e6C
            rom_15e6C[0] <= 32'h83797973;

            // 0x15e70
            rom_15e70[0] <= 32'h716b6d67;

            // 0x17e10
            rom_17e10[0] <= 32'h22000001;
            rom_17e10[1] <= 32'h22000001;

            // 0x17e50
            rom_17e50[0] <= 32'h0030eb49;
            rom_17e50[1] <= 32'h0030eb49;
            rom_17e50[2] <= 32'h0030eb49;
            rom_17e50[3] <= 32'h0030eb49;
            rom_17e50[4] <= 32'h0030eb49;
            rom_17e50[5] <= 32'h0030eb49;
            rom_17e50[6] <= 32'h1030eb49;
            rom_17e50[7] <= 32'h2030eb49;
            rom_17e50[8] <= 32'h3030eb49;
            rom_17e50[9] <= 32'h4030eb49;
            rom_17e50[10] <= 32'h5030eb49;
            rom_17e50[11] <= 32'h6030eb49;
            rom_17e50[12] <= 32'h7030eb49;
            rom_17e50[13] <= 32'h8030eb49;
            rom_17e50[14] <= 32'h9030eb49;
            rom_17e50[15] <= 32'ha030eb49;
            rom_17e50[16] <= 32'hb030eb49;
            rom_17e50[17] <= 32'hc030eb49;
            rom_17e50[18] <= 32'hd030eb49;
            rom_17e50[19] <= 32'he030eb49;
            rom_17e50[20] <= 32'hf030eb49;
            rom_17e50[21] <= 32'hf030eb49;

            // 0x17e60
            rom_17e60[0] <= 32'h22000001;
            rom_17e60[1] <= 32'h22000001;

            // 0x132a0
            rom_132a0[0] <= 32'h24903156;
            rom_132a0[1] <= 32'h2490b156;
            rom_132a0[2] <= 32'h2490b156;
            rom_132a0[3] <= 32'h24903156;
            rom_132a0[4] <= 32'h24907156;
            rom_132a0[5] <= 32'h24907156;
            rom_132a0[6] <= 32'h24987156;
            rom_132a0[7] <= 32'h249b7156;

            // 0x132e0
            rom_132e0[0] <= 32'hc43a10e1;
            rom_132e0[1] <= 32'hc43b10e1;

            // 0x132e4
            rom_132e4[0] <= 32'h30d52c68;
            rom_132e4[1] <= 32'h3cd52c68;

            // 0x17e0C
            rom_17e0C[0] <= 32'h0000001c;
            rom_17e0C[1] <= 32'h00000014;
            rom_17e0C[2] <= 32'h00000015;
            rom_17e0C[3] <= 32'h0000001d;

            // 0x17e5C
            rom_17e5C[0] <= 32'h0000001c;
            rom_17e5C[1] <= 32'h00000014;
            rom_17e5C[2] <= 32'h00000015;
            rom_17e5C[3] <= 32'h0000001d;

            // 0x17e28
            rom_17e28[0] <= 32'hc0000001;
            rom_17e28[1] <= 32'h88000001;
            rom_17e28[2] <= 32'h84000001;
            rom_17e28[3] <= 32'h846f0001;
            rom_17e28[4] <= 32'h846a0001;
            rom_17e28[5] <= 32'h60000003;
            rom_17e28[6] <= 32'h7c000003;
            rom_17e28[7] <= 32'h7f3f0003;
            rom_17e28[8] <= 32'h7f670003;
            rom_17e28[9] <= 32'h7f640003;
            rom_17e28[10] <= 32'h70000007;
            rom_17e28[11] <= 32'h7e000007;
            rom_17e28[12] <= 32'h7f5f0007;
            rom_17e28[13] <= 32'h7f630007;
            rom_17e28[14] <= 32'h0000000f;
            rom_17e28[15] <= 32'h7800000f;
            rom_17e28[16] <= 32'h7b00000f;
            rom_17e28[17] <= 32'h7b5f000f;
            rom_17e28[18] <= 32'h7b5d000f;
            rom_17e28[19] <= 32'h4000001f;
            rom_17e28[20] <= 32'h7400001f;
            rom_17e28[21] <= 32'h7700001f;
            rom_17e28[22] <= 32'h776f001f;
            rom_17e28[23] <= 32'h7762001f;
            rom_17e28[24] <= 32'h6000003f;
            rom_17e28[25] <= 32'h7c00003f;
            rom_17e28[26] <= 32'h783f003f;
            rom_17e28[27] <= 32'h7857003f;
            rom_17e28[28] <= 32'h785e003f;
            rom_17e28[29] <= 32'h7000007f;
            rom_17e28[30] <= 32'h7a00007f;
            rom_17e28[31] <= 32'h7b5f007f;
            rom_17e28[32] <= 32'h7b69007f;
            rom_17e28[33] <= 32'h400000ff;
            rom_17e28[34] <= 32'h7c0000ff;
            rom_17e28[35] <= 32'h7d0000ff;
            rom_17e28[36] <= 32'h7d6700ff;
            rom_17e28[37] <= 32'h7d6400ff;
            rom_17e28[38] <= 32'ha00001ff;
            rom_17e28[39] <= 32'h820001ff;
            rom_17e28[40] <= 32'h803f01ff;
            rom_17e28[41] <= 32'h806701ff;
            rom_17e28[42] <= 32'h000003ff;
            rom_17e28[43] <= 32'h900003ff;
            rom_17e28[44] <= 32'h860003ff;
            rom_17e28[45] <= 32'h845f03ff;
            rom_17e28[46] <= 32'h846b03ff;
            rom_17e28[47] <= 32'h000007ff;
            rom_17e28[48] <= 32'h880007ff;
            rom_17e28[49] <= 32'h850007ff;
            rom_17e28[50] <= 32'h855f07ff;
            rom_17e28[51] <= 32'h856d07ff;
            rom_17e28[52] <= 32'hc0000fff;
            rom_17e28[53] <= 32'h88000fff;
            rom_17e28[54] <= 32'h8b000fff;
            rom_17e28[55] <= 32'h8b6f0fff;
            rom_17e28[56] <= 32'h8b720fff;
            rom_17e28[57] <= 32'ha0001fff;
            rom_17e28[58] <= 32'h84001fff;
            rom_17e28[59] <= 32'h873f1fff;
            rom_17e28[60] <= 32'h87771fff;
            rom_17e28[61] <= 32'h87721fff;
            rom_17e28[62] <= 32'h90003fff;
            rom_17e28[63] <= 32'h8a003fff;
            rom_17e28[64] <= 32'h8b3f3fff;
            rom_17e28[65] <= 32'h8b6b3fff;
            rom_17e28[66] <= 32'h816c0000;
            rom_17e28[67] <= 32'h816c0000;
            rom_17e28[68] <= 32'h816c0000;
            rom_17e28[69] <= 32'h816c0000;
            rom_17e28[70] <= 32'h816c0000;
            rom_17e28[71] <= 32'h816c0000;
            rom_17e28[72] <= 32'h816c0000;
            rom_17e28[73] <= 32'h816c0000;
            rom_17e28[74] <= 32'h816c0000;
            rom_17e28[75] <= 32'h816c0000;
            rom_17e28[76] <= 32'h816c0000;
            rom_17e28[77] <= 32'h816c0000;
            rom_17e28[78] <= 32'h816c0000;
            rom_17e28[79] <= 32'h816c0000;
            rom_17e28[80] <= 32'h816c0000;
            rom_17e28[81] <= 32'h706c0000;
            rom_17e28[82] <= 32'h766c0000;
            rom_17e28[83] <= 32'h745f0000;
            rom_17e28[84] <= 32'h747b0000;
            rom_17e28[85] <= 32'h846a0001;
            rom_17e28[86] <= 32'h786a0001;
            rom_17e28[87] <= 32'h796a0001;
            rom_17e28[88] <= 32'h785f0001;
            rom_17e28[89] <= 32'h78750001;
            rom_17e28[90] <= 32'h40650003;
            rom_17e28[91] <= 32'h78650003;
            rom_17e28[92] <= 32'h73650003;
            rom_17e28[93] <= 32'h736f0003;
            rom_17e28[94] <= 32'h73720003;
            rom_17e28[95] <= 32'h60640007;
            rom_17e28[96] <= 32'h74640007;
            rom_17e28[97] <= 32'h733f0007;
            rom_17e28[98] <= 32'h73770007;
            rom_17e28[99] <= 32'h73700007;
            rom_17e28[100] <= 32'h705e000f;
            rom_17e28[101] <= 32'h6e5e000f;
            rom_17e28[102] <= 32'h6f3f000f;
            rom_17e28[103] <= 32'h6f6b000f;
            rom_17e28[104] <= 32'h7763001f;
            rom_17e28[105] <= 32'h7063001f;
            rom_17e28[106] <= 32'h6b63001f;
            rom_17e28[107] <= 32'h6b5f001f;
            rom_17e28[108] <= 32'h6b6b001f;
            rom_17e28[109] <= 32'h405e003f;
            rom_17e28[110] <= 32'h685e003f;
            rom_17e28[111] <= 32'h6b5e003f;
            rom_17e28[112] <= 32'h6b6f003f;
            rom_17e28[113] <= 32'h6b69003f;
            rom_17e28[114] <= 32'h6069007f;
            rom_17e28[115] <= 32'h6e69007f;
            rom_17e28[116] <= 32'h6f3f007f;
            rom_17e28[117] <= 32'h6f73007f;
            rom_17e28[118] <= 32'h7d6500ff;
            rom_17e28[119] <= 32'h706500ff;
            rom_17e28[120] <= 32'h736500ff;
            rom_17e28[121] <= 32'h725f00ff;
            rom_17e28[122] <= 32'h727300ff;
            rom_17e28[123] <= 32'h406a01ff;
            rom_17e28[124] <= 32'h786a01ff;
            rom_17e28[125] <= 32'h736a01ff;
            rom_17e28[126] <= 32'h736f01ff;
            rom_17e28[127] <= 32'h737501ff;
            rom_17e28[128] <= 32'h406b03ff;
            rom_17e28[129] <= 32'h7c6b03ff;
            rom_17e28[130] <= 32'h796b03ff;
            rom_17e28[131] <= 32'h796f03ff;
            rom_17e28[132] <= 32'h797603ff;
            rom_17e28[133] <= 32'h606e07ff;
            rom_17e28[134] <= 32'h7a6e07ff;
            rom_17e28[135] <= 32'h793f07ff;
            rom_17e28[136] <= 32'h797707ff;
            rom_17e28[137] <= 32'h8b720fff;
            rom_17e28[138] <= 32'h70720fff;
            rom_17e28[139] <= 32'h7e720fff;
            rom_17e28[140] <= 32'h7f5f0fff;
            rom_17e28[141] <= 32'h7f7b0fff;
            rom_17e28[142] <= 32'h87721fff;
            rom_17e28[143] <= 32'h78721fff;
            rom_17e28[144] <= 32'h7b721fff;
            rom_17e28[145] <= 32'h7b5f1fff;
            rom_17e28[146] <= 32'h7b7d1fff;
            rom_17e28[147] <= 32'h406e3fff;
            rom_17e28[148] <= 32'h786e3fff;
            rom_17e28[149] <= 32'h7f6e3fff;
            rom_17e28[150] <= 32'h7f6f3fff;
            rom_17e28[151] <= 32'h7f793fff;
            rom_17e28[152] <= 32'h7478ffff;

            // 0x17e78
            rom_17e78[0] <= 32'h7477ffff;

            // 0x17e48
            rom_17e48[0] <= 32'h00038a40;
            rom_17e48[1] <= 32'h00038a40;

            // 0x17e98
            rom_17e98[0] <= 32'h000d9040;
            rom_17e98[1] <= 32'h000d8240;
            rom_17e98[2] <= 32'h0009a040;
            rom_17e98[3] <= 32'h000d8440;
            rom_17e98[4] <= 32'h00038440;
            rom_17e98[5] <= 32'h00038440;

            // 0x132e8
            rom_132e8[0] <= 32'h02024128;
            rom_132e8[1] <= 32'h0202412c;

            // 0x1d23C
            rom_1d23C[0] <= 32'h000d174a;
            rom_1d23C[1] <= 32'h000d374a;

            // 0x17e44
            rom_17e44[0] <= 32'h017e78f8;
            rom_17e44[1] <= 32'h017e74f4;
            rom_17e44[2] <= 32'h017e76f6;
            rom_17e44[3] <= 32'h017e78f8;
            rom_17e44[4] <= 32'h017e7cfc;
            rom_17e44[5] <= 32'h017e8202;
            rom_17e44[6] <= 32'h017e8000;
            rom_17e44[7] <= 32'h017e8202;
            rom_17e44[8] <= 32'h017e7efe;
            rom_17e44[9] <= 32'h017e7efe;
            rom_17e44[10] <= 32'h017e7cfc;
            rom_17e44[11] <= 32'h017e8000;
            rom_17e44[12] <= 32'h017e8000;
            rom_17e44[13] <= 32'h017e8202;
            rom_17e44[14] <= 32'h017e8202;
            rom_17e44[15] <= 32'h017e8808;

            // 0x17e94
            rom_17e94[0] <= 32'h00777cfc;
            rom_17e94[1] <= 32'h00777afa;
            rom_17e94[2] <= 32'h007778f8;
            rom_17e94[3] <= 32'h007778f8;
            rom_17e94[4] <= 32'h007778f8;
            rom_17e94[5] <= 32'h007776f6;
            rom_17e94[6] <= 32'h007774f4;
            rom_17e94[7] <= 32'h007776f6;
            rom_17e94[8] <= 32'h007774f4;
            rom_17e94[9] <= 32'h007774f4;
            rom_17e94[10] <= 32'h00777afa;
            rom_17e94[11] <= 32'h007778f8;
            rom_17e94[12] <= 32'h00777afa;
            rom_17e94[13] <= 32'h00777afa;
            rom_17e94[14] <= 32'h00778606;
            rom_17e94[15] <= 32'h00778404;

            // 0x17e30
            rom_17e30[0] <= 32'h03c3cf00;

            // 0x17e80
            rom_17e80[0] <= 32'h03c3bf00;

            // 0x17e14
            rom_17e14[0] <= 32'h88828280;

            // 0x17e18
            rom_17e18[0] <= 32'h807c7e7e;

            // 0x17e1C
            rom_17e1C[0] <= 32'h8280827c;

            // 0x17e20
            rom_17e20[0] <= 32'h78767478;

            // 0x17e64
            rom_17e64[0] <= 32'h84867a7a;

            // 0x17e68
            rom_17e68[0] <= 32'h787a7474;

            // 0x17e6C
            rom_17e6C[0] <= 32'h76747678;

            // 0x17e70
            rom_17e70[0] <= 32'h78787a7c;

            // 0xc348
            rom_c348[0] <= 32'h0000ffff; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c348[1] <= 32'h0000ffff; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c348[2] <= 32'h0000ffff; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c348[3] <= 32'h0000ffff; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // ops_read16+0x6d/0xf0 [rtw89pci]

            // 0x1c248
            rom_1c248[0] <= 32'h00088000;
            rom_1c248[1] <= 32'h00088000;
            rom_1c248[2] <= 32'h00088000;
            rom_1c248[3] <= 32'h00088000;
            rom_1c248[4] <= 32'h00089801;
            rom_1c248[5] <= 32'h00089800;

            // 0x1c250
            rom_1c250[0] <= 32'h00000080;

            // 0x1c24C
            rom_1c24C[0] <= 32'h00088000;

            // 0x1d248
            rom_1d248[0] <= 32'h00088000;
            rom_1d248[1] <= 32'h00088000;
            rom_1d248[2] <= 32'h00088000;
            rom_1d248[3] <= 32'h00088000;
            rom_1d248[4] <= 32'h00058801;
            rom_1d248[5] <= 32'h00058800;

            // 0x1d250
            rom_1d250[0] <= 32'h00000080;

            // 0x1d24C
            rom_1d24C[0] <= 32'h00088000;

            // 0x15804
            rom_15804[0] <= 32'h04237040;

            // 0x17804
            rom_17804[0] <= 32'h04237040;

            // 0x15808
            rom_15808[0] <= 32'h04237040;

            // 0x17808
            rom_17808[0] <= 32'h04237040;

            // 0x1c10C
            rom_1c10C[0] <= 32'h00000000;

            // 0x1d10C
            rom_1d10C[0] <= 32'h00000000;

            // 0x1c180
            rom_1c180[0] <= 32'h00011000;
            rom_1c180[1] <= 32'h00013000;

            // 0x1d180
            rom_1d180[0] <= 32'h00011000;
            rom_1d180[1] <= 32'h00013000;

            // 0x9c18
            rom_9c18[0] <= 32'h00025a95;
            rom_9c18[1] <= 32'h00025a95;

            // 0xc614
            rom_c614[0] <= 32'hffff0000; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c614[1] <= 32'h00000000; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c614[2] <= 32'hffff0000; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c614[3] <= 32'hffff0200; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c614[4] <= 32'h00000200; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c614[5] <= 32'hffff0200; // ops_read16+0x6d/0xf0 [rtw89pci]

            // 0x01a4
            rom_01a4[0] <= 32'h00110000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // interrupt_handler+0x4f/0x80 [rtw89pci]
            rom_01a4[1] <= 32'h00110000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // interrupt_handler+0x4f/0x80 [rtw89pci]
            rom_01a4[2] <= 32'h00110000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // interrupt_handler+0x4f/0x80 [rtw89pci]
            rom_01a4[3] <= 32'h00110000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // interrupt_handler+0x4f/0x80 [rtw89pci]
            rom_01a4[4] <= 32'h00110000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // interrupt_handler+0x4f/0x80 [rtw89pci]
            rom_01a4[5] <= 32'h00110000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // interrupt_handler+0x4f/0x80 [rtw89pci]
            rom_01a4[6] <= 32'h00110000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci] // interrupt_handler+0x4f/0x80 [rtw89pci]

            // 0x10b4
            rom_10b4[0] <= 32'h0001e001; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_10b4[1] <= 32'h0001e001; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_10b4[2] <= 32'h0001e001; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_10b4[3] <= 32'h0001e001; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_10b4[4] <= 32'h0001e001; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_10b4[5] <= 32'h0001e001; // recognize_intrs+0x28/0xe0 [rtw89pci]
            rom_10b4[6] <= 32'h0001e001; // recognize_intrs+0x28/0xe0 [rtw89pci]

            // 0x13b4
            rom_13b4[0] <= 32'h00000000; // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_13b4[1] <= 32'h00000000; // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_13b4[2] <= 32'h00000000; // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_13b4[3] <= 32'h00000000; // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_13b4[4] <= 32'h00000000; // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_13b4[5] <= 32'h00000000; // recognize_intrs+0x4b/0xe0 [rtw89pci]
            rom_13b4[6] <= 32'h00000000; // recognize_intrs+0x4b/0xe0 [rtw89pci]

            // 0x1054
            rom_1054[0] <= 32'h00000000; // napi_poll+0x5e/0x160 [rtw89pci]
            rom_1054[1] <= 32'h00000000; // napi_poll+0x5e/0x160 [rtw89pci]
            rom_1054[2] <= 32'h00000000; // napi_poll+0x5e/0x160 [rtw89pci]
            rom_1054[3] <= 32'h00000000; // napi_poll+0x5e/0x160 [rtw89pci]
            rom_1054[4] <= 32'h00000000; // napi_poll+0x5e/0x160 [rtw89pci]
            rom_1054[5] <= 32'h00000000; // napi_poll+0x5e/0x160 [rtw89pci]
            rom_1054[6] <= 32'h00000000; // napi_poll+0x5e/0x160 [rtw89pci]

            // 0x1050
            rom_1050[0] <= 32'h00100000; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_1050[1] <= 32'h00180010; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_1050[2] <= 32'h001a0018; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_1050[3] <= 32'h0024001a; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_1050[4] <= 32'h00280024; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_1050[5] <= 32'h00290028; // napi_poll+0xd5/0x160 [rtw89pci]
            rom_1050[6] <= 32'h002b0029; // napi_poll+0xd5/0x160 [rtw89pci]

            // 0xc400
            rom_c400[0] <= 32'h0001e01b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_c400[1] <= 32'h0001e01b; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_c400[2] <= 32'h0001e019; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_c400[3] <= 32'h0001e018; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_c400[4] <= 32'h0001e018; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_c400[5] <= 32'h0000c018; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_c400[6] <= 32'h0000c008; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_c400[7] <= 32'h0000c000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]
            rom_c400[8] <= 32'h0000c000; // ops_tx_kick_off+0x6e/0x80 [rtw89pci]

            // 0xc414
            rom_c414[0] <= 32'h00000064;

            // 0xc590
            rom_c590[0] <= 32'h02020202;

            // 0xca08
            rom_ca08[0] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ca08[1] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_ca08[2] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xc424
            rom_c424[0] <= 32'h01000000; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c424[1] <= 32'h01000000; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c424[2] <= 32'h01000000; // ops_read16+0x6d/0xf0 [rtw89pci]

            // 0xc63C
            rom_c63C[0] <= 32'h00000000;

            // 0xc404
            rom_c404[0] <= 32'h00c80002;
            rom_c404[1] <= 32'h00c80002;

            // 0xc408
            rom_c408[0] <= 32'h00000060;

            // 0xc40C
            rom_c40C[0] <= 32'h000500a0; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c40C[1] <= 32'h00050000; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c40C[2] <= 32'h000500a0; // ops_read16+0x6d/0xf0 [rtw89pci]
            rom_c40C[3] <= 32'h000500a0; // ops_read16+0x6d/0xf0 [rtw89pci]

            // 0xc6a0
            rom_c6a0[0] <= 32'h00000000;

            // 0xc568
            rom_c568[0] <= 32'h0000ffff;

            // 0x1d0f8
            rom_1d0f8[0] <= 32'h00000000;
            rom_1d0f8[1] <= 32'h00000001;

            // 0xce40
            rom_ce40[0] <= 32'h0000002f;

            // 0x10000
            rom_10000[0] <= 32'h8580801f;
            rom_10000[1] <= 32'h0580801f;

            // 0x120fC
            rom_120fC[0] <= 32'h00000000;
            rom_120fC[1] <= 32'h0f000000;

            // 0xc010
            rom_c010[0] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c010[1] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c010[2] <= 32'h00000000; // ops_read8+0x72/0x110 [rtw89pci]

            // 0xc628
            rom_c628[0] <= 32'h00100204; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c628[1] <= 32'h00000004; // ops_read8+0x72/0x110 [rtw89pci]
            rom_c628[2] <= 32'h00100204; // ops_read8+0x72/0x110 [rtw89pci]

            // 0x123b0
            rom_123b0[0] <= 32'h0001d5b0;

            // 0x123b4
            rom_123b4[0] <= 32'h000285d2;

            // 0x1c060
            rom_1c060[0] <= 32'h00000400;
            rom_1c060[1] <= 32'h00000400;
            rom_1c060[2] <= 32'h00000401;
            rom_1c060[3] <= 32'h00000401;

            // 0x1d060
            rom_1d060[0] <= 32'h00000401;
            rom_1d060[1] <= 32'h00000401;
            rom_1d060[2] <= 32'h00000401;
            rom_1d060[3] <= 32'h00000401;

            // 0x14718
            rom_14718[0] <= 32'h2a72ad09;

            // 0x14974
            rom_14974[0] <= 32'h800cd62d;
            rom_14974[1] <= 32'h800cd66d;

            // 0x14498
            rom_14498[0] <= 32'ha0000000;

            // 0x12300
            rom_12300[0] <= 32'h02748790;

            // 0x12304
            rom_12304[0] <= 32'h00558670;

            // 0x12308
            rom_12308[0] <= 32'h002883f0;

            // 0x1230C
            rom_1230C[0] <= 32'h00090120;

            // 0x12310
            rom_12310[0] <= 32'h00000000;

            // 0x12314
            rom_12314[0] <= 32'h06000000;

            // 0x12318
            rom_12318[0] <= 32'h00000000;

            // 0x1231C
            rom_1231C[0] <= 32'h00000000;

            // 0x14978
            rom_14978[0] <= 32'h00000103;
            rom_14978[1] <= 32'h00000103;

            // 0x112d0
            rom_112d0[0] <= 32'h00000000;

            // 0x132d0
            rom_132d0[0] <= 32'h00000000;

            // 0x12344
            rom_12344[0] <= 32'h0006318a;

            // 0x1469C
            rom_1469C[0] <= 32'h00000151;

            // 0x14770
            rom_14770[0] <= 32'h00000151;

            // 0x142c4
            rom_142c4[0] <= 32'h00280280;

            // 0x10734
            rom_10734[0] <= 32'h00000000;

            // 0xd204
            rom_d204[0] <= 32'h00000000;

            // 0x1058
            rom_1058[0] <= 32'h00000000; // napi_poll+0x14d/0x160 [rtw89pci]
            // 0x105C
            rom_105C[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x1060
            rom_1060[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x1064
            rom_1064[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x1068
            rom_1068[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x106C
            rom_106C[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x1070
            rom_1070[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x1074
            rom_1074[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x1078
            rom_1078[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x107C
            rom_107C[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x137C
            rom_137C[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x1380
            rom_1380[0] <= 32'h00000000; // ops_flush_queues+0x85/0xc0 [rtw89pci]
            // 0x8430
            rom_8430[0] <= 32'h07ff079f; // ops_flush_queues+0x85/0xc0 [rtw89pci]
    end else begin
        drd_req_ctx     <= rd_req_ctx;
        drd_req_valid   <= rd_req_valid;
        dwr_valid       <= wr_valid;
        drd_req_addr    <= rd_req_addr;
        rd_rsp_ctx      <= drd_req_ctx;
        rd_rsp_valid    <= drd_req_valid;
        dwr_addr        <= wr_addr;
        dwr_data        <= wr_data;

           if (drd_req_valid && rom_addr_check(local_addr)) begin
           case(local_addr)
                20'h00f0: rd_rsp_data <= rom_00f0[0];
                20'h02d0: rd_rsp_data <= rom_02d0[0];
                20'h03f0: begin
                    counter_03f0 <= (counter_03f0 == 2'd3) ? 2'd0 : counter_03f0 + 1;
                    rd_rsp_data <= rom_03f0[counter_03f0];
                end
                20'h00c4: begin
                    counter_00c4 <= (counter_00c4 == 1'd1) ? 1'd0 : counter_00c4 + 1;
                    rd_rsp_data <= rom_00c4[counter_00c4];
                end
                20'h0004: begin
                    counter_0004 <= (counter_0004 == 5'd30) ? 5'd0 : counter_0004 + 1;
                    rd_rsp_data <= rom_0004[counter_0004];
                end
                20'h0088: begin
                    counter_0088 <= (counter_0088 == 5'd19) ? 5'd0 : counter_0088 + 1;
                    rd_rsp_data <= rom_0088[counter_0088];
                end
                20'h0080: begin
                    counter_0080 <= (counter_0080 == 3'd5) ? 3'd0 : counter_0080 + 1;
                    rd_rsp_data <= rom_0080[counter_0080];
                end
                20'h0024: begin
                    counter_0024 <= (counter_0024 == 1'd1) ? 1'd0 : counter_0024 + 1;
                    rd_rsp_data <= rom_0024[counter_0024];
                end
                20'h02a0: begin
                    counter_02a0 <= (counter_02a0 == 2'd3) ? 2'd0 : counter_02a0 + 1;
                    rd_rsp_data <= rom_02a0[counter_02a0];
                end
                20'h0070: begin
                    counter_0070 <= (counter_0070 == 4'd12) ? 4'd0 : counter_0070 + 1;
                    rd_rsp_data <= rom_0070[counter_0070];
                end
                20'h8380: begin
                    counter_8380 <= (counter_8380 == 1'd1) ? 1'd0 : counter_8380 + 1;
                    rd_rsp_data <= rom_8380[counter_8380];
                end
                20'h8400: begin
                    counter_8400 <= (counter_8400 == 6'd41) ? 6'd0 : counter_8400 + 1;
                    rd_rsp_data <= rom_8400[counter_8400];
                end
                20'h8404: begin
                    counter_8404 <= (counter_8404 == 2'd2) ? 2'd0 : counter_8404 + 1;
                    rd_rsp_data <= rom_8404[counter_8404];
                end
                20'h8c08: begin
                    counter_8c08 <= (counter_8c08 == 2'd2) ? 2'd0 : counter_8c08 + 1;
                    rd_rsp_data <= rom_8c08[counter_8c08];
                end
                20'h9008: begin
                    counter_9008 <= (counter_9008 == 2'd2) ? 2'd0 : counter_9008 + 1;
                    rd_rsp_data <= rom_9008[counter_9008];
                end
                20'h8d00: begin
                    counter_8d00 <= (counter_8d00 == 3'd5) ? 3'd0 : counter_8d00 + 1;
                    rd_rsp_data <= rom_8d00[counter_8d00];
                end
                20'h9100: begin
                    counter_9100 <= (counter_9100 == 2'd2) ? 2'd0 : counter_9100 + 1;
                    rd_rsp_data <= rom_9100[counter_9100];
                end
                20'h8a00: begin
                    counter_8a00 <= (counter_8a00 == 4'd9) ? 4'd0 : counter_8a00 + 1;
                    rd_rsp_data <= rom_8a00[counter_8a00];
                end
                20'h1000: begin
                    counter_1000 <= (counter_1000 == 5'd24) ? 5'd0 : counter_1000 + 1;
                    rd_rsp_data <= rom_1000[counter_1000];
                end
                20'h1008: begin
                    counter_1008 <= (counter_1008 == 1'd1) ? 1'd0 : counter_1008 + 1;
                    rd_rsp_data <= rom_1008[counter_1008];
                end
                20'h10a0: begin
                    counter_10a0 <= (counter_10a0 == 6'd47) ? 6'd0 : counter_10a0 + 1;
                    rd_rsp_data <= rom_10a0[counter_10a0];
                end
                20'h10a4: begin
                    counter_10a4 <= (counter_10a4 == 3'd7) ? 3'd0 : counter_10a4 + 1;
                    rd_rsp_data <= rom_10a4[counter_10a4];
                end
                20'h0074: begin
                    counter_0074 <= (counter_0074 == 1'd1) ? 1'd0 : counter_0074 + 1;
                    rd_rsp_data <= rom_0074[counter_0074];
                end
                20'h13f0: begin
                    counter_13f0 <= (counter_13f0 == 3'd5) ? 3'd0 : counter_13f0 + 1;
                    rd_rsp_data <= rom_13f0[counter_13f0];
                end
                20'h11d8: begin
                    counter_11d8 <= (counter_11d8 == 2'd3) ? 2'd0 : counter_11d8 + 1;
                    rd_rsp_data <= rom_11d8[counter_11d8];
                end
                20'h11c0: begin
                    counter_11c0 <= (counter_11c0 == 1'd1) ? 1'd0 : counter_11c0 + 1;
                    rd_rsp_data <= rom_11c0[counter_11c0];
                end
                20'h1010: begin
                    counter_1010 <= (counter_1010 == 4'd12) ? 4'd0 : counter_1010 + 1;
                    rd_rsp_data <= rom_1010[counter_1010];
                end
                20'h101C: begin
                    counter_101C <= (counter_101C == 2'd3) ? 2'd0 : counter_101C + 1;
                    rd_rsp_data <= rom_101C[counter_101C];
                end
                20'h131C: begin
                    counter_131C <= (counter_131C == 1'd1) ? 1'd0 : counter_131C + 1;
                    rd_rsp_data <= rom_131C[counter_131C];
                end
                20'h1014: begin
                    counter_1014 <= (counter_1014 == 2'd2) ? 2'd0 : counter_1014 + 1;
                    rd_rsp_data <= rom_1014[counter_1014];
                end
                20'h1314: begin
                    counter_1314 <= (counter_1314 == 2'd2) ? 2'd0 : counter_1314 + 1;
                    rd_rsp_data <= rom_1314[counter_1314];
                end
                20'h1018: begin
                    counter_1018 <= (counter_1018 == 2'd2) ? 2'd0 : counter_1018 + 1;
                    rd_rsp_data <= rom_1018[counter_1018];
                end
                20'h1004: begin
                    counter_1004 <= (counter_1004 == 2'd3) ? 2'd0 : counter_1004 + 1;
                    rd_rsp_data <= rom_1004[counter_1004];
                end
                20'h8810: begin
                    counter_8810 <= (counter_8810 == 2'd2) ? 2'd0 : counter_8810 + 1;
                    rd_rsp_data <= rom_8810[counter_8810];
                end
                20'h9a00: begin
                    counter_9a00 <= (counter_9a00 == 2'd2) ? 2'd0 : counter_9a00 + 1;
                    rd_rsp_data <= rom_9a00[counter_9a00];
                end
                20'h1310: begin
                    counter_1310 <= (counter_1310 == 2'd2) ? 2'd0 : counter_1310 + 1;
                    rd_rsp_data <= rom_1310[counter_1310];
                end
                20'h01e0: begin
                    counter_01e0 <= (counter_01e0 == 6'd38) ? 6'd0 : counter_01e0 + 1;
                    rd_rsp_data <= rom_01e0[counter_01e0];
                end
                20'h0008: begin
                    counter_0008 <= (counter_0008 == 3'd4) ? 3'd0 : counter_0008 + 1;
                    rd_rsp_data <= rom_0008[counter_0008];
                end
                20'h40000: begin
                    counter_40000 <= (counter_40000 == 1'd1) ? 1'd0 : counter_40000 + 1;
                    rd_rsp_data <= rom_40000[counter_40000];
                end
                20'h01e4: begin
                    counter_01e4 <= (counter_01e4 == 1'd1) ? 1'd0 : counter_01e4 + 1;
                    rd_rsp_data <= rom_01e4[counter_01e4];
                end
                20'h1080: begin
                    counter_1080 <= (counter_1080 == 9'd424) ? 9'd0 : counter_1080 + 1;
                    rd_rsp_data <= rom_1080[counter_1080];
                end
                20'h0038: begin
                    counter_0038 <= (counter_0038 == 2'd2) ? 2'd0 : counter_0038 + 1;
                    rd_rsp_data <= rom_0038[counter_0038];
                end
                20'h0030: begin
                    counter_0030 <= (counter_0030 == 12'd2678) ? 12'd0 : counter_0030 + 1;
                    rd_rsp_data <= rom_0030[counter_0030];
                end
                20'h8160: begin
                    counter_8160 <= (counter_8160 == 3'd4) ? 3'd0 : counter_8160 + 1;
                    rd_rsp_data <= rom_8160[counter_8160];
                end
                20'h01f4: begin
                    counter_01f4 <= (counter_01f4 == 4'd9) ? 4'd0 : counter_01f4 + 1;
                    rd_rsp_data <= rom_01f4[counter_01f4];
                end
                20'h8164: begin
                    counter_8164 <= (counter_8164 == 6'd53) ? 6'd0 : counter_8164 + 1;
                    rd_rsp_data <= rom_8164[counter_8164];
                end
                20'h8150: begin
                    counter_8150 <= (counter_8150 == 3'd4) ? 3'd0 : counter_8150 + 1;
                    rd_rsp_data <= rom_8150[counter_8150];
                end
                20'h8154: begin
                    counter_8154 <= (counter_8154 == 3'd4) ? 3'd0 : counter_8154 + 1;
                    rd_rsp_data <= rom_8154[counter_8154];
                end
                20'h8158: begin
                    counter_8158 <= (counter_8158 == 3'd4) ? 3'd0 : counter_8158 + 1;
                    rd_rsp_data <= rom_8158[counter_8158];
                end
                20'h815C: begin
                    counter_815C <= (counter_815C == 3'd4) ? 3'd0 : counter_815C + 1;
                    rd_rsp_data <= rom_815C[counter_815C];
                end
                20'h02f0: begin
                    counter_02f0 <= (counter_02f0 == 3'd6) ? 3'd0 : counter_02f0 + 1;
                    rd_rsp_data <= rom_02f0[counter_02f0];
                end
                20'h0000: begin
                    counter_0000 <= (counter_0000 == 3'd4) ? 3'd0 : counter_0000 + 1;
                    rd_rsp_data <= rom_0000[counter_0000];
                end
                20'h0090: begin
                    counter_0090 <= (counter_0090 == 1'd1) ? 1'd0 : counter_0090 + 1;
                    rd_rsp_data <= rom_0090[counter_0090];
                end
                20'h8040: begin
                    counter_8040 <= (counter_8040 == 2'd2) ? 2'd0 : counter_8040 + 1;
                    rd_rsp_data <= rom_8040[counter_8040];
                end
                20'hc004: rd_rsp_data <= rom_c004[0];
                20'hc000: begin
                    counter_c000 <= (counter_c000 == 5'd25) ? 5'd0 : counter_c000 + 1;
                    rd_rsp_data <= rom_c000[counter_c000];
                end
                20'h0200: rd_rsp_data <= rom_0200[0];
                20'h8a50: rd_rsp_data <= rom_8a50[0];
                20'h8a54: rd_rsp_data <= rom_8a54[0];
                20'h8a58: rd_rsp_data <= rom_8a58[0];
                20'h8a5C: rd_rsp_data <= rom_8a5C[0];
                20'h8a60: rd_rsp_data <= rom_8a60[0];
                20'h8a64: rd_rsp_data <= rom_8a64[0];
                20'h8a68: rd_rsp_data <= rom_8a68[0];
                20'h8a6C: rd_rsp_data <= rom_8a6C[0];
                20'h8a70: rd_rsp_data <= rom_8a70[0];
                20'h8a74: rd_rsp_data <= rom_8a74[0];
                20'h8a78: rd_rsp_data <= rom_8a78[0];
                20'h8a7C: rd_rsp_data <= rom_8a7C[0];
                20'h8a98: rd_rsp_data <= rom_8a98[0];
                20'h8a8C: rd_rsp_data <= rom_8a8C[0];
                20'h8a9C: rd_rsp_data <= rom_8a9C[0];
                20'h8aa8: rd_rsp_data <= rom_8aa8[0];
                20'h8a04: rd_rsp_data <= rom_8a04[0];
                20'h8a94: rd_rsp_data <= rom_8a94[0];
                20'h8a90: rd_rsp_data <= rom_8a90[0];
                20'h9e10: begin
                    counter_9e10 <= (counter_9e10 == 3'd4) ? 3'd0 : counter_9e10 + 1;
                    rd_rsp_data <= rom_9e10[counter_9e10];
                end
                20'h9d00: rd_rsp_data <= rom_9d00[0];
                20'hc33C: rd_rsp_data <= rom_c33C[0];
                20'hc340: begin
                    counter_c340 <= (counter_c340 == 3'd6) ? 3'd0 : counter_c340 + 1;
                    rd_rsp_data <= rom_c340[counter_c340];
                end
                20'hc338: rd_rsp_data <= rom_c338[0];
                20'hce34: begin
                    counter_ce34 <= (counter_ce34 == 2'd2) ? 2'd0 : counter_ce34 + 1;
                    rd_rsp_data <= rom_ce34[counter_ce34];
                end
                20'hce04: begin
                    counter_ce04 <= (counter_ce04 == 2'd3) ? 2'd0 : counter_ce04 + 1;
                    rd_rsp_data <= rom_ce04[counter_ce04];
                end
                20'hc390: rd_rsp_data <= rom_c390[0];
                20'hcc00: rd_rsp_data <= rom_cc00[0];
                20'hcc04: begin
                    counter_cc04 <= (counter_cc04 == 3'd7) ? 3'd0 : counter_cc04 + 1;
                    rd_rsp_data <= rom_cc04[counter_cc04];
                end
                20'hcc80: begin
                    counter_cc80 <= (counter_cc80 == 1'd1) ? 1'd0 : counter_cc80 + 1;
                    rd_rsp_data <= rom_cc80[counter_cc80];
                end
                20'hce48: begin
                    counter_ce48 <= (counter_ce48 == 3'd5) ? 3'd0 : counter_ce48 + 1;
                    rd_rsp_data <= rom_ce48[counter_ce48];
                end
                20'hcc20: rd_rsp_data <= rom_cc20[0];
                20'hca00: rd_rsp_data <= rom_ca00[0];
                20'hca1C: begin
                    counter_ca1C <= (counter_ca1C == 1'd1) ? 1'd0 : counter_ca1C + 1;
                    rd_rsp_data <= rom_ca1C[counter_ca1C];
                end
                20'hcc08: begin
                    counter_cc08 <= (counter_cc08 == 1'd1) ? 1'd0 : counter_cc08 + 1;
                    rd_rsp_data <= rom_cc08[counter_cc08];
                end
                20'hce3C: begin
                    counter_ce3C <= (counter_ce3C == 3'd4) ? 3'd0 : counter_ce3C + 1;
                    rd_rsp_data <= rom_ce3C[counter_ce3C];
                end
                20'hce00: begin
                    counter_ce00 <= (counter_ce00 == 4'd11) ? 4'd0 : counter_ce00 + 1;
                    rd_rsp_data <= rom_ce00[counter_ce00];
                end
                20'hce20: begin
                    counter_ce20 <= (counter_ce20 == 2'd2) ? 2'd0 : counter_ce20 + 1;
                    rd_rsp_data <= rom_ce20[counter_ce20];
                end
                20'hc088: rd_rsp_data <= rom_c088[0];
                20'hc090: rd_rsp_data <= rom_c090[0];
                20'hc624: rd_rsp_data <= rom_c624[0];
                20'hc6e8: rd_rsp_data <= rom_c6e8[0];
                20'hc600: begin
                    counter_c600 <= (counter_c600 == 3'd5) ? 3'd0 : counter_c600 + 1;
                    rd_rsp_data <= rom_c600[counter_c600];
                end
                20'hc660: begin
                    counter_c660 <= (counter_c660 == 2'd2) ? 2'd0 : counter_c660 + 1;
                    rd_rsp_data <= rom_c660[counter_c660];
                end
                20'h9430: begin
                    counter_9430 <= (counter_9430 == 1'd1) ? 1'd0 : counter_9430 + 1;
                    rd_rsp_data <= rom_9430[counter_9430];
                end
                20'h9d1C: rd_rsp_data <= rom_9d1C[0];
                20'h9bf4: begin
                    counter_9bf4 <= (counter_9bf4 == 1'd1) ? 1'd0 : counter_9bf4 + 1;
                    rd_rsp_data <= rom_9bf4[counter_9bf4];
                end
                20'h9cf4: begin
                    counter_9cf4 <= (counter_9cf4 == 1'd1) ? 1'd0 : counter_9cf4 + 1;
                    rd_rsp_data <= rom_9cf4[counter_9cf4];
                end
                20'h9ef0: begin
                    counter_9ef0 <= (counter_9ef0 == 1'd1) ? 1'd0 : counter_9ef0 + 1;
                    rd_rsp_data <= rom_9ef0[counter_9ef0];
                end
                20'h9f1C: begin
                    counter_9f1C <= (counter_9f1C == 1'd1) ? 1'd0 : counter_9f1C + 1;
                    rd_rsp_data <= rom_9f1C[counter_9f1C];
                end
                20'h9f2C: begin
                    counter_9f2C <= (counter_9f2C == 1'd1) ? 1'd0 : counter_9f2C + 1;
                    rd_rsp_data <= rom_9f2C[counter_9f2C];
                end
                20'h8c38: begin
                    counter_8c38 <= (counter_8c38 == 1'd1) ? 1'd0 : counter_8c38 + 1;
                    rd_rsp_data <= rom_8c38[counter_8c38];
                end
                20'h9038: begin
                    counter_9038 <= (counter_9038 == 1'd1) ? 1'd0 : counter_9038 + 1;
                    rd_rsp_data <= rom_9038[counter_9038];
                end
                20'h9a20: rd_rsp_data <= rom_9a20[0];
                20'h8850: begin
                    counter_8850 <= (counter_8850 == 1'd1) ? 1'd0 : counter_8850 + 1;
                    rd_rsp_data <= rom_8850[counter_8850];
                end
                20'h8854: begin
                    counter_8854 <= (counter_8854 == 1'd1) ? 1'd0 : counter_8854 + 1;
                    rd_rsp_data <= rom_8854[counter_8854];
                end
                20'h8858: begin
                    counter_8858 <= (counter_8858 == 1'd1) ? 1'd0 : counter_8858 + 1;
                    rd_rsp_data <= rom_8858[counter_8858];
                end
                20'h9840: begin
                    counter_9840 <= (counter_9840 == 1'd1) ? 1'd0 : counter_9840 + 1;
                    rd_rsp_data <= rom_9840[counter_9840];
                end
                20'h960C: rd_rsp_data <= rom_960C[0];
                20'h962C: begin
                    counter_962C <= (counter_962C == 1'd1) ? 1'd0 : counter_962C + 1;
                    rd_rsp_data <= rom_962C[counter_962C];
                end
                20'h963C: rd_rsp_data <= rom_963C[0];
                20'h966C: rd_rsp_data <= rom_966C[0];
                20'hc3e8: begin
                    counter_c3e8 <= (counter_c3e8 == 1'd1) ? 1'd0 : counter_c3e8 + 1;
                    rd_rsp_data <= rom_c3e8[counter_c3e8];
                end
                20'hc6c0: begin
                    counter_c6c0 <= (counter_c6c0 == 1'd1) ? 1'd0 : counter_c6c0 + 1;
                    rd_rsp_data <= rom_c6c0[counter_c6c0];
                end
                20'hc800: begin
                    counter_c800 <= (counter_c800 == 1'd1) ? 1'd0 : counter_c800 + 1;
                    rd_rsp_data <= rom_c800[counter_c800];
                end
                20'hccfC: begin
                    counter_ccfC <= (counter_ccfC == 1'd1) ? 1'd0 : counter_ccfC + 1;
                    rd_rsp_data <= rom_ccfC[counter_ccfC];
                end
                20'hcef4: begin
                    counter_cef4 <= (counter_cef4 == 1'd1) ? 1'd0 : counter_cef4 + 1;
                    rd_rsp_data <= rom_cef4[counter_cef4];
                end
                20'hcceC: begin
                    counter_cceC <= (counter_cceC == 1'd1) ? 1'd0 : counter_cceC + 1;
                    rd_rsp_data <= rom_cceC[counter_cceC];
                end
                20'h9408: rd_rsp_data <= rom_9408[0];
                20'h9410: rd_rsp_data <= rom_9410[0];
                20'h9414: begin
                    counter_9414 <= (counter_9414 == 1'd1) ? 1'd0 : counter_9414 + 1;
                    rd_rsp_data <= rom_9414[counter_9414];
                end
                20'h8410: begin
                    counter_8410 <= (counter_8410 == 3'd5) ? 3'd0 : counter_8410 + 1;
                    rd_rsp_data <= rom_8410[counter_8410];
                end
                20'h8414: begin
                    counter_8414 <= (counter_8414 == 2'd2) ? 2'd0 : counter_8414 + 1;
                    rd_rsp_data <= rom_8414[counter_8414];
                end
                20'h8418: rd_rsp_data <= rom_8418[0];
                20'h841C: rd_rsp_data <= rom_841C[0];
                20'h158dC: begin
                    counter_158dC <= (counter_158dC == 3'd4) ? 3'd0 : counter_158dC + 1;
                    rd_rsp_data <= rom_158dC[counter_158dC];
                end
                20'h15818: begin
                    counter_15818 <= (counter_15818 == 2'd3) ? 2'd0 : counter_15818 + 1;
                    rd_rsp_data <= rom_15818[counter_15818];
                end
                20'h178dC: begin
                    counter_178dC <= (counter_178dC == 3'd4) ? 3'd0 : counter_178dC + 1;
                    rd_rsp_data <= rom_178dC[counter_178dC];
                end
                20'h17818: begin
                    counter_17818 <= (counter_17818 == 2'd3) ? 2'd0 : counter_17818 + 1;
                    rd_rsp_data <= rom_17818[counter_17818];
                end
                20'h10704: begin
                    counter_10704 <= (counter_10704 == 3'd7) ? 3'd0 : counter_10704 + 1;
                    rd_rsp_data <= rom_10704[counter_10704];
                end
                20'h0040: begin
                    counter_0040 <= (counter_0040 == 3'd5) ? 3'd0 : counter_0040 + 1;
                    rd_rsp_data <= rom_0040[counter_0040];
                end
                20'hda20: begin
                    counter_da20 <= (counter_da20 == 3'd5) ? 3'd0 : counter_da20 + 1;
                    rd_rsp_data <= rom_da20[counter_da20];
                end
                20'hda34: begin
                    counter_da34 <= (counter_da34 == 3'd5) ? 3'd0 : counter_da34 + 1;
                    rd_rsp_data <= rom_da34[counter_da34];
                end
                20'hda40: begin
                    counter_da40 <= (counter_da40 == 4'd13) ? 4'd0 : counter_da40 + 1;
                    rd_rsp_data <= rom_da40[counter_da40];
                end
                20'hdaf0: begin
                    counter_daf0 <= (counter_daf0 == 5'd17) ? 5'd0 : counter_daf0 + 1;
                    rd_rsp_data <= rom_daf0[counter_daf0];
                end
                20'hdaf8: begin
                    counter_daf8 <= (counter_daf8 == 1'd1) ? 1'd0 : counter_daf8 + 1;
                    rd_rsp_data <= rom_daf8[counter_daf8];
                end
                20'hda4C: begin
                    counter_da4C <= (counter_da4C == 3'd5) ? 3'd0 : counter_da4C + 1;
                    rd_rsp_data <= rom_da4C[counter_da4C];
                end
                20'hda6C: begin
                    counter_da6C <= (counter_da6C == 3'd5) ? 3'd0 : counter_da6C + 1;
                    rd_rsp_data <= rom_da6C[counter_da6C];
                end
                20'hda30: begin
                    counter_da30 <= (counter_da30 == 1'd1) ? 1'd0 : counter_da30 + 1;
                    rd_rsp_data <= rom_da30[counter_da30];
                end
                20'hda10: begin
                    counter_da10 <= (counter_da10 == 1'd1) ? 1'd0 : counter_da10 + 1;
                    rd_rsp_data <= rom_da10[counter_da10];
                end
                20'h1c008: begin
                    counter_1c008 <= (counter_1c008 == 1'd1) ? 1'd0 : counter_1c008 + 1;
                    rd_rsp_data <= rom_1c008[counter_1c008];
                end
                20'h1d008: begin
                    counter_1d008 <= (counter_1d008 == 1'd1) ? 1'd0 : counter_1d008 + 1;
                    rd_rsp_data <= rom_1d008[counter_1d008];
                end
                20'h1c3bC: begin
                    counter_1c3bC <= (counter_1c3bC == 3'd7) ? 3'd0 : counter_1c3bC + 1;
                    rd_rsp_data <= rom_1c3bC[counter_1c3bC];
                end
                20'h1c0cC: begin
                    counter_1c0cC <= (counter_1c0cC == 2'd3) ? 2'd0 : counter_1c0cC + 1;
                    rd_rsp_data <= rom_1c0cC[counter_1c0cC];
                end
                20'h1c0fC: begin
                    counter_1c0fC <= (counter_1c0fC == 2'd3) ? 2'd0 : counter_1c0fC + 1;
                    rd_rsp_data <= rom_1c0fC[counter_1c0fC];
                end
                20'h1d3bC: begin
                    counter_1d3bC <= (counter_1d3bC == 3'd7) ? 3'd0 : counter_1d3bC + 1;
                    rd_rsp_data <= rom_1d3bC[counter_1d3bC];
                end
                20'h1d0cC: begin
                    counter_1d0cC <= (counter_1d0cC == 2'd3) ? 2'd0 : counter_1d0cC + 1;
                    rd_rsp_data <= rom_1d0cC[counter_1d0cC];
                end
                20'h1d0fC: begin
                    counter_1d0fC <= (counter_1d0fC == 2'd3) ? 2'd0 : counter_1d0fC + 1;
                    rd_rsp_data <= rom_1d0fC[counter_1d0fC];
                end
                20'h00aC: begin
                    counter_00aC <= (counter_00aC == 4'd10) ? 4'd0 : counter_00aC + 1;
                    rd_rsp_data <= rom_00aC[counter_00aC];
                end
                20'hd200: begin
                    counter_d200 <= (counter_d200 == 1'd1) ? 1'd0 : counter_d200 + 1;
                    rd_rsp_data <= rom_d200[counter_d200];
                end
                20'hd220: rd_rsp_data <= rom_d220[0];
                20'hc67C: begin
                    counter_c67C <= (counter_c67C == 3'd5) ? 3'd0 : counter_c67C + 1;
                    rd_rsp_data <= rom_c67C[counter_c67C];
                end
                20'h1466C: begin
                    counter_1466C <= (counter_1466C == 3'd7) ? 3'd0 : counter_1466C + 1;
                    rd_rsp_data <= rom_1466C[counter_1466C];
                end
                20'h14740: begin
                    counter_14740 <= (counter_14740 == 3'd7) ? 3'd0 : counter_14740 + 1;
                    rd_rsp_data <= rom_14740[counter_14740];
                end
                20'h10980: begin
                    counter_10980 <= (counter_10980 == 3'd7) ? 3'd0 : counter_10980 + 1;
                    rd_rsp_data <= rom_10980[counter_10980];
                end
                20'h14624: begin
                    counter_14624 <= (counter_14624 == 3'd7) ? 3'd0 : counter_14624 + 1;
                    rd_rsp_data <= rom_14624[counter_14624];
                end
                20'h146f8: begin
                    counter_146f8 <= (counter_146f8 == 3'd7) ? 3'd0 : counter_146f8 + 1;
                    rd_rsp_data <= rom_146f8[counter_146f8];
                end
                20'h14674: begin
                    counter_14674 <= (counter_14674 == 4'd8) ? 4'd0 : counter_14674 + 1;
                    rd_rsp_data <= rom_14674[counter_14674];
                end
                20'h14748: begin
                    counter_14748 <= (counter_14748 == 4'd8) ? 4'd0 : counter_14748 + 1;
                    rd_rsp_data <= rom_14748[counter_14748];
                end
                20'h14650: begin
                    counter_14650 <= (counter_14650 == 4'd8) ? 4'd0 : counter_14650 + 1;
                    rd_rsp_data <= rom_14650[counter_14650];
                end
                20'h14724: begin
                    counter_14724 <= (counter_14724 == 3'd7) ? 3'd0 : counter_14724 + 1;
                    rd_rsp_data <= rom_14724[counter_14724];
                end
                20'h14688: begin
                    counter_14688 <= (counter_14688 == 3'd7) ? 3'd0 : counter_14688 + 1;
                    rd_rsp_data <= rom_14688[counter_14688];
                end
                20'h1475C: begin
                    counter_1475C <= (counter_1475C == 3'd7) ? 3'd0 : counter_1475C + 1;
                    rd_rsp_data <= rom_1475C[counter_1475C];
                end
                20'h1c108: begin
                    counter_1c108 <= (counter_1c108 == 2'd3) ? 2'd0 : counter_1c108 + 1;
                    rd_rsp_data <= rom_1c108[counter_1c108];
                end
                20'h1d108: begin
                    counter_1d108 <= (counter_1d108 == 2'd3) ? 2'd0 : counter_1d108 + 1;
                    rd_rsp_data <= rom_1d108[counter_1d108];
                end
                20'h10d7C: rd_rsp_data <= rom_10d7C[0];
                20'h12d7C: rd_rsp_data <= rom_12d7C[0];
                20'h10d84: rd_rsp_data <= rom_10d84[0];
                20'h10738: begin
                    counter_10738 <= (counter_10738 == 2'd2) ? 2'd0 : counter_10738 + 1;
                    rd_rsp_data <= rom_10738[counter_10738];
                end
                20'h14404: rd_rsp_data <= rom_14404[0];
                20'h1440C: rd_rsp_data <= rom_1440C[0];
                20'h109a4: begin
                    counter_109a4 <= (counter_109a4 == 1'd1) ? 1'd0 : counter_109a4 + 1;
                    rd_rsp_data <= rom_109a4[counter_109a4];
                end
                20'h10da0: rd_rsp_data <= rom_10da0[0];
                20'h10c00: begin
                    counter_10c00 <= (counter_10c00 == 2'd3) ? 2'd0 : counter_10c00 + 1;
                    rd_rsp_data <= rom_10c00[counter_10c00];
                end
                20'h10c2C: begin
                    counter_10c2C <= (counter_10c2C == 2'd2) ? 2'd0 : counter_10c2C + 1;
                    rd_rsp_data <= rom_10c2C[counter_10c2C];
                end
                20'h10c30: begin
                    counter_10c30 <= (counter_10c30 == 2'd2) ? 2'd0 : counter_10c30 + 1;
                    rd_rsp_data <= rom_10c30[counter_10c30];
                end
                20'h10c34: begin
                    counter_10c34 <= (counter_10c34 == 2'd2) ? 2'd0 : counter_10c34 + 1;
                    rd_rsp_data <= rom_10c34[counter_10c34];
                end
                20'h10c38: begin
                    counter_10c38 <= (counter_10c38 == 2'd2) ? 2'd0 : counter_10c38 + 1;
                    rd_rsp_data <= rom_10c38[counter_10c38];
                end
                20'h10764: begin
                    counter_10764 <= (counter_10764 == 1'd1) ? 1'd0 : counter_10764 + 1;
                    rd_rsp_data <= rom_10764[counter_10764];
                end
                20'h10768: begin
                    counter_10768 <= (counter_10768 == 1'd1) ? 1'd0 : counter_10768 + 1;
                    rd_rsp_data <= rom_10768[counter_10768];
                end
                20'h1076C: begin
                    counter_1076C <= (counter_1076C == 1'd1) ? 1'd0 : counter_1076C + 1;
                    rd_rsp_data <= rom_1076C[counter_1076C];
                end
                20'h10770: begin
                    counter_10770 <= (counter_10770 == 2'd2) ? 2'd0 : counter_10770 + 1;
                    rd_rsp_data <= rom_10770[counter_10770];
                end
                20'h10774: begin
                    counter_10774 <= (counter_10774 == 2'd2) ? 2'd0 : counter_10774 + 1;
                    rd_rsp_data <= rom_10774[counter_10774];
                end
                20'h14628: rd_rsp_data <= rom_14628[0];
                20'h1462C: begin
                    counter_1462C <= (counter_1462C == 2'd2) ? 2'd0 : counter_1462C + 1;
                    rd_rsp_data <= rom_1462C[counter_1462C];
                end
                20'h14630: begin
                    counter_14630 <= (counter_14630 == 2'd2) ? 2'd0 : counter_14630 + 1;
                    rd_rsp_data <= rom_14630[counter_14630];
                end
                20'h14634: begin
                    counter_14634 <= (counter_14634 == 2'd3) ? 2'd0 : counter_14634 + 1;
                    rd_rsp_data <= rom_14634[counter_14634];
                end
                20'h14638: begin
                    counter_14638 <= (counter_14638 == 2'd2) ? 2'd0 : counter_14638 + 1;
                    rd_rsp_data <= rom_14638[counter_14638];
                end
                20'h1463C: rd_rsp_data <= rom_1463C[0];
                20'h14640: begin
                    counter_14640 <= (counter_14640 == 1'd1) ? 1'd0 : counter_14640 + 1;
                    rd_rsp_data <= rom_14640[counter_14640];
                end
                20'h14644: begin
                    counter_14644 <= (counter_14644 == 2'd2) ? 2'd0 : counter_14644 + 1;
                    rd_rsp_data <= rom_14644[counter_14644];
                end
                20'h14668: rd_rsp_data <= rom_14668[0];
                20'h1473C: rd_rsp_data <= rom_1473C[0];
                20'h14658: rd_rsp_data <= rom_14658[0];
                20'h1472C: rd_rsp_data <= rom_1472C[0];
                20'h1481C: begin
                    counter_1481C <= (counter_1481C == 1'd1) ? 1'd0 : counter_1481C + 1;
                    rd_rsp_data <= rom_1481C[counter_1481C];
                end
                20'h146a0: rd_rsp_data <= rom_146a0[0];
                20'h146a4: rd_rsp_data <= rom_146a4[0];
                20'h14774: rd_rsp_data <= rom_14774[0];
                20'h14778: rd_rsp_data <= rom_14778[0];
                20'h0280: begin
                    counter_0280 <= (counter_0280 == 2'd3) ? 2'd0 : counter_0280 + 1;
                    rd_rsp_data <= rom_0280[counter_0280];
                end
                20'h14494: rd_rsp_data <= rom_14494[0];
                20'h14490: rd_rsp_data <= rom_14490[0];
                20'hd248: rd_rsp_data <= rom_d248[0];
                20'h10c70: rd_rsp_data <= rom_10c70[0];
                20'h10c60: rd_rsp_data <= rom_10c60[0];
                20'h10c6C: rd_rsp_data <= rom_10c6C[0];
                20'h158aC: rd_rsp_data <= rom_158aC[0];
                20'h178aC: rd_rsp_data <= rom_178aC[0];
                20'h18080: rd_rsp_data <= rom_18080[0];
                20'h1c014: begin
                    counter_1c014 <= (counter_1c014 == 3'd7) ? 3'd0 : counter_1c014 + 1;
                    rd_rsp_data <= rom_1c014[counter_1c014];
                end
                20'h1c000: begin
                    counter_1c000 <= (counter_1c000 == 3'd7) ? 3'd0 : counter_1c000 + 1;
                    rd_rsp_data <= rom_1c000[counter_1c000];
                end
                20'h1c06C: begin
                    counter_1c06C <= (counter_1c06C == 2'd3) ? 2'd0 : counter_1c06C + 1;
                    rd_rsp_data <= rom_1c06C[counter_1c06C];
                end
                20'h1c070: begin
                    counter_1c070 <= (counter_1c070 == 2'd2) ? 2'd0 : counter_1c070 + 1;
                    rd_rsp_data <= rom_1c070[counter_1c070];
                end
                20'h1c074: begin
                    counter_1c074 <= (counter_1c074 == 1'd1) ? 1'd0 : counter_1c074 + 1;
                    rd_rsp_data <= rom_1c074[counter_1c074];
                end
                20'h1c3c0: begin
                    counter_1c3c0 <= (counter_1c3c0 == 1'd1) ? 1'd0 : counter_1c3c0 + 1;
                    rd_rsp_data <= rom_1c3c0[counter_1c3c0];
                end
                20'h1d014: begin
                    counter_1d014 <= (counter_1d014 == 3'd7) ? 3'd0 : counter_1d014 + 1;
                    rd_rsp_data <= rom_1d014[counter_1d014];
                end
                20'h1d000: begin
                    counter_1d000 <= (counter_1d000 == 3'd7) ? 3'd0 : counter_1d000 + 1;
                    rd_rsp_data <= rom_1d000[counter_1d000];
                end
                20'h1d06C: begin
                    counter_1d06C <= (counter_1d06C == 2'd3) ? 2'd0 : counter_1d06C + 1;
                    rd_rsp_data <= rom_1d06C[counter_1d06C];
                end
                20'h1d070: begin
                    counter_1d070 <= (counter_1d070 == 2'd2) ? 2'd0 : counter_1d070 + 1;
                    rd_rsp_data <= rom_1d070[counter_1d070];
                end
                20'h1d074: begin
                    counter_1d074 <= (counter_1d074 == 1'd1) ? 1'd0 : counter_1d074 + 1;
                    rd_rsp_data <= rom_1d074[counter_1d074];
                end
                20'h1d3c0: begin
                    counter_1d3c0 <= (counter_1d3c0 == 1'd1) ? 1'd0 : counter_1d3c0 + 1;
                    rd_rsp_data <= rom_1d3c0[counter_1d3c0];
                end
                20'h112eC: begin
                    counter_112eC <= (counter_112eC == 2'd2) ? 2'd0 : counter_112eC + 1;
                    rd_rsp_data <= rom_112eC[counter_112eC];
                end
                20'h15e00: begin
                    counter_15e00 <= (counter_15e00 == 5'd23) ? 5'd0 : counter_15e00 + 1;
                    rd_rsp_data <= rom_15e00[counter_15e00];
                end
                20'h132eC: begin
                    counter_132eC <= (counter_132eC == 2'd2) ? 2'd0 : counter_132eC + 1;
                    rd_rsp_data <= rom_132eC[counter_132eC];
                end
                20'h17e00: begin
                    counter_17e00 <= (counter_17e00 == 5'd23) ? 5'd0 : counter_17e00 + 1;
                    rd_rsp_data <= rom_17e00[counter_17e00];
                end
                20'h112d8: begin
                    counter_112d8 <= (counter_112d8 == 4'd9) ? 4'd0 : counter_112d8 + 1;
                    rd_rsp_data <= rom_112d8[counter_112d8];
                end
                20'h132d8: begin
                    counter_132d8 <= (counter_132d8 == 4'd9) ? 4'd0 : counter_132d8 + 1;
                    rd_rsp_data <= rom_132d8[counter_132d8];
                end
                20'h112b8: begin
                    counter_112b8 <= (counter_112b8 == 3'd6) ? 3'd0 : counter_112b8 + 1;
                    rd_rsp_data <= rom_112b8[counter_112b8];
                end
                20'h1032C: begin
                    counter_1032C <= (counter_1032C == 5'd27) ? 5'd0 : counter_1032C + 1;
                    rd_rsp_data <= rom_1032C[counter_1032C];
                end
                20'h1030C: begin
                    counter_1030C <= (counter_1030C == 4'd13) ? 4'd0 : counter_1030C + 1;
                    rd_rsp_data <= rom_1030C[counter_1030C];
                end
                20'h112dC: begin
                    counter_112dC <= (counter_112dC == 2'd3) ? 2'd0 : counter_112dC + 1;
                    rd_rsp_data <= rom_112dC[counter_112dC];
                end
                20'h120f4: begin
                    counter_120f4 <= (counter_120f4 == 3'd5) ? 3'd0 : counter_120f4 + 1;
                    rd_rsp_data <= rom_120f4[counter_120f4];
                end
                20'h120f8: begin
                    counter_120f8 <= (counter_120f8 == 3'd5) ? 3'd0 : counter_120f8 + 1;
                    rd_rsp_data <= rom_120f8[counter_120f8];
                end
                20'h120f0: begin
                    counter_120f0 <= (counter_120f0 == 5'd23) ? 5'd0 : counter_120f0 + 1;
                    rd_rsp_data <= rom_120f0[counter_120f0];
                end
                20'h11730: begin
                    counter_11730 <= (counter_11730 == 10'd599) ? 10'd0 : counter_11730 + 1;
                    rd_rsp_data <= rom_11730[counter_11730];
                end
                20'h11e00: begin
                    counter_11e00 <= (counter_11e00 == 2'd2) ? 2'd0 : counter_11e00 + 1;
                    rd_rsp_data <= rom_11e00[counter_11e00];
                end
                20'h132b8: begin
                    counter_132b8 <= (counter_132b8 == 3'd6) ? 3'd0 : counter_132b8 + 1;
                    rd_rsp_data <= rom_132b8[counter_132b8];
                end
                20'h132dC: begin
                    counter_132dC <= (counter_132dC == 2'd3) ? 2'd0 : counter_132dC + 1;
                    rd_rsp_data <= rom_132dC[counter_132dC];
                end
                20'h13e00: begin
                    counter_13e00 <= (counter_13e00 == 2'd2) ? 2'd0 : counter_13e00 + 1;
                    rd_rsp_data <= rom_13e00[counter_13e00];
                end
                20'h112d4: begin
                    counter_112d4 <= (counter_112d4 == 1'd1) ? 1'd0 : counter_112d4 + 1;
                    rd_rsp_data <= rom_112d4[counter_112d4];
                end
                20'h132d4: begin
                    counter_132d4 <= (counter_132d4 == 1'd1) ? 1'd0 : counter_132d4 + 1;
                    rd_rsp_data <= rom_132d4[counter_132d4];
                end
                20'h15e10: begin
                    counter_15e10 <= (counter_15e10 == 1'd1) ? 1'd0 : counter_15e10 + 1;
                    rd_rsp_data <= rom_15e10[counter_15e10];
                end
                20'h15e50: begin
                    counter_15e50 <= (counter_15e50 == 5'd21) ? 5'd0 : counter_15e50 + 1;
                    rd_rsp_data <= rom_15e50[counter_15e50];
                end
                20'h15e60: begin
                    counter_15e60 <= (counter_15e60 == 1'd1) ? 1'd0 : counter_15e60 + 1;
                    rd_rsp_data <= rom_15e60[counter_15e60];
                end
                20'h112a0: begin
                    counter_112a0 <= (counter_112a0 == 3'd7) ? 3'd0 : counter_112a0 + 1;
                    rd_rsp_data <= rom_112a0[counter_112a0];
                end
                20'h112e0: begin
                    counter_112e0 <= (counter_112e0 == 1'd1) ? 1'd0 : counter_112e0 + 1;
                    rd_rsp_data <= rom_112e0[counter_112e0];
                end
                20'h112e4: begin
                    counter_112e4 <= (counter_112e4 == 1'd1) ? 1'd0 : counter_112e4 + 1;
                    rd_rsp_data <= rom_112e4[counter_112e4];
                end
                20'h15e0C: begin
                    counter_15e0C <= (counter_15e0C == 2'd3) ? 2'd0 : counter_15e0C + 1;
                    rd_rsp_data <= rom_15e0C[counter_15e0C];
                end
                20'h15e5C: begin
                    counter_15e5C <= (counter_15e5C == 2'd3) ? 2'd0 : counter_15e5C + 1;
                    rd_rsp_data <= rom_15e5C[counter_15e5C];
                end
                20'h15e28: begin
                    counter_15e28 <= (counter_15e28 == 8'd144) ? 8'd0 : counter_15e28 + 1;
                    rd_rsp_data <= rom_15e28[counter_15e28];
                end
                20'h15e78: rd_rsp_data <= rom_15e78[0];
                20'h15e48: begin
                    counter_15e48 <= (counter_15e48 == 1'd1) ? 1'd0 : counter_15e48 + 1;
                    rd_rsp_data <= rom_15e48[counter_15e48];
                end
                20'h15e98: begin
                    counter_15e98 <= (counter_15e98 == 3'd5) ? 3'd0 : counter_15e98 + 1;
                    rd_rsp_data <= rom_15e98[counter_15e98];
                end
                20'h112e8: begin
                    counter_112e8 <= (counter_112e8 == 1'd1) ? 1'd0 : counter_112e8 + 1;
                    rd_rsp_data <= rom_112e8[counter_112e8];
                end
                20'h1c23C: begin
                    counter_1c23C <= (counter_1c23C == 1'd1) ? 1'd0 : counter_1c23C + 1;
                    rd_rsp_data <= rom_1c23C[counter_1c23C];
                end
                20'h15e44: begin
                    counter_15e44 <= (counter_15e44 == 4'd15) ? 4'd0 : counter_15e44 + 1;
                    rd_rsp_data <= rom_15e44[counter_15e44];
                end
                20'h15e94: begin
                    counter_15e94 <= (counter_15e94 == 4'd15) ? 4'd0 : counter_15e94 + 1;
                    rd_rsp_data <= rom_15e94[counter_15e94];
                end
                20'h15e30: rd_rsp_data <= rom_15e30[0];
                20'h15e80: rd_rsp_data <= rom_15e80[0];
                20'h15e14: rd_rsp_data <= rom_15e14[0];
                20'h15e18: rd_rsp_data <= rom_15e18[0];
                20'h15e1C: rd_rsp_data <= rom_15e1C[0];
                20'h15e20: rd_rsp_data <= rom_15e20[0];
                20'h15e64: rd_rsp_data <= rom_15e64[0];
                20'h15e68: rd_rsp_data <= rom_15e68[0];
                20'h15e6C: rd_rsp_data <= rom_15e6C[0];
                20'h15e70: rd_rsp_data <= rom_15e70[0];
                20'h17e10: begin
                    counter_17e10 <= (counter_17e10 == 1'd1) ? 1'd0 : counter_17e10 + 1;
                    rd_rsp_data <= rom_17e10[counter_17e10];
                end
                20'h17e50: begin
                    counter_17e50 <= (counter_17e50 == 5'd21) ? 5'd0 : counter_17e50 + 1;
                    rd_rsp_data <= rom_17e50[counter_17e50];
                end
                20'h17e60: begin
                    counter_17e60 <= (counter_17e60 == 1'd1) ? 1'd0 : counter_17e60 + 1;
                    rd_rsp_data <= rom_17e60[counter_17e60];
                end
                20'h132a0: begin
                    counter_132a0 <= (counter_132a0 == 3'd7) ? 3'd0 : counter_132a0 + 1;
                    rd_rsp_data <= rom_132a0[counter_132a0];
                end
                20'h132e0: begin
                    counter_132e0 <= (counter_132e0 == 1'd1) ? 1'd0 : counter_132e0 + 1;
                    rd_rsp_data <= rom_132e0[counter_132e0];
                end
                20'h132e4: begin
                    counter_132e4 <= (counter_132e4 == 1'd1) ? 1'd0 : counter_132e4 + 1;
                    rd_rsp_data <= rom_132e4[counter_132e4];
                end
                20'h17e0C: begin
                    counter_17e0C <= (counter_17e0C == 2'd3) ? 2'd0 : counter_17e0C + 1;
                    rd_rsp_data <= rom_17e0C[counter_17e0C];
                end
                20'h17e5C: begin
                    counter_17e5C <= (counter_17e5C == 2'd3) ? 2'd0 : counter_17e5C + 1;
                    rd_rsp_data <= rom_17e5C[counter_17e5C];
                end
                20'h17e28: begin
                    counter_17e28 <= (counter_17e28 == 8'd152) ? 8'd0 : counter_17e28 + 1;
                    rd_rsp_data <= rom_17e28[counter_17e28];
                end
                20'h17e78: rd_rsp_data <= rom_17e78[0];
                20'h17e48: begin
                    counter_17e48 <= (counter_17e48 == 1'd1) ? 1'd0 : counter_17e48 + 1;
                    rd_rsp_data <= rom_17e48[counter_17e48];
                end
                20'h17e98: begin
                    counter_17e98 <= (counter_17e98 == 3'd5) ? 3'd0 : counter_17e98 + 1;
                    rd_rsp_data <= rom_17e98[counter_17e98];
                end
                20'h132e8: begin
                    counter_132e8 <= (counter_132e8 == 1'd1) ? 1'd0 : counter_132e8 + 1;
                    rd_rsp_data <= rom_132e8[counter_132e8];
                end
                20'h1d23C: begin
                    counter_1d23C <= (counter_1d23C == 1'd1) ? 1'd0 : counter_1d23C + 1;
                    rd_rsp_data <= rom_1d23C[counter_1d23C];
                end
                20'h17e44: begin
                    counter_17e44 <= (counter_17e44 == 4'd15) ? 4'd0 : counter_17e44 + 1;
                    rd_rsp_data <= rom_17e44[counter_17e44];
                end
                20'h17e94: begin
                    counter_17e94 <= (counter_17e94 == 4'd15) ? 4'd0 : counter_17e94 + 1;
                    rd_rsp_data <= rom_17e94[counter_17e94];
                end
                20'h17e30: rd_rsp_data <= rom_17e30[0];
                20'h17e80: rd_rsp_data <= rom_17e80[0];
                20'h17e14: rd_rsp_data <= rom_17e14[0];
                20'h17e18: rd_rsp_data <= rom_17e18[0];
                20'h17e1C: rd_rsp_data <= rom_17e1C[0];
                20'h17e20: rd_rsp_data <= rom_17e20[0];
                20'h17e64: rd_rsp_data <= rom_17e64[0];
                20'h17e68: rd_rsp_data <= rom_17e68[0];
                20'h17e6C: rd_rsp_data <= rom_17e6C[0];
                20'h17e70: rd_rsp_data <= rom_17e70[0];
                20'hc348: begin
                    counter_c348 <= (counter_c348 == 2'd3) ? 2'd0 : counter_c348 + 1;
                    rd_rsp_data <= rom_c348[counter_c348];
                end
                20'h1c248: begin
                    counter_1c248 <= (counter_1c248 == 3'd5) ? 3'd0 : counter_1c248 + 1;
                    rd_rsp_data <= rom_1c248[counter_1c248];
                end
                20'h1c250: rd_rsp_data <= rom_1c250[0];
                20'h1c24C: rd_rsp_data <= rom_1c24C[0];
                20'h1d248: begin
                    counter_1d248 <= (counter_1d248 == 3'd5) ? 3'd0 : counter_1d248 + 1;
                    rd_rsp_data <= rom_1d248[counter_1d248];
                end
                20'h1d250: rd_rsp_data <= rom_1d250[0];
                20'h1d24C: rd_rsp_data <= rom_1d24C[0];
                20'h15804: rd_rsp_data <= rom_15804[0];
                20'h17804: rd_rsp_data <= rom_17804[0];
                20'h15808: rd_rsp_data <= rom_15808[0];
                20'h17808: rd_rsp_data <= rom_17808[0];
                20'h1c180: begin
                    counter_1c180 <= (counter_1c180 == 1'd1) ? 1'd0 : counter_1c180 + 1;
                    rd_rsp_data <= rom_1c180[counter_1c180];
                end
                20'h1d180: begin
                    counter_1d180 <= (counter_1d180 == 1'd1) ? 1'd0 : counter_1d180 + 1;
                    rd_rsp_data <= rom_1d180[counter_1d180];
                end
                20'h9c18: begin
                    counter_9c18 <= (counter_9c18 == 1'd1) ? 1'd0 : counter_9c18 + 1;
                    rd_rsp_data <= rom_9c18[counter_9c18];
                end
                20'hc614: begin
                    counter_c614 <= (counter_c614 == 3'd5) ? 3'd0 : counter_c614 + 1;
                    rd_rsp_data <= rom_c614[counter_c614];
                end
                20'h01a4: begin
                    counter_01a4 <= (counter_01a4 == 3'd6) ? 3'd0 : counter_01a4 + 1;
                    rd_rsp_data <= rom_01a4[counter_01a4];
                end
                20'h10b4: begin
                    counter_10b4 <= (counter_10b4 == 3'd6) ? 3'd0 : counter_10b4 + 1;
                    rd_rsp_data <= rom_10b4[counter_10b4];
                end
                20'h13b4: begin
                    counter_13b4 <= (counter_13b4 == 3'd6) ? 3'd0 : counter_13b4 + 1;
                    rd_rsp_data <= rom_13b4[counter_13b4];
                end
                20'h1054: begin
                    counter_1054 <= (counter_1054 == 3'd6) ? 3'd0 : counter_1054 + 1;
                    rd_rsp_data <= rom_1054[counter_1054];
                end
                20'h1050: begin
                    counter_1050 <= (counter_1050 == 3'd6) ? 3'd0 : counter_1050 + 1;
                    rd_rsp_data <= rom_1050[counter_1050];
                end
                20'hc400: begin
                    counter_c400 <= (counter_c400 == 4'd8) ? 4'd0 : counter_c400 + 1;
                    rd_rsp_data <= rom_c400[counter_c400];
                end
                20'hc414: rd_rsp_data <= rom_c414[0];
                20'hc590: rd_rsp_data <= rom_c590[0];
                20'hca08: begin
                    counter_ca08 <= (counter_ca08 == 2'd2) ? 2'd0 : counter_ca08 + 1;
                    rd_rsp_data <= rom_ca08[counter_ca08];
                end
                20'hc424: begin
                    counter_c424 <= (counter_c424 == 2'd2) ? 2'd0 : counter_c424 + 1;
                    rd_rsp_data <= rom_c424[counter_c424];
                end
                20'hc404: begin
                    counter_c404 <= (counter_c404 == 1'd1) ? 1'd0 : counter_c404 + 1;
                    rd_rsp_data <= rom_c404[counter_c404];
                end
                20'hc408: rd_rsp_data <= rom_c408[0];
                20'hc40C: begin
                    counter_c40C <= (counter_c40C == 2'd3) ? 2'd0 : counter_c40C + 1;
                    rd_rsp_data <= rom_c40C[counter_c40C];
                end
                20'hc568: rd_rsp_data <= rom_c568[0];
                20'h1d0f8: begin
                    counter_1d0f8 <= (counter_1d0f8 == 1'd1) ? 1'd0 : counter_1d0f8 + 1;
                    rd_rsp_data <= rom_1d0f8[counter_1d0f8];
                end
                20'hce40: rd_rsp_data <= rom_ce40[0];
                20'h10000: begin
                    counter_10000 <= (counter_10000 == 1'd1) ? 1'd0 : counter_10000 + 1;
                    rd_rsp_data <= rom_10000[counter_10000];
                end
                20'h120fC: begin
                    counter_120fC <= (counter_120fC == 1'd1) ? 1'd0 : counter_120fC + 1;
                    rd_rsp_data <= rom_120fC[counter_120fC];
                end
                20'hc010: begin
                    counter_c010 <= (counter_c010 == 2'd2) ? 2'd0 : counter_c010 + 1;
                    rd_rsp_data <= rom_c010[counter_c010];
                end
                20'hc628: begin
                    counter_c628 <= (counter_c628 == 2'd2) ? 2'd0 : counter_c628 + 1;
                    rd_rsp_data <= rom_c628[counter_c628];
                end
                20'h123b0: rd_rsp_data <= rom_123b0[0];
                20'h123b4: rd_rsp_data <= rom_123b4[0];
                20'h1c060: begin
                    counter_1c060 <= (counter_1c060 == 2'd3) ? 2'd0 : counter_1c060 + 1;
                    rd_rsp_data <= rom_1c060[counter_1c060];
                end
                20'h1d060: begin
                    counter_1d060 <= (counter_1d060 == 2'd3) ? 2'd0 : counter_1d060 + 1;
                    rd_rsp_data <= rom_1d060[counter_1d060];
                end
                20'h14718: rd_rsp_data <= rom_14718[0];
                20'h14974: begin
                    counter_14974 <= (counter_14974 == 1'd1) ? 1'd0 : counter_14974 + 1;
                    rd_rsp_data <= rom_14974[counter_14974];
                end
                20'h14498: rd_rsp_data <= rom_14498[0];
                20'h12300: rd_rsp_data <= rom_12300[0];
                20'h12304: rd_rsp_data <= rom_12304[0];
                20'h12308: rd_rsp_data <= rom_12308[0];
                20'h1230C: rd_rsp_data <= rom_1230C[0];
                20'h12314: rd_rsp_data <= rom_12314[0];
                20'h14978: begin
                    counter_14978 <= (counter_14978 == 1'd1) ? 1'd0 : counter_14978 + 1;
                    rd_rsp_data <= rom_14978[counter_14978];
                end
                20'h12344: rd_rsp_data <= rom_12344[0];
                20'h1469C: rd_rsp_data <= rom_1469C[0];
                20'h14770: rd_rsp_data <= rom_14770[0];
                20'h142c4: rd_rsp_data <= rom_142c4[0];
                20'h8430: rd_rsp_data <= rom_8430[0];
                default: rd_rsp_data = 32'h00000000;
            endcase
        end
    end
end
endmodule
