// Green Beret (Rusn'n Attack) MiST top-level

module gberet_mist (
	output        LED,
	output  [5:0] VGA_R,
	output  [5:0] VGA_G,
	output  [5:0] VGA_B,
	output        VGA_HS,
	output        VGA_VS,
	output        AUDIO_L,
	output        AUDIO_R,
	input         SPI_SCK,
	output        SPI_DO,
	input         SPI_DI,
	input         SPI_SS2,
	input         SPI_SS3,
	input         CONF_DATA0,
	input         CLOCK_27,
	output [12:0] SDRAM_A,
	inout  [15:0] SDRAM_DQ,
	output        SDRAM_DQML,
	output        SDRAM_DQMH,
	output        SDRAM_nWE,
	output        SDRAM_nCAS,
	output        SDRAM_nRAS,
	output        SDRAM_nCS,
	output  [1:0] SDRAM_BA,
	output        SDRAM_CLK,
	output        SDRAM_CKE

);

`include "rtl\build_id.v" 

`define CORE_NAME "GBERET"

localparam CONF_STR = {
	`CORE_NAME, ";ROM;",
	"O2,Rotate Controls,Off,On;",
	"O34,Scandoubler Fx,None,CRT 25%,CRT 50%,CRT 75%;",
	"O5,Blend,Off,On;",
	"O89,Lives,2,3,5,7;",
	"OAB,Extend,20k/ev.60k,30k/ev.70k,40k/ev.80k,50k/ev.90k;",
	"OCD,Difficulty,Easy,Medium,Hard,Hardest;",
	"OE,Demo Sound,Off,On;",
	"T0,Reset;",
	"V,v1.00.",`BUILD_DATE
};

wire        rotate    = status[2];
wire  [1:0] scanlines = status[4:3];
wire        blend     = status[5];

wire  [1:0] dsLives   = ~status[9:8];
wire  [1:0] dsExtend  = ~status[11:10];
wire  [1:0] dsDiff    = ~status[13:12];
wire        dsDemoSnd = ~status[14];

wire  [6:0] core_mod;

assign      LED = ~ioctl_downl;
assign      AUDIO_R = AUDIO_L;
assign      SDRAM_CLK = clock_48;
assign      SDRAM_CKE = 1;

wire clock_48, pll_locked;
pll pll(
	.inclk0(CLOCK_27),
	.c0(clock_48),
	.locked(pll_locked)
	);

wire [31:0] status;
wire  [1:0] buttons;
wire  [1:0] switches;
wire  [7:0] joystick_0;
wire  [7:0] joystick_1;
wire        scandoublerD;
wire        ypbpr;
wire        no_csync;
wire        key_strobe;
wire        key_pressed;
wire  [7:0] key_code;

user_io #(.STRLEN($size(CONF_STR)>>3))user_io(
	.clk_sys        ( clock_48         ),
	.conf_str       ( CONF_STR         ),
	.SPI_CLK        ( SPI_SCK          ),
	.SPI_SS_IO      ( CONF_DATA0       ),
	.SPI_MISO       ( SPI_DO           ),
	.SPI_MOSI       ( SPI_DI           ),
	.buttons        ( buttons          ),
	.switches       ( switches         ),
	.scandoubler_disable ( scandoublerD ),
	.ypbpr          ( ypbpr            ),
	.no_csync       ( no_csync         ),
	.core_mod       ( core_mod         ),
	.key_strobe     ( key_strobe       ),
	.key_pressed    ( key_pressed      ),
	.key_code       ( key_code         ),
	.joystick_0     ( joystick_0       ),
	.joystick_1     ( joystick_1       ),
	.status         ( status           )
	);

wire [15:0] rom_addr;
wire [15:0] rom_do;
wire [15:1] spr_addr;
wire [15:0] spr_do;

wire        ioctl_downl;
wire  [7:0] ioctl_index;
wire        ioctl_wr;
wire [24:0] ioctl_addr;
wire  [7:0] ioctl_dout;

// Don't delete!
// ROM structure
// 00000 - 0FFFF - maincpu -  64k - 10c+8c+7c+7c
// 10000 - 1FFFF - gfx2    -  64k - 5e+4e+4f+3e
// 20000 - 23FFF - gfx1    -  16k - 3f
// 24000 - 240FF - sprites - 256b - 5f
// 24100 - 241FF - chars   - 256b - 6f
// 24200 - 2421F - pal     -  32b - 2f

data_io data_io(
	.clk_sys       ( clock_48     ),
	.SPI_SCK       ( SPI_SCK      ),
	.SPI_SS2       ( SPI_SS2      ),
	.SPI_DI        ( SPI_DI       ),
	.ioctl_download( ioctl_downl  ),
	.ioctl_index   ( ioctl_index  ),
	.ioctl_wr      ( ioctl_wr     ),
	.ioctl_addr    ( ioctl_addr   ),
	.ioctl_dout    ( ioctl_dout   )
);

wire [24:0] bg_ioctl_addr = ioctl_addr - 17'h10000;

reg port1_req, port2_req;
sdram sdram(
	.*,
	.init_n        ( pll_locked   ),
	.clk           ( clock_48      ),

	.port1_req     ( port1_req    ),
	.port1_ack     ( ),
	.port1_a       ( ioctl_addr[23:1] ),
	.port1_ds      ( {ioctl_addr[0], ~ioctl_addr[0]} ),
	.port1_we      ( ioctl_downl ),
	.port1_d       ( {ioctl_dout, ioctl_dout} ),
	.port1_q       ( ),

	.cpu1_addr     ( ioctl_downl ? 16'hffff : {1'b0, rom_addr[15:1]} ),
	.cpu1_q        ( rom_do ),

	// port2 for sprite graphics
	.port2_req     ( port2_req ),
	.port2_ack     ( ),
	.port2_a       ( bg_ioctl_addr[23:1] ),
	.port2_ds      ( {bg_ioctl_addr[0], ~bg_ioctl_addr[0]} ),
	.port2_we      ( ioctl_downl ),
	.port2_d       ( {ioctl_dout, ioctl_dout} ),
	.port2_q       ( ),

	.spr_addr      ( ioctl_downl ? 15'h7fff : spr_addr ),
	.spr_q         ( spr_do )
);

// ROM download controller
always @(posedge clock_48) begin
	reg        ioctl_wr_last = 0;

	ioctl_wr_last <= ioctl_wr;
	if (ioctl_downl) begin
		if (~ioctl_wr_last && ioctl_wr) begin
			port1_req <= ~port1_req;
			port2_req <= ~port2_req;
		end
	end
end

reg reset = 1;
reg rom_loaded = 0;
always @(posedge clock_48) begin
	reg ioctl_downlD;
	ioctl_downlD <= ioctl_downl;
	if (ioctl_downlD & ~ioctl_downl) rom_loaded <= 1;
	reset <= status[0] | buttons[1] | ioctl_downl | ~rom_loaded;
end

//////////////////////////////////////////////
wire  [7:0] audio;
wire        hs, vs;
wire        hb, vb;
wire        blankn = ~(hb | vb);
wire [3:0]  r, g, b;

wire        PCLK;
wire        PCLK_EN;
wire  [8:0] HPOS,VPOS;
wire [11:0] POUT;

HVGEN hvgen
(
	.HPOS(HPOS),.VPOS(VPOS),.CLK(clock_48),.PCLK_EN(PCLK_EN),.iRGB(POUT),
	.oRGB({b,g,r}),.HBLK(hb),.VBLK(vb),.HSYN(hs),.VSYN(vs)
);

wire  [5:0] INP0 = { m_fireB, m_fireA, m_left, m_down, m_right, m_up };
wire  [5:0] INP1 = { m_fire2B, m_fire2A, m_left2, m_down2, m_right2, m_up2 };
wire  [2:0] INP2 = { m_coin1 | m_coin2, m_two_players, m_one_player };

wire  [7:0] DSW0 = {dsDemoSnd,dsDiff,dsExtend,1'b0,dsLives};
wire  [7:0] DSW1 = 8'hFF;
wire  [7:0] DSW2 = 8'hFF;

FPGA_GreenBeret GameCore (
	.reset(reset),.clk48M(clock_48),
	.INP0(INP0),.INP1(INP1),.INP2(INP2),
	.DSW0(DSW0),.DSW1(DSW1),.DSW2(DSW2),

	.PH(HPOS),.PV(VPOS),.PCLK(PCLK),.PCLK_EN(PCLK_EN),.POUT(POUT),
	.SND(audio),

	.CPU_ROMA(rom_addr), .CPU_ROMDT(rom_addr[0] ? rom_do[15:8] : rom_do[7:0]),
	.SP_ROMA(spr_addr), .SP_ROMD(spr_do),
	.ROMCL(clock_48),.ROMAD(ioctl_addr),.ROMDT(ioctl_dout),.ROMEN(ioctl_wr)
);

//////////////////////////////////////////////

mist_video #(.COLOR_DEPTH(4), .SD_HCNT_WIDTH(10)) mist_video(
	.clk_sys        ( clock_48         ),
	.SPI_SCK        ( SPI_SCK          ),
	.SPI_SS3        ( SPI_SS3          ),
	.SPI_DI         ( SPI_DI           ),
	.R              ( blankn ? r : 0   ),
	.G              ( blankn ? g : 0   ),
	.B              ( blankn ? b : 0   ),
	.HSync          ( hs               ),
	.VSync          ( vs               ),
	.VGA_R          ( VGA_R            ),
	.VGA_G          ( VGA_G            ),
	.VGA_B          ( VGA_B            ),
	.VGA_VS         ( VGA_VS           ),
	.VGA_HS         ( VGA_HS           ),
	.rotate         ( { 1'b1, rotate } ),
	.scandoubler_disable( scandoublerD ),
	.blend          ( blend            ),
	.scanlines      ( scanlines        ),
	.no_csync       ( no_csync         ),
	.ypbpr          ( ypbpr            )
	);

dac #(8) dac(
	.clk_i(clock_48),
	.res_n_i(1),
	.dac_i(audio),
	.dac_o(AUDIO_L)
	);

wire m_up, m_down, m_left, m_right, m_fireA, m_fireB, m_fireC, m_fireD, m_fireE, m_fireF;
wire m_up2, m_down2, m_left2, m_right2, m_fire2A, m_fire2B, m_fire2C, m_fire2D, m_fire2E, m_fire2F;
wire m_tilt, m_coin1, m_coin2, m_coin3, m_coin4, m_one_player, m_two_players, m_three_players, m_four_players;

arcade_inputs inputs (
	.clk         ( clock_48    ),
	.key_strobe  ( key_strobe  ),
	.key_pressed ( key_pressed ),
	.key_code    ( key_code    ),
	.joystick_0  ( joystick_0  ),
	.joystick_1  ( joystick_1  ),
	.rotate      ( rotate      ),
	.orientation ( 2'b10       ),
	.joyswap     ( 1'b0        ),
	.oneplayer   ( 1'b1        ),
	.controls    ( {m_tilt, m_coin4, m_coin3, m_coin2, m_coin1, m_four_players, m_three_players, m_two_players, m_one_player} ),
	.player1     ( {m_fireF, m_fireE, m_fireD, m_fireC, m_fireB, m_fireA, m_up, m_down, m_left, m_right} ),
	.player2     ( {m_fire2F, m_fire2E, m_fire2D, m_fire2C, m_fire2B, m_fire2A, m_up2, m_down2, m_left2, m_right2} )
);

endmodule
