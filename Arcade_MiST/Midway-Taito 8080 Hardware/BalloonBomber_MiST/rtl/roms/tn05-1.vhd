library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity tn05_1 is
port (
	clk  : in  std_logic;
	addr : in  std_logic_vector(10 downto 0);
	data : out std_logic_vector(7 downto 0)
);
end entity;

architecture prom of tn05_1 is
	type rom is array(0 to  2047) of std_logic_vector(7 downto 0);
	signal rom_data: rom := (
		X"01",X"01",X"00",X"00",X"02",X"02",X"01",X"00",X"01",X"02",X"02",X"02",X"02",X"00",X"00",X"01",
		X"01",X"00",X"00",X"00",X"06",X"0E",X"0E",X"03",X"15",X"04",X"11",X"18",X"1B",X"1B",X"05",X"08",
		X"0D",X"04",X"13",X"08",X"0B",X"13",X"00",X"00",X"07",X"07",X"02",X"1C",X"8B",X"77",X"8B",X"1C",
		X"02",X"07",X"07",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"38",X"00",X"F0",
		X"00",X"70",X"00",X"30",X"00",X"18",X"00",X"18",X"00",X"18",X"00",X"1C",X"00",X"1C",X"00",X"1C",
		X"00",X"3E",X"00",X"BE",X"00",X"E0",X"00",X"9C",X"00",X"9C",X"00",X"9C",X"80",X"B0",X"C0",X"AD",
		X"C0",X"DC",X"00",X"9E",X"00",X"9E",X"00",X"1E",X"00",X"04",X"00",X"38",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"38",X"00",X"F0",X"00",X"70",X"00",X"30",
		X"00",X"18",X"00",X"18",X"00",X"18",X"00",X"1C",X"00",X"1C",X"00",X"1C",X"00",X"3E",X"00",X"BE",
		X"00",X"E0",X"00",X"9C",X"00",X"9C",X"00",X"9C",X"80",X"B0",X"C0",X"AD",X"C0",X"DC",X"00",X"9E",
		X"00",X"9E",X"00",X"1E",X"00",X"04",X"80",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"38",
		X"00",X"04",X"00",X"1E",X"00",X"9E",X"00",X"9E",X"C0",X"DC",X"C0",X"AD",X"80",X"B0",X"00",X"9C",
		X"00",X"9C",X"00",X"9C",X"00",X"E0",X"00",X"BE",X"00",X"3E",X"00",X"1C",X"00",X"1C",X"00",X"1C",
		X"00",X"18",X"00",X"18",X"00",X"18",X"00",X"30",X"00",X"70",X"00",X"F0",X"00",X"38",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"80",X"03",X"00",X"04",X"00",X"1E",X"00",X"9E",X"00",X"9E",X"C0",
		X"DC",X"C0",X"AD",X"80",X"B0",X"00",X"9C",X"00",X"9C",X"00",X"9C",X"00",X"E0",X"00",X"BE",X"00",
		X"3E",X"00",X"1C",X"00",X"1C",X"00",X"1C",X"00",X"18",X"00",X"18",X"00",X"18",X"00",X"30",X"00",
		X"70",X"00",X"F0",X"00",X"38",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"60",X"00",X"00",X"30",X"00",X"80",X"1B",X"00",X"C0",X"FF",X"00",X"C0",
		X"67",X"00",X"C0",X"0B",X"00",X"00",X"08",X"00",X"00",X"08",X"00",X"00",X"08",X"00",X"00",X"10",
		X"1E",X"00",X"10",X"3F",X"00",X"90",X"7F",X"00",X"E0",X"FF",X"00",X"E0",X"FF",X"00",X"E0",X"FF",
		X"00",X"C0",X"FF",X"00",X"C0",X"FF",X"00",X"80",X"7F",X"00",X"00",X"3F",X"00",X"00",X"1E",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"00",X"80",
		X"01",X"00",X"80",X"07",X"00",X"80",X"03",X"00",X"F0",X"00",X"00",X"78",X"01",X"00",X"78",X"02",
		X"1E",X"38",X"04",X"3F",X"38",X"88",X"7F",X"00",X"D0",X"FF",X"00",X"E0",X"FF",X"00",X"E0",X"FF",
		X"00",X"C0",X"FF",X"00",X"C0",X"FF",X"00",X"80",X"7F",X"00",X"00",X"3F",X"00",X"00",X"1E",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"40",X"00",X"00",X"40",X"02",X"00",X"C0",X"01",X"00",X"C0",X"00",
		X"1E",X"40",X"00",X"3F",X"F0",X"81",X"7F",X"78",X"C6",X"FF",X"78",X"D8",X"FF",X"38",X"E0",X"FF",
		X"38",X"C0",X"FF",X"00",X"C0",X"FF",X"00",X"80",X"7F",X"00",X"00",X"3F",X"00",X"00",X"1E",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"24",X"00",X"00",X"34",X"00",
		X"1E",X"34",X"00",X"3F",X"3C",X"80",X"7F",X"3C",X"C0",X"FF",X"18",X"C0",X"FF",X"F8",X"FF",X"FF",
		X"1C",X"C0",X"FF",X"3C",X"C0",X"FF",X"3C",X"80",X"7F",X"38",X"00",X"3F",X"10",X"00",X"1E",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"1E",X"00",X"00",X"3F",X"00",X"80",X"7F",X"00",X"C0",X"FF",X"00",X"C0",X"FF",X"20",X"E0",X"FF",
		X"24",X"D8",X"FF",X"38",X"C6",X"FF",X"B0",X"81",X"7F",X"60",X"00",X"3F",X"E0",X"00",X"1E",X"E0",
		X"00",X"00",X"E0",X"01",X"00",X"E0",X"01",X"00",X"C0",X"01",X"00",X"80",X"01",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"1E",X"00",X"00",X"3F",X"00",X"80",X"7F",X"00",X"C0",X"FF",X"00",X"C0",X"FF",X"00",X"E0",X"FF",
		X"00",X"E0",X"FF",X"00",X"D0",X"FF",X"40",X"88",X"7F",X"40",X"04",X"3F",X"40",X"02",X"1E",X"F8",
		X"01",X"00",X"E0",X"00",X"00",X"80",X"03",X"00",X"80",X"07",X"00",X"00",X"07",X"00",X"00",X"07",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"1E",X"00",X"00",X"3F",X"00",X"80",X"7F",X"00",X"C0",X"FF",X"00",X"C0",X"FF",X"00",X"E0",X"FF",
		X"00",X"E0",X"FF",X"00",X"E0",X"FF",X"00",X"90",X"7F",X"00",X"10",X"3F",X"00",X"10",X"1E",X"00",
		X"08",X"00",X"00",X"08",X"00",X"80",X"05",X"00",X"00",X"0B",X"00",X"00",X"06",X"00",X"C0",X"7F",
		X"00",X"00",X"FB",X"00",X"00",X"F0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"15",X"00",
		X"1F",X"00",X"1F",X"00",X"06",X"00",X"F2",X"00",X"2D",X"C0",X"DE",X"7F",X"DE",X"7F",X"2D",X"C0",
		X"F2",X"00",X"06",X"00",X"1F",X"00",X"1F",X"00",X"15",X"00",X"DE",X"3F",X"DE",X"7C",X"7C",X"7C",
		X"12",X"02",X"0E",X"11",X"04",X"1C",X"21",X"1B",X"1B",X"07",X"08",X"1C",X"12",X"02",X"0E",X"11",
		X"04",X"1B",X"1B",X"12",X"02",X"0E",X"11",X"04",X"1C",X"22",X"00",X"00",X"03",X"30",X"03",X"30",
		X"1D",X"26",X"1D",X"29",X"1D",X"2F",X"05",X"23",X"1D",X"26",X"00",X"00",X"7F",X"04",X"0F",X"03",
		X"83",X"40",X"01",X"38",X"11",X"0C",X"01",X"00",X"01",X"01",X"03",X"8C",X"07",X"1A",X"0F",X"40",
		X"0F",X"20",X"9F",X"0C",X"FF",X"00",X"1F",X"00",X"0F",X"20",X"27",X"00",X"07",X"00",X"13",X"04",
		X"03",X"00",X"07",X"00",X"13",X"01",X"07",X"20",X"1F",X"00",X"7F",X"00",X"7F",X"00",X"3F",X"00",
		X"0F",X"00",X"01",X"00",X"03",X"00",X"03",X"00",X"03",X"00",X"03",X"00",X"07",X"00",X"0F",X"00",
		X"3F",X"00",X"7F",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"00",X"00",X"A4",X"04",X"00",X"10",
		X"C8",X"54",X"E0",X"1B",X"E0",X"03",X"8C",X"01",X"20",X"12",X"00",X"0C",X"30",X"11",X"00",X"00",
		X"00",X"00",X"00",X"00",X"0C",X"C0",X"07",X"F1",X"0F",X"11",X"56",X"00",X"82",X"21",X"08",X"45",
		X"0A",X"00",X"A0",X"63",X"B0",X"42",X"40",X"01",X"04",X"00",X"0E",X"70",X"4A",X"78",X"03",X"31",
		X"0B",X"C0",X"02",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"00",X"A0",X"13",X"C8",X"04",
		X"E0",X"01",X"50",X"07",X"A0",X"1E",X"C0",X"0B",X"C0",X"02",X"88",X"10",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"02",X"00",X"00",X"10",X"90",X"1C",X"38",X"48",X"21",X"04",X"8C",X"20",
		X"18",X"40",X"08",X"08",X"24",X"00",X"20",X"1C",X"14",X"48",X"68",X"20",X"22",X"01",X"00",X"0B",
		X"08",X"43",X"00",X"00",X"0F",X"0B",X"00",X"18",X"04",X"11",X"1B",X"1E",X"1B",X"1F",X"1B",X"06",
		X"00",X"0C",X"04",X"1B",X"0E",X"15",X"04",X"11",X"C3",X"01",X"C2",X"04",X"C3",X"05",X"C2",X"06",
		X"C3",X"02",X"C2",X"03",X"FF",X"FF",X"FF",X"FF",X"C1",X"02",X"C0",X"05",X"C1",X"06",X"C0",X"01",
		X"C1",X"03",X"C0",X"04",X"FF",X"FF",X"FF",X"FF",X"02",X"DD",X"01",X"FF",X"01",X"D7",X"02",X"CC",
		X"01",X"FF",X"01",X"D7",X"02",X"DD",X"01",X"FF",X"01",X"D7",X"02",X"CC",X"01",X"FF",X"01",X"D7",
		X"02",X"DD",X"02",X"FF",X"02",X"E1",X"02",X"FF",X"06",X"E1",X"02",X"FF",X"02",X"DD",X"01",X"FF",
		X"01",X"D7",X"02",X"CC",X"01",X"FF",X"01",X"D7",X"02",X"DD",X"01",X"FF",X"01",X"D7",X"02",X"CC",
		X"01",X"FF",X"01",X"D7",X"02",X"D2",X"02",X"FF",X"02",X"DD",X"02",X"FF",X"06",X"B9",X"02",X"FF",
		X"02",X"DD",X"01",X"FF",X"01",X"D7",X"02",X"CC",X"01",X"FF",X"01",X"D7",X"02",X"DD",X"01",X"FF",
		X"01",X"D7",X"02",X"CC",X"01",X"FF",X"01",X"D7",X"02",X"DD",X"02",X"FF",X"02",X"E1",X"02",X"FF",
		X"06",X"E4",X"02",X"FF",X"02",X"E6",X"02",X"FF",X"01",X"E4",X"01",X"E1",X"01",X"DD",X"01",X"D9",
		X"02",X"D7",X"01",X"FF",X"01",X"D2",X"02",X"CC",X"01",X"FF",X"01",X"C9",X"02",X"CC",X"02",X"FF",
		X"02",X"E6",X"02",X"FF",X"03",X"CC",X"06",X"FF",X"FF",X"00",X"00",X"00",X"04",X"D9",X"02",X"D7",
		X"01",X"FF",X"01",X"D9",X"01",X"D2",X"01",X"FF",X"04",X"D9",X"01",X"DD",X"01",X"FF",X"01",X"DF",
		X"01",X"FF",X"01",X"E1",X"01",X"FF",X"01",X"E2",X"01",X"FF",X"01",X"E4",X"01",X"FF",X"02",X"E6",
		X"07",X"FF",X"FF",X"00",X"00",X"00",X"01",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"18",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"C8",X"D0",X"00",X"00",X"02",X"1B",
		X"00",X"00",X"00",X"FD",X"00",X"00",X"00",X"00",X"04",X"00",X"FD",X"00",X"00",X"00",X"00",X"08",
		X"00",X"FD",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"30",X"00",X"E8",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"B1",X"46",X"10",X"02",X"E1",X"17",X"00",X"00",X"00",X"00",X"00",X"29",
		X"00",X"03",X"03",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"1D",X"25",
		X"1D",X"38",X"1D",X"2E",X"00",X"00",X"00",X"00",X"C5",X"26",X"01",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"C3",X"01",X"18",X"27",X"C2",X"04",X"18",X"2D",X"C3",X"05",X"18",X"33",
		X"C2",X"06",X"18",X"39",X"C3",X"02",X"18",X"3F",X"C2",X"03",X"18",X"45",X"FF",X"FF",X"FF",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"20",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00");
begin
process(clk)
begin
	if rising_edge(clk) then
		data <= rom_data(to_integer(unsigned(addr)));
	end if;
end process;
end architecture;
