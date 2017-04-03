-- csr-bccmd.lua

-- bluez/tools/csr.h
local BCCMD_TYPE = {
    [0x0000] = "CSR_TYPE_GETREQ",
    [0x0001] = "CSR_TYPE_SETREP",
    [0x0002] = "CSR_TYPE_SETREQ"
}

-- grep "#define CSR_VARID_" csr.h | awk ' { printf "    [%s] = \"%s\",\n", $3, $2;} '
local BCCMD_VARID = {
    [0x000b] = "CSR_VARID_PS_CLR_ALL",
    [0x000c] = "CSR_VARID_PS_FACTORY_SET",
    [0x082d] = "CSR_VARID_PS_CLR_ALL_STORES",
    [0x2801] = "CSR_VARID_BC01_STATUS",
    [0x2819] = "CSR_VARID_BUILDID",
    [0x281a] = "CSR_VARID_CHIPVER",
    [0x281b] = "CSR_VARID_CHIPREV",
    [0x2825] = "CSR_VARID_INTERFACE_VERSION",
    [0x282a] = "CSR_VARID_RAND",
    [0x282c] = "CSR_VARID_MAX_CRYPT_KEY_LENGTH",
    [0x2836] = "CSR_VARID_CHIPANAREV",
    [0x2838] = "CSR_VARID_BUILDID_LOADER",
    [0x2c00] = "CSR_VARID_BT_CLOCK",
    [0x3005] = "CSR_VARID_PS_NEXT",
    [0x3006] = "CSR_VARID_PS_SIZE",
    [0x3008] = "CSR_VARID_CRYPT_KEY_LENGTH",
    [0x3009] = "CSR_VARID_PICONET_INSTANCE",
    [0x300a] = "CSR_VARID_GET_CLR_EVT",
    [0x300b] = "CSR_VARID_GET_NEXT_BUILDDEF",
    [0x3012] = "CSR_VARID_PS_MEMORY_TYPE",
    [0x301c] = "CSR_VARID_READ_BUILD_NAME",
    [0x4001] = "CSR_VARID_COLD_RESET",
    [0x4002] = "CSR_VARID_WARM_RESET",
    [0x4003] = "CSR_VARID_COLD_HALT",
    [0x4004] = "CSR_VARID_WARM_HALT",
    [0x4005] = "CSR_VARID_INIT_BT_STACK",
    [0x4006] = "CSR_VARID_ACTIVATE_BT_STACK",
    [0x4007] = "CSR_VARID_ENABLE_TX",
    [0x4008] = "CSR_VARID_DISABLE_TX",
    [0x4009] = "CSR_VARID_RECAL",
    [0x400d] = "CSR_VARID_PS_FACTORY_RESTORE",
    [0x400e] = "CSR_VARID_PS_FACTORY_RESTORE_ALL",
    [0x400f] = "CSR_VARID_PS_DEFRAG_RESET",
    [0x4010] = "CSR_VARID_KILL_VM_APPLICATION",
    [0x4011] = "CSR_VARID_HOPPING_ON",
    [0x4012] = "CSR_VARID_CANCEL_PAGE",
    [0x4818] = "CSR_VARID_PS_CLR",
    [0x481c] = "CSR_VARID_MAP_SCO_PCM",
    [0x482e] = "CSR_VARID_SINGLE_CHAN",
    [0x5004] = "CSR_VARID_RADIOTEST",
    [0x500c] = "CSR_VARID_PS_CLR_STORES",
    [0x6000] = "CSR_VARID_NO_VARIABLE",
    [0x6802] = "CSR_VARID_CONFIG_UART",
    [0x6805] = "CSR_VARID_PANIC_ARG",
    [0x6806] = "CSR_VARID_FAULT_ARG",
    [0x6827] = "CSR_VARID_MAX_TX_POWER",
    [0x682b] = "CSR_VARID_DEFAULT_TX_POWER",
    [0x7003] = "CSR_VARID_PS",
}

-- grep "#define CSR_PSKEY_" csr.h | awk ' { printf "    [%s] = \"%s\",\n", $3, $2;} '
BCCMD_PSKEY = {
    [0x0001] = "CSR_PSKEY_BDADDR",
    [0x0002] = "CSR_PSKEY_COUNTRYCODE",
    [0x0003] = "CSR_PSKEY_CLASSOFDEVICE",
    [0x0004] = "CSR_PSKEY_DEVICE_DRIFT",
    [0x0005] = "CSR_PSKEY_DEVICE_JITTER",
    [0x000d] = "CSR_PSKEY_MAX_ACLS",
    [0x000e] = "CSR_PSKEY_MAX_SCOS",
    [0x000f] = "CSR_PSKEY_MAX_REMOTE_MASTERS",
    [0x0010] = "CSR_PSKEY_ENABLE_MASTERY_WITH_SLAVERY",
    [0x0011] = "CSR_PSKEY_H_HC_FC_MAX_ACL_PKT_LEN",
    [0x0012] = "CSR_PSKEY_H_HC_FC_MAX_SCO_PKT_LEN",
    [0x0013] = "CSR_PSKEY_H_HC_FC_MAX_ACL_PKTS",
    [0x0014] = "CSR_PSKEY_H_HC_FC_MAX_SCO_PKTS",
    [0x0015] = "CSR_PSKEY_LC_FC_BUFFER_LOW_WATER_MARK",
    [0x0017] = "CSR_PSKEY_LC_MAX_TX_POWER",
    [0x001d] = "CSR_PSKEY_TX_GAIN_RAMP",
    [0x001e] = "CSR_PSKEY_LC_POWER_TABLE",
    [0x001f] = "CSR_PSKEY_LC_PEER_POWER_PERIOD",
    [0x0020] = "CSR_PSKEY_LC_FC_POOLS_LOW_WATER_MARK",
    [0x0021] = "CSR_PSKEY_LC_DEFAULT_TX_POWER",
    [0x0022] = "CSR_PSKEY_LC_RSSI_GOLDEN_RANGE",
    [0x0028] = "CSR_PSKEY_LC_COMBO_DISABLE_PIO_MASK",
    [0x0029] = "CSR_PSKEY_LC_COMBO_PRIORITY_PIO_MASK",
    [0x002a] = "CSR_PSKEY_LC_COMBO_DOT11_CHANNEL_PIO_BASE",
    [0x002b] = "CSR_PSKEY_LC_COMBO_DOT11_BLOCK_CHANNELS",
    [0x002d] = "CSR_PSKEY_LC_MAX_TX_POWER_NO_RSSI",
    [0x002e] = "CSR_PSKEY_LC_CONNECTION_RX_WINDOW",
    [0x0030] = "CSR_PSKEY_LC_COMBO_DOT11_TX_PROTECTION_MODE",
    [0x0031] = "CSR_PSKEY_LC_ENHANCED_POWER_TABLE",
    [0x0032] = "CSR_PSKEY_LC_WIDEBAND_RSSI_CONFIG",
    [0x0033] = "CSR_PSKEY_LC_COMBO_DOT11_PRIORITY_LEAD",
    [0x0034] = "CSR_PSKEY_BT_CLOCK_INIT",
    [0x0038] = "CSR_PSKEY_TX_MR_MOD_DELAY",
    [0x0039] = "CSR_PSKEY_RX_MR_SYNC_TIMING",
    [0x003a] = "CSR_PSKEY_RX_MR_SYNC_CONFIG",
    [0x003b] = "CSR_PSKEY_LC_LOST_SYNC_SLOTS",
    [0x003c] = "CSR_PSKEY_RX_MR_SAMP_CONFIG",
    [0x003d] = "CSR_PSKEY_AGC_HYST_LEVELS",
    [0x003e] = "CSR_PSKEY_RX_LEVEL_LOW_SIGNAL",
    [0x003f] = "CSR_PSKEY_AGC_IQ_LVL_VALUES",
    [0x0040] = "CSR_PSKEY_MR_FTRIM_OFFSET_12DB",
    [0x0041] = "CSR_PSKEY_MR_FTRIM_OFFSET_6DB",
    [0x0042] = "CSR_PSKEY_NO_CAL_ON_BOOT",
    [0x0043] = "CSR_PSKEY_RSSI_HI_TARGET",
    [0x0044] = "CSR_PSKEY_PREFERRED_MIN_ATTENUATION",
    [0x0045] = "CSR_PSKEY_LC_COMBO_DOT11_PRIORITY_OVERRIDE",
    [0x0047] = "CSR_PSKEY_LC_MULTISLOT_HOLDOFF",
    [0x00c9] = "CSR_PSKEY_FREE_KEY_PIGEON_HOLE",
    [0x00ca] = "CSR_PSKEY_LINK_KEY_BD_ADDR0",
    [0x00cb] = "CSR_PSKEY_LINK_KEY_BD_ADDR1",
    [0x00cc] = "CSR_PSKEY_LINK_KEY_BD_ADDR2",
    [0x00cd] = "CSR_PSKEY_LINK_KEY_BD_ADDR3",
    [0x00ce] = "CSR_PSKEY_LINK_KEY_BD_ADDR4",
    [0x00cf] = "CSR_PSKEY_LINK_KEY_BD_ADDR5",
    [0x00d0] = "CSR_PSKEY_LINK_KEY_BD_ADDR6",
    [0x00d1] = "CSR_PSKEY_LINK_KEY_BD_ADDR7",
    [0x00d2] = "CSR_PSKEY_LINK_KEY_BD_ADDR8",
    [0x00d3] = "CSR_PSKEY_LINK_KEY_BD_ADDR9",
    [0x00d4] = "CSR_PSKEY_LINK_KEY_BD_ADDR10",
    [0x00d5] = "CSR_PSKEY_LINK_KEY_BD_ADDR11",
    [0x00d6] = "CSR_PSKEY_LINK_KEY_BD_ADDR12",
    [0x00d7] = "CSR_PSKEY_LINK_KEY_BD_ADDR13",
    [0x00d8] = "CSR_PSKEY_LINK_KEY_BD_ADDR14",
    [0x00d9] = "CSR_PSKEY_LINK_KEY_BD_ADDR15",
    [0x00da] = "CSR_PSKEY_ENC_KEY_LMIN",
    [0x00db] = "CSR_PSKEY_ENC_KEY_LMAX",
    [0x00ef] = "CSR_PSKEY_LOCAL_SUPPORTED_FEATURES",
    [0x00f0] = "CSR_PSKEY_LM_USE_UNIT_KEY",
    [0x00f2] = "CSR_PSKEY_HCI_NOP_DISABLE",
    [0x00f4] = "CSR_PSKEY_LM_MAX_EVENT_FILTERS",
    [0x00f5] = "CSR_PSKEY_LM_USE_ENC_MODE_BROADCAST",
    [0x00f6] = "CSR_PSKEY_LM_TEST_SEND_ACCEPTED_TWICE",
    [0x00f7] = "CSR_PSKEY_LM_MAX_PAGE_HOLD_TIME",
    [0x00f8] = "CSR_PSKEY_AFH_ADAPTATION_RESPONSE_TIME",
    [0x00f9] = "CSR_PSKEY_AFH_OPTIONS",
    [0x00fa] = "CSR_PSKEY_AFH_RSSI_RUN_PERIOD",
    [0x00fb] = "CSR_PSKEY_AFH_REENABLE_CHANNEL_TIME",
    [0x00fc] = "CSR_PSKEY_NO_DROP_ON_ACR_MS_FAIL",
    [0x00fd] = "CSR_PSKEY_MAX_PRIVATE_KEYS",
    [0x00fe] = "CSR_PSKEY_PRIVATE_LINK_KEY_BD_ADDR0",
    [0x00ff] = "CSR_PSKEY_PRIVATE_LINK_KEY_BD_ADDR1",
    [0x0100] = "CSR_PSKEY_PRIVATE_LINK_KEY_BD_ADDR2",
    [0x0101] = "CSR_PSKEY_PRIVATE_LINK_KEY_BD_ADDR3",
    [0x0102] = "CSR_PSKEY_PRIVATE_LINK_KEY_BD_ADDR4",
    [0x0103] = "CSR_PSKEY_PRIVATE_LINK_KEY_BD_ADDR5",
    [0x0104] = "CSR_PSKEY_PRIVATE_LINK_KEY_BD_ADDR6",
    [0x0105] = "CSR_PSKEY_PRIVATE_LINK_KEY_BD_ADDR7",
    [0x0106] = "CSR_PSKEY_LOCAL_SUPPORTED_COMMANDS",
    [0x0107] = "CSR_PSKEY_LM_MAX_ABSENCE_INDEX",
    [0x0108] = "CSR_PSKEY_DEVICE_NAME",
    [0x0109] = "CSR_PSKEY_AFH_RSSI_THRESHOLD",
    [0x010a] = "CSR_PSKEY_LM_CASUAL_SCAN_INTERVAL",
    [0x010b] = "CSR_PSKEY_AFH_MIN_MAP_CHANGE",
    [0x010c] = "CSR_PSKEY_AFH_RSSI_LP_RUN_PERIOD",
    [0x010d] = "CSR_PSKEY_HCI_LMP_LOCAL_VERSION",
    [0x010e] = "CSR_PSKEY_LMP_REMOTE_VERSION",
    [0x0113] = "CSR_PSKEY_HOLD_ERROR_MESSAGE_NUMBER",
    [0x0136] = "CSR_PSKEY_DFU_ATTRIBUTES",
    [0x0137] = "CSR_PSKEY_DFU_DETACH_TO",
    [0x0138] = "CSR_PSKEY_DFU_TRANSFER_SIZE",
    [0x0139] = "CSR_PSKEY_DFU_ENABLE",
    [0x013a] = "CSR_PSKEY_DFU_LIN_REG_ENABLE",
    [0x015e] = "CSR_PSKEY_DFUENC_VMAPP_PK_MODULUS_MSB",
    [0x015f] = "CSR_PSKEY_DFUENC_VMAPP_PK_MODULUS_LSB",
    [0x0160] = "CSR_PSKEY_DFUENC_VMAPP_PK_M_DASH",
    [0x0161] = "CSR_PSKEY_DFUENC_VMAPP_PK_R2N_MSB",
    [0x0162] = "CSR_PSKEY_DFUENC_VMAPP_PK_R2N_LSB",
    [0x0192] = "CSR_PSKEY_BCSP_LM_PS_BLOCK",
    [0x0193] = "CSR_PSKEY_HOSTIO_FC_PS_BLOCK",
    [0x0194] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO0",
    [0x0195] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO1",
    [0x0196] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO2",
    [0x0197] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO3",
    [0x0198] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO4",
    [0x0199] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO5",
    [0x019a] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO6",
    [0x019b] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO7",
    [0x019c] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO8",
    [0x019d] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO9",
    [0x019e] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO10",
    [0x019f] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO11",
    [0x01a0] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO12",
    [0x01a1] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO13",
    [0x01a2] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO14",
    [0x01a3] = "CSR_PSKEY_HOSTIO_PROTOCOL_INFO15",
    [0x01a4] = "CSR_PSKEY_HOSTIO_UART_RESET_TIMEOUT",
    [0x01a5] = "CSR_PSKEY_HOSTIO_USE_HCI_EXTN",
    [0x01a6] = "CSR_PSKEY_HOSTIO_USE_HCI_EXTN_CCFC",
    [0x01a7] = "CSR_PSKEY_HOSTIO_HCI_EXTN_PAYLOAD_SIZE",
    [0x01aa] = "CSR_PSKEY_BCSP_LM_CNF_CNT_LIMIT",
    [0x01ab] = "CSR_PSKEY_HOSTIO_MAP_SCO_PCM",
    [0x01ac] = "CSR_PSKEY_HOSTIO_AWKWARD_PCM_SYNC",
    [0x01ad] = "CSR_PSKEY_HOSTIO_BREAK_POLL_PERIOD",
    [0x01ae] = "CSR_PSKEY_HOSTIO_MIN_UART_HCI_SCO_SIZE",
    [0x01b0] = "CSR_PSKEY_HOSTIO_MAP_SCO_CODEC",
    [0x01b1] = "CSR_PSKEY_PCM_CVSD_TX_HI_FREQ_BOOST",
    [0x01b2] = "CSR_PSKEY_PCM_CVSD_RX_HI_FREQ_BOOST",
    [0x01b3] = "CSR_PSKEY_PCM_CONFIG32",
    [0x01b4] = "CSR_PSKEY_USE_OLD_BCSP_LE",
    [0x01b5] = "CSR_PSKEY_PCM_CVSD_USE_NEW_FILTER",
    [0x01b6] = "CSR_PSKEY_PCM_FORMAT",
    [0x01b7] = "CSR_PSKEY_CODEC_OUT_GAIN",
    [0x01b8] = "CSR_PSKEY_CODEC_IN_GAIN",
    [0x01b9] = "CSR_PSKEY_CODEC_PIO",
    [0x01ba] = "CSR_PSKEY_PCM_LOW_JITTER_CONFIG",
    [0x01bb] = "CSR_PSKEY_HOSTIO_SCO_PCM_THRESHOLDS",
    [0x01bc] = "CSR_PSKEY_HOSTIO_SCO_HCI_THRESHOLDS",
    [0x01bd] = "CSR_PSKEY_HOSTIO_MAP_SCO_PCM_SLOT",
    [0x01be] = "CSR_PSKEY_UART_BAUDRATE",
    [0x01bf] = "CSR_PSKEY_UART_CONFIG_BCSP",
    [0x01c0] = "CSR_PSKEY_UART_CONFIG_H4",
    [0x01c1] = "CSR_PSKEY_UART_CONFIG_H5",
    [0x01c2] = "CSR_PSKEY_UART_CONFIG_USR",
    [0x01c3] = "CSR_PSKEY_UART_TX_CRCS",
    [0x01c4] = "CSR_PSKEY_UART_ACK_TIMEOUT",
    [0x01c5] = "CSR_PSKEY_UART_TX_MAX_ATTEMPTS",
    [0x01c6] = "CSR_PSKEY_UART_TX_WINDOW_SIZE",
    [0x01c7] = "CSR_PSKEY_UART_HOST_WAKE",
    [0x01c8] = "CSR_PSKEY_HOSTIO_THROTTLE_TIMEOUT",
    [0x01c9] = "CSR_PSKEY_PCM_ALWAYS_ENABLE",
    [0x01ca] = "CSR_PSKEY_UART_HOST_WAKE_SIGNAL",
    [0x01cb] = "CSR_PSKEY_UART_CONFIG_H4DS",
    [0x01cc] = "CSR_PSKEY_H4DS_WAKE_DURATION",
    [0x01cd] = "CSR_PSKEY_H4DS_MAXWU",
    [0x01cf] = "CSR_PSKEY_H4DS_LE_TIMER_PERIOD",
    [0x01d0] = "CSR_PSKEY_H4DS_TWU_TIMER_PERIOD",
    [0x01d1] = "CSR_PSKEY_H4DS_UART_IDLE_TIMER_PERIOD",
    [0x01f6] = "CSR_PSKEY_ANA_FTRIM",
    [0x01f7] = "CSR_PSKEY_WD_TIMEOUT",
    [0x01f8] = "CSR_PSKEY_WD_PERIOD",
    [0x01f9] = "CSR_PSKEY_HOST_INTERFACE",
    [0x01fb] = "CSR_PSKEY_HQ_HOST_TIMEOUT",
    [0x01fc] = "CSR_PSKEY_HQ_ACTIVE",
    [0x01fd] = "CSR_PSKEY_BCCMD_SECURITY_ACTIVE",
    [0x01fe] = "CSR_PSKEY_ANA_FREQ",
    [0x0202] = "CSR_PSKEY_PIO_PROTECT_MASK",
    [0x0203] = "CSR_PSKEY_PMALLOC_SIZES",
    [0x0204] = "CSR_PSKEY_UART_BAUD_RATE",
    [0x0205] = "CSR_PSKEY_UART_CONFIG",
    [0x0207] = "CSR_PSKEY_STUB",
    [0x0209] = "CSR_PSKEY_TXRX_PIO_CONTROL",
    [0x020b] = "CSR_PSKEY_ANA_RX_LEVEL",
    [0x020c] = "CSR_PSKEY_ANA_RX_FTRIM",
    [0x020d] = "CSR_PSKEY_PSBC_DATA_VERSION",
    [0x020f] = "CSR_PSKEY_PCM0_ATTENUATION",
    [0x0211] = "CSR_PSKEY_LO_LVL_MAX",
    [0x0212] = "CSR_PSKEY_LO_ADC_AMPL_MIN",
    [0x0213] = "CSR_PSKEY_LO_ADC_AMPL_MAX",
    [0x0214] = "CSR_PSKEY_IQ_TRIM_CHANNEL",
    [0x0215] = "CSR_PSKEY_IQ_TRIM_GAIN",
    [0x0216] = "CSR_PSKEY_IQ_TRIM_ENABLE",
    [0x0217] = "CSR_PSKEY_TX_OFFSET_HALF_MHZ",
    [0x0221] = "CSR_PSKEY_GBL_MISC_ENABLES",
    [0x0222] = "CSR_PSKEY_UART_SLEEP_TIMEOUT",
    [0x0229] = "CSR_PSKEY_DEEP_SLEEP_STATE",
    [0x022d] = "CSR_PSKEY_IQ_ENABLE_PHASE_TRIM",
    [0x0237] = "CSR_PSKEY_HCI_HANDLE_FREEZE_PERIOD",
    [0x0238] = "CSR_PSKEY_MAX_FROZEN_HCI_HANDLES",
    [0x0239] = "CSR_PSKEY_PAGETABLE_DESTRUCTION_DELAY",
    [0x023a] = "CSR_PSKEY_IQ_TRIM_PIO_SETTINGS",
    [0x023b] = "CSR_PSKEY_USE_EXTERNAL_CLOCK",
    [0x023c] = "CSR_PSKEY_DEEP_SLEEP_WAKE_CTS",
    [0x023d] = "CSR_PSKEY_FC_HC2H_FLUSH_DELAY",
    [0x023e] = "CSR_PSKEY_RX_HIGHSIDE",
    [0x0240] = "CSR_PSKEY_TX_PRE_LVL",
    [0x0242] = "CSR_PSKEY_RX_SINGLE_ENDED",
    [0x0243] = "CSR_PSKEY_TX_FILTER_CONFIG",
    [0x0246] = "CSR_PSKEY_CLOCK_REQUEST_ENABLE",
    [0x0249] = "CSR_PSKEY_RX_MIN_ATTEN",
    [0x024b] = "CSR_PSKEY_XTAL_TARGET_AMPLITUDE",
    [0x024d] = "CSR_PSKEY_PCM_MIN_CPU_CLOCK",
    [0x0250] = "CSR_PSKEY_HOST_INTERFACE_PIO_USB",
    [0x0251] = "CSR_PSKEY_CPU_IDLE_MODE",
    [0x0252] = "CSR_PSKEY_DEEP_SLEEP_CLEAR_RTS",
    [0x0254] = "CSR_PSKEY_RF_RESONANCE_TRIM",
    [0x0255] = "CSR_PSKEY_DEEP_SLEEP_PIO_WAKE",
    [0x0256] = "CSR_PSKEY_DRAIN_BORE_TIMERS",
    [0x0257] = "CSR_PSKEY_DRAIN_TX_POWER_BASE",
    [0x0259] = "CSR_PSKEY_MODULE_ID",
    [0x025a] = "CSR_PSKEY_MODULE_DESIGN",
    [0x025c] = "CSR_PSKEY_MODULE_SECURITY_CODE",
    [0x025d] = "CSR_PSKEY_VM_DISABLE",
    [0x025e] = "CSR_PSKEY_MOD_MANUF0",
    [0x025f] = "CSR_PSKEY_MOD_MANUF1",
    [0x0260] = "CSR_PSKEY_MOD_MANUF2",
    [0x0261] = "CSR_PSKEY_MOD_MANUF3",
    [0x0262] = "CSR_PSKEY_MOD_MANUF4",
    [0x0263] = "CSR_PSKEY_MOD_MANUF5",
    [0x0264] = "CSR_PSKEY_MOD_MANUF6",
    [0x0265] = "CSR_PSKEY_MOD_MANUF7",
    [0x0266] = "CSR_PSKEY_MOD_MANUF8",
    [0x0267] = "CSR_PSKEY_MOD_MANUF9",
    [0x0268] = "CSR_PSKEY_DUT_VM_DISABLE",
    [0x028a] = "CSR_PSKEY_USR0",
    [0x028b] = "CSR_PSKEY_USR1",
    [0x028c] = "CSR_PSKEY_USR2",
    [0x028d] = "CSR_PSKEY_USR3",
    [0x028e] = "CSR_PSKEY_USR4",
    [0x028f] = "CSR_PSKEY_USR5",
    [0x0290] = "CSR_PSKEY_USR6",
    [0x0291] = "CSR_PSKEY_USR7",
    [0x0292] = "CSR_PSKEY_USR8",
    [0x0293] = "CSR_PSKEY_USR9",
    [0x0294] = "CSR_PSKEY_USR10",
    [0x0295] = "CSR_PSKEY_USR11",
    [0x0296] = "CSR_PSKEY_USR12",
    [0x0297] = "CSR_PSKEY_USR13",
    [0x0298] = "CSR_PSKEY_USR14",
    [0x0299] = "CSR_PSKEY_USR15",
    [0x029a] = "CSR_PSKEY_USR16",
    [0x029b] = "CSR_PSKEY_USR17",
    [0x029c] = "CSR_PSKEY_USR18",
    [0x029d] = "CSR_PSKEY_USR19",
    [0x029e] = "CSR_PSKEY_USR20",
    [0x029f] = "CSR_PSKEY_USR21",
    [0x02a0] = "CSR_PSKEY_USR22",
    [0x02a1] = "CSR_PSKEY_USR23",
    [0x02a2] = "CSR_PSKEY_USR24",
    [0x02a3] = "CSR_PSKEY_USR25",
    [0x02a4] = "CSR_PSKEY_USR26",
    [0x02a5] = "CSR_PSKEY_USR27",
    [0x02a6] = "CSR_PSKEY_USR28",
    [0x02a7] = "CSR_PSKEY_USR29",
    [0x02a8] = "CSR_PSKEY_USR30",
    [0x02a9] = "CSR_PSKEY_USR31",
    [0x02aa] = "CSR_PSKEY_USR32",
    [0x02ab] = "CSR_PSKEY_USR33",
    [0x02ac] = "CSR_PSKEY_USR34",
    [0x02ad] = "CSR_PSKEY_USR35",
    [0x02ae] = "CSR_PSKEY_USR36",
    [0x02af] = "CSR_PSKEY_USR37",
    [0x02b0] = "CSR_PSKEY_USR38",
    [0x02b1] = "CSR_PSKEY_USR39",
    [0x02b2] = "CSR_PSKEY_USR40",
    [0x02b3] = "CSR_PSKEY_USR41",
    [0x02b4] = "CSR_PSKEY_USR42",
    [0x02b5] = "CSR_PSKEY_USR43",
    [0x02b6] = "CSR_PSKEY_USR44",
    [0x02b7] = "CSR_PSKEY_USR45",
    [0x02b8] = "CSR_PSKEY_USR46",
    [0x02b9] = "CSR_PSKEY_USR47",
    [0x02ba] = "CSR_PSKEY_USR48",
    [0x02bb] = "CSR_PSKEY_USR49",
    [0x02bc] = "CSR_PSKEY_USB_VERSION",
    [0x02bd] = "CSR_PSKEY_USB_DEVICE_CLASS_CODES",
    [0x02be] = "CSR_PSKEY_USB_VENDOR_ID",
    [0x02bf] = "CSR_PSKEY_USB_PRODUCT_ID",
    [0x02c1] = "CSR_PSKEY_USB_MANUF_STRING",
    [0x02c2] = "CSR_PSKEY_USB_PRODUCT_STRING",
    [0x02c3] = "CSR_PSKEY_USB_SERIAL_NUMBER_STRING",
    [0x02c4] = "CSR_PSKEY_USB_CONFIG_STRING",
    [0x02c5] = "CSR_PSKEY_USB_ATTRIBUTES",
    [0x02c6] = "CSR_PSKEY_USB_MAX_POWER",
    [0x02c7] = "CSR_PSKEY_USB_BT_IF_CLASS_CODES",
    [0x02c9] = "CSR_PSKEY_USB_LANGID",
    [0x02ca] = "CSR_PSKEY_USB_DFU_CLASS_CODES",
    [0x02cb] = "CSR_PSKEY_USB_DFU_PRODUCT_ID",
    [0x02ce] = "CSR_PSKEY_USB_PIO_DETACH",
    [0x02cf] = "CSR_PSKEY_USB_PIO_WAKEUP",
    [0x02d0] = "CSR_PSKEY_USB_PIO_PULLUP",
    [0x02d1] = "CSR_PSKEY_USB_PIO_VBUS",
    [0x02d2] = "CSR_PSKEY_USB_PIO_WAKE_TIMEOUT",
    [0x02d3] = "CSR_PSKEY_USB_PIO_RESUME",
    [0x02d4] = "CSR_PSKEY_USB_BT_SCO_IF_CLASS_CODES",
    [0x02d5] = "CSR_PSKEY_USB_SUSPEND_PIO_LEVEL",
    [0x02d6] = "CSR_PSKEY_USB_SUSPEND_PIO_DIR",
    [0x02d7] = "CSR_PSKEY_USB_SUSPEND_PIO_MASK",
    [0x02d8] = "CSR_PSKEY_USB_ENDPOINT_0_MAX_PACKET_SIZE",
    [0x02d9] = "CSR_PSKEY_USB_CONFIG",
    [0x0320] = "CSR_PSKEY_RADIOTEST_ATTEN_INIT",
    [0x0326] = "CSR_PSKEY_RADIOTEST_FIRST_TRIM_TIME",
    [0x0327] = "CSR_PSKEY_RADIOTEST_SUBSEQUENT_TRIM_TIME",
    [0x0328] = "CSR_PSKEY_RADIOTEST_LO_LVL_TRIM_ENABLE",
    [0x032c] = "CSR_PSKEY_RADIOTEST_DISABLE_MODULATION",
    [0x0352] = "CSR_PSKEY_RFCOMM_FCON_THRESHOLD",
    [0x0353] = "CSR_PSKEY_RFCOMM_FCOFF_THRESHOLD",
    [0x0354] = "CSR_PSKEY_IPV6_STATIC_ADDR",
    [0x0355] = "CSR_PSKEY_IPV4_STATIC_ADDR",
    [0x0356] = "CSR_PSKEY_IPV6_STATIC_PREFIX_LEN",
    [0x0357] = "CSR_PSKEY_IPV6_STATIC_ROUTER_ADDR",
    [0x0358] = "CSR_PSKEY_IPV4_STATIC_SUBNET_MASK",
    [0x0359] = "CSR_PSKEY_IPV4_STATIC_ROUTER_ADDR",
    [0x035a] = "CSR_PSKEY_MDNS_NAME",
    [0x035b] = "CSR_PSKEY_FIXED_PIN",
    [0x035c] = "CSR_PSKEY_MDNS_PORT",
    [0x035d] = "CSR_PSKEY_MDNS_TTL",
    [0x035e] = "CSR_PSKEY_MDNS_IPV4_ADDR",
    [0x035f] = "CSR_PSKEY_ARP_CACHE_TIMEOUT",
    [0x0360] = "CSR_PSKEY_HFP_POWER_TABLE",
    [0x03e7] = "CSR_PSKEY_DRAIN_BORE_TIMER_COUNTERS",
    [0x03e6] = "CSR_PSKEY_DRAIN_BORE_COUNTERS",
    [0x03e4] = "CSR_PSKEY_LOOP_FILTER_TRIM",
    [0x03e3] = "CSR_PSKEY_DRAIN_BORE_CURRENT_PEAK",
    [0x03e2] = "CSR_PSKEY_VM_E2_CACHE_LIMIT",
    [0x03e1] = "CSR_PSKEY_FORCE_16MHZ_REF_PIO",
    [0x03df] = "CSR_PSKEY_CDMA_LO_REF_LIMITS",
    [0x03de] = "CSR_PSKEY_CDMA_LO_ERROR_LIMITS",
    [0x03dd] = "CSR_PSKEY_CLOCK_STARTUP_DELAY",
    [0x03dc] = "CSR_PSKEY_DEEP_SLEEP_CORRECTION_FACTOR",
    [0x03db] = "CSR_PSKEY_TEMPERATURE_CALIBRATION",
    [0x03da] = "CSR_PSKEY_TEMPERATURE_VS_DELTA_INTERNAL_PA",
    [0x03d9] = "CSR_PSKEY_TEMPERATURE_VS_DELTA_TX_PRE_LVL",
    [0x03d8] = "CSR_PSKEY_TEMPERATURE_VS_DELTA_TX_BB",
    [0x03d7] = "CSR_PSKEY_TEMPERATURE_VS_DELTA_ANA_FTRIM",
    [0x03d6] = "CSR_PSKEY_TEST_DELTA_OFFSET",
    [0x03d4] = "CSR_PSKEY_RX_DYNAMIC_LVL_OFFSET",
    [0x03d3] = "CSR_PSKEY_TEST_FORCE_OFFSET",
    [0x03cf] = "CSR_PSKEY_RF_TRAP_BAD_DIVISION_RATIOS",
    [0x03ce] = "CSR_PSKEY_RADIOTEST_CDMA_LO_REF_LIMITS",
    [0x03cd] = "CSR_PSKEY_INITIAL_BOOTMODE",
    [0x03cc] = "CSR_PSKEY_ONCHIP_HCI_CLIENT",
    [0x03ca] = "CSR_PSKEY_RX_ATTEN_BACKOFF",
    [0x03c9] = "CSR_PSKEY_RX_ATTEN_UPDATE_RATE",
    [0x03c7] = "CSR_PSKEY_SYNTH_TXRX_THRESHOLDS",
    [0x03c6] = "CSR_PSKEY_MIN_WAIT_STATES",
    [0x03c5] = "CSR_PSKEY_RSSI_CORRECTION",
    [0x03c4] = "CSR_PSKEY_SCHED_THROTTLE_TIMEOUT",
    [0x03c3] = "CSR_PSKEY_DEEP_SLEEP_USE_EXTERNAL_CLOCK",
    [0x03c2] = "CSR_PSKEY_TRIM_RADIO_FILTERS",
    [0x03c1] = "CSR_PSKEY_TRANSMIT_OFFSET",
    [0x03c0] = "CSR_PSKEY_USB_VM_CONTROL",
    [0x03bf] = "CSR_PSKEY_MR_ANA_RX_FTRIM",
    [0x03be] = "CSR_PSKEY_I2C_CONFIG",
    [0x03bd] = "CSR_PSKEY_IQ_LVL_RX",
    [0x03bb] = "CSR_PSKEY_MR_TX_FILTER_CONFIG",
    [0x03ba] = "CSR_PSKEY_MR_TX_CONFIG2",
    [0x03b9] = "CSR_PSKEY_USB_DONT_RESET_BOOTMODE_ON_HOST_RESET",
    [0x03b8] = "CSR_PSKEY_LC_USE_THROTTLING",
    [0x03b7] = "CSR_PSKEY_CHARGER_TRIM",
    [0x03b6] = "CSR_PSKEY_CLOCK_REQUEST_FEATURES",
    [0x03b4] = "CSR_PSKEY_TRANSMIT_OFFSET_CLASS1",
    [0x03b3] = "CSR_PSKEY_TX_AVOID_PA_CLASS1_PIO",
    [0x03b2] = "CSR_PSKEY_MR_PIO_CONFIG",
    [0x03b1] = "CSR_PSKEY_UART_CONFIG2",
    [0x03b0] = "CSR_PSKEY_CLASS1_IQ_LVL",
    [0x03af] = "CSR_PSKEY_CLASS1_TX_CONFIG2",
    [0x03ae] = "CSR_PSKEY_TEMPERATURE_VS_DELTA_INTERNAL_PA_CLASS1",
    [0x03ad] = "CSR_PSKEY_TEMPERATURE_VS_DELTA_EXTERNAL_PA_CLASS1",
    [0x03ac] = "CSR_PSKEY_TEMPERATURE_VS_DELTA_TX_PRE_LVL_MR",
    [0x03ab] = "CSR_PSKEY_TEMPERATURE_VS_DELTA_TX_BB_MR_HEADER",
    [0x03aa] = "CSR_PSKEY_TEMPERATURE_VS_DELTA_TX_BB_MR_PAYLOAD",
    [0x03a9] = "CSR_PSKEY_RX_MR_EQ_TAPS",
    [0x03a8] = "CSR_PSKEY_TX_PRE_LVL_CLASS1",
    [0x03a7] = "CSR_PSKEY_ANALOGUE_ATTENUATOR",
    [0x03a6] = "CSR_PSKEY_MR_RX_FILTER_TRIM",
    [0x03a5] = "CSR_PSKEY_MR_RX_FILTER_RESPONSE",
    [0x039f] = "CSR_PSKEY_PIO_WAKEUP_STATE",
    [0x0394] = "CSR_PSKEY_MR_TX_IF_ATTEN_OFF_TEMP",
    [0x0393] = "CSR_PSKEY_LO_DIV_LATCH_BYPASS",
    [0x0392] = "CSR_PSKEY_LO_VCO_STANDBY",
    [0x0391] = "CSR_PSKEY_SLOW_CLOCK_FILTER_SHIFT",
    [0x0390] = "CSR_PSKEY_SLOW_CLOCK_FILTER_DIVIDER",
    [0x03f2] = "CSR_PSKEY_USB_ATTRIBUTES_POWER",
    [0x03f3] = "CSR_PSKEY_USB_ATTRIBUTES_WAKEUP",
    [0x03f4] = "CSR_PSKEY_DFU_ATTRIBUTES_MANIFESTATION_TOLERANT",
    [0x03f5] = "CSR_PSKEY_DFU_ATTRIBUTES_CAN_UPLOAD",
    [0x03f6] = "CSR_PSKEY_DFU_ATTRIBUTES_CAN_DOWNLOAD",
    [0x03fc] = "CSR_PSKEY_UART_CONFIG_STOP_BITS",
    [0x03fd] = "CSR_PSKEY_UART_CONFIG_PARITY_BIT",
    [0x03fe] = "CSR_PSKEY_UART_CONFIG_FLOW_CTRL_EN",
    [0x03ff] = "CSR_PSKEY_UART_CONFIG_RTS_AUTO_EN",
    [0x0400] = "CSR_PSKEY_UART_CONFIG_RTS",
    [0x0401] = "CSR_PSKEY_UART_CONFIG_TX_ZERO_EN",
    [0x0402] = "CSR_PSKEY_UART_CONFIG_NON_BCSP_EN",
    [0x0403] = "CSR_PSKEY_UART_CONFIG_RX_RATE_DELAY",
    [0x0405] = "CSR_PSKEY_UART_SEQ_TIMEOUT",
    [0x0406] = "CSR_PSKEY_UART_SEQ_RETRIES",
    [0x0407] = "CSR_PSKEY_UART_SEQ_WINSIZE",
    [0x0408] = "CSR_PSKEY_UART_USE_CRC_ON_TX",
    [0x0409] = "CSR_PSKEY_UART_HOST_INITIAL_STATE",
    [0x040a] = "CSR_PSKEY_UART_HOST_ATTENTION_SPAN",
    [0x040b] = "CSR_PSKEY_UART_HOST_WAKEUP_TIME",
    [0x040c] = "CSR_PSKEY_UART_HOST_WAKEUP_WAIT",
    [0x0410] = "CSR_PSKEY_BCSP_LM_MODE",
    [0x0411] = "CSR_PSKEY_BCSP_LM_SYNC_RETRIES",
    [0x0412] = "CSR_PSKEY_BCSP_LM_TSHY",
    [0x0417] = "CSR_PSKEY_UART_DFU_CONFIG_STOP_BITS",
    [0x0418] = "CSR_PSKEY_UART_DFU_CONFIG_PARITY_BIT",
    [0x0419] = "CSR_PSKEY_UART_DFU_CONFIG_FLOW_CTRL_EN",
    [0x041a] = "CSR_PSKEY_UART_DFU_CONFIG_RTS_AUTO_EN",
    [0x041b] = "CSR_PSKEY_UART_DFU_CONFIG_RTS",
    [0x041c] = "CSR_PSKEY_UART_DFU_CONFIG_TX_ZERO_EN",
    [0x041d] = "CSR_PSKEY_UART_DFU_CONFIG_NON_BCSP_EN",
    [0x041e] = "CSR_PSKEY_UART_DFU_CONFIG_RX_RATE_DELAY",
    [0x041f] = "CSR_PSKEY_AMUX_AIO0",
    [0x0420] = "CSR_PSKEY_AMUX_AIO1",
    [0x0421] = "CSR_PSKEY_AMUX_AIO2",
    [0x0422] = "CSR_PSKEY_AMUX_AIO3",
    [0x0423] = "CSR_PSKEY_LOCAL_NAME_SIMPLIFIED",
    [0x2001] = "CSR_PSKEY_EXTENDED_STUB",
}

BCCMD_STATUS = {
    [0x0000] = "OK",
    [0x0001] = "NO_SUCH_VARID",
    [0x0002] = "TOO_BIG",
    [0x0003] = "NO_VALUE",
    [0x0004] = "BAD_REQ",
    [0x0005] = "NO_ACCESS",
    [0x0006] = "READ_ONLY",
    [0x0007] = "WRITE_ONLY",
    [0x0008] = "ERROR",
    [0x0009] = "PERMISSION_DENIED",
    [0x000a] = "TIMEOUT"
}

-- BlueCore Command Field and ProtoField
hci_cmd_opcode = Field.new("bthci_cmd.opcode.ogf")
hci_cmd_param_length = Field.new("bthci_cmd.param_length")

hci_event_code = Field.new("bthci_evt.code")
hci_event_param_length = Field.new("bthci_evt.param_length")

bccmd_opcode = ProtoField.uint16("bthci_cmd.bccmd.opcode", "Command", base.HEX_DEC, BCCMD_TYPE)
bccmd_size = ProtoField.uint16("bthci_cmd.bccmd.size", "Size")
bccmd_seqnum = ProtoField.uint16("bthci_cmd.bccmd.seqnum", "SeqNum", base.DEC_HEX)
bccmd_varid = ProtoField.uint16("bthci_cmd.bccmd.varid", "VarId", base.HEX_DEC, BCCMD_VARID)
bccmd_status = ProtoField.uint16("bthci_cmd.bccmd.status", "Status", base.HEX_DEC, BCCMD_STATUS)
bccmd_payload = ProtoField.bytes("bthci_cmd.bccmd.payload", "Payload")
bccmd_padding = ProtoField.bytes("bthci_cmd.bccmd.padding", "Padding")

-- 0x281b - CSR_VARID_CHIPREV
bccmd_chiprev = ProtoField.uint16("bthci_cmd.bccmd.chip.rev", "Chip Rev", base.HEX_DEC, {
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
bccmd_rand = ProtoField.uint16("bthci_cmd.bccmd.rand", "Rand", base.HEX_DEC)

-- 0x282a - CSR_VARID_RAND
bccmd_rand = ProtoField.uint32("bthci_cmd.bccmd.rand", "Rand", base.HEX_DEC)

-- 0x2c00 - CSR_VARID_BT_CLOCK
bccmd_clock = ProtoField.uint32("bthci_cmd.bccmd.clock", "Clock", base.HEX_DEC)

-- 0x3008 - CSR_VARID_CRYPT_KEY_LENGTH
bccmd_handle = ProtoField.uint16("bthci_cmd.bccmd.handle", "Handle", base.HEX_DEC)
bccmd_key_len = ProtoField.uint16("bthci_cmd.bccmd.key.length", "Key Length", base.DEC)

-- 0x300b - CSR_VARID_GET_NEXT_BUILDDEF
bccmd_def = ProtoField.uint16("bthci_cmd.bccmd.def", "Def", base.HEX_DEC)
bccmd_nextdef = ProtoField.uint16("bthci_cmd.bccmd.nextdef", "Nextdef", base.HEX_DEC)

-- 0x3012 - CSR_VARID_PS_MEMORY_TYPE
bccmd_mem_type = ProtoField.uint16("bthci_cmd.bccmd.mem.type", "MemType", base.HEX_DEC, {
    [0x0000] = "Flash memory",
    [0x0001] = "EEPROM",
    [0x0002] = "RAM (transient)",
    [0x0003] = "ROM (or \"read-only\" flash memory)",
})

-- 0x301c - CSR_VARID_READ_BUILD_NAME
bccmd_buildname = ProtoField.string("bthci_cmd.bccmd.buildname", "BuildName")
bccmd_start = ProtoField.uint16("bthci_cmd.bccmd.name.start", "Start", base.HEX_DEC)
bccmd_key_len = ProtoField.uint16("bthci_cmd.bccmd.name.length", "Length", base.DEC)

-- 0x482e - CSR_VARID_SINGLE_CHAN
bccmd_channel = ProtoField.uint16("bthci_cmd.bccmd.channel", "Channel", base.HEX_DEC)

-- 0x6805 - CSR_VARID_PANIC_ARG
bccmd_panic_error = ProtoField.uint16("bthci_cmd.bccmd.panic.error", "Error", base.HEX_DEC)

-- 0x6806 - CSR_VARID_FAULT_ARG
bccmd_fault_error = ProtoField.uint16("bthci_cmd.bccmd.fault.error", "Error", base.HEX_DEC)

-- 0x3005 - CSR_VARID_PS_NEXT
bccmd_nextkey = ProtoField.uint16("bthci_cmd.bccmd.nextkey", "Next Key", base.HEX, BCCMD_PSKEY)
-- 0x3006 - CSR_VARID_PS_SIZE
-- 0x500c - CSR_VARID_PS_CLR_STORES
-- 0x7003 - CSR_VARID_PS
bccmd_pskey = ProtoField.uint16("bthci_cmd.bccmd.pskey", "PS Key", base.HEX, BCCMD_PSKEY)
bccmd_pskey_size = ProtoField.uint16("bthci_cmd.bccmd.pskey.size", "PsKey Size", base.DEC)
bccmd_pskey_store = ProtoField.uint16("bthci_cmd.bccmd.pskey.store", "PsKey Store", base.HEX_DEC, {
    [0x0000] = 'Default',
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

bccmd_pskey_value = {
    [0] = ProtoField.string("bthci_cmd.bccmd.pskey.value", "PsKey Value"),
    [1] = ProtoField.uint16("bthci_cmd.bccmd.pskey.value1", "PsKey Value1", base.HEX_DEC),
    [2] = ProtoField.uint16("bthci_cmd.bccmd.pskey.value2", "PsKey Value2", base.HEX_DEC),
    [3] = ProtoField.uint16("bthci_cmd.bccmd.pskey.value3", "PsKey Value3", base.HEX_DEC),
    [4] = ProtoField.uint16("bthci_cmd.bccmd.pskey.value4", "PsKey Value4", base.HEX_DEC),
    [5] = ProtoField.uint16("bthci_cmd.bccmd.pskey.value5", "PsKey Value5", base.HEX_DEC),
    [6] = ProtoField.uint16("bthci_cmd.bccmd.pskey.value6", "PsKey Value6", base.HEX_DEC),
    [7] = ProtoField.uint16("bthci_cmd.bccmd.pskey.value7", "PsKey Value7", base.HEX_DEC),
    [8] = ProtoField.uint16("bthci_cmd.bccmd.pskey.value8", "PsKey Value8", base.HEX_DEC),
    [9] = ProtoField.uint16("bthci_cmd.bccmd.pskey.value9", "PsKey Value9", base.HEX_DEC),
    [10] = ProtoField.uint16("bthci_cmd.bccmd.pskey.value10", "PsKey Value10", base.HEX_DEC)
}

-- BlueCore Command Postdissector

csr_bccmd_proto = Proto("CSR-BCCMD","CSR BCCMD post dissector")
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
    -- 0x6805 -- CSR_VARID_PANIC_ARG
    bccmd_panic_error,
    -- 0x6806 - CSR_VARID_FAULT_ARG
    bccmd_fault_error,
    -- 0x3005 - CSR_VARID_PS_NEXT
    bccmd_nextkey,
    -- 0x3006 - CSR_VARID_PS_SIZE
    -- 0x500c - CSR_VARID_PS_CLR_STORES
    -- 0x7003 - CSR_VARID_PS
    bccmd_pskey,
    bccmd_pskey_size,
    bccmd_pskey_store,
    bccmd_pskey_value[0],
    bccmd_pskey_value[1],
    bccmd_pskey_value[2],
    bccmd_pskey_value[3],
    bccmd_pskey_value[4],
    bccmd_pskey_value[5],
    bccmd_pskey_value[6],
    bccmd_pskey_value[7],
    bccmd_pskey_value[8],
    bccmd_pskey_value[9],
    bccmd_pskey_value[10],
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
            for k = 1,math.min(10, size) do
                tree:add_le(bccmd_pskey_value[k], buff:range(offset, 2))
                offset = offset + 2
            end

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
            tree:add(bccmd_pskey_value[0], buff:range(offset, size * 2))
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
                pinfo.cols.protocol = 'BCCMD'
                subtree = tree:add(csr_bccmd_proto, data, "CSR BlueCore Command")

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
                pinfo.cols.protocol = 'BCEVT'
                subtree = tree:add(csr_bccmd_proto, data,"CSR BlueCore Event")

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
            end
        end
    end

    if varid ~= nil then
        local op = bccmd_op_varid[varid]
        local payload = subtree:add(bccmd_payload, data:range(offset, data:len() - offset))
        if op ~= nil and op[sup] ~= nil then
            offset = offset + op[sup](data:range(offset), payload)
        end
        if data:len() ~= offset then
            payload:add(bccmd_padding, data:range(offset))
        end
    end
end

-- register csr bccmd protocol as a postdissector
register_postdissector(csr_bccmd_proto)
