-- csr-bccmd.lua

-- bluez/tools/csr.h
local bccmd_types = {
    [0x0000] = "GetReq",
    [0x0001] = "SetRep",
    [0x0002] = "SetReq"
}

-- grep "#define CSR_VARID_" csr.h | awk ' { printf "    [%s] = \"%s\",\n", $3, $2;} '
local BCCMD_VARID = {
    [0x000b] = "PS CLR All",
    [0x000c] = "PS Factory Set",
    [0x082d] = "PS CLR All Stores",
    [0x2801] = "BC01 Status",
    [0x2819] = "Build Id",
    [0x281a] = "Chip Ver",
    [0x281b] = "Chip Rev",
    [0x2825] = "Interface Version",
    [0x282a] = "Rand",
    [0x282c] = "Max Crypt Key Length",
    [0x2836] = "Chip ANA Rev",
    [0x2838] = "Build Id Loader",
    [0x2c00] = "BT Clock",
    [0x3005] = "PS Next",
    [0x3006] = "PS Size",
    [0x3008] = "Crypt Key Length",
    [0x3009] = "Piconet Instance",
    [0x300a] = "Get CLR EVT",
    [0x300b] = "GET Next Builddef",
    [0x3012] = "PS Memory Type",
    [0x301c] = "Read Build Name",
    [0x4001] = "Cold Reset",
    [0x4002] = "Warm Reset",
    [0x4003] = "Cold Halt",
    [0x4004] = "Warm Halt",
    [0x4005] = "Init BT Stack",
    [0x4006] = "Activate BT Stack",
    [0x4007] = "Enable Tx",
    [0x4008] = "Disable Tx",
    [0x4009] = "Recal",
    [0x400d] = "PS Factory Restore",
    [0x400e] = "PS Factory Restore All",
    [0x400f] = "PS Defrag Reset",
    [0x4010] = "Kill VM Application",
    [0x4011] = "Hopping  On",
    [0x4012] = "Cancel Page",
    [0x4818] = "PS CLR",
    [0x481c] = "Map SCO PCM",
    [0x482e] = "Single Chan",
    [0x5004] = "Radio Test",
    [0x500c] = "PS CLR Stores",
    [0x6000] = "No Variable",
    [0x6802] = "Config UART",
    [0x6805] = "Panic Arg",
    [0x6806] = "Fault Arg",
    [0x6827] = "Max Tx Power",
    [0x682b] = "Default Tx Power",

    [0x7003] = "PS",
}

-- grep "#define CSR_PSKEY_" csr.h | awk ' { printf "    [%s] = \"%s\",\n", $3, $2;} '
bccmd_pskeys = {
    [0x0001] = "BDADDR",
    [0x0002] = "Country Code",
    [0x0003] = "Class Of Device",
    [0x0004] = "Device Drift",
    [0x0005] = "Device Jitter",
    [0x000d] = "Max ACLs",
    [0x000e] = "Max SCOs",
    [0x000f] = "Max Remote Masters",
    [0x0010] = "Enable Mastery With Slavery",
    [0x0011] = "Max ACL Packet length",
    [0x0012] = "Max SCO Packet length",
    [0x0013] = "Max ACL Packets",
    [0x0014] = "Max SCO Packets",
    [0x0015] = "LC FC Buffer Low Water Mark",
    [0x0017] = "LC Max Tx Power",
    [0x001d] = "Tx Gain Ramp",
    [0x001e] = "LC Power Table",
    [0x001f] = "LC Peer Power Period",
    [0x0020] = "LC FC Pools Low Water Mask",
    [0x0021] = "LC Default Tx Power",
    [0x0022] = "LC RSSI Golden Range",
    [0x0028] = "LC Combo Disable PIO Mask",
    [0x0029] = "LC Combo Priority PIO Mask",
    [0x002a] = "LC Combo Dot11 Channel PIO Base",
    [0x002b] = "LC Combo Dot11 Block Channels",
    [0x002d] = "LC Max Tx Power No RSSI",
    [0x002e] = "LC Connection Rx Window",
    [0x0030] = "LC Combo Dot11 Tx Protection Mode",
    [0x0031] = "LC Enhanced Power Table",
    [0x0032] = "LC Wideband RSSI Config",
    [0x0033] = "LC Combo Dot11 Priority Lead",
    [0x0034] = "BT Clock Init",
    [0x0038] = "Tx MR Mod Delay",
    [0x0039] = "Rx MR Sync Timing",
    [0x003a] = "Rx MR Sync Config",
    [0x003b] = "LC Lost Sync Slots",
    [0x003c] = "Rx MR Samp Config",
    [0x003d] = "Agc Hyst Levels",
    [0x003e] = "Rx Level Low Signal",
    [0x003f] = "Agc IQ lvl Values",
    [0x0040] = "MR Ftrim Offset 12dB",
    [0x0041] = "MR Ftrim Offset 6dB",
    [0x0042] = "No Cal On Boot",
    [0x0043] = "RSSI Hi Target",
    [0x0044] = "Preferred Min Attenuation",
    [0x0045] = "LC Combo Dot11 Priority Override",
    [0x0047] = "LC Multislot Holdoff",
    [0x00c9] = "Free Key Pigeon Hole",
    [0x00ca] = "Link Key BDADDR0",
    [0x00cb] = "Link Key BDADDR1",
    [0x00cc] = "Link Key BDADDR2",
    [0x00cd] = "Link Key BDADDR3",
    [0x00ce] = "Link Key BDADDR4",
    [0x00cf] = "Link Key BDADDR5",
    [0x00d0] = "Link Key BDADDR6",
    [0x00d1] = "Link Key BDADDR7",
    [0x00d2] = "Link Key BDADDR8",
    [0x00d3] = "Link Key BDADDR9",
    [0x00d4] = "Link Key BDADDR10",
    [0x00d5] = "Link Key BDADDR11",
    [0x00d6] = "Link Key BDADDR12",
    [0x00d7] = "Link Key BDADDR13",
    [0x00d8] = "Link Key BDADDR14",
    [0x00d9] = "Link Key BDADDR15",
    [0x00da] = "Enc Key Lmin",
    [0x00db] = "Enc Key Lmax",
    [0x00ef] = "Local Supported Features",
    [0x00f0] = "LM Use Unit Key",
    [0x00f2] = "HCI Nop Disable",
    [0x00f4] = "LM Max Event Filters",
    [0x00f5] = "LM Use Enc Mode Broadcast",
    [0x00f6] = "LM Test Send Accepted Twice",
    [0x00f7] = "LM Max Page Hold Time",
    [0x00f8] = "Afh Adaption Response Time",
    [0x00f9] = "Afh Options",
    [0x00fa] = "Afh RSSI Run Period",
    [0x00fb] = "Afh Reenable Channel Time",
    [0x00fc] = "No Drop On Acr MS Fail",
    [0x00fd] = "Max Private Keys",
    [0x00fe] = "Private Link Key BDADDR0",
    [0x00ff] = "Private Link Key BDADDR1",
    [0x0100] = "Private Link Key BDADDR2",
    [0x0101] = "Private Link Key BDADDR3",
    [0x0102] = "Private Link Key BDADDR4",
    [0x0103] = "Private Link Key BDADDR5",
    [0x0104] = "Private Link Key BDADDR6",
    [0x0105] = "Private Link Key BDADDR7",
    [0x0106] = "Local Supported Commands",
    [0x0107] = "LM Max Absence Index",
    [0x0108] = "Device Name",
    [0x0109] = "Afh RSSI Threshold",
    [0x010a] = "LM Casual Scan Interval",
    [0x010b] = "Afh Min Map Change",
    [0x010c] = "Afh RSSI LP Run Period",
    [0x010d] = "HCI LMP Local Version",
    [0x010e] = "LMP Remote Version",
    [0x0113] = "Hold Error Message Number",
    [0x0136] = "DFU Attributes",
    [0x0137] = "DFU Detach To",
    [0x0138] = "DFU Transfer Size",
    [0x0139] = "DFU Enable",
    [0x013a] = "DFU Lin Reg Enable",
    [0x015e] = "DFU Enc Vmapp PK Modules MSB",
    [0x015f] = "DFU Enc Vmapp PK Modules LSB",
    [0x0160] = "DFU Enc Vmapp PK M Dash",
    [0x0161] = "DFU Enc Vmapp PK R2N MSB",
    [0x0162] = "DFU Enc Vmapp PK R2N LSB",
    [0x0192] = "BCSP LM PS Block",
    [0x0193] = "Host IO FC PS Block",
    [0x0194] = "Host IO Protocol Info 0",
    [0x0195] = "Host IO Protocol Info 1",
    [0x0196] = "Host IO Protocol Info 2",
    [0x0197] = "Host IO Protocol Info 3",
    [0x0198] = "Host IO Protocol Info 4",
    [0x0199] = "Host IO Protocol Info 5",
    [0x019a] = "Host IO Protocol Info 6",
    [0x019b] = "Host IO Protocol Info 7",
    [0x019c] = "Host IO Protocol Info 8",
    [0x019d] = "Host IO Protocol Info 9",
    [0x019e] = "Host IO Protocol Info 10",
    [0x019f] = "Host IO Protocol Info 11",
    [0x01a0] = "Host IO Protocol Info 12",
    [0x01a1] = "Host IO Protocol Info 13",
    [0x01a2] = "Host IO Protocol Info 14",
    [0x01a3] = "Host IO Protocol Info 15",
    [0x01a4] = "Host IO UART Reset Timeout",
    [0x01a5] = "Host IO Use HCI EXTN",
    [0x01a6] = "Host IO Use HCI EXTN CCFC",
    [0x01a7] = "Host IO HCI EXTN Payload Size",
    [0x01aa] = "BCSP LM CNF CNT Limit",
    [0x01ab] = "Host IO Map SCO PCM",
    [0x01ac] = "Host IO Awkward PCM Sync",
    [0x01ad] = "Host IO Break Poll Period",
    [0x01ae] = "Host IO Min UART HCI SCO Size",
    [0x01b0] = "Host IO Map SCO Codec",
    [0x01b1] = "PCM CVSD Tx Hi Freq Boost",
    [0x01b2] = "PCM CVSD Rx Hi Freq Boost",
    [0x01b3] = "PCM Config32",
    [0x01b4] = "Use Old BCSP LE",
    [0x01b5] = "PCM CVSD Use New Filter",
    [0x01b6] = "PCM Format",
    [0x01b7] = "Codec Out Gain",
    [0x01b8] = "Codec In Gain",
    [0x01b9] = "Codec PIO",
    [0x01ba] = "PCM Low Jitter Config",
    [0x01bb] = "Host IO SCO PCM Thresholds",
    [0x01bc] = "Host IO SCO HCI Thresholds",
    [0x01bd] = "Host IO Map SCO PCM Slot",
    [0x01be] = "UART Baudrate",
    [0x01bf] = "UART Config BCSP",
    [0x01c0] = "UART Config H4",
    [0x01c1] = "UART Config H5",
    [0x01c2] = "UART Config USR",
    [0x01c3] = "UART Tx CRCS",
    [0x01c4] = "UART Ack Timeout",
    [0x01c5] = "UART Tx Max Attempts",
    [0x01c6] = "UART Tx Window Size",
    [0x01c7] = "UART Host Wake",
    [0x01c8] = "Host IO Throttle Timeout",
    [0x01c9] = "PCM Always Enable",
    [0x01ca] = "UART Host Wake Signal",
    [0x01cb] = "UART Config H4DS",
    [0x01cc] = "H4DS Wake Duration",
    [0x01cd] = "H4DS Maxwu",
    [0x01cf] = "H4DS LE timer Period",
    [0x01d0] = "H4DS TWU Timer Period",
    [0x01d1] = "H4DS UART Idle Timer Period",
    [0x01f6] = "Ana Ftrim",
    [0x01f7] = "WD Timeout",
    [0x01f8] = "WD Period",
    [0x01f9] = "Host Interface",
    [0x01fb] = "Hq Host Timeout",
    [0x01fc] = "Hq Active",
    [0x01fd] = "Bccmd Security Active",
    [0x01fe] = "Ana Freq",
    [0x0202] = "Pio Protect Mask",
    [0x0203] = "Pmalloc Sizes",
    [0x0204] = "UART Baud Rate",
    [0x0205] = "UART Config",
    [0x0207] = "Stub",
    [0x0209] = "Txrx Pio Control",
    [0x020b] = "Ana Rx Level",
    [0x020c] = "Ana Rx Ftrim",
    [0x020d] = "Psbc Data Version",
    [0x020f] = "Pcm0 Attenuation",
    [0x0211] = "Lo Lvl Max",
    [0x0212] = "Lo Adc Ampl Min",
    [0x0213] = "Lo Adc Ampl Max",
    [0x0214] = "Iq Trim Channel",
    [0x0215] = "Iq Trim Gain",
    [0x0216] = "Iq Trim Enable",
    [0x0217] = "Tx Offset Half Mhz",
    [0x0221] = "Gbl Misc Enables",
    [0x0222] = "UART Sleep Timeout",
    [0x0229] = "Deep Sleep State",
    [0x022d] = "Iq Enable Phase Trim",
    [0x0237] = "Hci Handle Freeze Period",
    [0x0238] = "Max Frozen Hci Handles",
    [0x0239] = "Pagetable Destruction Delay",
    [0x023a] = "Iq Trim Pio Settings",
    [0x023b] = "Use External Clock",
    [0x023c] = "Deep Sleep Wake Cts",
    [0x023d] = "Fc Hc2h Flush Delay",
    [0x023e] = "Rx Highside",
    [0x0240] = "Tx Pre Lvl",
    [0x0242] = "Rx Single Ended",
    [0x0243] = "Tx Filter Config",
    [0x0246] = "Clock Request Enable",
    [0x0249] = "Rx Min Atten",
    [0x024b] = "Xtal Target Amplitude",
    [0x024d] = "Pcm Min Cpu Clock",
    [0x0250] = "Host Interface Pio USB",
    [0x0251] = "Cpu Idle Mode",
    [0x0252] = "Deep Sleep Clear Rts",
    [0x0254] = "Rf Resonance Trim",
    [0x0255] = "Deep Sleep Pio Wake",
    [0x0256] = "Drain Bore Timers",
    [0x0257] = "Drain Tx Power Base",
    [0x0259] = "Module Id",
    [0x025a] = "Module Design",
    [0x025c] = "Module Security Code",
    [0x025d] = "Vm Disable",
    [0x025e] = "Mod Manuf0",
    [0x025f] = "Mod Manuf1",
    [0x0260] = "Mod Manuf2",
    [0x0261] = "Mod Manuf3",
    [0x0262] = "Mod Manuf4",
    [0x0263] = "Mod Manuf5",
    [0x0264] = "Mod Manuf6",
    [0x0265] = "Mod Manuf7",
    [0x0266] = "Mod Manuf8",
    [0x0267] = "Mod Manuf9",
    [0x0268] = "Dut Vm Disable",
    [0x028a] = "Usr 0",
    [0x028b] = "Usr 1",
    [0x028c] = "Usr 2",
    [0x028d] = "Usr 3",
    [0x028e] = "Usr 4",
    [0x028f] = "Usr 5",
    [0x0290] = "Usr 6",
    [0x0291] = "Usr 7",
    [0x0292] = "Usr 8",
    [0x0293] = "Usr 9",
    [0x0294] = "Usr 10",
    [0x0295] = "Usr 11",
    [0x0296] = "Usr 12",
    [0x0297] = "Usr 13",
    [0x0298] = "Usr 14",
    [0x0299] = "Usr 15",
    [0x029a] = "Usr 16",
    [0x029b] = "Usr 17",
    [0x029c] = "Usr 18",
    [0x029d] = "Usr 19",
    [0x029e] = "Usr 20",
    [0x029f] = "Usr 21",
    [0x02a0] = "Usr 22",
    [0x02a1] = "Usr 23",
    [0x02a2] = "Usr 24",
    [0x02a3] = "Usr 25",
    [0x02a4] = "Usr 26",
    [0x02a5] = "Usr 27",
    [0x02a6] = "Usr 28",
    [0x02a7] = "Usr 29",
    [0x02a8] = "Usr 30",
    [0x02a9] = "Usr 31",
    [0x02aa] = "Usr 32",
    [0x02ab] = "Usr 33",
    [0x02ac] = "Usr 34",
    [0x02ad] = "Usr 35",
    [0x02ae] = "Usr 36",
    [0x02af] = "Usr 37",
    [0x02b0] = "Usr 38",
    [0x02b1] = "Usr 39",
    [0x02b2] = "Usr 40",
    [0x02b3] = "Usr 41",
    [0x02b4] = "Usr 42",
    [0x02b5] = "Usr 43",
    [0x02b6] = "Usr 44",
    [0x02b7] = "Usr 45",
    [0x02b8] = "Usr 46",
    [0x02b9] = "Usr 47",
    [0x02ba] = "Usr 48",
    [0x02bb] = "Usr 49",
    [0x02bc] = "USB Version",
    [0x02bd] = "USB Device Class Codes",
    [0x02be] = "USB Vendor Id",
    [0x02bf] = "USB Product Id",
    [0x02c1] = "USB Manuf String",
    [0x02c2] = "USB Product String",
    [0x02c3] = "USB Serial Number String",
    [0x02c4] = "USB Config String",
    [0x02c5] = "USB Attributes",
    [0x02c6] = "USB Max Power",
    [0x02c7] = "USB Bt If Class Codes",
    [0x02c9] = "USB Langid",
    [0x02ca] = "USB Dfu Class Codes",
    [0x02cb] = "USB Dfu Product Id",
    [0x02ce] = "USB Pio Detach",
    [0x02cf] = "USB Pio Wakeup",
    [0x02d0] = "USB Pio Pullup",
    [0x02d1] = "USB Pio Vbus",
    [0x02d2] = "USB Pio Wake Timeout",
    [0x02d3] = "USB Pio Resume",
    [0x02d4] = "USB Bt Sco If Class Codes",
    [0x02d5] = "USB Suspend Pio Level",
    [0x02d6] = "USB Suspend Pio Dir",
    [0x02d7] = "USB Suspend Pio Mask",
    [0x02d8] = "USB Endpoint 0 Max Packet Size",
    [0x02d9] = "USB Config",
    [0x0320] = "Radiotest Atten Init",
    [0x0326] = "Radiotest First Trim Time",
    [0x0327] = "Radiotest Subsequent Trim Time",
    [0x0328] = "Radiotest Lo Lvl Trim Enable",
    [0x032c] = "Radiotest Disable Modulation",
    [0x0352] = "Rfcomm Fcon Threshold",
    [0x0353] = "Rfcomm Fcoff Threshold",
    [0x0354] = "Ipv6 Static Addr",
    [0x0355] = "Ipv4 Static Addr",
    [0x0356] = "Ipv6 Static Prefix Len",
    [0x0357] = "Ipv6 Static Router Addr",
    [0x0358] = "Ipv4 Static Subnet Mask",
    [0x0359] = "Ipv4 Static Router Addr",
    [0x035a] = "Mdns Name",
    [0x035b] = "Fixed Pin",
    [0x035c] = "Mdns Port",
    [0x035d] = "Mdns Ttl",
    [0x035e] = "Mdns Ipv4 Addr",
    [0x035f] = "Arp Cache Timeout",
    [0x0360] = "Hfp Power Table",
    [0x03e7] = "Drain Bore Timer Counters",
    [0x03e6] = "Drain Bore Counters",
    [0x03e4] = "Loop Filter Trim",
    [0x03e3] = "Drain Bore Current Peak",
    [0x03e2] = "Vm E2 Cache Limit",
    [0x03e1] = "Force 16mhz Ref Pio",
    [0x03df] = "Cdma Lo Ref Limits",
    [0x03de] = "Cdma Lo Error Limits",
    [0x03dd] = "Clock Startup Delay",
    [0x03dc] = "Deep Sleep Correction Factor",
    [0x03db] = "Temperature Calibration",
    [0x03da] = "Temperature Vs Delta Internal Pa",
    [0x03d9] = "Temperature Vs Delta Tx Pre Lvl",
    [0x03d8] = "Temperature Vs Delta Tx Bb",
    [0x03d7] = "Temperature Vs Delta Ana Ftrim",
    [0x03d6] = "Test Delta Offset",
    [0x03d4] = "Rx Dynamic Lvl Offset",
    [0x03d3] = "Test Force Offset",
    [0x03cf] = "Rf Trap Bad Division Ratios",
    [0x03ce] = "Radiotest Cdma Lo Ref Limits",
    [0x03cd] = "Initial Bootmode",
    [0x03cc] = "Onchip Hci Client",
    [0x03ca] = "Rx Atten Backoff",
    [0x03c9] = "Rx Atten Update Rate",
    [0x03c7] = "Synth Txrx Thresholds",
    [0x03c6] = "Min Wait States",
    [0x03c5] = "Rssi Correction",
    [0x03c4] = "Sched Throttle Timeout",
    [0x03c3] = "Deep Sleep Use External Clock",
    [0x03c2] = "Trim Radio Filters",
    [0x03c1] = "Transmit Offset",
    [0x03c0] = "USB Vm Control",
    [0x03bf] = "Mr Ana Rx Ftrim",
    [0x03be] = "I2c Config",
    [0x03bd] = "Iq Lvl Rx",
    [0x03bb] = "Mr Tx Filter Config",
    [0x03ba] = "Mr Tx Config2",
    [0x03b9] = "USB Dont Reset Bootmode On Host Reset",
    [0x03b8] = "Lc Use Throttling",
    [0x03b7] = "Charger Trim",
    [0x03b6] = "Clock Request Features",
    [0x03b4] = "Transmit Offset Class1",
    [0x03b3] = "Tx Avoid Pa Class1 Pio",
    [0x03b2] = "Mr Pio Config",
    [0x03b1] = "UART Config2",
    [0x03b0] = "Class1 Iq Lvl",
    [0x03af] = "Class1 Tx Config2",
    [0x03ae] = "Temperature Vs Delta Internal Pa Class1",
    [0x03ad] = "Temperature Vs Delta External Pa Class1",
    [0x03ac] = "Temperature Vs Delta Tx Pre Lvl Mr",
    [0x03ab] = "Temperature Vs Delta Tx Bb Mr Header",
    [0x03aa] = "Temperature Vs Delta Tx Bb Mr Payload",
    [0x03a9] = "Rx Mr Eq Taps",
    [0x03a8] = "Tx Pre Lvl Class1",
    [0x03a7] = "Analogue Attenuator",
    [0x03a6] = "Mr Rx Filter Trim",
    [0x03a5] = "Mr Rx Filter Response",
    [0x039f] = "Pio Wakeup State",
    [0x0394] = "Mr Tx If Atten Off Temp",
    [0x0393] = "Lo Div Latch Bypass",
    [0x0392] = "Lo Vco Standby",
    [0x0391] = "Slow Clock Filter Shift",
    [0x0390] = "Slow Clock Filter Divider",
    [0x03f2] = "USB Attributes Power",
    [0x03f3] = "USB Attributes Wakeup",
    [0x03f4] = "Dfu Attributes Manifestation Tolerant",
    [0x03f5] = "Dfu Attributes Can Upload",
    [0x03f6] = "Dfu Attributes Can Download",
    [0x03fc] = "UART Config Stop Bits",
    [0x03fd] = "UART Config Parity Bit",
    [0x03fe] = "UART Config Flow Ctrl En",
    [0x03ff] = "UART Config Rts Auto En",
    [0x0400] = "UART Config Rts",
    [0x0401] = "UART Config Tx Zero En",
    [0x0402] = "UART Config Non BCSP En",
    [0x0403] = "UART Config Rx Rate Delay",
    [0x0405] = "UART Seq Timeout",
    [0x0406] = "UART Seq Retries",
    [0x0407] = "UART Seq Winsize",
    [0x0408] = "UART Use CRC On Tx",
    [0x0409] = "UART Host Initial State",
    [0x040a] = "UART Host Attention Span",
    [0x040b] = "UART Host Wakeup Time",
    [0x040c] = "UART Host Wakeup Wait",
    [0x0410] = "BCSP Lm Mode",
    [0x0411] = "BCSP Lm Sync Retries",
    [0x0412] = "BCSP Lm Tshy",
    [0x0417] = "UART Dfu Config Stop Bits",
    [0x0418] = "UART Dfu Config Parity Bit",
    [0x0419] = "UART Dfu Config Flow Ctrl En",
    [0x041a] = "UART Dfu Config Rts Auto En",
    [0x041b] = "UART Dfu Config Rts",
    [0x041c] = "UART Dfu Config Tx Zero En",
    [0x041d] = "UART Dfu Config Non BCSP En",
    [0x041e] = "UART Dfu Config Rx Rate Delay",
    [0x041f] = "Amux Aio0",
    [0x0420] = "Amux Aio1",
    [0x0421] = "Amux Aio2",
    [0x0422] = "Amux Aio3",
    [0x0423] = "Local Name Simplified",
    [0x2001] = "Extended Stub",
}

bccmd_status = {
    [0x0000] = "OK",
    [0x0001] = "No such varid",
    [0x0002] = "Too big",
    [0x0003] = "No value",
    [0x0004] = "Bad req",
    [0x0005] = "No access",
    [0x0006] = "Read only",
    [0x0007] = "Write only",
    [0x0008] = "Error",
    [0x0009] = "Permission denied",
    [0x000a] = "Timeout"
}

-- BlueCore Command Field and ProtoField
hci_cmd_opcode = Field.new("bthci_cmd.opcode.ogf")
hci_cmd_param_length = Field.new("bthci_cmd.param_length")

hci_event_code = Field.new("bthci_evt.code")
hci_event_param_length = Field.new("bthci_evt.param_length")

bccmd_opcode = ProtoField.uint16("bthci_vendor.csr.command", "Command", base.HEX_DEC, bccmd_types)
bccmd_size = ProtoField.uint16("bthci_vendor.csr.size", "Size")
bccmd_seqnum = ProtoField.uint16("bthci_vendor.csr.seqnum", "SeqNum", base.DEC_HEX)
bccmd_varid = ProtoField.uint16("bthci_vendor.csr.varid", "VarId", base.HEX_DEC, bccmd_known_varids)
bccmd_status = ProtoField.uint16("bthci_vendor.csr.status", "Status", base.HEX_DEC, bccmd_status)
bccmd_payload = ProtoField.bytes("bthci_vendor.csr.payload", "Payload")
bccmd_padding = ProtoField.bytes("bthci_vendor.csr.padding", "Padding")

-- 0x281b - CSR_VARID_CHIPREV
bccmd_chiprev = ProtoField.uint16("bthci_vendor.csr.chip_rev", "Chip Rev", base.HEX_DEC, {
    [0x15] = "BC3-ROM",
    [0x26] = "BC4-External",
    [0x30] = "BC4-ROM",
    [0x28] = "BC2-ROM",
    [0x43] = "BC3-Multimedia",
    [0x64] = "BC1 ES",
    [0x65] = "BC1",
    [0x89] = "BC2-External A",
    [0x8a] = "BC2-External B",
    [0xe2] = "BC3-Flash",
})

-- 0x282a - CSR_VARID_RAND
bccmd_rand = ProtoField.uint16("bthci_vendor.csr.rand", "Rand", base.HEX_DEC)

-- 0x282a - CSR_VARID_RAND
bccmd_rand = ProtoField.uint32("bthci_vendor.csr.rand", "Rand", base.HEX_DEC)

-- 0x2c00 - CSR_VARID_BT_CLOCK
bccmd_clock = ProtoField.uint32("bthci_vendor.csr.clock", "Clock", base.HEX_DEC)

-- 0x3008 - CSR_VARID_CRYPT_KEY_LENGTH
bccmd_handle = ProtoField.uint16("bthci_vendor.csr.handle", "Handle", base.HEX_DEC)
bccmd_key_len = ProtoField.uint16("bthci_vendor.csr.key_length", "Key Length", base.DEC)

-- 0x300b - CSR_VARID_GET_NEXT_BUILDDEF
bccmd_def = ProtoField.uint16("bthci_vendor.csr.def", "Def", base.HEX_DEC)
bccmd_nextdef = ProtoField.uint16("bthci_vendor.csr.nextdef", "Nextdef", base.HEX_DEC)

-- 0x3012 - CSR_VARID_PS_MEMORY_TYPE
bccmd_mem_type = ProtoField.uint16("bthci_vendor.csr.mem_type", "MemType", base.HEX_DEC, {
    [0x0000] = "Flash memory",
    [0x0001] = "EEPROM",
    [0x0002] = "RAM (transient)",
    [0x0003] = "ROM (or \"read-only\" flash memory)",
})

-- 0x301c - CSR_VARID_READ_BUILD_NAME
bccmd_buildname = ProtoField.string("bthci_vendor.csr.build_name", "BuildName")
bccmd_start = ProtoField.uint16("bthci_vendor.csr.name_start", "Start", base.HEX_DEC)
bccmd_key_len = ProtoField.uint16("bthci_vendor.csr.name_length", "Length", base.DEC)

-- 0x482e - CSR_VARID_SINGLE_CHAN
bccmd_channel = ProtoField.uint16("bthci_vendor.csr.channel", "Channel", base.HEX_DEC)

-- 0x6805 - CSR_VARID_PANIC_ARG
bccmd_panic_error = ProtoField.uint16("bthci_vendor.csr.panic_error", "Error", base.HEX_DEC)

-- 0x6806 - CSR_VARID_FAULT_ARG
bccmd_fault_error = ProtoField.uint16("bthci_vendor.csr.fault_error", "Error", base.HEX_DEC)

-- 0x3005 - CSR_VARID_PS_NEXT
bccmd_nextkey = ProtoField.uint16("bthci_vendor.csr.next_key", "Next Key", base.HEX, BCCMD_PSKEY)

-- 0x3006 - CSR_VARID_PS_SIZE
-- 0x500c - CSR_VARID_PS_CLR_STORES
-- 0x7003 - CSR_VARID_PS
bccmd_pskey = ProtoField.uint16("bthci_vendor.csr.pskey", "PS Key", base.HEX, bccmd_pskeys)
bccmd_pskey_size = ProtoField.uint16("bthci_vendor.csr.pskey_size", "PsKey Size", base.DEC)
bccmd_pskey_store = ProtoField.uint16("bthci_vendor.csr.pskey_store", "PsKey Store", base.HEX_DEC, {
    [0x0000] = 'default',
    [0x0001] = 'psi',
    [0x0002] = 'psf',
    [0x0003] = 'psi then psf',
    [0x0004] = 'psrom',
    [0x0007] = 'psi, psf then psrom',
    [0x0008] = 'psram',
    [0x0009] = 'psram then psi',
    [0x000b] = 'psram, psi then psf',
    [0x000f] = 'psram, psi, psf then psrom'
})

bccmd_pskey_value = ProtoField.string("bthci_vendor.csr.pskey_value", "PsKey Value")

-- BlueCore Command Postdissector

csr_bccmd_proto = Proto("bthci_vendor.csr", "Bluetooth CSR HCI")
csr_bccmd_proto.fields = {
    bccmd_opcode,
    bccmd_size,
    bccmd_seqnum,
    bccmd_varid,
    bccmd_status,
    bccmd_payload,
    bccmd_padding,
    -- 0x281b - CSR_VARID_CHIPREV
    bccmd_chiprev,
    -- 0x282a - CSR_VARID_RAND
    bccmd_rand,
    -- 0x2c00 - CSR_VARID_BT_CLOCK
    bccmd_clock,
    -- 0x3008 - CSR_VARID_CRYPT_KEY_LENGTH
    bccmd_handle,
    bccmd_key_len,
    -- 0x300b - CSR_VARID_GET_NEXT_BUILDDEF
    bccmd_def,
    bccmd_nextdef,
    -- 0x3012 - CSR_VARID_PS_MEMORY_TYPE
    bccmd_mem_type,
    -- 0x301c - CSR_VARID_READ_BUILD_NAME
    bccmd_start,
    bccmd_length,
    bccmd_buildname,
    -- 0x482e - CSR_VARID_SINGLE_CHAN
    bccmd_channel,
    -- 0x3005 - CSR_VARID_PS_NEXT
    bccmd_nextkey,

    -- 0x6805 -- CSR_VARID_PANIC_ARG
    bccmd_panic_error,
    -- 0x6806 - CSR_VARID_FAULT_ARG
    bccmd_fault_error,
    -- 0x3006 - CSR_VARID_PS_SIZE
    -- 0x500c - CSR_VARID_PS_CLR_STORES
    -- 0x7003 - CSR_VARID_PS
    bccmd_pskey,
    bccmd_pskey_size,
    bccmd_pskey_store,
    bccmd_pskey_value,
}

-- FUNCTION
function tree_add_u32(tree, protofield, buff)
    local val = 0

    val = buff:range(1, 1):uint()
    val = val * 256 + buff:range(0, 1):uint()
    val = val * 256 + buff:range(3, 1):uint()
    val = val * 256 + buff:range(2, 1):uint()

    return tree:add(protofield, buff, val)
end

local bccmd_op_varid = {
    [0x281b] = { -- CSR_VARID_CHIPREV
        [1] = function(buff, tree)
            tree:add_le(bccmd_chiprev, buff:range(0, 2))

            return 2
        end
    },
    [0x282a] = { -- CSR_VARID_RAND
        [1] = function(buff, tree)
            tree:add_le(bccmd_rand, buff:range(0, 2))

            return 2
        end
    },
    [0x2c00] = { -- CSR_VARID_BT_CLOCK
        [1] = function(buff, tree)
            tree_add_u32(tree, bccmd_clock, buff:range(0, 4))

            return 4
        end
    },
    [0x3005] = { -- CSR_VARID_PS_NEXT
        [0] = function(buff, tree)
            local offset = 0
            tree:add_le(bccmd_pskey, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_pskey_store, buff:range(offset, 2))
            offset = offset + 2

            return offset
        end,
        [1] = function(buff, tree)
            local offset = 0
            tree:add_le(bccmd_pskey, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_pskey_store, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_nextkey, buff:range(offset, 2))
            offset = offset + 2
            return offset
        end
    },
    [0x3006] = { -- CSR_VARID_PS_SIZE
        [0] = function(buff, tree)
            local offset = 0
            tree:add_le(bccmd_pskey, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_pskey_store, buff:range(offset, 2))
            offset = offset + 2

            return offset
        end,
        [1] = function(buff, tree)
            local offset = 0
            tree:add_le(bccmd_pskey, buff:range(offset, 2))
            offset = offset + 2
            local size = buff:range(offset, 2):le_uint()
            tree:add_le(bccmd_pskey_size, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_pskey_store, buff:range(offset, 2))
            offset = offset + 2

            return offset
        end
    },
    [0x3008] = { -- CSR_VARID_CRYPT_KEY_LENGTH
        [0] = function(buff, tree)
            tree:add_le(bccmd_handle, buff:range(0, 2))

            return 2
        end,
        [1] = function(buff, tree)
            local offset = 0
            tree:add_le(bccmd_handle, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_key_len, buff:range(offset, 2))
            offset = offset + 2

            return offset
        end
    },
    [0x300b] = { -- CSR_VARID_GET_NEXT_BUILDDEF
        [0] = function(buff, tree)
            tree:add_le(bccmd_def, buff:range(0, 2))

            return 2
        end,
        [1] = function(buff, tree)
            local offset = 0
            tree:add_le(bccmd_def, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_nextdef, buff:range(offset, 2))
            offset = offset + 2

            return offset
        end
    },
    [0x3012] = { -- CSR_VARID_PS_MEMORY_TYPE
        [1] = function(buff, tree)
            local offset = 0
            tree:add_le(bccmd_pskey_store, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_mem_type, buff:range(offset, 2))
            offset = offset + 2

            return offset
        end
    },
    [0x301c] = { -- CSR_VARID_READ_BUILD_NAME
        [1] = function(buff, tree)
            local offset = 0
            local start = buff:range(offset, 2):le_uint()
            tree:add_le(bccmd_def, buff:range(offset, 2))
            offset = offset + 2
            local length = buff:range(offset, 2):le_uint()
            tree:add_le(bccmd_nextdef, buff:range(offset, 2))
            offset = offset + 2
            tree:add(bccmd_buildname, buff:range(offset + start, length))

            return offset + start + length
        end
    },
    [0x482e] = { -- CSR_VARID_SINGLE_CHAN
        [0] = function(buff, tree)
            tree:add_le(bccmd_channel, buff:range(0, 2))

            return 2
        end
    },
    [0x500c] = { -- CSR_VARID_PS_CLR_STORES
        [0] = function(buff, tree)
            local offset = 0
            tree:add_le(bccmd_pskey, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_pskey_store, buff:range(offset, 2))
            offset = offset + 2

            return offset
        end
    },
    [0x6805] = { -- CSR_VARID_PANIC_ARG
        [1] = function(buff, tree)
            tree:add_le(bccmd_panic_error, buff:range(0, 2))

            return 2
        end
    },
    [0x6806] = { -- CSR_VARID_FAULT_ARG
        [1] = function(buff, tree)
            tree:add_le(bccmd_fault_error, buff:range(0, 2))

            return 2
        end
    },
    [0x7003] = { -- CSR_VARID_PS
        [0] = function(buff, tree)
            local offset = 0
            tree:add_le(bccmd_pskey, buff:range(offset, 2))
            offset = offset + 2
            local size = buff:range(offset, 2):le_uint()
            tree:add_le(bccmd_pskey_size, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_pskey_store, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_pskey_value, buff:range(offset, size * 2))
            offset = offset + size * 2

            return offset
        end,
        [1] = function(buff, tree)
            local offset = 0
            tree:add_le(bccmd_pskey, buff:range(offset, 2))
            offset = offset + 2
            local size = buff:range(offset, 2):le_uint()
            tree:add_le(bccmd_pskey_size, buff:range(offset, 2))
            offset = offset + 2
            tree:add_le(bccmd_pskey_store, buff:range(offset, 2))
            offset = offset + 2
            tree:add(bccmd_pskey_value, buff:range(offset, size * 2))
            offset = offset + size * 2

            return offset
        end
    },
}

-- Dissector
function csr_bccmd_proto.dissector(buff, pinfo, tree)
    -- Bluetooth HCI Command
    local cmd_opcode = hci_cmd_opcode()
    -- Bluetooth HCI Event
    local event_code = hci_event_code()

    local data, offset, subtree, sup, varid

    if cmd_opcode ~= nil and cmd_opcode.value == 0x3f then -- Vendor-Specific
        local param_length = hci_cmd_param_length()
        if param_length ~=nil and param_length.value > 10 then
            data = buff:range(4)
            code = data:range(0, 1):uint()
            -- refer to external/bluetooth/bluez/tools/csr_bcsp.c#do_command
            if code == 0xc2 or code == 0xc3 then
                sup = 0
                if code == 0xc3 then
                    subtree = tree:add(csr_bccmd_proto, data, "CSR BlueCore HQ Command")
                    pinfo.cols.protocol = 'HCI_HQ_CMD_CSR'
                else
                    subtree = tree:add(csr_bccmd_proto, data, "CSR BlueCore Command")
                    pinfo.cols.protocol = 'HCI_CMD_CSR'
                end

                offset = 1
                subtree:add_le(bccmd_opcode, data:range(offset, 2))
                offset = offset + 2
                subtree:add_le(bccmd_size, data:range(offset, 2))
                offset = offset + 2
                subtree:add_le(bccmd_seqnum, data:range(offset, 2))
                offset = offset + 2
                varid = data:range(offset, 2):le_uint()
                subtree:add_le(bccmd_varid, data:range(offset, 2))
                offset = offset + 2
                subtree:add_le(bccmd_status, data:range(offset, 2))
                offset = offset + 2

                if bccmd_known_varids[varid] ~= nil then
                    pinfo.cols.info = "Send CSR " .. bccmd_known_varids[varid]
                else
                    pinfo.cols.info = "Send CSR Unknown command 0x" .. string.format("%X", varid)
                end
            end
        end
    elseif event_code ~= nil and event_code.value == 0xff then -- Vendor-Specific
        local param_length = hci_event_param_length()
        if param_length ~=nil and param_length.value > 10 then
            data = buff:range(3)
            code = data:range(0, 1):uint()
            -- refer to bluez/tools/csr_bcsp.c#do_command
            if code == 0xc2 or code == 0xc3 then
                sup = 1
                if code == 0xc3 then
                    subtree = tree:add(csr_bccmd_proto, data, "CSR BlueCore HQ Event")
                    pinfo.cols.protocol = 'HCI_HQ_EVT_CSR'
                else
                    subtree = tree:add(csr_bccmd_proto, data, "CSR BlueCore Event")
                    pinfo.cols.protocol = 'HCI_EVT_CSR'
                end

                offset = 1
                subtree:add_le(bccmd_opcode, data:range(offset, 2))
                offset = offset + 2
                subtree:add_le(bccmd_size, data:range(offset, 2))
                offset = offset + 2
                subtree:add_le(bccmd_seqnum, data:range(offset, 2))
                offset = offset + 2
                varid = data:range(offset, 2):le_uint()
                subtree:add_le(bccmd_varid, data:range(offset, 2))
                offset = offset + 2
                subtree:add_le(bccmd_status, data:range(offset, 2))
                offset = offset + 2

                if bccmd_known_varids[varid] ~= nil then
                    pinfo.cols.info = "Rcvd CSR (" .. bccmd_known_varids[varid] .. ")"
                else
                    pinfo.cols.info = "Rcvd CSR (Unknown command 0x" .. string.format("%X", varid) .. ")"
                end
            end
        end
    end

    if varid ~= nil then
        local func = nil
        local op = bccmd_op_varid[varid]

        -- follow the equaling command link
        while type(op) == "number" do
            op = bccmd_op_varid[op]
        end

        local payload = subtree:add(bccmd_payload, data:range(offset))
        if op ~= nil then
            func = op[sup]
            -- command/event is duplicated
            if func == nil and op[2] ~= nil then
                func = op[2]
            end
            if func ~= nil then
                offset = offset + func(data:range(offset), payload)
            end
        end
        if func ~= nil and data:len() ~= offset then
            payload:add(bccmd_padding, data:range(offset))
        end
    end
end

-- register csr bccmd protocol as a postdissector
register_postdissector(csr_bccmd_proto)
