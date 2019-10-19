library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity ROM_SND_0 is
port (
	clk  : in  std_logic;
	addr : in  std_logic_vector(10 downto 0);
	data : out std_logic_vector(7 downto 0)
);
end entity;

architecture prom of ROM_SND_0 is
	type rom is array(0 to  2047) of std_logic_vector(7 downto 0);
	signal rom_data: rom := (
		X"C3",X"A4",X"02",X"FF",X"FF",X"FF",X"FF",X"FF",X"87",X"5F",X"16",X"00",X"19",X"5E",X"23",X"56",
		X"EB",X"E9",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"08",X"D9",X"3E",X"0E",X"D3",X"40",X"DB",X"80",
		X"B7",X"28",X"13",X"FE",X"30",X"FA",X"63",X"00",X"FE",X"40",X"F2",X"52",X"00",X"D6",X"10",X"CD",
		X"6A",X"00",X"D9",X"08",X"FB",X"C9",X"06",X"0C",X"21",X"00",X"80",X"77",X"23",X"10",X"FC",X"D9",
		X"08",X"FB",X"C9",X"CD",X"97",X"00",X"D9",X"08",X"FB",X"C9",X"CD",X"83",X"00",X"B7",X"C8",X"FE",
		X"07",X"F0",X"D5",X"E5",X"21",X"00",X"80",X"3D",X"87",X"5F",X"16",X"00",X"19",X"72",X"23",X"72",
		X"E1",X"D1",X"C9",X"C5",X"21",X"00",X"80",X"06",X"06",X"BE",X"28",X"06",X"23",X"23",X"10",X"F9",
		X"06",X"07",X"3E",X"07",X"90",X"C1",X"C9",X"32",X"1A",X"80",X"CD",X"83",X"00",X"B7",X"20",X"55",
		X"3A",X"1A",X"80",X"21",X"B1",X"01",X"BE",X"28",X"5E",X"23",X"BE",X"28",X"5A",X"3A",X"1A",X"80",
		X"21",X"B3",X"01",X"BE",X"CA",X"3B",X"01",X"23",X"BE",X"CA",X"3B",X"01",X"AF",X"CD",X"83",X"00",
		X"B7",X"C2",X"6F",X"01",X"CD",X"1E",X"02",X"CD",X"49",X"02",X"B7",X"CA",X"73",X"01",X"3A",X"17",
		X"80",X"B7",X"CA",X"8F",X"01",X"3A",X"18",X"80",X"21",X"06",X"80",X"CD",X"B5",X"01",X"CD",X"C3",
		X"01",X"47",X"3A",X"17",X"80",X"21",X"00",X"80",X"CD",X"B5",X"01",X"CD",X"C3",X"01",X"B8",X"F2",
		X"8F",X"01",X"C3",X"73",X"01",X"FE",X"07",X"F0",X"D5",X"E5",X"21",X"01",X"80",X"3D",X"87",X"5F",
		X"16",X"00",X"19",X"72",X"E1",X"D1",X"C9",X"AF",X"CD",X"83",X"00",X"B7",X"20",X"18",X"CD",X"1E",
		X"02",X"B7",X"C8",X"FE",X"01",X"28",X"1A",X"FE",X"02",X"28",X"1B",X"21",X"04",X"80",X"3A",X"1A",
		X"80",X"77",X"23",X"36",X"00",X"C9",X"FE",X"04",X"FA",X"2D",X"01",X"18",X"E1",X"CD",X"0A",X"02",
		X"C9",X"21",X"00",X"80",X"18",X"E8",X"21",X"02",X"80",X"18",X"E3",X"AF",X"CD",X"83",X"00",X"B7",
		X"20",X"18",X"CD",X"49",X"02",X"B7",X"C8",X"FE",X"01",X"28",X"16",X"FE",X"02",X"28",X"17",X"21",
		X"0A",X"80",X"3A",X"1A",X"80",X"77",X"23",X"36",X"00",X"C9",X"FE",X"04",X"F2",X"6B",X"01",X"18",
		X"E1",X"21",X"06",X"80",X"18",X"EC",X"21",X"08",X"80",X"18",X"E7",X"CD",X"0A",X"02",X"C9",X"CD",
		X"0A",X"02",X"C9",X"3A",X"17",X"80",X"B7",X"C8",X"FE",X"01",X"28",X"09",X"FE",X"02",X"28",X"0A",
		X"21",X"04",X"80",X"18",X"1A",X"21",X"00",X"80",X"18",X"15",X"21",X"02",X"80",X"18",X"10",X"3A",
		X"18",X"80",X"B7",X"C8",X"FE",X"01",X"28",X"0F",X"FE",X"02",X"28",X"10",X"21",X"0A",X"80",X"3A",
		X"1A",X"80",X"77",X"23",X"36",X"00",X"C9",X"21",X"06",X"80",X"18",X"F3",X"21",X"08",X"80",X"18",
		X"EE",X"13",X"23",X"22",X"28",X"FE",X"01",X"28",X"08",X"23",X"23",X"FE",X"02",X"28",X"02",X"23",
		X"23",X"7E",X"C9",X"21",X"74",X"02",X"5F",X"16",X"00",X"19",X"7E",X"C9",X"3A",X"12",X"80",X"21",
		X"13",X"80",X"BE",X"FA",X"E7",X"01",X"3A",X"14",X"80",X"BE",X"FA",X"01",X"02",X"3A",X"15",X"80",
		X"BE",X"3E",X"00",X"F8",X"3E",X"02",X"C9",X"21",X"14",X"80",X"BE",X"FA",X"F8",X"01",X"3A",X"15",
		X"80",X"BE",X"3E",X"00",X"F8",X"3E",X"03",X"C9",X"21",X"15",X"80",X"BE",X"3E",X"01",X"F8",X"AF",
		X"C9",X"21",X"15",X"80",X"BE",X"3E",X"03",X"F8",X"AF",X"C9",X"21",X"1A",X"80",X"46",X"0E",X"00",
		X"21",X"00",X"80",X"3D",X"87",X"D5",X"5F",X"51",X"19",X"D1",X"70",X"23",X"71",X"C9",X"3A",X"00",
		X"80",X"CD",X"C3",X"01",X"32",X"12",X"80",X"3A",X"02",X"80",X"CD",X"C3",X"01",X"32",X"13",X"80",
		X"3A",X"04",X"80",X"CD",X"C3",X"01",X"32",X"14",X"80",X"3A",X"1A",X"80",X"CD",X"C3",X"01",X"32",
		X"15",X"80",X"CD",X"CC",X"01",X"32",X"17",X"80",X"C9",X"3A",X"06",X"80",X"CD",X"C3",X"01",X"32",
		X"12",X"80",X"3A",X"08",X"80",X"CD",X"C3",X"01",X"32",X"13",X"80",X"3A",X"0A",X"80",X"CD",X"C3",
		X"01",X"32",X"14",X"80",X"3A",X"1A",X"80",X"CD",X"C3",X"01",X"32",X"15",X"80",X"CD",X"CC",X"01",
		X"32",X"18",X"80",X"C9",X"00",X"27",X"28",X"29",X"2A",X"2B",X"0F",X"22",X"23",X"30",X"31",X"32",
		X"33",X"34",X"35",X"36",X"37",X"19",X"3F",X"24",X"25",X"26",X"1C",X"46",X"47",X"48",X"49",X"4A",
		X"4B",X"4C",X"4D",X"4E",X"0E",X"1F",X"20",X"1E",X"1D",X"1A",X"21",X"1B",X"19",X"18",X"40",X"41",
		X"42",X"43",X"44",X"45",X"06",X"00",X"21",X"00",X"80",X"70",X"23",X"7C",X"FE",X"84",X"20",X"F9",
		X"31",X"00",X"84",X"ED",X"56",X"21",X"00",X"90",X"22",X"0C",X"80",X"77",X"3E",X"07",X"D3",X"40",
		X"3E",X"3F",X"32",X"0E",X"80",X"D3",X"80",X"3E",X"07",X"D3",X"10",X"3E",X"3F",X"32",X"0F",X"80",
		X"D3",X"20",X"CD",X"2A",X"04",X"CD",X"2E",X"04",X"CD",X"32",X"04",X"CD",X"3A",X"04",X"CD",X"3E",
		X"04",X"CD",X"42",X"04",X"FB",X"3E",X"0F",X"D3",X"40",X"DB",X"80",X"E6",X"80",X"20",X"F6",X"3E",
		X"0F",X"D3",X"40",X"DB",X"80",X"E6",X"80",X"28",X"F6",X"F3",X"3E",X"01",X"32",X"10",X"80",X"3A",
		X"01",X"80",X"B7",X"CA",X"7D",X"03",X"3A",X"00",X"80",X"CD",X"DE",X"07",X"FB",X"00",X"00",X"F3",
		X"3E",X"02",X"32",X"10",X"80",X"3A",X"03",X"80",X"B7",X"CA",X"86",X"03",X"3A",X"02",X"80",X"CD",
		X"DE",X"07",X"FB",X"00",X"00",X"F3",X"3E",X"03",X"32",X"10",X"80",X"3A",X"05",X"80",X"B7",X"CA",
		X"8F",X"03",X"3A",X"04",X"80",X"CD",X"DE",X"07",X"FB",X"00",X"00",X"F3",X"3E",X"04",X"32",X"10",
		X"80",X"3A",X"07",X"80",X"B7",X"CA",X"98",X"03",X"3A",X"06",X"80",X"CD",X"DE",X"07",X"FB",X"00",
		X"00",X"F3",X"3E",X"05",X"32",X"10",X"80",X"3A",X"09",X"80",X"B7",X"CA",X"A1",X"03",X"3A",X"08",
		X"80",X"CD",X"DE",X"07",X"FB",X"00",X"00",X"F3",X"3E",X"06",X"32",X"10",X"80",X"3A",X"0B",X"80",
		X"B7",X"CA",X"AA",X"03",X"3A",X"0A",X"80",X"CD",X"DE",X"07",X"C3",X"E4",X"02",X"3A",X"00",X"80",
		X"CD",X"B3",X"03",X"C3",X"0C",X"03",X"3A",X"02",X"80",X"CD",X"B3",X"03",X"C3",X"22",X"03",X"3A",
		X"04",X"80",X"CD",X"B3",X"03",X"C3",X"38",X"03",X"3A",X"06",X"80",X"CD",X"B3",X"03",X"C3",X"4E",
		X"03",X"3A",X"08",X"80",X"CD",X"B3",X"03",X"C3",X"64",X"03",X"3A",X"0A",X"80",X"CD",X"B3",X"03",
		X"C3",X"E4",X"02",X"21",X"CA",X"03",X"CF",X"E5",X"21",X"01",X"80",X"3A",X"10",X"80",X"3D",X"87",
		X"D5",X"5F",X"16",X"00",X"19",X"D1",X"36",X"01",X"E1",X"C9",X"4A",X"04",X"8D",X"08",X"09",X"09",
		X"82",X"09",X"FB",X"09",X"74",X"0A",X"B4",X"0C",X"0D",X"10",X"98",X"11",X"8A",X"0F",X"98",X"0F",
		X"9F",X"0F",X"BB",X"0F",X"C9",X"0F",X"CF",X"0F",X"EA",X"0F",X"F8",X"0F",X"33",X"12",X"00",X"00",
		X"FD",X"0A",X"A2",X"0B",X"2A",X"0C",X"41",X"13",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"33",X"0D",X"99",X"14",X"82",X"16",
		X"A5",X"10",X"23",X"11",X"02",X"13",X"CD",X"13",X"6C",X"14",X"82",X"16",X"82",X"16",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"3E",X"08",X"18",X"06",X"3E",X"09",
		X"18",X"02",X"3E",X"0A",X"D3",X"40",X"AF",X"D3",X"80",X"C9",X"3E",X"08",X"18",X"06",X"3E",X"09",
		X"18",X"02",X"3E",X"0A",X"D3",X"10",X"AF",X"D3",X"20",X"C9",X"3A",X"10",X"80",X"FE",X"01",X"28",
		X"19",X"FE",X"02",X"28",X"1E",X"FE",X"03",X"28",X"23",X"FE",X"04",X"28",X"28",X"FE",X"05",X"28",
		X"2D",X"06",X"24",X"CD",X"A5",X"04",X"CD",X"42",X"04",X"C9",X"06",X"09",X"CD",X"97",X"04",X"CD",
		X"2A",X"04",X"C9",X"06",X"12",X"CD",X"97",X"04",X"CD",X"2E",X"04",X"C9",X"06",X"24",X"CD",X"97",
		X"04",X"CD",X"32",X"04",X"C9",X"06",X"09",X"CD",X"A5",X"04",X"CD",X"3A",X"04",X"C9",X"06",X"12",
		X"CD",X"A5",X"04",X"CD",X"3E",X"04",X"C9",X"3E",X"07",X"D3",X"40",X"3A",X"0E",X"80",X"B0",X"32",
		X"0E",X"80",X"D3",X"80",X"C9",X"3E",X"07",X"D3",X"10",X"3A",X"0F",X"80",X"B0",X"32",X"0F",X"80",
		X"D3",X"20",X"C9",X"3A",X"10",X"80",X"FE",X"01",X"28",X"20",X"FE",X"02",X"28",X"2C",X"FE",X"03",
		X"28",X"2C",X"FE",X"04",X"28",X"2C",X"FE",X"05",X"28",X"2C",X"06",X"04",X"78",X"D3",X"10",X"7D",
		X"D3",X"20",X"04",X"78",X"D3",X"10",X"7C",X"D3",X"20",X"C9",X"06",X"00",X"78",X"D3",X"40",X"7D",
		X"D3",X"80",X"04",X"78",X"D3",X"40",X"7C",X"D3",X"80",X"C9",X"06",X"02",X"18",X"EE",X"06",X"04",
		X"18",X"EA",X"06",X"00",X"18",X"D6",X"06",X"02",X"18",X"D2",X"3A",X"10",X"80",X"3D",X"28",X"14",
		X"3D",X"28",X"19",X"3D",X"28",X"1C",X"3D",X"28",X"1F",X"3D",X"28",X"22",X"16",X"FB",X"1E",X"20",
		X"CD",X"59",X"05",X"C9",X"16",X"FE",X"1E",X"08",X"CD",X"4A",X"05",X"C9",X"16",X"FD",X"1E",X"10",
		X"18",X"F6",X"16",X"FB",X"1E",X"20",X"18",X"F0",X"16",X"FE",X"1E",X"08",X"18",X"E2",X"16",X"FD",
		X"1E",X"10",X"18",X"DC",X"3A",X"10",X"80",X"FE",X"04",X"FA",X"43",X"05",X"7A",X"D3",X"10",X"7B",
		X"D3",X"20",X"C9",X"7A",X"D3",X"40",X"7B",X"D3",X"80",X"C9",X"3E",X"07",X"D3",X"40",X"3A",X"0E",
		X"80",X"A2",X"B3",X"32",X"0E",X"80",X"D3",X"80",X"C9",X"3E",X"07",X"D3",X"10",X"3A",X"0F",X"80",
		X"A2",X"B3",X"32",X"0F",X"80",X"D3",X"20",X"C9",X"3A",X"10",X"80",X"3D",X"28",X"13",X"3D",X"28",
		X"17",X"3D",X"28",X"1A",X"3D",X"28",X"1D",X"3D",X"28",X"20",X"16",X"DF",X"1E",X"04",X"C3",X"59",
		X"05",X"16",X"F7",X"1E",X"01",X"C3",X"4A",X"05",X"16",X"EF",X"1E",X"02",X"18",X"F7",X"16",X"DF",
		X"1E",X"04",X"18",X"F1",X"16",X"F7",X"1E",X"01",X"18",X"E4",X"16",X"EF",X"1E",X"02",X"18",X"DE",
		X"3A",X"10",X"80",X"3D",X"28",X"13",X"3D",X"28",X"17",X"3D",X"28",X"1A",X"3D",X"28",X"1D",X"3D",
		X"28",X"20",X"16",X"DB",X"1E",X"00",X"C3",X"59",X"05",X"16",X"F6",X"1E",X"00",X"C3",X"4A",X"05",
		X"16",X"ED",X"1E",X"00",X"18",X"F7",X"16",X"DB",X"1E",X"00",X"18",X"F1",X"16",X"F6",X"1E",X"00",
		X"18",X"E4",X"16",X"ED",X"1E",X"00",X"18",X"DE",X"3A",X"10",X"80",X"FE",X"01",X"28",X"18",X"FE",
		X"02",X"28",X"1C",X"FE",X"03",X"28",X"1C",X"FE",X"04",X"28",X"1C",X"FE",X"05",X"28",X"1C",X"3E",
		X"0A",X"D3",X"10",X"78",X"D3",X"20",X"C9",X"3E",X"08",X"D3",X"40",X"78",X"D3",X"80",X"C9",X"3E",
		X"09",X"18",X"F6",X"3E",X"0A",X"18",X"F2",X"3E",X"08",X"18",X"E6",X"3E",X"09",X"18",X"E2",X"3A",
		X"10",X"80",X"FE",X"04",X"FA",X"1E",X"06",X"7A",X"D3",X"10",X"DB",X"20",X"5F",X"C9",X"7A",X"D3",
		X"40",X"DB",X"80",X"5F",X"C9",X"3A",X"10",X"80",X"FE",X"01",X"28",X"17",X"FE",X"02",X"28",X"1A",
		X"FE",X"03",X"28",X"1A",X"FE",X"04",X"28",X"1A",X"FE",X"05",X"28",X"1A",X"3E",X"0A",X"D3",X"10",
		X"DB",X"20",X"C9",X"3E",X"08",X"D3",X"40",X"DB",X"80",X"C9",X"3E",X"09",X"18",X"F7",X"3E",X"0A",
		X"18",X"F3",X"3E",X"08",X"18",X"E8",X"3E",X"09",X"18",X"E4",X"3A",X"10",X"80",X"FE",X"01",X"28",
		X"20",X"FE",X"02",X"28",X"2C",X"FE",X"03",X"28",X"2C",X"FE",X"04",X"28",X"2C",X"FE",X"05",X"28",
		X"2C",X"06",X"04",X"78",X"D3",X"10",X"DB",X"20",X"6F",X"04",X"78",X"D3",X"10",X"DB",X"20",X"67",
		X"C9",X"06",X"00",X"78",X"D3",X"40",X"DB",X"80",X"6F",X"04",X"78",X"D3",X"40",X"DB",X"80",X"67",
		X"C9",X"06",X"02",X"18",X"EE",X"06",X"04",X"18",X"EA",X"06",X"00",X"18",X"D6",X"06",X"02",X"18",
		X"D2",X"3A",X"10",X"80",X"FE",X"04",X"28",X"21",X"FE",X"05",X"28",X"22",X"FE",X"06",X"28",X"23",
		X"FE",X"01",X"28",X"24",X"FE",X"02",X"28",X"25",X"11",X"FF",X"F3",X"2A",X"0C",X"80",X"7A",X"A4",
		X"67",X"7B",X"A5",X"6F",X"22",X"0C",X"80",X"77",X"C9",X"11",X"FC",X"FF",X"18",X"ED",X"11",X"F3",
		X"FF",X"18",X"E8",X"11",X"CF",X"FF",X"18",X"E3",X"11",X"3F",X"FF",X"18",X"DE",X"11",X"FF",X"FC",
		X"18",X"D9",X"3A",X"10",X"80",X"FE",X"04",X"28",X"20",X"FE",X"05",X"28",X"21",X"FE",X"06",X"28",
		X"22",X"FE",X"01",X"28",X"23",X"FE",X"02",X"28",X"24",X"11",X"FF",X"F3",X"2A",X"0C",X"80",X"7A",
		X"A4",X"67",X"7B",X"A5",X"6F",X"22",X"0C",X"80",X"C9",X"11",X"FC",X"FF",X"18",X"EE",X"11",X"F3",
		X"FF",X"18",X"E9",X"11",X"CF",X"FF",X"18",X"E4",X"11",X"3F",X"FF",X"18",X"DF",X"11",X"FF",X"FC",
		X"18",X"DA",X"CD",X"E2",X"06",X"3A",X"10",X"80",X"FE",X"04",X"28",X"17",X"FE",X"05",X"28",X"18",
		X"FE",X"06",X"28",X"19",X"FE",X"01",X"28",X"1A",X"FE",X"02",X"28",X"1B",X"11",X"00",X"08",X"CD",
		X"D0",X"07",X"C9",X"11",X"02",X"00",X"18",X"F7",X"11",X"08",X"00",X"18",X"F2",X"11",X"20",X"00",
		X"18",X"ED",X"11",X"80",X"00",X"18",X"E8",X"11",X"00",X"02",X"18",X"E3",X"CD",X"E2",X"06",X"3A",
		X"10",X"80",X"FE",X"04",X"28",X"17",X"FE",X"05",X"28",X"18",X"FE",X"06",X"28",X"19",X"FE",X"01",
		X"28",X"1A",X"FE",X"02",X"28",X"1B",X"11",X"00",X"04",X"CD",X"D0",X"07",X"C9",X"11",X"01",X"00",
		X"18",X"F7",X"11",X"04",X"00",X"18",X"F2",X"11",X"10",X"00",X"18",X"ED",X"11",X"40",X"00",X"18",
		X"E8",X"11",X"00",X"01",X"18",X"E3",X"CD",X"E2",X"06",X"3A",X"10",X"80",X"FE",X"04",X"28",X"17",
		X"FE",X"05",X"28",X"18",X"FE",X"06",X"28",X"19",X"FE",X"01",X"28",X"1A",X"FE",X"02",X"28",X"1B",
		X"11",X"00",X"0C",X"CD",X"D0",X"07",X"C9",X"11",X"03",X"00",X"18",X"F7",X"11",X"0C",X"00",X"18",
		X"F2",X"11",X"30",X"00",X"18",X"ED",X"11",X"C0",X"00",X"18",X"E8",X"11",X"00",X"03",X"18",X"E3",
		X"2A",X"0C",X"80",X"7A",X"B4",X"67",X"7B",X"B5",X"6F",X"22",X"0C",X"80",X"77",X"C9",X"B7",X"C8",
		X"21",X"2D",X"08",X"CF",X"B7",X"C8",X"3A",X"10",X"80",X"FE",X"01",X"28",X"18",X"FE",X"02",X"28",
		X"1C",X"FE",X"03",X"28",X"20",X"FE",X"04",X"28",X"24",X"FE",X"05",X"28",X"28",X"AF",X"32",X"0A");
begin
process(clk)
begin
	if rising_edge(clk) then
		data <= rom_data(to_integer(unsigned(addr)));
	end if;
end process;
end architecture;