DROP TABLE IF EXISTS DDOS;

CREATE TABLE DDOS (
	ID			INTEGER,
	Flow_ID 		VARCHAR(50),
	Src_IP			VARCHAR(15),
	Src_Port		INTEGER,
	Dst_IP			VARCHAR(15),
	Dst_Port		INTEGER,
	Protocol		INTEGER,
	Timestamp		CHAR(22),
	Flow_Duration		INTEGER,
	Tot_Fwd_Pkts		INTEGER,
	Tot_Bwd_Pkts		INTEGER,
	TotLen_Fwd_Pkts		DECIMAL(15,2),
	TotLen_Bwd_Pkts		DECIMAL(15,2),
	Fwd_Pkt_Len_Max		DECIMAL(15,2),
	Fwd_Pkt_Len_Min		DECIMAL(15,2),
	Fwd_Pkt_Len_Mean	DECIMAL(15,2),
	Fwd_Pkt_Len_Std		DECIMAL(15,2),
	Bwd_Pkt_Len_Max		DECIMAL(15,2),
	Bwd_Pkt_Len_Min		DECIMAL(15,2),
	Bwd_Pkt_Len_Mean	DECIMAL(15,2),
	Bwd_Pkt_Len_Std		DECIMAL(15,2),
	Flow_Byts_s		DECIMAL(15,2),
	Flow_Pkts_s		DECIMAL(15,2),
	Flow_IAT_Mean		DECIMAL(15,2),
	Flow_IAT_Std		DECIMAL(15,2),
	Flow_IAT_Max		DECIMAL(15,2),
	Flow_IAT_Min		DECIMAL(15,2),
	Fwd_IAT_Tot		DECIMAL(15,2),
	Fwd_IAT_Mean		DECIMAL(15,2),
	Fwd_IAT_Std		DECIMAL(15,2),
	Fwd_IAT_Max		DECIMAL(15,2),
	Fwd_IAT_Min		DECIMAL(15,2),
	Bwd_IAT_Tot		DECIMAL(15,2),
	Bwd_IAT_Mean		DECIMAL(15,2),
	Bwd_IAT_Std		DECIMAL(15,2),
	Bwd_IAT_Max		DECIMAL(15,2),
	Bwd_IAT_Min		DECIMAL(15,2),
	Fwd_PSH_Flags		INTEGER,
	Bwd_PSH_Flags		INTEGER,
	Fwd_URG_Flags		INTEGER,
	Bwd_URG_Flags		INTEGER,
	Fwd_Header_Len		INTEGER,
	Bwd_Header_Len		INTEGER,
	Fwd_Pkts_s		DECIMAL(15,2),
	Bwd_Pkts_s		DECIMAL(15,2),
	Pkt_Len_Min		DECIMAL(15,2),
	Pkt_Len_Max		DECIMAL(15,2),
	Pkt_Len_Mean		DECIMAL(15,2),
	Pkt_Len_Std		DECIMAL(15,2),
	Pkt_Len_Var		DECIMAL(15,2),
	FIN_Flag_Cnt		INTEGER,
	SYN_Flag_Cnt		INTEGER,
	RST_Flag_Cnt		INTEGER,
	PSH_Flag_Cnt		INTEGER,
	ACK_Flag_Cnt		INTEGER,
	URG_Flag_Cnt		INTEGER,
	CWE_Flag_Count		INTEGER,
	ECE_Flag_Cnt		INTEGER,
	Down_Up_Ratio		DECIMAL(15,2),
	Pkt_Size_Avg		DECIMAL(15,2),
	Fwd_Seg_Size_Avg	DECIMAL(15,2),
	Bwd_Seg_Size_Avg	DECIMAL(15,2),
	Fwd_Byts_b_Avg		DECIMAL(15,2),
	Fwd_Pkts_b_Avg		DECIMAL(15,2),
	Fwd_Blk_Rate_Avg	DECIMAL(15,2),
	Bwd_Byts_b_Avg		DECIMAL(15,2),
	Bwd_Pkts_b_Avg		DECIMAL(15,2),
	Bwd_Blk_Rate_Avg	DECIMAL(15,2),
	Subflow_Fwd_Pkts	INTEGER,
	Subflow_Fwd_Byts	INTEGER,
	Subflow_Bwd_Pkts	INTEGER,
	Subflow_Bwd_Byts	INTEGER,
	Init_Fwd_Win_Byts	INTEGER,
	Init_Bwd_Win_Byts	INTEGER,
	Fwd_Act_Data_Pkts	INTEGER,
	Fwd_Seg_Size_Min	INTEGER,
	Active_Mean		DECIMAL(15,2),
	Active_Std		DECIMAL(15,2),
	Active_Max		DECIMAL(15,2),
	Active_Min		DECIMAL(15,2),
	Idle_Mean		DECIMAL(15,2),
	Idle_Std		DECIMAL(15,2),
	Idle_Max		DECIMAL(15,2),
	Idle_Min		DECIMAL(15,2),
	Label			VARCHAR(6)
);

SET GLOBAL local_infile = 'ON';
SHOW GLOBAL VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE '/path/to/ddos.csv' INTO TABLE `DDOS` FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
