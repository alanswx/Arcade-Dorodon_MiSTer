library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity rom_sprite_l is
port (
	clk  : in  std_logic;
	addr : in  std_logic_vector(11 downto 0);
	data : out std_logic_vector(7 downto 0)
);
end entity;

architecture prom of rom_sprite_l is
	type rom is array(0 to  4095) of std_logic_vector(7 downto 0);
	signal rom_data: rom := (
		X"00",X"00",X"03",X"FF",X"0F",X"EB",X"3F",X"AB",X"3F",X"AB",X"3F",X"AB",X"0F",X"AB",X"03",X"EB",
		X"00",X"00",X"00",X"00",X"54",X"00",X"43",X"00",X"43",X"00",X"FF",X"00",X"57",X"00",X"43",X"00",
		X"0F",X"FB",X"3F",X"FF",X"3F",X"FF",X"3F",X"FF",X"3F",X"FF",X"0F",X"FF",X"03",X"F0",X"00",X"00",
		X"43",X"00",X"FC",X"00",X"FC",X"00",X"F0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"3F",X"03",X"FB",X"0F",X"EB",X"3F",X"EB",X"3F",X"EB",X"3F",X"EB",X"03",X"EB",
		X"00",X"00",X"C0",X"00",X"54",X"00",X"04",X"00",X"07",X"00",X"FF",X"00",X"57",X"00",X"07",X"00",
		X"3F",X"FB",X"3F",X"FF",X"3F",X"FF",X"0F",X"FF",X"03",X"FF",X"00",X"FF",X"00",X"00",X"00",X"00",
		X"04",X"00",X"FC",X"00",X"F0",X"00",X"F0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"3F",X"FF",X"3F",X"FB",X"3F",X"EB",X"0F",X"EB",X"0F",X"EB",X"03",X"EB",X"03",X"EB",
		X"00",X"00",X"00",X"00",X"54",X"00",X"43",X"00",X"43",X"00",X"FF",X"00",X"43",X"00",X"43",X"00",
		X"07",X"FB",X"0F",X"FF",X"0F",X"FF",X"1F",X"FF",X"3F",X"FF",X"3F",X"FC",X"2F",X"40",X"00",X"00",
		X"54",X"00",X"FC",X"00",X"F0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"03",X"FF",X"0F",X"FF",X"3F",X"EB",X"3F",X"AB",X"0F",X"AB",X"03",X"AB",
		X"00",X"00",X"00",X"00",X"C0",X"00",X"FC",X"00",X"57",X"00",X"43",X"00",X"43",X"C0",X"FF",X"C0",
		X"03",X"AB",X"03",X"AB",X"03",X"AB",X"03",X"AB",X"00",X"FF",X"00",X"3F",X"00",X"00",X"00",X"00",
		X"FF",X"C0",X"43",X"C0",X"43",X"00",X"57",X"00",X"FC",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"03",X"FC",X"0F",X"FF",X"3F",X"FF",X"3F",X"EF",X"3F",X"AF",X"0F",X"AF",X"03",X"AF",
		X"00",X"00",X"00",X"00",X"C0",X"00",X"F0",X"00",X"54",X"00",X"07",X"00",X"07",X"00",X"FF",X"00",
		X"03",X"AF",X"0F",X"AF",X"3F",X"AF",X"3F",X"EF",X"3F",X"FF",X"0F",X"FF",X"03",X"FC",X"00",X"00",
		X"FF",X"00",X"57",X"00",X"07",X"00",X"04",X"00",X"F0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"3C",X"00",X"FF",X"03",X"FF",X"03",X"EF",X"03",X"AF",X"0F",X"AF",X"0F",X"AF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"C0",X"00",X"54",X"00",X"04",X"00",X"04",X"00",X"F0",X"00",
		X"0F",X"AF",X"0F",X"AF",X"3F",X"AF",X"3F",X"EF",X"3F",X"FF",X"0F",X"FF",X"03",X"F0",X"00",X"00",
		X"F0",X"00",X"04",X"00",X"04",X"00",X"54",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"02",X"A8",X"02",X"AF",X"02",X"AD",X"03",X"F5",X"03",X"F5",X"03",X"F5",X"23",X"F5",
		X"00",X"00",X"A0",X"14",X"FC",X"54",X"7C",X"50",X"50",X"C0",X"5F",X"C0",X"5F",X"C0",X"70",X"C0",
		X"2B",X"FD",X"2B",X"FF",X"2B",X"FE",X"03",X"FE",X"00",X"FC",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FC",X"C0",X"FF",X"D4",X"BF",X"54",X"AC",X"50",X"A0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"3E",X"20",X"FF",X"2B",X"F7",X"2B",X"F5",X"2B",X"F5",X"03",X"F5",X"23",X"F5",
		X"00",X"00",X"A0",X"14",X"FC",X"54",X"F3",X"50",X"C3",X"C0",X"FF",X"C0",X"FF",X"C0",X"C3",X"C0",
		X"2B",X"F7",X"2B",X"FF",X"2B",X"FF",X"03",X"FF",X"00",X"FE",X"00",X"02",X"00",X"00",X"00",X"00",
		X"F3",X"C0",X"FF",X"C0",X"FF",X"50",X"AC",X"54",X"A0",X"14",X"80",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"02",X"00",X"FF",X"23",X"F5",X"2B",X"F5",X"2B",X"F5",X"2B",X"F5",X"03",X"F5",
		X"00",X"00",X"A0",X"00",X"FC",X"14",X"C3",X"54",X"73",X"D4",X"7F",X"C0",X"7F",X"C0",X"C3",X"C0",
		X"03",X"F7",X"03",X"F7",X"03",X"FF",X"02",X"AF",X"02",X"AF",X"02",X"A8",X"00",X"00",X"00",X"00",
		X"F3",X"C0",X"FF",X"C0",X"FF",X"50",X"AC",X"54",X"A8",X"14",X"28",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"FF",X"23",X"FE",X"2B",X"FA",X"2B",X"DB",X"2B",X"EA",X"03",X"D9",
		X"00",X"00",X"00",X"00",X"A0",X"00",X"AC",X"50",X"BF",X"54",X"F3",X"D4",X"C3",X"C0",X"FF",X"C0",
		X"03",X"EA",X"03",X"D9",X"03",X"EB",X"03",X"FB",X"0A",X"BF",X"0A",X"BF",X"0A",X"A2",X"00",X"02",
		X"FF",X"C0",X"F3",X"C0",X"C3",X"C0",X"FF",X"50",X"FC",X"54",X"A0",X"14",X"A0",X"00",X"80",X"00",
		X"00",X"00",X"00",X"02",X"00",X"FE",X"23",X"FF",X"2B",X"FB",X"2B",X"FA",X"2B",X"FE",X"03",X"FE",
		X"00",X"00",X"80",X"00",X"A0",X"14",X"AC",X"54",X"FF",X"50",X"F3",X"C0",X"C3",X"C0",X"FF",X"C0",
		X"03",X"FE",X"2B",X"FE",X"2B",X"FA",X"2B",X"FB",X"23",X"FF",X"00",X"FE",X"00",X"02",X"00",X"00",
		X"FF",X"C0",X"C3",X"C0",X"F3",X"C0",X"FF",X"50",X"AC",X"54",X"A0",X"14",X"80",X"00",X"00",X"00",
		X"00",X"02",X"0A",X"A2",X"0A",X"BF",X"0A",X"BF",X"03",X"DF",X"03",X"E7",X"03",X"D9",X"03",X"EA",
		X"80",X"00",X"A0",X"00",X"A0",X"14",X"FC",X"54",X"FF",X"50",X"C3",X"C0",X"F3",X"C0",X"FF",X"C0",
		X"03",X"D9",X"2B",X"EA",X"2B",X"D7",X"2B",X"EE",X"23",X"FE",X"00",X"FF",X"00",X"00",X"00",X"00",
		X"FF",X"C0",X"C3",X"C0",X"F3",X"D4",X"BF",X"54",X"AC",X"50",X"A0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"28",X"20",X"AF",X"28",X"FF",X"2B",X"FC",X"2B",X"F0",X"0F",X"FC",X"0F",X"5F",
		X"01",X"40",X"05",X"40",X"F5",X"00",X"FF",X"05",X"FF",X"D5",X"3F",X"D4",X"FF",X"F0",X"F3",X"F0",
		X"0F",X"D7",X"0F",X"F5",X"03",X"FD",X"03",X"FF",X"00",X"FF",X"00",X"0F",X"00",X"00",X"00",X"00",
		X"C0",X"F0",X"F3",X"F8",X"7F",X"E8",X"7F",X"E0",X"FF",X"00",X"FA",X"80",X"0A",X"A0",X"00",X"00",
		X"00",X"00",X"02",X"80",X"50",X"AF",X"54",X"FF",X"17",X"F3",X"03",X"C0",X"0F",X"F3",X"0F",X"FF",
		X"00",X"00",X"2A",X"80",X"FA",X"80",X"FF",X"00",X"F7",X"C0",X"DF",X"C0",X"F7",X"F0",X"DF",X"F0",
		X"0F",X"FF",X"0F",X"F3",X"03",X"C0",X"17",X"F3",X"54",X"FF",X"50",X"AF",X"02",X"80",X"00",X"00",
		X"DF",X"F0",X"F7",X"F0",X"DF",X"C0",X"F7",X"C0",X"FF",X"00",X"FA",X"80",X"2A",X"80",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"0F",X"00",X"FF",X"03",X"FF",X"03",X"FD",X"0F",X"F5",X"0F",X"D7",
		X"00",X"00",X"0A",X"A0",X"FA",X"80",X"FF",X"00",X"7F",X"E0",X"7F",X"E8",X"F3",X"F8",X"C0",X"F0",
		X"0F",X"5F",X"0F",X"FC",X"2B",X"F0",X"2B",X"FC",X"28",X"FF",X"20",X"AF",X"00",X"28",X"00",X"00",
		X"F3",X"F0",X"FF",X"F0",X"3F",X"D4",X"FF",X"D5",X"FF",X"05",X"F5",X"00",X"05",X"40",X"01",X"40",
		X"00",X"00",X"00",X"28",X"20",X"AF",X"28",X"FF",X"2B",X"FC",X"2B",X"F0",X"0F",X"FC",X"0F",X"0F",
		X"01",X"40",X"05",X"40",X"F5",X"00",X"FF",X"05",X"FF",X"D5",X"3F",X"D4",X"FF",X"F0",X"F3",X"F0",
		X"0F",X"D7",X"0F",X"F5",X"03",X"FD",X"03",X"FF",X"00",X"FF",X"00",X"0F",X"00",X"00",X"00",X"00",
		X"C0",X"F0",X"F3",X"F8",X"7F",X"E8",X"7F",X"E0",X"FF",X"00",X"FA",X"80",X"0A",X"A0",X"00",X"00",
		X"00",X"00",X"02",X"80",X"50",X"AF",X"54",X"FF",X"17",X"F3",X"03",X"C0",X"0F",X"F3",X"0F",X"FF",
		X"00",X"00",X"2A",X"80",X"FA",X"80",X"FF",X"00",X"F7",X"C0",X"DF",X"C0",X"F7",X"F0",X"DF",X"F0",
		X"0F",X"FF",X"0F",X"F3",X"03",X"C0",X"17",X"F3",X"54",X"FF",X"50",X"AF",X"02",X"80",X"00",X"00",
		X"DF",X"F0",X"F7",X"F0",X"DF",X"C0",X"F7",X"C0",X"FF",X"00",X"FA",X"80",X"2A",X"80",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"0F",X"00",X"FF",X"03",X"FF",X"03",X"FD",X"0F",X"F5",X"0F",X"D7",
		X"00",X"00",X"0A",X"A0",X"FA",X"80",X"FF",X"00",X"7F",X"E0",X"7F",X"E8",X"F3",X"F8",X"C0",X"F0",
		X"0F",X"5F",X"0F",X"FC",X"2B",X"F0",X"2B",X"FC",X"28",X"FF",X"20",X"AF",X"00",X"28",X"00",X"00",
		X"F3",X"F0",X"FF",X"F0",X"3F",X"D4",X"FF",X"D5",X"FF",X"05",X"F5",X"00",X"05",X"40",X"01",X"40",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"00",X"25",X"02",X"A5",X"2A",X"A5",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"00",X"65",X"00",X"65",X"90",X"96",X"54",
		X"2A",X"A5",X"2A",X"A5",X"2A",X"A5",X"02",X"A5",X"00",X"25",X"00",X"05",X"00",X"01",X"00",X"00",
		X"96",X"54",X"95",X"90",X"95",X"90",X"95",X"40",X"95",X"40",X"65",X"00",X"40",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"00",X"25",X"02",X"A5",X"2A",X"A5",X"2A",X"A5",
		X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"00",X"64",X"00",X"65",X"80",X"95",X"90",X"96",X"50",
		X"2A",X"A5",X"2A",X"A6",X"02",X"A6",X"00",X"26",X"00",X"05",X"00",X"00",X"00",X"00",X"00",X"00",
		X"96",X"54",X"56",X"50",X"59",X"40",X"58",X"00",X"50",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"01",X"00",X"05",X"00",X"25",X"02",X"A5",X"2A",X"A5",X"2A",X"A5",X"2A",X"A5",
		X"00",X"00",X"40",X"00",X"65",X"00",X"65",X"40",X"95",X"40",X"95",X"90",X"95",X"90",X"96",X"54",
		X"2A",X"A5",X"02",X"A5",X"00",X"25",X"00",X"01",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"96",X"54",X"A5",X"90",X"65",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"04",X"00",X"15",X"00",X"25",X"02",X"A5",X"2A",X"A5",X"2A",X"A5",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"94",X"00",X"96",X"40",X"66",X"50",X"65",X"94",
		X"2A",X"A5",X"2A",X"A5",X"02",X"A5",X"00",X"25",X"00",X"15",X"00",X"04",X"00",X"00",X"00",X"00",
		X"65",X"94",X"66",X"50",X"96",X"50",X"95",X"00",X"14",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"00",X"25",X"02",X"A5",X"2A",X"A5",X"2A",X"A5",
		X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"00",X"64",X"00",X"65",X"80",X"95",X"90",X"96",X"50",
		X"2A",X"A5",X"2A",X"A6",X"02",X"A6",X"00",X"26",X"00",X"05",X"00",X"00",X"00",X"00",X"00",X"00",
		X"96",X"54",X"56",X"50",X"59",X"40",X"58",X"00",X"50",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"00",X"25",X"02",X"A5",X"2A",X"96",X"2A",X"96",
		X"00",X"00",X"00",X"00",X"00",X"00",X"50",X"00",X"65",X"00",X"95",X"90",X"56",X"94",X"56",X"54",
		X"2A",X"96",X"2A",X"96",X"02",X"A5",X"00",X"25",X"00",X"01",X"00",X"00",X"00",X"00",X"00",X"00",
		X"56",X"54",X"56",X"90",X"95",X"80",X"65",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"00",X"0E",X"02",X"AB",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"00",X"AC",X"00",X"AF",X"00",
		X"0A",X"BF",X"0A",X"FF",X"03",X"F5",X"03",X"F5",X"03",X"F5",X"0F",X"D5",X"0F",X"D5",X"0F",X"D5",
		X"FF",X"05",X"FF",X"C5",X"FF",X"D5",X"7F",X"14",X"5F",X"30",X"5C",X"30",X"5F",X"F0",X"5F",X"F0",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"00",X"0E",X"00",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"00",X"AC",X"00",X"AF",X"00",
		X"23",X"FF",X"23",X"FF",X"2B",X"FD",X"2B",X"FD",X"2B",X"FD",X"0F",X"FF",X"0F",X"FF",X"0F",X"FF",
		X"FF",X"05",X"FF",X"C5",X"FF",X"D5",X"FC",X"D4",X"7C",X"F0",X"70",X"F0",X"7F",X"F0",X"7F",X"F0",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"0F",X"00",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"28",X"00",X"A8",X"00",X"AF",X"00",
		X"23",X"FF",X"23",X"FF",X"2B",X"FF",X"2B",X"F7",X"2B",X"F5",X"0F",X"F5",X"0F",X"F5",X"0F",X"F5",
		X"FF",X"50",X"FF",X"54",X"FF",X"D4",X"FC",X"D4",X"FC",X"F0",X"70",X"F0",X"7F",X"F0",X"7F",X"F0",
		X"0F",X"D5",X"0F",X"D5",X"0F",X"D5",X"2B",X"F5",X"2B",X"F5",X"2B",X"F5",X"23",X"FF",X"23",X"FF",
		X"5F",X"F0",X"5F",X"F0",X"5C",X"30",X"5F",X"30",X"7F",X"14",X"FF",X"D4",X"FF",X"54",X"FF",X"50",
		X"00",X"FF",X"00",X"0F",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"AF",X"00",X"A8",X"00",X"28",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"0F",X"FF",X"0F",X"FF",X"0F",X"FF",X"2B",X"FD",X"2B",X"FD",X"2B",X"FD",X"23",X"FF",X"23",X"FF",
		X"7F",X"F0",X"7F",X"F0",X"70",X"F0",X"7C",X"F0",X"FC",X"D4",X"FF",X"D5",X"FF",X"C5",X"FF",X"05",
		X"00",X"FF",X"00",X"0E",X"00",X"02",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"AF",X"00",X"AC",X"00",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"0F",X"F5",X"0F",X"F5",X"0F",X"F5",X"03",X"F5",X"03",X"F7",X"03",X"FF",X"0A",X"FF",X"0A",X"BF",
		X"7F",X"F0",X"7F",X"F0",X"70",X"F0",X"FC",X"F0",X"FC",X"D4",X"FF",X"D5",X"FF",X"C5",X"FF",X"05",
		X"02",X"AB",X"00",X"02",X"00",X"02",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"AF",X"00",X"AC",X"00",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"0F",X"20",X"FF",X"2B",X"FF",X"2B",X"FD",X"03",X"FD",
		X"00",X"00",X"00",X"00",X"00",X"00",X"E8",X"50",X"AF",X"50",X"F3",X"D4",X"F0",X"D4",X"7F",X"F0",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"0F",X"20",X"FF",X"2B",X"FF",X"2B",X"FF",X"03",X"FD",
		X"00",X"00",X"00",X"00",X"00",X"00",X"E0",X"00",X"AF",X"00",X"BF",X"D5",X"F0",X"D5",X"3F",X"F0",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"AF",X"02",X"BF",X"02",X"BE",X"03",X"F5",X"03",X"FD",
		X"00",X"00",X"00",X"00",X"00",X"00",X"E0",X"00",X"AC",X"50",X"BF",X"50",X"C3",X"50",X"FF",X"C0",
		X"03",X"FD",X"2B",X"FD",X"2B",X"FF",X"20",X"FF",X"00",X"0F",X"00",X"00",X"00",X"00",X"00",X"00",
		X"7F",X"F0",X"F0",X"D4",X"F3",X"D4",X"AF",X"50",X"E8",X"50",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"03",X"FD",X"03",X"FF",X"02",X"BF",X"02",X"BF",X"02",X"AF",X"00",X"00",X"00",X"00",X"00",X"00",
		X"7F",X"F0",X"F0",X"D5",X"BF",X"D5",X"AF",X"00",X"E0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"03",X"FD",X"2B",X"F5",X"2B",X"FE",X"20",X"FF",X"00",X"0F",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"C0",X"C3",X"50",X"BF",X"50",X"AC",X"50",X"E0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"03",X"FC",X"0F",X"FF",X"3F",X"B0",X"3E",X"F0",X"3E",X"F5",X"0E",X"FF",X"0E",X"FF",
		X"00",X"00",X"00",X"00",X"C0",X"00",X"70",X"00",X"7C",X"00",X"7C",X"00",X"FF",X"00",X"FF",X"00",
		X"0E",X"F0",X"0E",X"B0",X"3F",X"B5",X"3F",X"FF",X"3F",X"FF",X"0F",X"FF",X"03",X"FC",X"00",X"00",
		X"7F",X"00",X"7F",X"00",X"7C",X"00",X"FC",X"00",X"F0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"0F",X"00",X"3F",X"C0",X"3F",X"F3",X"3F",X"BD",X"3F",X"AD",X"0F",X"AD",X"0F",X"AF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"FC",X"00",X"0F",X"00",X"0F",X"00",X"5F",X"00",X"FF",X"00",
		X"3F",X"AD",X"3F",X"AD",X"3F",X"BD",X"3F",X"FF",X"0F",X"FF",X"0F",X"FF",X"03",X"FC",X"00",X"00",
		X"0F",X"00",X"0C",X"00",X"5C",X"00",X"FC",X"00",X"F0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"3F",X"03",X"F5",X"0F",X"B4",X"3E",X"F4",X"3E",X"FF",X"3E",X"FF",X"3E",X"F5",
		X"00",X"00",X"C0",X"00",X"70",X"00",X"3C",X"00",X"3C",X"00",X"FC",X"00",X"FC",X"00",X"7C",X"00",
		X"0E",X"B4",X"0F",X"B4",X"3F",X"FF",X"3F",X"FF",X"3F",X"FF",X"3F",X"FF",X"03",X"F0",X"00",X"00",
		X"30",X"00",X"30",X"00",X"F0",X"00",X"C0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"BA",X"AA",X"FA",X"AA",X"FE",X"EA",X"BA",X"FA",X"AA",X"FA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"FA",X"AA",X"FA",X"AA",X"EA",X"BA",X"AA",X"FA",X"AA",X"FE",X"AA",X"BA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"BA",X"AA",X"FE",X"AA",X"EE",X"EA",X"BA",X"BA",X"AA",X"BA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"BA",X"AA",X"BA",X"AA",X"EA",X"AA",X"AA",X"BA",X"AA",X"FE",X"AA",X"EE",X"AA",X"BA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AB",X"AA",X"AB",X"AA",X"AF",X"AA",X"AF",
		X"AA",X"AA",X"AA",X"BA",X"AA",X"FE",X"AA",X"BE",X"EA",X"BA",X"EA",X"AA",X"FA",X"AA",X"FA",X"AA",
		X"AA",X"AF",X"AA",X"AF",X"AA",X"AB",X"AA",X"AB",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"FA",X"AA",X"FA",X"AA",X"EA",X"AA",X"EA",X"BA",X"AA",X"FE",X"AA",X"BE",X"AA",X"BA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AB",X"AA",X"AF",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"EA",X"AA",X"EA",X"AA",X"EA",X"AA",
		X"AA",X"AF",X"AA",X"AB",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"EA",X"AA",X"EA",X"AA",X"EA",X"AA",X"EA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AB",X"AA",X"AF",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"FA",X"AA",X"FA",X"AA",X"FA",X"AA",
		X"AA",X"AF",X"AA",X"AB",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"FA",X"AA",X"FA",X"AA",X"FA",X"AA",X"EA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AB",X"AA",X"AB",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"EA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AB",X"AA",X"AB",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"EA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AB",X"AA",X"AF",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"EA",X"AA",X"EA",X"AA",X"EA",X"AA",
		X"AA",X"AF",X"AA",X"AB",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"EA",X"AA",X"EA",X"AA",X"EA",X"AA",X"EA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AB",X"AA",X"AF",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"FA",X"AA",X"FA",X"AA",X"FA",X"AA",
		X"AA",X"AF",X"AA",X"AB",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"FA",X"AA",X"FA",X"AA",X"FA",X"AA",X"EA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AB",X"AA",X"AB",X"AA",X"AB",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"EA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AB",X"AA",X"AB",X"AA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"EA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AE",X"AA",X"AE",X"AA",X"AE",X"AA",X"AF",X"AA",X"AB",
		X"AA",X"AA",X"AA",X"AA",X"AB",X"EA",X"AB",X"EA",X"AB",X"FE",X"AB",X"FE",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AB",X"AA",X"AF",X"AA",X"AE",X"AA",X"AE",X"AA",X"AE",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AB",X"EA",X"AB",X"EA",X"AB",X"FE",X"AB",X"FE",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AE",X"AA",X"AE",X"AA",X"AF",X"AA",X"AF",
		X"AA",X"AA",X"AA",X"AA",X"AB",X"FE",X"AB",X"AE",X"AB",X"AE",X"AB",X"FE",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AF",X"AA",X"AF",X"AA",X"AE",X"AA",X"AE",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AB",X"FE",X"AB",X"AE",X"AB",X"AE",X"AB",X"FE",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AE",X"AA",X"AF",X"AA",X"AF",X"AA",X"BF",X"AA",X"BF",
		X"AA",X"AA",X"AA",X"AA",X"AB",X"FE",X"AB",X"FE",X"AA",X"BE",X"AA",X"BE",X"EA",X"AA",X"EA",X"AA",
		X"AA",X"BF",X"AA",X"BF",X"AA",X"AF",X"AA",X"AF",X"AA",X"AE",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"EA",X"AA",X"EA",X"AA",X"AB",X"FE",X"AB",X"FE",X"AA",X"BE",X"AA",X"BE",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AE",X"AA",X"AE",X"AA",X"AE",X"AA",X"AF",X"AA",X"AB",
		X"AA",X"AA",X"AA",X"AA",X"AB",X"EA",X"AB",X"EA",X"AB",X"FE",X"AB",X"FE",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AB",X"AA",X"AF",X"AA",X"AE",X"AA",X"AE",X"AA",X"AE",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AB",X"EA",X"AB",X"EA",X"AB",X"FE",X"AB",X"FE",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AE",X"AA",X"AE",X"AA",X"AF",X"AA",X"AF",
		X"AA",X"AA",X"AA",X"AA",X"AB",X"FE",X"AB",X"AE",X"AB",X"AE",X"AB",X"FE",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AF",X"AA",X"AF",X"AA",X"AE",X"AA",X"AE",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AB",X"FE",X"AB",X"AE",X"AB",X"AE",X"AB",X"FE",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AE",X"AA",X"AF",X"AA",X"AF",X"AA",X"BF",X"AA",X"BF",
		X"AA",X"AA",X"AA",X"AA",X"AB",X"FE",X"AB",X"FE",X"AA",X"BE",X"AA",X"BE",X"EA",X"AA",X"EA",X"AA",
		X"AA",X"BF",X"AA",X"BF",X"AA",X"AF",X"AA",X"AF",X"AA",X"AE",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"EA",X"AA",X"EA",X"AA",X"AB",X"FE",X"AB",X"FE",X"AA",X"BE",X"AA",X"BE",X"AA",X"AA",X"AA",X"AA",
		X"00",X"00",X"00",X"00",X"00",X"0F",X"00",X"30",X"00",X"0F",X"00",X"00",X"00",X"0F",X"00",X"30",
		X"00",X"00",X"00",X"00",X"F0",X"00",X"0C",X"00",X"F0",X"00",X"00",X"00",X"F0",X"00",X"0C",X"00",
		X"00",X"0F",X"00",X"00",X"00",X"30",X"00",X"3F",X"00",X"30",X"00",X"00",X"00",X"00",X"00",X"00",
		X"F0",X"00",X"00",X"00",X"00",X"00",X"FC",X"00",X"30",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"0F",X"00",X"30",X"00",X"0F",X"00",X"00",X"00",X"0F",X"00",X"30",
		X"00",X"00",X"00",X"00",X"F0",X"00",X"0C",X"00",X"F0",X"00",X"00",X"00",X"F0",X"00",X"0C",X"00",
		X"00",X"0F",X"00",X"00",X"00",X"0F",X"00",X"30",X"00",X"0C",X"00",X"00",X"00",X"00",X"00",X"00",
		X"F0",X"00",X"00",X"00",X"3C",X"00",X"CC",X"00",X"0C",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"0F",X"00",X"30",X"00",X"0F",X"00",X"00",X"00",X"0F",X"00",X"30",
		X"00",X"00",X"00",X"00",X"F0",X"00",X"0C",X"00",X"F0",X"00",X"00",X"00",X"F0",X"00",X"0C",X"00",
		X"00",X"0F",X"00",X"00",X"00",X"0F",X"00",X"30",X"00",X"0F",X"00",X"00",X"00",X"00",X"00",X"00",
		X"F0",X"00",X"00",X"00",X"30",X"00",X"CC",X"00",X"30",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"0A",X"81",X"0A",X"25",X"0A",X"A5",X"0A",X"A5",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"00",X"65",X"00",X"65",X"90",X"96",X"54",
		X"0A",X"A5",X"0A",X"A5",X"2A",X"A5",X"2A",X"A5",X"20",X"25",X"00",X"05",X"00",X"01",X"00",X"00",
		X"96",X"54",X"95",X"90",X"95",X"90",X"95",X"40",X"95",X"40",X"65",X"00",X"40",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"20",X"25",X"2A",X"A5",X"2A",X"A5",X"0A",X"A5",
		X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"00",X"64",X"00",X"65",X"80",X"95",X"C0",X"96",X"50",
		X"0A",X"A5",X"2A",X"A6",X"2A",X"A6",X"20",X"26",X"00",X"01",X"00",X"00",X"00",X"00",X"00",X"00",
		X"96",X"54",X"56",X"50",X"59",X"40",X"1C",X"00",X"50",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"01",X"00",X"05",X"20",X"25",X"2A",X"A5",X"2A",X"A5",X"0A",X"A5",X"0A",X"A5",
		X"00",X"00",X"40",X"00",X"65",X"00",X"65",X"40",X"95",X"40",X"95",X"90",X"95",X"90",X"96",X"54",
		X"0F",X"F0",X"0F",X"F0",X"0F",X"30",X"0F",X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"96",X"54",X"A5",X"90",X"65",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"14",X"0A",X"95",X"0A",X"25",X"0A",X"A5",X"0A",X"A5",X"0A",X"A5",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"94",X"00",X"96",X"40",X"66",X"50",X"65",X"94",
		X"0A",X"A5",X"2A",X"A5",X"2A",X"A5",X"20",X"25",X"00",X"15",X"00",X"14",X"00",X"00",X"00",X"00",
		X"65",X"D0",X"66",X"50",X"96",X"50",X"95",X"00",X"14",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"10",X"00",X"14",X"00",X"35",X"75",X"2F",X"F5",X"2B",X"F5",X"0B",X"F5",
		X"00",X"00",X"00",X"00",X"14",X"00",X"55",X"00",X"71",X"40",X"60",X"C0",X"D1",X"D0",X"D7",X"50",
		X"01",X"5F",X"01",X"57",X"05",X"55",X"15",X"57",X"14",X"0A",X"10",X"28",X"00",X"00",X"00",X"00",
		X"D7",X"50",X"D1",X"50",X"40",X"40",X"51",X"40",X"55",X"00",X"94",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"20",X"25",X"2A",X"A5",X"2A",X"96",X"0A",X"96",
		X"00",X"00",X"00",X"00",X"00",X"00",X"50",X"00",X"45",X"20",X"95",X"90",X"56",X"94",X"56",X"54",
		X"0A",X"96",X"0A",X"96",X"0A",X"A5",X"0A",X"25",X"0A",X"81",X"00",X"00",X"00",X"00",X"00",X"00",
		X"56",X"54",X"56",X"90",X"95",X"80",X"65",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF");
begin
process(clk)
begin
	if rising_edge(clk) then
		data <= rom_data(to_integer(unsigned(addr)));
	end if;
end process;
end architecture;
