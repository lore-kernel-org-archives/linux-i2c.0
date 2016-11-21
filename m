From: Piotr Kasprzak <piotr.kasprzak@icloud.com>
Subject: i2c /i801_smbus bug/issue
Date: Mon, 21 Nov 2016 11:59:41 +0000
Message-ID: <A7814E6B-AF39-4EF3-8EF6-C080E954A81E@icloud.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_0DBD6A7A-BF2A-4EE5-9284-B23F64BD2CE0"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:60954 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936216AbcKXMKk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 24 Nov 2016 07:10:40 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, kean.ho.chew@intel.com, james.d.ralston@intel.com, seth.heasley@intel.com


--Apple-Mail=_0DBD6A7A-BF2A-4EE5-9284-B23F64BD2CE0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi=20
i dont know who is responsible for driver for i2c intel, and where to =
raport bug


on my board Apollo Lake - Asrock J3455-ITX im getting on latets kernel =
master 4.9rc5 following issue


[    2.079564] i2c /dev entries driver
[    2.079911] i801_smbus 0000:00:1f.1: can't derive routing for PCI INT =
A
[    2.079913] i801_smbus 0000:00:1f.1: PCI INT A: not connected
[    2.079939] i801_smbus 0000:00:1f.1: SPD Write Disable is set
[    2.079964] i801_smbus 0000:00:1f.1: Failed to allocate irq =
-2147483648: -107
[    2.079973] i801_smbus 0000:00:1f.1: SMBus using polling

here my hardware log

--Apple-Mail=_0DBD6A7A-BF2A-4EE5-9284-B23F64BD2CE0
Content-Disposition: attachment;
	filename=03_Hardware.log
Content-Type: application/octet-stream;
	name="03_Hardware.log"
Content-Transfer-Encoding: 7bit

################################################################################
# ... output of lspci -vvvvnn
# LibreELEC release: Generic.x86_64-devel-20161120
# LibreELEC git: 2e3081a9304242b3d10c78d55f673dfd1824da0d
################################################################################
00:00.0 Host bridge [0600]: Intel Corporation Device [8086:5af0] (rev 0b)
	Subsystem: ASRock Incorporation Device [1849:5af0]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:02.0 VGA compatible controller [0300]: Intel Corporation Device [8086:5a85] (rev 0b) (prog-if 00 [VGA controller])
	Subsystem: ASRock Incorporation Device [1849:5a85]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 124
	Region 0: Memory at 90000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at 80000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at f000 [size=64]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [40] Vendor Specific Information: Len=0c <?>
	Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41e1
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Process Address Space ID (PASID)
		PASIDCap: Exec+ Priv-, Max PASID Width: 14
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [200 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [300 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped-
		Page Request Capacity: 00008000, Page Request Allocation: 00000000
	Kernel driver in use: i915

00:0e.0 Audio device [0403]: Intel Corporation Device [8086:5a98] (rev 0b)
	Subsystem: ASRock Incorporation Device [1849:c892]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 127
	Region 0: Memory at 91310000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at 91000000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Vendor Specific Information: Len=14 <?>
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4182
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_soc_skl, snd_hda_intel

00:0f.0 Communication controller [0780]: Intel Corporation Device [8086:5a9a] (rev 0b)
	Subsystem: ASRock Incorporation Device [1849:5a9a]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 9131b000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a4] Vendor Specific Information: Len=14 <?>

00:12.0 SATA controller [0106]: Intel Corporation Device [8086:5ae3] (rev 0b) (prog-if 01 [AHCI 1.0])
	Subsystem: ASRock Incorporation Device [1849:5ae3]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at 91314000 (32-bit, non-prefetchable) [size=8K]
	Region 1: Memory at 91318000 (32-bit, non-prefetchable) [size=256]
	Region 2: I/O ports at f090 [size=8]
	Region 3: I/O ports at f080 [size=4]
	Region 4: I/O ports at f060 [size=32]
	Region 5: Memory at 91317000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci

00:13.0 PCI bridge [0604]: Intel Corporation Device [8086:5ad8] (rev fb) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 120
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: 91200000-912fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM not supported, Exit Latency L0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4161
	Capabilities: [90] Subsystem: ASRock Incorporation Device [1849:5ad8]
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v0] #00
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [150 v0] #00
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
	Kernel driver in use: pcieport

00:13.1 PCI bridge [0604]: Intel Corporation Device [8086:5ad9] (rev fb) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 121
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 5GT/s, Width x1, ASPM not supported, Exit Latency L0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train+ SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4181
	Capabilities: [90] Subsystem: ASRock Incorporation Device [1849:5ad9]
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [100 v0] #00
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [150 v0] #00
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
	Kernel driver in use: pcieport

00:13.2 PCI bridge [0604]: Intel Corporation Device [8086:5ada] (rev fb) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 122
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: 91100000-911fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 5GT/s, Width x1, ASPM not supported, Exit Latency L0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41a1
	Capabilities: [90] Subsystem: ASRock Incorporation Device [1849:5ada]
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v0] #00
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [150 v0] #00
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
	Kernel driver in use: pcieport

00:13.3 PCI bridge [0604]: Intel Corporation Device [8086:5adb] (rev fb) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 123
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #6, Speed 5GT/s, Width x1, ASPM not supported, Exit Latency L0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train+ SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41c1
	Capabilities: [90] Subsystem: ASRock Incorporation Device [1849:5adb]
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [100 v0] #00
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [150 v0] #00
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
	Kernel driver in use: pcieport

00:15.0 USB controller [0c03]: Intel Corporation Device [8086:5aa8] (rev 0b) (prog-if 30 [XHCI])
	Subsystem: ASRock Incorporation Device [1849:5aa8]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 126
	Region 0: Memory at 91300000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4152
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: xhci_hcd

00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:5ae8] (rev 0b)
	Subsystem: ASRock Incorporation Device [1849:5ae8]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.1 SMBus [0c05]: Intel Corporation Broxton SMBus Controller [8086:5ad4] (rev 0b)
	Subsystem: ASRock Incorporation Broxton SMBus Controller [1849:5ad4]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ -2147483648
	Region 0: Memory at 91316000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at f040 [size=32]
	Kernel driver in use: i801_smbus

01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 11)
	Subsystem: ASRock Incorporation RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (Motherboard (one of many)) [1849:8168]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 125
	Region 0: I/O ports at e000 [size=256]
	Region 2: Memory at 91204000 (64-bit, non-prefetchable) [size=4K]
	Region 4: Memory at 91200000 (64-bit, prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4122
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via message/WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [d0] Vital Product Data
		Not readable
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
	Capabilities: [170 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Kernel driver in use: r8169

03:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062 Serial ATA Controller [1b21:0612] (rev 02) (prog-if 01 [AHCI 1.0])
	Subsystem: ASRock Incorporation ASM1062 Serial ATA Controller (Motherboard) [1849:0612]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at d050 [size=8]
	Region 1: I/O ports at d040 [size=4]
	Region 2: I/O ports at d030 [size=8]
	Region 3: I/O ports at d020 [size=4]
	Region 4: I/O ports at d000 [size=32]
	Region 5: Memory at 91100000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM not supported, Exit Latency L0s unlimited, L1 <2us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Kernel driver in use: ahci


################################################################################
# ... output of lsusb -vvv
# LibreELEC release: Generic.x86_64-devel-20161120
# LibreELEC git: 2e3081a9304242b3d10c78d55f673dfd1824da0d
################################################################################

Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         3 
  bMaxPacketSize0         9
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0003 3.0 root hub
  bcdDevice            4.09
  iManufacturer           3 Linux 4.9.0-rc5+ xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 0000:00:15.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           31
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
        bMaxBurst               0
Hub Descriptor:
  bLength              12
  bDescriptorType      42
  nNbrPorts             7
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  bHubDecLat          0.0 micro seconds
  wHubDelay             0 nano seconds
  DeviceRemovable    0x00
 Hub Port Status:
   Port 1: 0000.02a0 5Gbps power Rx.Detect
   Port 2: 0000.02a0 5Gbps power Rx.Detect
   Port 3: 0000.02a0 5Gbps power Rx.Detect
   Port 4: 0000.02a0 5Gbps power Rx.Detect
   Port 5: 0000.02a0 5Gbps power Rx.Detect
   Port 6: 0000.02a0 5Gbps power Rx.Detect
   Port 7: 0000.02a0 5Gbps power Rx.Detect
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           15
  bNumDeviceCaps          1
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x02
      Latency Tolerance Messages (LTM) Supported
    wSpeedsSupported   0x0008
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   3
      Lowest fully-functional device speed is SuperSpeed (5Gbps)
    bU1DevExitLat          10 micro seconds
    bU2DevExitLat         512 micro seconds
Device Status:     0x0001
  Self Powered

Bus 001 Device 004: ID 045e:0745 Microsoft Corp. Nano Transceiver v1.0 for Bluetooth
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x045e Microsoft Corp.
  idProduct          0x0745 Nano Transceiver v1.0 for Bluetooth
  bcdDevice            6.34
  iManufacturer           1 Microsoft
  iProduct                2 Microsoft? Nano Transceiver v2.0
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           84
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      57
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     295
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     319
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)

Bus 001 Device 003: ID 413c:2003 Dell Computer Corp. Keyboard
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x413c Dell Computer Corp.
  idProduct          0x2003 Keyboard
  bcdDevice            3.01
  iManufacturer           1 Dell
  iProduct                2 Dell USB Keyboard
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower               70mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      65
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              24
Device Status:     0x0000
  (Bus Powered)

Bus 001 Device 002: ID 0471:2168 Philips (or NXP) 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0471 Philips (or NXP)
  idProduct          0x2168 
  bcdDevice            1.04
  iManufacturer           1 PHILIPS
  iProduct                2 OVU710023
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     479
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            4.09
  iManufacturer           3 Linux 4.9.0-rc5+ xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 0000:00:15.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength              11
  bDescriptorType      41
  nNbrPorts             8
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00 0x00
  PortPwrCtrlMask    0xff 0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0303 lowspeed power enable connect
   Port 4: 0000.0303 lowspeed power enable connect
   Port 5: 0000.0100 power
   Port 6: 0000.0103 power enable connect
   Port 7: 0000.0100 power
   Port 8: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

################################################################################
# ... output of lsusb -t
# LibreELEC release: Generic.x86_64-devel-20161120
# LibreELEC git: 2e3081a9304242b3d10c78d55f673dfd1824da0d
################################################################################
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/7p, 5000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/8p, 480M
    |__ Port 3: Dev 2, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
    |__ Port 4: Dev 3, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
    |__ Port 6: Dev 4, If 2, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 6: Dev 4, If 0, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 6: Dev 4, If 1, Class=Human Interface Device, Driver=usbhid, 12M

################################################################################
# ... output of cat /proc/cpuinfo
# LibreELEC release: Generic.x86_64-devel-20161120
# LibreELEC git: 2e3081a9304242b3d10c78d55f673dfd1824da0d
################################################################################
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 92
model name	: Intel(R) Celeron(R) CPU J3455 @ 1.50GHz
stepping	: 9
microcode	: 0x1c
cpu MHz		: 2199.920
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 21
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg cx16 xtpr pdcm sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave rdrand lahf_lm 3dnowprefetch intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust smep erms mpx rdseed smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts
bugs		: monitor
bogomips	: 2996.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 92
model name	: Intel(R) Celeron(R) CPU J3455 @ 1.50GHz
stepping	: 9
microcode	: 0x1c
cpu MHz		: 2199.920
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 21
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg cx16 xtpr pdcm sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave rdrand lahf_lm 3dnowprefetch intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust smep erms mpx rdseed smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts
bugs		: monitor
bogomips	: 2999.27
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 92
model name	: Intel(R) Celeron(R) CPU J3455 @ 1.50GHz
stepping	: 9
microcode	: 0x1c
cpu MHz		: 2199.920
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 21
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg cx16 xtpr pdcm sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave rdrand lahf_lm 3dnowprefetch intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust smep erms mpx rdseed smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts
bugs		: monitor
bogomips	: 3000.79
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 92
model name	: Intel(R) Celeron(R) CPU J3455 @ 1.50GHz
stepping	: 9
microcode	: 0x1c
cpu MHz		: 2199.920
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 21
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg cx16 xtpr pdcm sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave rdrand lahf_lm 3dnowprefetch intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust smep erms mpx rdseed smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts
bugs		: monitor
bogomips	: 3000.70
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:


################################################################################
# ... output of get_governor_details
# LibreELEC release: Generic.x86_64-devel-20161120
# LibreELEC git: 2e3081a9304242b3d10c78d55f673dfd1824da0d
################################################################################
/sys/devices/system/cpu
    cpu0                           : <dir>
    cpu1                           : <dir>
    cpu2                           : <dir>
    cpu3                           : <dir>
    cpufreq                        : <dir>
    cpuidle                        : <dir>
    hotplug                        : <dir>
    intel_pstate                   : <dir>
    kernel_max                     : 15
    microcode                      : <dir>
    modalias                       : cpu:type:x86,ven0000fam0006mod005C:feature:,0000,0001,0002,0003,0004,0005,0006,0007,0008,0009,000B,000C,000D,000E,000F,0010,0011,0013,0015,0016,0017,0018,0019,001A,001B,001C,001D,001F,002B,0034,003A,003B,003D,0068,006A,006B,006C,006D,006F,0070,0072,0074,0075,0076,0078,007C,007D,0080,0081,0082,0083,0084,0085,0087,0088,0089,008B,008D,008E,008F,0093,0094,0095,0096,0097,0098,0099,009A,009B,009E,00C0,00C8,00EF,0100,0101,0102,0103,0104,0120,0121,0127,0129,012D,012E,012F,0132,0134,0137,0139,013D,0140,0141,0142,0143,01C0,01C1,01C2,01C4,01C6
    online                         : 0-3
    possible                       : 0-3
    power                          : <dir>
    present                        : 0-3
/sys/devices/system/cpu/cpufreq
    policy0                        : <dir>
    policy1                        : <dir>
    policy2                        : <dir>
    policy3                        : <dir>
/sys/devices/system/cpu/cpu0/cpufreq
    affected_cpus                  : 0
    cpuinfo_cur_freq               : 2173461
    cpuinfo_max_freq               : 2300000
    cpuinfo_min_freq               : 800000
    cpuinfo_transition_latency     : 4294967295
    related_cpus                   : 0
    scaling_available_governors    : performance powersave
    scaling_cur_freq               : 2199920
    scaling_driver                 : intel_pstate
    scaling_governor               : powersave
    scaling_max_freq               : 2300000
    scaling_min_freq               : 800000
    scaling_setspeed               : <unsupported>
/sys/devices/system/cpu/cpu1/cpufreq
    affected_cpus                  : 1
    cpuinfo_cur_freq               : 2199920
    cpuinfo_max_freq               : 2300000
    cpuinfo_min_freq               : 800000
    cpuinfo_transition_latency     : 4294967295
    related_cpus                   : 1
    scaling_available_governors    : performance powersave
    scaling_cur_freq               : 2152770
    scaling_driver                 : intel_pstate
    scaling_governor               : powersave
    scaling_max_freq               : 2300000
    scaling_min_freq               : 800000
    scaling_setspeed               : <unsupported>
/sys/devices/system/cpu/cpu2/cpufreq
    affected_cpus                  : 2
    cpuinfo_cur_freq               : 2025787
    cpuinfo_max_freq               : 2300000
    cpuinfo_min_freq               : 800000
    cpuinfo_transition_latency     : 4294967295
    related_cpus                   : 2
    scaling_available_governors    : performance powersave
    scaling_cur_freq               : 2026336
    scaling_driver                 : intel_pstate
    scaling_governor               : powersave
    scaling_max_freq               : 2300000
    scaling_min_freq               : 800000
    scaling_setspeed               : <unsupported>
/sys/devices/system/cpu/cpu3/cpufreq
    affected_cpus                  : 3
    cpuinfo_cur_freq               : 2070281
    cpuinfo_max_freq               : 2300000
    cpuinfo_min_freq               : 800000
    cpuinfo_transition_latency     : 4294967295
    related_cpus                   : 3
    scaling_available_governors    : performance powersave
    scaling_cur_freq               : 2047943
    scaling_driver                 : intel_pstate
    scaling_governor               : powersave
    scaling_max_freq               : 2300000
    scaling_min_freq               : 800000
    scaling_setspeed               : <unsupported>

################################################################################
# ... output of cat /proc/meminfo
# LibreELEC release: Generic.x86_64-devel-20161120
# LibreELEC git: 2e3081a9304242b3d10c78d55f673dfd1824da0d
################################################################################
MemTotal:        3426544 kB
MemFree:         2614020 kB
MemAvailable:    2893032 kB
Buffers:           50888 kB
Cached:           542560 kB
SwapCached:            0 kB
Active:           269680 kB
Inactive:         472168 kB
Active(anon):     200856 kB
Inactive(anon):   203204 kB
Active(file):      68824 kB
Inactive(file):   268964 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:               236 kB
Writeback:            28 kB
AnonPages:        148388 kB
Mapped:            61020 kB
Shmem:            255532 kB
Slab:              29984 kB
SReclaimable:      15020 kB
SUnreclaim:        14964 kB
KernelStack:        3168 kB
PageTables:         2224 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     1713272 kB
Committed_AS:     844180 kB
VmallocTotal:   34359738367 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
AnonHugePages:         0 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
DirectMap4k:       19808 kB
DirectMap2M:     1464320 kB
DirectMap1G:     4194304 kB


--Apple-Mail=_0DBD6A7A-BF2A-4EE5-9284-B23F64BD2CE0
Content-Disposition: attachment;
	filename=02_System.log
Content-Type: application/octet-stream;
	name="02_System.log"
Content-Transfer-Encoding: quoted-printable

#=
##########################################################################=
#####=0A#=20...=20output=20of=20dmesg=0A#=20LibreELEC=20release:=20=
Generic.x86_64-devel-20161120=0A#=20LibreELEC=20git:=20=
2e3081a9304242b3d10c78d55f673dfd1824da0d=0A=
##########################################################################=
######=0A[=20=20=20=200.000000]=20Linux=20version=204.9.0-rc5+=20=
(root@kompilator)=20(gcc=20version=205.4.0=20(GCC)=20)=20#1=20SMP=20Sun=20=
Nov=2020=2005:29:03=20CET=202016=0A[=20=20=20=200.000000]=20Command=20=
line:=20BOOT_IMAGE=3D/KERNEL=20boot=3DLABEL=3DSystem=20=
disk=3DLABEL=3DStorage=20=20quiet=0A[=20=20=20=200.000000]=20x86/fpu:=20=
Supporting=20XSAVE=20feature=200x001:=20'x87=20floating=20point=20=
registers'=0A[=20=20=20=200.000000]=20x86/fpu:=20Supporting=20XSAVE=20=
feature=200x002:=20'SSE=20registers'=0A[=20=20=20=200.000000]=20x86/fpu:=20=
Supporting=20XSAVE=20feature=200x008:=20'MPX=20bounds=20registers'=0A[=20=
=20=20=200.000000]=20x86/fpu:=20Supporting=20XSAVE=20feature=200x010:=20=
'MPX=20CSR'=0A[=20=20=20=200.000000]=20x86/fpu:=20xstate_offset[3]:=20=20=
576,=20xstate_sizes[3]:=20=20=2064=0A[=20=20=20=200.000000]=20x86/fpu:=20=
xstate_offset[4]:=20=20640,=20xstate_sizes[4]:=20=20=2064=0A[=20=20=20=20=
0.000000]=20x86/fpu:=20Enabled=20xstate=20features=200x1b,=20context=20=
size=20is=20704=20bytes,=20using=20'compacted'=20format.=0A[=20=20=20=20=
0.000000]=20x86/fpu:=20Using=20'eager'=20FPU=20context=20switches.=0A[=20=
=20=20=200.000000]=20e820:=20BIOS-provided=20physical=20RAM=20map:=0A[=20=
=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x0000000000000000-0x000000000003efff]=20usable=0A[=20=20=20=200.000000]=20=
BIOS-e820:=20[mem=200x000000000003f000-0x000000000003ffff]=20reserved=0A=
[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x0000000000040000-0x000000000009dfff]=20usable=0A[=20=20=20=200.000000]=20=
BIOS-e820:=20[mem=200x000000000009e000-0x00000000000fffff]=20reserved=0A=
[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x0000000000100000-0x000000000fffffff]=20usable=0A[=20=20=20=200.000000]=20=
BIOS-e820:=20[mem=200x0000000010000000-0x0000000012150fff]=20reserved=0A=
[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x0000000012151000-0x000000005b4d7fff]=20usable=0A[=20=20=20=200.000000]=20=
BIOS-e820:=20[mem=200x000000005b4d8000-0x000000005d5cdfff]=20reserved=0A=
[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x000000005d5ce000-0x000000005d9a9fff]=20usable=0A[=20=20=20=200.000000]=20=
BIOS-e820:=20[mem=200x000000005d9aa000-0x000000005d9e0fff]=20ACPI=20NVS=0A=
[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x000000005d9e1000-0x000000005ddddfff]=20reserved=0A[=20=20=20=20=
0.000000]=20BIOS-e820:=20[mem=200x000000005ddde000-0x000000005e154fff]=20=
usable=0A[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x000000005e155000-0x000000005e155fff]=20ACPI=20NVS=0A[=20=20=20=20=
0.000000]=20BIOS-e820:=20[mem=200x000000005e156000-0x000000005e17ffff]=20=
reserved=0A[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x000000005e180000-0x000000005e756fff]=20usable=0A[=20=20=20=200.000000]=20=
BIOS-e820:=20[mem=200x000000005e757000-0x000000005e758fff]=20reserved=0A=
[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x000000005e759000-0x000000005effffff]=20usable=0A[=20=20=20=200.000000]=20=
BIOS-e820:=20[mem=200x000000005f000000-0x000000007fffffff]=20reserved=0A=
[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x00000000d0000000-0x00000000d0ffffff]=20reserved=0A[=20=20=20=20=
0.000000]=20BIOS-e820:=20[mem=200x00000000e0000000-0x00000000efffffff]=20=
reserved=0A[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x00000000fe042000-0x00000000fe044fff]=20reserved=0A[=20=20=20=20=
0.000000]=20BIOS-e820:=20[mem=200x00000000fe900000-0x00000000fe902fff]=20=
reserved=0A[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x00000000fec00000-0x00000000fec00fff]=20reserved=0A[=20=20=20=20=
0.000000]=20BIOS-e820:=20[mem=200x00000000fed01000-0x00000000fed01fff]=20=
reserved=0A[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x00000000fee00000-0x00000000fee00fff]=20reserved=0A[=20=20=20=20=
0.000000]=20BIOS-e820:=20[mem=200x00000000ff800000-0x00000000ffffffff]=20=
reserved=0A[=20=20=20=200.000000]=20BIOS-e820:=20[mem=20=
0x0000000100000000-0x000000017fffffff]=20usable=0A[=20=20=20=200.000000]=20=
NX=20(Execute=20Disable)=20protection:=20active=0A[=20=20=20=200.000000]=20=
e820:=20update=20[mem=200x567f6018-0x56806057]=20usable=20=3D=3D>=20=
usable=0A[=20=20=20=200.000000]=20e820:=20update=20[mem=20=
0x567e7018-0x567f5057]=20usable=20=3D=3D>=20usable=0A[=20=20=20=20=
0.000000]=20extended=20physical=20RAM=20map:=0A[=20=20=20=200.000000]=20=
reserve=20setup_data:=20[mem=200x0000000000000000-0x000000000003efff]=20=
usable=0A[=20=20=20=200.000000]=20reserve=20setup_data:=20[mem=20=
0x000000000003f000-0x000000000003ffff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x0000000000040000-0x000000000009dfff]=20usable=0A[=20=20=20=200.000000]=20=
reserve=20setup_data:=20[mem=200x000000000009e000-0x00000000000fffff]=20=
reserved=0A[=20=20=20=200.000000]=20reserve=20setup_data:=20[mem=20=
0x0000000000100000-0x000000000fffffff]=20usable=0A[=20=20=20=200.000000]=20=
reserve=20setup_data:=20[mem=200x0000000010000000-0x0000000012150fff]=20=
reserved=0A[=20=20=20=200.000000]=20reserve=20setup_data:=20[mem=20=
0x0000000012151000-0x00000000567e7017]=20usable=0A[=20=20=20=200.000000]=20=
reserve=20setup_data:=20[mem=200x00000000567e7018-0x00000000567f5057]=20=
usable=0A[=20=20=20=200.000000]=20reserve=20setup_data:=20[mem=20=
0x00000000567f5058-0x00000000567f6017]=20usable=0A[=20=20=20=200.000000]=20=
reserve=20setup_data:=20[mem=200x00000000567f6018-0x0000000056806057]=20=
usable=0A[=20=20=20=200.000000]=20reserve=20setup_data:=20[mem=20=
0x0000000056806058-0x000000005b4d7fff]=20usable=0A[=20=20=20=200.000000]=20=
reserve=20setup_data:=20[mem=200x000000005b4d8000-0x000000005d5cdfff]=20=
reserved=0A[=20=20=20=200.000000]=20reserve=20setup_data:=20[mem=20=
0x000000005d5ce000-0x000000005d9a9fff]=20usable=0A[=20=20=20=200.000000]=20=
reserve=20setup_data:=20[mem=200x000000005d9aa000-0x000000005d9e0fff]=20=
ACPI=20NVS=0A[=20=20=20=200.000000]=20reserve=20setup_data:=20[mem=20=
0x000000005d9e1000-0x000000005ddddfff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x000000005ddde000-0x000000005e154fff]=20usable=0A[=20=20=20=200.000000]=20=
reserve=20setup_data:=20[mem=200x000000005e155000-0x000000005e155fff]=20=
ACPI=20NVS=0A[=20=20=20=200.000000]=20reserve=20setup_data:=20[mem=20=
0x000000005e156000-0x000000005e17ffff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x000000005e180000-0x000000005e756fff]=20usable=0A[=20=20=20=200.000000]=20=
reserve=20setup_data:=20[mem=200x000000005e757000-0x000000005e758fff]=20=
reserved=0A[=20=20=20=200.000000]=20reserve=20setup_data:=20[mem=20=
0x000000005e759000-0x000000005effffff]=20usable=0A[=20=20=20=200.000000]=20=
reserve=20setup_data:=20[mem=200x000000005f000000-0x000000007fffffff]=20=
reserved=0A[=20=20=20=200.000000]=20reserve=20setup_data:=20[mem=20=
0x00000000d0000000-0x00000000d0ffffff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x00000000e0000000-0x00000000efffffff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x00000000fe042000-0x00000000fe044fff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x00000000fe900000-0x00000000fe902fff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x00000000fec00000-0x00000000fec00fff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x00000000fed01000-0x00000000fed01fff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x00000000fee00000-0x00000000fee00fff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x00000000ff800000-0x00000000ffffffff]=20reserved=0A[=20=20=20=20=
0.000000]=20reserve=20setup_data:=20[mem=20=
0x0000000100000000-0x000000017fffffff]=20usable=0A[=20=20=20=200.000000]=20=
efi:=20EFI=20v2.50=20by=20American=20Megatrends=0A[=20=20=20=200.000000]=20=
efi:=20=20ESRT=3D0x5dd82918=20=20ACPI=3D0x5d9aa000=20=20ACPI=20=
2.0=3D0x5d9aa000=20=20SMBIOS=3D0x5dc4f000=20=20SMBIOS=203.0=3D0x5dc4e000=20=
=0A[=20=20=20=200.000000]=20SMBIOS=203.0.0=20present.=0A[=20=20=20=20=
0.000000]=20e820:=20update=20[mem=200x00000000-0x00000fff]=20usable=20=
=3D=3D>=20reserved=0A[=20=20=20=200.000000]=20e820:=20remove=20[mem=20=
0x000a0000-0x000fffff]=20usable=0A[=20=20=20=200.000000]=20e820:=20=
last_pfn=20=3D=200x180000=20max_arch_pfn=20=3D=200x400000000=0A[=20=20=20=
=200.000000]=20MTRR=20default=20type:=20uncachable=0A[=20=20=20=20=
0.000000]=20MTRR=20fixed=20ranges=20enabled:=0A[=20=20=20=200.000000]=20=20=
=2000000-6FFFF=20write-back=0A[=20=20=20=200.000000]=20=20=2070000-7FFFF=20=
uncachable=0A[=20=20=20=200.000000]=20=20=2080000-9FFFF=20write-back=0A[=20=
=20=20=200.000000]=20=20=20A0000-BFFFF=20uncachable=0A[=20=20=20=20=
0.000000]=20=20=20C0000-FFFFF=20write-protect=0A[=20=20=20=200.000000]=20=
MTRR=20variable=20ranges=20enabled:=0A[=20=20=20=200.000000]=20=20=200=20=
base=200000000000=20mask=207FC0000000=20write-back=0A[=20=20=20=20=
0.000000]=20=20=201=20base=200040000000=20mask=207FE0000000=20write-back=0A=
[=20=20=20=200.000000]=20=20=202=20base=20005F000000=20mask=207FFF000000=20=
uncachable=0A[=20=20=20=200.000000]=20=20=203=20base=200100000000=20mask=20=
7F80000000=20write-back=0A[=20=20=20=200.000000]=20=20=204=20base=20=
00FF800000=20mask=207FFF800000=20write-combining=0A[=20=20=20=20=
0.000000]=20=20=205=20disabled=0A[=20=20=20=200.000000]=20=20=206=20=
disabled=0A[=20=20=20=200.000000]=20=20=207=20disabled=0A[=20=20=20=20=
0.000000]=20=20=208=20disabled=0A[=20=20=20=200.000000]=20=20=209=20=
disabled=0A[=20=20=20=200.000000]=20x86/PAT:=20Configuration=20[0-7]:=20=
WB=20=20WC=20=20UC-=20UC=20=20WB=20=20WC=20=20UC-=20WT=20=20=0A[=20=20=20=
=200.000000]=20e820:=20last_pfn=20=3D=200x5f000=20max_arch_pfn=20=3D=20=
0x400000000=0A[=20=20=20=200.000000]=20esrt:=20Reserving=20ESRT=20space=20=
from=200x000000005dd82918=20to=200x000000005dd82950.=0A[=20=20=20=20=
0.000000]=20Scanning=201=20areas=20for=20low=20memory=20corruption=0A[=20=
=20=20=200.000000]=20Base=20memory=20trampoline=20at=20=
[ffff880000097000]=2097000=20size=2024576=0A[=20=20=20=200.000000]=20=
Using=20GB=20pages=20for=20direct=20mapping=0A[=20=20=20=200.000000]=20=
BRK=20[0x0332f000,=200x0332ffff]=20PGTABLE=0A[=20=20=20=200.000000]=20=
BRK=20[0x03330000,=200x03330fff]=20PGTABLE=0A[=20=20=20=200.000000]=20=
BRK=20[0x03331000,=200x03331fff]=20PGTABLE=0A[=20=20=20=200.000000]=20=
BRK=20[0x03332000,=200x03332fff]=20PGTABLE=0A[=20=20=20=200.000000]=20=
BRK=20[0x03333000,=200x03333fff]=20PGTABLE=0A[=20=20=20=200.000000]=20=
BRK=20[0x03334000,=200x03334fff]=20PGTABLE=0A[=20=20=20=200.000000]=20=
ACPI:=20Early=20table=20checksum=20verification=20disabled=0A[=20=20=20=20=
0.000000]=20ACPI:=20RSDP=200x000000005D9AA000=20000024=20(v02=20ALASKA)=0A=
[=20=20=20=200.000000]=20ACPI:=20XSDT=200x000000005D9AA0C0=200000EC=20=
(v01=20ALASKA=20A=20M=20I=20=20=20=2001072009=20AMI=20=2000010013)=0A[=20=
=20=20=200.000000]=20ACPI:=20FACP=200x000000005D9B3210=20000114=20(v06=20=
ALASKA=20A=20M=20I=20=20=20=2001072009=20AMI=20=2000010013)=0A[=20=20=20=20=
0.000000]=20ACPI:=20DSDT=200x000000005D9AA250=20008FB3=20(v02=20ALASKA=20=
A=20M=20I=20=20=20=2001072009=20INTL=2020120913)=0A[=20=20=20=20=
0.000000]=20ACPI:=20FACS=200x000000005D9C8080=20000040=0A[=20=20=20=20=
0.000000]=20ACPI:=20FPDT=200x000000005D9B3330=20000044=20(v01=20ALASKA=20=
A=20M=20I=20=20=20=2001072009=20AMI=20=2000010013)=0A[=20=20=20=20=
0.000000]=20ACPI:=20FIDT=200x000000005D9B3380=2000009C=20(v01=20ALASKA=20=
A=20M=20I=20=20=20=2001072009=20AMI=20=2000010013)=0A[=20=20=20=20=
0.000000]=20ACPI:=20MCFG=200x000000005D9B3420=2000003C=20(v01=20ALASKA=20=
A=20M=20I=20=20=20=2001072009=20MSFT=2000000097)=0A[=20=20=20=20=
0.000000]=20ACPI:=20DBG2=200x000000005D9B3460=20000072=20(v00=20INTEL=20=20=
EDK2=20=20=20=20=2000000003=20BRXT=200100000D)=0A[=20=20=20=200.000000]=20=
ACPI:=20DBGP=200x000000005D9B34E0=20000034=20(v01=20INTEL=20=20EDK2=20=20=
=20=20=2000000003=20BRXT=200100000D)=0A[=20=20=20=200.000000]=20ACPI:=20=
HPET=200x000000005D9B3520=20000038=20(v01=20INTEL=20=20EDK2=20=20=20=20=20=
00000003=20BRXT=200100000D)=0A[=20=20=20=200.000000]=20ACPI:=20LPIT=20=
0x000000005D9B3560=2000005C=20(v01=20INTEL=20=20EDK2=20=20=20=20=20=
00000003=20BRXT=200100000D)=0A[=20=20=20=200.000000]=20ACPI:=20APIC=20=
0x000000005D9B35C0=20000084=20(v03=20INTEL=20=20EDK2=20=20=20=20=20=
00000003=20BRXT=200100000D)=0A[=20=20=20=200.000000]=20ACPI:=20NPKT=20=
0x000000005D9B3650=20000065=20(v01=20INTEL=20=20EDK2=20=20=20=20=20=
00000003=20BRXT=200100000D)=0A[=20=20=20=200.000000]=20ACPI:=20PRAM=20=
0x000000005D9B36C0=20000030=20(v01=20INTEL=20=20EDK2=20=20=20=20=20=
00000003=20BRXT=200100000D)=0A[=20=20=20=200.000000]=20ACPI:=20WSMT=20=
0x000000005D9B36F0=20000028=20(v00=20INTEL=20=20EDK2=20=20=20=20=20=
00000003=20BRXT=200100000D)=0A[=20=20=20=200.000000]=20ACPI:=20SSDT=20=
0x000000005D9B3720=20000B53=20(v02=20INTEL=20=20UsbCTabl=2000000003=20=
BRXT=200100000D)=0A[=20=20=20=200.000000]=20ACPI:=20SSDT=20=
0x000000005D9B4280=200016E9=20(v01=20Intel_=20Platform=2000001000=20INTL=20=
20120913)=0A[=20=20=20=200.000000]=20ACPI:=20AAFT=200x000000005D9B5970=20=
0002DA=20(v01=20ALASKA=20OEMAAFT=20=2001072009=20MSFT=2000000097)=0A[=20=20=
=20=200.000000]=20ACPI:=20SSDT=200x000000005D9B5C50=20000442=20(v02=20=
PmRef=20=20Cpu0Ist=20=2000003000=20INTL=2020120913)=0A[=20=20=20=20=
0.000000]=20ACPI:=20SSDT=200x000000005D9B60A0=2000072B=20(v02=20CpuRef=20=
CpuSsdt=20=2000003000=20INTL=2020120913)=0A[=20=20=20=200.000000]=20=
ACPI:=20SSDT=200x000000005D9B67D0=2000032D=20(v02=20PmRef=20=20Cpu0Tst=20=
=2000003000=20INTL=2020120913)=0A[=20=20=20=200.000000]=20ACPI:=20SSDT=20=
0x000000005D9B6B00=2000017C=20(v02=20PmRef=20=20ApTst=20=20=20=20=
00003000=20INTL=2020120913)=0A[=20=20=20=200.000000]=20ACPI:=20SSDT=20=
0x000000005D9B6C80=20002760=20(v02=20SaSsdt=20SaSsdt=20=20=2000003000=20=
INTL=2020120913)=0A[=20=20=20=200.000000]=20ACPI:=20UEFI=20=
0x000000005D9B93E0=20000042=20(v01=20ALASKA=20A=20M=20I=20=20=20=20=
00000000=20=20=20=20=20=2000000000)=0A[=20=20=20=200.000000]=20ACPI:=20=
BGRT=200x000000005D9B9430=20000038=20(v01=20ALASKA=20A=20M=20I=20=20=20=20=
01072009=20AMI=20=2000010013)=0A[=20=20=20=200.000000]=20ACPI:=20TPM2=20=
0x000000005D9B9470=20000034=20(v03=20=20=20=20=20=20=20=20Tpm2Tabl=20=
00000001=20AMI=20=2000000000)=0A[=20=20=20=200.000000]=20ACPI:=20WDAT=20=
0x000000005D9B94B0=20000104=20(v01=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=2000000000=20=20=20=20=20=2000000000)=0A[=20=20=20=200.000000]=20=
ACPI:=20NHLT=200x000000005D9B95C0=20001A50=20(v00=20INTEL=20=20EDK2=20=20=
=20=20=2000000002=20=20=20=20=20=2001000013)=0A[=20=20=20=200.000000]=20=
ACPI:=20Local=20APIC=20address=200xfee00000=0A[=20=20=20=200.000000]=20=
No=20NUMA=20configuration=20found=0A[=20=20=20=200.000000]=20Faking=20a=20=
node=20at=20[mem=200x0000000000000000-0x000000017fffffff]=0A[=20=20=20=20=
0.000000]=20NODE_DATA(0)=20allocated=20[mem=200x17fff7000-0x17fffafff]=0A=
[=20=20=20=200.000000]=20Zone=20ranges:=0A[=20=20=20=200.000000]=20=20=20=
DMA=20=20=20=20=20=20[mem=200x0000000000001000-0x0000000000ffffff]=0A[=20=
=20=20=200.000000]=20=20=20DMA32=20=20=20=20[mem=20=
0x0000000001000000-0x00000000ffffffff]=0A[=20=20=20=200.000000]=20=20=20=
Normal=20=20=20[mem=200x0000000100000000-0x000000017fffffff]=0A[=20=20=20=
=200.000000]=20Movable=20zone=20start=20for=20each=20node=0A[=20=20=20=20=
0.000000]=20Early=20memory=20node=20ranges=0A[=20=20=20=200.000000]=20=20=
=20node=20=20=200:=20[mem=200x0000000000001000-0x000000000003efff]=0A[=20=
=20=20=200.000000]=20=20=20node=20=20=200:=20[mem=20=
0x0000000000040000-0x000000000009dfff]=0A[=20=20=20=200.000000]=20=20=20=
node=20=20=200:=20[mem=200x0000000000100000-0x000000000fffffff]=0A[=20=20=
=20=200.000000]=20=20=20node=20=20=200:=20[mem=20=
0x0000000012151000-0x000000005b4d7fff]=0A[=20=20=20=200.000000]=20=20=20=
node=20=20=200:=20[mem=200x000000005d5ce000-0x000000005d9a9fff]=0A[=20=20=
=20=200.000000]=20=20=20node=20=20=200:=20[mem=20=
0x000000005ddde000-0x000000005e154fff]=0A[=20=20=20=200.000000]=20=20=20=
node=20=20=200:=20[mem=200x000000005e180000-0x000000005e756fff]=0A[=20=20=
=20=200.000000]=20=20=20node=20=20=200:=20[mem=20=
0x000000005e759000-0x000000005effffff]=0A[=20=20=20=200.000000]=20=20=20=
node=20=20=200:=20[mem=200x0000000100000000-0x000000017fffffff]=0A[=20=20=
=20=200.000000]=20Initmem=20setup=20node=200=20[mem=20=
0x0000000000001000-0x000000017fffffff]=0A[=20=20=20=200.000000]=20On=20=
node=200=20totalpages:=20895220=0A[=20=20=20=200.000000]=20=20=20DMA=20=
zone:=2064=20pages=20used=20for=20memmap=0A[=20=20=20=200.000000]=20=20=20=
DMA=20zone:=2022=20pages=20reserved=0A[=20=20=20=200.000000]=20=20=20DMA=20=
zone:=203996=20pages,=20LIFO=20batch:0=0A[=20=20=20=200.000000]=20=20=20=
DMA32=20zone:=205734=20pages=20used=20for=20memmap=0A[=20=20=20=20=
0.000000]=20=20=20DMA32=20zone:=20366936=20pages,=20LIFO=20batch:31=0A[=20=
=20=20=200.000000]=20=20=20Normal=20zone:=208192=20pages=20used=20for=20=
memmap=0A[=20=20=20=200.000000]=20=20=20Normal=20zone:=20524288=20pages,=20=
LIFO=20batch:31=0A[=20=20=20=200.000000]=20Reserving=20Intel=20graphics=20=
memory=20at=200x0000000060000000-0x000000007fffffff=0A[=20=20=20=20=
0.000000]=20ACPI:=20PM-Timer=20IO=20Port:=200x408=0A[=20=20=20=20=
0.000000]=20ACPI:=20Local=20APIC=20address=200xfee00000=0A[=20=20=20=20=
0.000000]=20ACPI:=20LAPIC_NMI=20(acpi_id[0x01]=20high=20level=20=
lint[0x1])=0A[=20=20=20=200.000000]=20ACPI:=20LAPIC_NMI=20(acpi_id[0x02]=20=
high=20level=20lint[0x1])=0A[=20=20=20=200.000000]=20ACPI:=20LAPIC_NMI=20=
(acpi_id[0x03]=20high=20level=20lint[0x1])=0A[=20=20=20=200.000000]=20=
ACPI:=20LAPIC_NMI=20(acpi_id[0x04]=20high=20level=20lint[0x1])=0A[=20=20=20=
=200.000000]=20IOAPIC[0]:=20apic_id=201,=20version=2032,=20address=20=
0xfec00000,=20GSI=200-119=0A[=20=20=20=200.000000]=20ACPI:=20INT_SRC_OVR=20=
(bus=200=20bus_irq=200=20global_irq=202=20dfl=20dfl)=0A[=20=20=20=20=
0.000000]=20ACPI:=20INT_SRC_OVR=20(bus=200=20bus_irq=209=20global_irq=20=
9=20low=20level)=0A[=20=20=20=200.000000]=20ACPI:=20IRQ0=20used=20by=20=
override.=0A[=20=20=20=200.000000]=20ACPI:=20IRQ9=20used=20by=20=
override.=0A[=20=20=20=200.000000]=20Using=20ACPI=20(MADT)=20for=20SMP=20=
configuration=20information=0A[=20=20=20=200.000000]=20ACPI:=20HPET=20=
id:=200x8086a701=20base:=200xfed00000=0A[=20=20=20=200.000000]=20=
smpboot:=20Allowing=204=20CPUs,=200=20hotplug=20CPUs=0A[=20=20=20=20=
0.000000]=20e820:=20[mem=200x80000000-0xcfffffff]=20available=20for=20=
PCI=20devices=0A[=20=20=20=200.000000]=20Booting=20paravirtualized=20=
kernel=20on=20bare=20hardware=0A[=20=20=20=200.000000]=20clocksource:=20=
refined-jiffies:=20mask:=200xffffffff=20max_cycles:=200xffffffff,=20=
max_idle_ns:=206370452778343963=20ns=0A[=20=20=20=200.000000]=20=
setup_percpu:=20NR_CPUS:16=20nr_cpumask_bits:16=20nr_cpu_ids:4=20=
nr_node_ids:1=0A[=20=20=20=200.000000]=20percpu:=20Embedded=2033=20=
pages/cpu=20@ffff88017fc00000=20s95256=20r8192=20d31720=20u524288=0A[=20=20=
=20=200.000000]=20pcpu-alloc:=20s95256=20r8192=20d31720=20u524288=20=
alloc=3D1*2097152=0A[=20=20=20=200.000000]=20pcpu-alloc:=20[0]=200=201=20=
2=203=20=0A[=20=20=20=200.000000]=20Built=201=20zonelists=20in=20Node=20=
order,=20mobility=20grouping=20on.=20=20Total=20pages:=20881208=0A[=20=20=
=20=200.000000]=20Policy=20zone:=20Normal=0A[=20=20=20=200.000000]=20=
Kernel=20command=20line:=20root=3D/dev/ram0=20rdinit=3D/init=20=
usbcore.autosuspend=3D-1=20BOOT_IMAGE=3D/KERNEL=20boot=3DLABEL=3DSystem=20=
disk=3DLABEL=3DStorage=20=20quiet=0A[=20=20=20=200.000000]=20PID=20hash=20=
table=20entries:=204096=20(order:=203,=2032768=20bytes)=0A[=20=20=20=20=
0.000000]=20Memory:=203343564K/3580880K=20available=20(9656K=20kernel=20=
code,=20798K=20rwdata,=2019296K=20rodata,=204068K=20init,=20392K=20bss,=20=
237316K=20reserved,=200K=20cma-reserved)=0A[=20=20=20=200.000000]=20=
SLUB:=20HWalign=3D64,=20Order=3D0-3,=20MinObjects=3D0,=20CPUs=3D4,=20=
Nodes=3D1=0A[=20=20=20=200.000000]=20Hierarchical=20RCU=20=
implementation.=0A[=20=20=20=200.000000]=20=09Build-time=20adjustment=20=
of=20leaf=20fanout=20to=2064.=0A[=20=20=20=200.000000]=20=09RCU=20=
restricting=20CPUs=20from=20NR_CPUS=3D16=20to=20nr_cpu_ids=3D4.=0A[=20=20=
=20=200.000000]=20RCU:=20Adjusting=20geometry=20for=20=
rcu_fanout_leaf=3D64,=20nr_cpu_ids=3D4=0A[=20=20=20=200.000000]=20=
NR_IRQS:4352=20nr_irqs:1024=2016=0A[=20=20=20=200.000000]=20Console:=20=
colour=20dummy=20device=2080x25=0A[=20=20=20=200.000000]=20console=20=
[tty0]=20enabled=0A[=20=20=20=200.000000]=20clocksource:=20hpet:=20mask:=20=
0xffffffff=20max_cycles:=200xffffffff,=20max_idle_ns:=2099544814920=20ns=0A=
[=20=20=20=200.000000]=20hpet=20clockevent=20registered=0A[=20=20=20=20=
0.000000]=20tsc:=20PIT=20calibration=20matches=20HPET.=201=20loops=0A[=20=
=20=20=200.000000]=20tsc:=20Detected=201497.587=20MHz=20processor=0A[=20=20=
=20=200.000093]=20Calibrating=20delay=20loop=20(skipped),=20value=20=
calculated=20using=20timer=20frequency..=202996.00=20BogoMIPS=20=
(lpj=3D4992000)=0A[=20=20=20=200.000097]=20pid_max:=20default:=2032768=20=
minimum:=20301=0A[=20=20=20=200.000110]=20ACPI:=20Core=20revision=20=
20160831=0A[=20=20=20=200.013988]=20ACPI:=208=20ACPI=20AML=20tables=20=
successfully=20acquired=20and=20loaded=0A[=20=20=20=200.015558]=20Dentry=20=
cache=20hash=20table=20entries:=20524288=20(order:=2010,=204194304=20=
bytes)=0A[=20=20=20=200.017313]=20Inode-cache=20hash=20table=20entries:=20=
262144=20(order:=209,=202097152=20bytes)=0A[=20=20=20=200.018108]=20=
Mount-cache=20hash=20table=20entries:=208192=20(order:=204,=2065536=20=
bytes)=0A[=20=20=20=200.018120]=20Mountpoint-cache=20hash=20table=20=
entries:=208192=20(order:=204,=2065536=20bytes)=0A[=20=20=20=200.018537]=20=
CPU:=20Physical=20Processor=20ID:=200=0A[=20=20=20=200.018540]=20CPU:=20=
Processor=20Core=20ID:=200=0A[=20=20=20=200.018565]=20Last=20level=20=
iTLB=20entries:=204KB=2048,=202MB=200,=204MB=200=0A[=20=20=20=20=
0.018567]=20Last=20level=20dTLB=20entries:=204KB=200,=202MB=200,=204MB=20=
0,=201GB=200=0A[=20=20=20=200.019660]=20Freeing=20SMP=20alternatives=20=
memory:=2040K=20(ffffffff832c2000=20-=20ffffffff832cc000)=0A[=20=20=20=20=
0.036689]=20smpboot:=20APIC(0)=20Converting=20physical=200=20to=20=
logical=20package=200=0A[=20=20=20=200.036691]=20smpboot:=20Max=20=
logical=20packages:=201=0A[=20=20=20=200.041269]=20..TIMER:=20=
vector=3D0x30=20apic1=3D0=20pin1=3D2=20apic2=3D-1=20pin2=3D-1=0A[=20=20=20=
=200.074288]=20TSC=20deadline=20timer=20enabled=0A[=20=20=20=200.074297]=20=
smpboot:=20CPU0:=20Intel(R)=20Celeron(R)=20CPU=20J3455=20@=201.50GHz=20=
(family:=200x6,=20model:=200x5c,=20stepping:=200x9)=0A[=20=20=20=20=
0.074304]=20Performance=20Events:=20PEBS=20fmt3+,=20Goldmont=20events,=20=
32-deep=20LBR,=20full-width=20counters,=20Intel=20PMU=20driver.=0A[=20=20=
=20=200.074333]=20...=20version:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=204=0A[=20=20=20=200.074334]=20...=20bit=20width:=20=20=20=20=20=20=20=
=20=20=20=20=20=20=2048=0A[=20=20=20=200.074335]=20...=20generic=20=
registers:=20=20=20=20=20=204=0A[=20=20=20=200.074336]=20...=20value=20=
mask:=20=20=20=20=20=20=20=20=20=20=20=20=200000ffffffffffff=0A[=20=20=20=
=200.074337]=20...=20max=20period:=20=20=20=20=20=20=20=20=20=20=20=20=20=
0000ffffffffffff=0A[=20=20=20=200.074338]=20...=20fixed-purpose=20=
events:=20=20=203=0A[=20=20=20=200.074339]=20...=20event=20mask:=20=20=20=
=20=20=20=20=20=20=20=20=20=20000000070000000f=0A[=20=20=20=200.075020]=20=
NMI=20watchdog:=20enabled=20on=20all=20CPUs,=20permanently=20consumes=20=
one=20hw-PMU=20counter.=0A[=20=20=20=200.075200]=20x86:=20Booting=20SMP=20=
configuration:=0A[=20=20=20=200.075203]=20....=20node=20=20#0,=20CPUs:=20=
=20=20=20=20=20#1=20#2=20#3=0A[=20=20=20=200.326691]=20x86:=20Booted=20=
up=201=20node,=204=20CPUs=0A[=20=20=20=200.326694]=20smpboot:=20Total=20=
of=204=20processors=20activated=20(11996.77=20BogoMIPS)=0A[=20=20=20=20=
0.328959]=20devtmpfs:=20initialized=0A[=20=20=20=200.329428]=20PM:=20=
Registering=20ACPI=20NVS=20region=20[mem=200x5d9aa000-0x5d9e0fff]=20=
(225280=20bytes)=0A[=20=20=20=200.329434]=20PM:=20Registering=20ACPI=20=
NVS=20region=20[mem=200x5e155000-0x5e155fff]=20(4096=20bytes)=0A[=20=20=20=
=200.329518]=20clocksource:=20jiffies:=20mask:=200xffffffff=20=
max_cycles:=200xffffffff,=20max_idle_ns:=206370867519511994=20ns=0A[=20=20=
=20=200.329559]=20xor:=20measuring=20software=20checksum=20speed=0A[=20=20=
=20=200.361898]=20=20=20=20prefetch64-sse:=20=207906.800=20MB/sec=0A[=20=20=
=20=200.395272]=20=20=20=20generic_sse:=20=206810.000=20MB/sec=0A[=20=20=20=
=200.395274]=20xor:=20using=20function:=20prefetch64-sse=20(7906.800=20=
MB/sec)=0A[=20=20=20=200.395301]=20pinctrl=20core:=20initialized=20=
pinctrl=20subsystem=0A[=20=20=20=200.395557]=20NET:=20Registered=20=
protocol=20family=2016=0A[=20=20=20=200.405298]=20cpuidle:=20using=20=
governor=20ladder=0A[=20=20=20=200.418654]=20cpuidle:=20using=20governor=20=
menu=0A[=20=20=20=200.418876]=20ACPI:=20bus=20type=20PCI=20registered=0A=
[=20=20=20=200.418980]=20PCI:=20MMCONFIG=20for=20domain=200000=20[bus=20=
00-ff]=20at=20[mem=200xe0000000-0xefffffff]=20(base=200xe0000000)=0A[=20=20=
=20=200.418984]=20PCI:=20MMCONFIG=20at=20[mem=200xe0000000-0xefffffff]=20=
reserved=20in=20E820=0A[=20=20=20=200.419003]=20PCI:=20Using=20=
configuration=20type=201=20for=20base=20access=0A[=20=20=20=200.488725]=20=
raid6:=20sse2x1=20=20=20gen()=20=203255=20MB/s=0A[=20=20=20=200.545459]=20=
raid6:=20sse2x1=20=20=20xor()=20=201936=20MB/s=0A[=20=20=20=200.602158]=20=
raid6:=20sse2x2=20=20=20gen()=20=203753=20MB/s=0A[=20=20=20=200.658911]=20=
raid6:=20sse2x2=20=20=20xor()=20=202320=20MB/s=0A[=20=20=20=200.715632]=20=
raid6:=20sse2x4=20=20=20gen()=20=204300=20MB/s=0A[=20=20=20=200.772341]=20=
raid6:=20sse2x4=20=20=20xor()=20=202089=20MB/s=0A[=20=20=20=200.772343]=20=
raid6:=20using=20algorithm=20sse2x4=20gen()=204300=20MB/s=0A[=20=20=20=20=
0.772344]=20raid6:=20....=20xor()=202089=20MB/s,=20rmw=20enabled=0A[=20=20=
=20=200.772346]=20raid6:=20using=20ssse3x2=20recovery=20algorithm=0A[=20=20=
=20=200.772414]=20ACPI:=20Added=20_OSI(Module=20Device)=0A[=20=20=20=20=
0.772416]=20ACPI:=20Added=20_OSI(Processor=20Device)=0A[=20=20=20=20=
0.772417]=20ACPI:=20Added=20_OSI(3.0=20_SCP=20Extensions)=0A[=20=20=20=20=
0.772418]=20ACPI:=20Added=20_OSI(Processor=20Aggregator=20Device)=0A[=20=20=
=20=200.773028]=20ACPI:=20Executed=203=20blocks=20of=20module-level=20=
executable=20AML=20code=0A[=20=20=20=200.783279]=20ACPI:=20Dynamic=20OEM=20=
Table=20Load:=0A[=20=20=20=200.783291]=20ACPI:=20SSDT=20=
0xFFFF88017AD93E00=20000102=20(v02=20PmRef=20=20Cpu0Cst=20=2000003001=20=
INTL=2020120913)=0A[=20=20=20=200.784016]=20ACPI:=20Dynamic=20OEM=20=
Table=20Load:=0A[=20=20=20=200.784026]=20ACPI:=20SSDT=20=
0xFFFF88017ADD6000=2000015F=20(v02=20PmRef=20=20ApIst=20=20=20=20=
00003000=20INTL=2020120913)=0A[=20=20=20=200.784428]=20ACPI:=20Dynamic=20=
OEM=20Table=20Load:=0A[=20=20=20=200.784437]=20ACPI:=20SSDT=20=
0xFFFF88017AD80600=2000008D=20(v02=20PmRef=20=20ApCst=20=20=20=20=
00003000=20INTL=2020120913)=0A[=20=20=20=200.786348]=20ACPI:=20=
Interpreter=20enabled=0A[=20=20=20=200.786384]=20ACPI:=20(supports=20S0=20=
S3=20S5)=0A[=20=20=20=200.786386]=20ACPI:=20Using=20IOAPIC=20for=20=
interrupt=20routing=0A[=20=20=20=200.786514]=20PCI:=20Using=20host=20=
bridge=20windows=20from=20ACPI;=20if=20necessary,=20use=20"pci=3Dnocrs"=20=
and=20report=20a=20bug=0A[=20=20=20=200.803643]=20ACPI:=20Power=20=
Resource=20[FN00]=20(on)=0A[=20=20=20=200.804893]=20ACPI:=20PCI=20Root=20=
Bridge=20[PCI0]=20(domain=200000=20[bus=2000-ff])=0A[=20=20=20=20=
0.804902]=20acpi=20PNP0A08:00:=20_OSC:=20OS=20supports=20[ExtendedConfig=20=
ASPM=20ClockPM=20Segments=20MSI]=0A[=20=20=20=200.805989]=20acpi=20=
PNP0A08:00:=20_OSC:=20OS=20now=20controls=20[PCIeHotplug=20PME=20AER=20=
PCIeCapability]=0A[=20=20=20=200.806258]=20PCI=20host=20bridge=20to=20=
bus=200000:00=0A[=20=20=20=200.806262]=20pci_bus=200000:00:=20root=20bus=20=
resource=20[io=20=200x0070-0x0077]=0A[=20=20=20=200.806265]=20pci_bus=20=
0000:00:=20root=20bus=20resource=20[io=20=200x0000-0x006f=20window]=0A[=20=
=20=20=200.806267]=20pci_bus=200000:00:=20root=20bus=20resource=20[io=20=20=
0x0078-0x0cf7=20window]=0A[=20=20=20=200.806269]=20pci_bus=200000:00:=20=
root=20bus=20resource=20[io=20=200x0d00-0xffff=20window]=0A[=20=20=20=20=
0.806272]=20pci_bus=200000:00:=20root=20bus=20resource=20[mem=20=
0x000a0000-0x000bffff=20window]=0A[=20=20=20=200.806274]=20pci_bus=20=
0000:00:=20root=20bus=20resource=20[mem=200x000c0000-0x000dffff=20=
window]=0A[=20=20=20=200.806276]=20pci_bus=200000:00:=20root=20bus=20=
resource=20[mem=200x000e0000-0x000fffff=20window]=0A[=20=20=20=20=
0.806278]=20pci_bus=200000:00:=20root=20bus=20resource=20[mem=20=
0x60000001-0x7fffffff=20window]=0A[=20=20=20=200.806281]=20pci_bus=20=
0000:00:=20root=20bus=20resource=20[mem=200x5f800001-0x5fffffff=20=
window]=0A[=20=20=20=200.806283]=20pci_bus=200000:00:=20root=20bus=20=
resource=20[mem=200x80000000-0xcfffffff=20window]=0A[=20=20=20=20=
0.806285]=20pci_bus=200000:00:=20root=20bus=20resource=20[mem=20=
0xe0000000-0xefffffff=20window]=0A[=20=20=20=200.806288]=20pci_bus=20=
0000:00:=20root=20bus=20resource=20[bus=2000-ff]=0A[=20=20=20=20=
0.806308]=20pci=200000:00:00.0:=20[8086:5af0]=20type=2000=20class=20=
0x060000=0A[=20=20=20=200.806786]=20pci=200000:00:02.0:=20[8086:5a85]=20=
type=2000=20class=200x030000=0A[=20=20=20=200.806804]=20pci=20=
0000:00:02.0:=20reg=200x10:=20[mem=200x90000000-0x90ffffff=2064bit]=0A[=20=
=20=20=200.806815]=20pci=200000:00:02.0:=20reg=200x18:=20[mem=20=
0x80000000-0x8fffffff=2064bit=20pref]=0A[=20=20=20=200.806824]=20pci=20=
0000:00:02.0:=20reg=200x20:=20[io=20=200xf000-0xf03f]=0A[=20=20=20=20=
0.807319]=20pci=200000:00:0e.0:=20[8086:5a98]=20type=2000=20class=20=
0x040300=0A[=20=20=20=200.807344]=20pci=200000:00:0e.0:=20reg=200x10:=20=
[mem=200x91310000-0x91313fff=2064bit]=0A[=20=20=20=200.807373]=20pci=20=
0000:00:0e.0:=20reg=200x20:=20[mem=200x91000000-0x910fffff=2064bit]=0A[=20=
=20=20=200.807438]=20pci=200000:00:0e.0:=20PME#=20supported=20from=20D0=20=
D3hot=20D3cold=0A[=20=20=20=200.807849]=20pci=200000:00:0e.0:=20System=20=
wakeup=20disabled=20by=20ACPI=0A[=20=20=20=200.807921]=20pci=20=
0000:00:0f.0:=20[8086:5a9a]=20type=2000=20class=200x078000=0A[=20=20=20=20=
0.807961]=20pci=200000:00:0f.0:=20reg=200x10:=20[mem=20=
0x9131b000-0x9131bfff=2064bit]=0A[=20=20=20=200.808094]=20pci=20=
0000:00:0f.0:=20PME#=20supported=20from=20D3hot=0A[=20=20=20=200.808493]=20=
pci=200000:00:12.0:=20[8086:5ae3]=20type=2000=20class=200x010601=0A[=20=20=
=20=200.808513]=20pci=200000:00:12.0:=20reg=200x10:=20[mem=20=
0x91314000-0x91315fff]=0A[=20=20=20=200.808524]=20pci=200000:00:12.0:=20=
reg=200x14:=20[mem=200x91318000-0x913180ff]=0A[=20=20=20=200.808534]=20=
pci=200000:00:12.0:=20reg=200x18:=20[io=20=200xf090-0xf097]=0A[=20=20=20=20=
0.808546]=20pci=200000:00:12.0:=20reg=200x1c:=20[io=20=200xf080-0xf083]=0A=
[=20=20=20=200.808556]=20pci=200000:00:12.0:=20reg=200x20:=20[io=20=20=
0xf060-0xf07f]=0A[=20=20=20=200.808566]=20pci=200000:00:12.0:=20reg=20=
0x24:=20[mem=200x91317000-0x913177ff]=0A[=20=20=20=200.808623]=20pci=20=
0000:00:12.0:=20PME#=20supported=20from=20D3hot=0A[=20=20=20=200.808992]=20=
pci=200000:00:13.0:=20[8086:5ad8]=20type=2001=20class=200x060400=0A[=20=20=
=20=200.809082]=20pci=200000:00:13.0:=20PME#=20supported=20from=20D0=20=
D3hot=20D3cold=0A[=20=20=20=200.809394]=20pci=200000:00:13.0:=20System=20=
wakeup=20disabled=20by=20ACPI=0A[=20=20=20=200.809458]=20pci=20=
0000:00:13.1:=20[8086:5ad9]=20type=2001=20class=200x060400=0A[=20=20=20=20=
0.809547]=20pci=200000:00:13.1:=20PME#=20supported=20from=20D0=20D3hot=20=
D3cold=0A[=20=20=20=200.809859]=20pci=200000:00:13.1:=20System=20wakeup=20=
disabled=20by=20ACPI=0A[=20=20=20=200.809922]=20pci=200000:00:13.2:=20=
[8086:5ada]=20type=2001=20class=200x060400=0A[=20=20=20=200.810010]=20=
pci=200000:00:13.2:=20PME#=20supported=20from=20D0=20D3hot=20D3cold=0A[=20=
=20=20=200.810330]=20pci=200000:00:13.2:=20System=20wakeup=20disabled=20=
by=20ACPI=0A[=20=20=20=200.810399]=20pci=200000:00:13.3:=20[8086:5adb]=20=
type=2001=20class=200x060400=0A[=20=20=20=200.810488]=20pci=20=
0000:00:13.3:=20PME#=20supported=20from=20D0=20D3hot=20D3cold=0A[=20=20=20=
=200.810801]=20pci=200000:00:13.3:=20System=20wakeup=20disabled=20by=20=
ACPI=0A[=20=20=20=200.810883]=20pci=200000:00:15.0:=20[8086:5aa8]=20type=20=
00=20class=200x0c0330=0A[=20=20=20=200.810907]=20pci=200000:00:15.0:=20=
reg=200x10:=20[mem=200x91300000-0x9130ffff=2064bit]=0A[=20=20=20=20=
0.810981]=20pci=200000:00:15.0:=20PME#=20supported=20from=20D3hot=20=
D3cold=0A[=20=20=20=200.811318]=20pci=200000:00:15.0:=20System=20wakeup=20=
disabled=20by=20ACPI=0A[=20=20=20=200.811440]=20pci=200000:00:1f.0:=20=
[8086:5ae8]=20type=2000=20class=200x060100=0A[=20=20=20=200.811938]=20=
pci=200000:00:1f.1:=20[8086:5ad4]=20type=2000=20class=200x0c0500=0A[=20=20=
=20=200.811993]=20pci=200000:00:1f.1:=20reg=200x10:=20[mem=20=
0x91316000-0x913160ff=2064bit]=0A[=20=20=20=200.812073]=20pci=20=
0000:00:1f.1:=20reg=200x20:=20[io=20=200xf040-0xf05f]=0A[=20=20=20=20=
0.812602]=20pci=200000:01:00.0:=20[10ec:8168]=20type=2000=20class=20=
0x020000=0A[=20=20=20=200.812627]=20pci=200000:01:00.0:=20reg=200x10:=20=
[io=20=200xe000-0xe0ff]=0A[=20=20=20=200.812663]=20pci=200000:01:00.0:=20=
reg=200x18:=20[mem=200x91204000-0x91204fff=2064bit]=0A[=20=20=20=20=
0.812684]=20pci=200000:01:00.0:=20reg=200x20:=20[mem=20=
0x91200000-0x91203fff=2064bit=20pref]=0A[=20=20=20=200.812704]=20pci=20=
0000:01:00.0:=20can't=20set=20Max=20Payload=20Size=20to=20256;=20if=20=
necessary,=20use=20"pci=3Dpcie_bus_safe"=20and=20report=20a=20bug=0A[=20=20=
=20=200.812811]=20pci=200000:01:00.0:=20supports=20D1=20D2=0A[=20=20=20=20=
0.812813]=20pci=200000:01:00.0:=20PME#=20supported=20from=20D0=20D1=20D2=20=
D3hot=20D3cold=0A[=20=20=20=200.812884]=20pci=200000:01:00.0:=20System=20=
wakeup=20disabled=20by=20ACPI=0A[=20=20=20=200.823764]=20pci=20=
0000:00:13.0:=20PCI=20bridge=20to=20[bus=2001]=0A[=20=20=20=200.823769]=20=
pci=200000:00:13.0:=20=20=20bridge=20window=20[io=20=200xe000-0xefff]=0A=
[=20=20=20=200.823774]=20pci=200000:00:13.0:=20=20=20bridge=20window=20=
[mem=200x91200000-0x912fffff]=0A[=20=20=20=200.823837]=20pci=20=
0000:00:13.1:=20PCI=20bridge=20to=20[bus=2002]=0A[=20=20=20=200.823920]=20=
pci=200000:03:00.0:=20[1b21:0612]=20type=2000=20class=200x010601=0A[=20=20=
=20=200.823945]=20pci=200000:03:00.0:=20reg=200x10:=20[io=20=20=
0xd050-0xd057]=0A[=20=20=20=200.823959]=20pci=200000:03:00.0:=20reg=20=
0x14:=20[io=20=200xd040-0xd043]=0A[=20=20=20=200.823972]=20pci=20=
0000:03:00.0:=20reg=200x18:=20[io=20=200xd030-0xd037]=0A[=20=20=20=20=
0.823986]=20pci=200000:03:00.0:=20reg=200x1c:=20[io=20=200xd020-0xd023]=0A=
[=20=20=20=200.824000]=20pci=200000:03:00.0:=20reg=200x20:=20[io=20=20=
0xd000-0xd01f]=0A[=20=20=20=200.824015]=20pci=200000:03:00.0:=20reg=20=
0x24:=20[mem=200x91100000-0x911001ff]=0A[=20=20=20=200.824157]=20pci=20=
0000:03:00.0:=20System=20wakeup=20disabled=20by=20ACPI=0A[=20=20=20=20=
0.833765]=20pci=200000:00:13.2:=20PCI=20bridge=20to=20[bus=2003]=0A[=20=20=
=20=200.833770]=20pci=200000:00:13.2:=20=20=20bridge=20window=20[io=20=20=
0xd000-0xdfff]=0A[=20=20=20=200.833775]=20pci=200000:00:13.2:=20=20=20=
bridge=20window=20[mem=200x91100000-0x911fffff]=0A[=20=20=20=200.833835]=20=
pci=200000:00:13.3:=20PCI=20bridge=20to=20[bus=2004]=0A[=20=20=20=20=
0.835611]=20ACPI:=20PCI=20Interrupt=20Link=20[LNKA]=20(IRQs=203=204=205=20=
6=2010=2011=2012=2014=20*15),=20disabled.=0A[=20=20=20=200.835716]=20=
ACPI:=20PCI=20Interrupt=20Link=20[LNKB]=20(IRQs=203=204=205=206=2010=20=
11=2012=2014=20*15),=20disabled.=0A[=20=20=20=200.835820]=20ACPI:=20PCI=20=
Interrupt=20Link=20[LNKC]=20(IRQs=203=204=205=206=2010=2011=2012=2014=20=
*15),=20disabled.=0A[=20=20=20=200.835922]=20ACPI:=20PCI=20Interrupt=20=
Link=20[LNKD]=20(IRQs=203=204=205=206=2010=2011=2012=2014=20*15),=20=
disabled.=0A[=20=20=20=200.836025]=20ACPI:=20PCI=20Interrupt=20Link=20=
[LNKE]=20(IRQs=203=204=205=206=2010=2011=2012=2014=20*15),=20disabled.=0A=
[=20=20=20=200.836128]=20ACPI:=20PCI=20Interrupt=20Link=20[LNKF]=20(IRQs=20=
3=204=205=206=2010=2011=2012=2014=20*15),=20disabled.=0A[=20=20=20=20=
0.836230]=20ACPI:=20PCI=20Interrupt=20Link=20[LNKG]=20(IRQs=203=204=205=20=
6=2010=2011=2012=2014=20*15),=20disabled.=0A[=20=20=20=200.836333]=20=
ACPI:=20PCI=20Interrupt=20Link=20[LNKH]=20(IRQs=203=204=205=206=2010=20=
11=2012=2014=20*15),=20disabled.=0A[=20=20=20=200.837519]=20ACPI:=20=
Enabled=204=20GPEs=20in=20block=2000=20to=207F=0A[=20=20=20=200.837822]=20=
pci=200000:00:02.0:=20vgaarb:=20setting=20as=20boot=20VGA=20device=0A[=20=
=20=20=200.837827]=20pci=200000:00:02.0:=20vgaarb:=20VGA=20device=20=
added:=20decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone=0A[=20=20=20=20=
0.837833]=20pci=200000:00:02.0:=20vgaarb:=20bridge=20control=20possible=0A=
[=20=20=20=200.837835]=20vgaarb:=20loaded=0A[=20=20=20=200.837979]=20=
SCSI=20subsystem=20initialized=0A[=20=20=20=200.838071]=20libata=20=
version=203.00=20loaded.=0A[=20=20=20=200.838107]=20ACPI:=20bus=20type=20=
USB=20registered=0A[=20=20=20=200.838142]=20usbcore:=20registered=20new=20=
interface=20driver=20usbfs=0A[=20=20=20=200.838162]=20usbcore:=20=
registered=20new=20interface=20driver=20hub=0A[=20=20=20=200.838195]=20=
usbcore:=20registered=20new=20device=20driver=20usb=0A[=20=20=20=20=
0.838242]=20pps_core:=20LinuxPPS=20API=20ver.=201=20registered=0A[=20=20=20=
=200.838243]=20pps_core:=20Software=20ver.=205.3.6=20-=20Copyright=20=
2005-2007=20Rodolfo=20Giometti=20<giometti@linux.it>=0A[=20=20=20=20=
0.838247]=20PTP=20clock=20support=20registered=0A[=20=20=20=200.838311]=20=
Registered=20efivars=20operations=0A[=20=20=20=200.866324]=20Advanced=20=
Linux=20Sound=20Architecture=20Driver=20Initialized.=0A[=20=20=20=20=
0.866325]=20PCI:=20Using=20ACPI=20for=20IRQ=20routing=0A[=20=20=20=20=
0.894545]=20PCI:=20pci_cache_line_size=20set=20to=2064=20bytes=0A[=20=20=20=
=200.894623]=20e820:=20reserve=20RAM=20buffer=20[mem=20=
0x0003f000-0x0003ffff]=0A[=20=20=20=200.894625]=20e820:=20reserve=20RAM=20=
buffer=20[mem=200x0009e000-0x0009ffff]=0A[=20=20=20=200.894627]=20e820:=20=
reserve=20RAM=20buffer=20[mem=200x567e7018-0x57ffffff]=0A[=20=20=20=20=
0.894628]=20e820:=20reserve=20RAM=20buffer=20[mem=20=
0x567f6018-0x57ffffff]=0A[=20=20=20=200.894630]=20e820:=20reserve=20RAM=20=
buffer=20[mem=200x5b4d8000-0x5bffffff]=0A[=20=20=20=200.894631]=20e820:=20=
reserve=20RAM=20buffer=20[mem=200x5d9aa000-0x5fffffff]=0A[=20=20=20=20=
0.894633]=20e820:=20reserve=20RAM=20buffer=20[mem=20=
0x5e155000-0x5fffffff]=0A[=20=20=20=200.894635]=20e820:=20reserve=20RAM=20=
buffer=20[mem=200x5e757000-0x5fffffff]=0A[=20=20=20=200.894637]=20e820:=20=
reserve=20RAM=20buffer=20[mem=200x5f000000-0x5fffffff]=0A[=20=20=20=20=
0.894962]=20clocksource:=20Switched=20to=20clocksource=20hpet=0A[=20=20=20=
=200.895088]=20pnp:=20PnP=20ACPI=20init=0A[=20=20=20=200.895523]=20=
system=2000:00:=20[io=20=200x0280-0x028f]=20has=20been=20reserved=0A[=20=20=
=20=200.895526]=20system=2000:00:=20[io=20=200x0290-0x029f]=20has=20been=20=
reserved=0A[=20=20=20=200.895528]=20system=2000:00:=20[io=20=20=
0x02a0-0x02af]=20has=20been=20reserved=0A[=20=20=20=200.895535]=20system=20=
00:00:=20Plug=20and=20Play=20ACPI=20device,=20IDs=20PNP0c02=20(active)=0A=
[=20=20=20=200.896060]=20pnp=2000:01:=20[dma=200=20disabled]=0A[=20=20=20=
=200.896150]=20pnp=2000:01:=20Plug=20and=20Play=20ACPI=20device,=20IDs=20=
PNP0501=20(active)=0A[=20=20=20=200.896246]=20system=2000:02:=20Plug=20=
and=20Play=20ACPI=20device,=20IDs=20PNP0c02=20(active)=0A[=20=20=20=20=
0.897028]=20system=2000:03:=20[io=20=200x0680-0x069f]=20has=20been=20=
reserved=0A[=20=20=20=200.897031]=20system=2000:03:=20[io=20=20=
0x0400-0x047f]=20has=20been=20reserved=0A[=20=20=20=200.897034]=20system=20=
00:03:=20[io=20=200x0500-0x05fe]=20has=20been=20reserved=0A[=20=20=20=20=
0.897038]=20system=2000:03:=20Plug=20and=20Play=20ACPI=20device,=20IDs=20=
PNP0c02=20(active)=0A[=20=20=20=200.897613]=20system=2000:04:=20[mem=20=
0xe0000000-0xefffffff]=20has=20been=20reserved=0A[=20=20=20=200.897616]=20=
system=2000:04:=20[mem=200xfea00000-0xfeafffff]=20has=20been=20reserved=0A=
[=20=20=20=200.897619]=20system=2000:04:=20[mem=200xfed01000-0xfed01fff]=20=
has=20been=20reserved=0A[=20=20=20=200.897621]=20system=2000:04:=20[mem=20=
0xfed03000-0xfed03fff]=20has=20been=20reserved=0A[=20=20=20=200.897624]=20=
system=2000:04:=20[mem=200xfed06000-0xfed06fff]=20has=20been=20reserved=0A=
[=20=20=20=200.897627]=20system=2000:04:=20[mem=200xfed08000-0xfed09fff]=20=
has=20been=20reserved=0A[=20=20=20=200.897629]=20system=2000:04:=20[mem=20=
0xfed80000-0xfedbffff]=20has=20been=20reserved=0A[=20=20=20=200.897632]=20=
system=2000:04:=20[mem=200xfed1c000-0xfed1cfff]=20has=20been=20reserved=0A=
[=20=20=20=200.897635]=20system=2000:04:=20[mem=200xfee00000-0xfeefffff]=20=
could=20not=20be=20reserved=0A[=20=20=20=200.897639]=20system=2000:04:=20=
Plug=20and=20Play=20ACPI=20device,=20IDs=20PNP0c02=20(active)=0A[=20=20=20=
=200.897865]=20pnp=2000:05:=20Plug=20and=20Play=20ACPI=20device,=20IDs=20=
PNP0b00=20(active)=0A[=20=20=20=200.898152]=20pnp:=20PnP=20ACPI:=20found=20=
6=20devices=0A[=20=20=20=200.907996]=20clocksource:=20acpi_pm:=20mask:=20=
0xffffff=20max_cycles:=200xffffff,=20max_idle_ns:=202085701024=20ns=0A[=20=
=20=20=200.908056]=20pci=200000:00:13.0:=20PCI=20bridge=20to=20[bus=20=
01]=0A[=20=20=20=200.908060]=20pci=200000:00:13.0:=20=20=20bridge=20=
window=20[io=20=200xe000-0xefff]=0A[=20=20=20=200.908067]=20pci=20=
0000:00:13.0:=20=20=20bridge=20window=20[mem=200x91200000-0x912fffff]=0A=
[=20=20=20=200.908076]=20pci=200000:00:13.1:=20PCI=20bridge=20to=20[bus=20=
02]=0A[=20=20=20=200.908087]=20pci=200000:00:13.2:=20PCI=20bridge=20to=20=
[bus=2003]=0A[=20=20=20=200.908091]=20pci=200000:00:13.2:=20=20=20bridge=20=
window=20[io=20=200xd000-0xdfff]=0A[=20=20=20=200.908096]=20pci=20=
0000:00:13.2:=20=20=20bridge=20window=20[mem=200x91100000-0x911fffff]=0A=
[=20=20=20=200.908104]=20pci=200000:00:13.3:=20PCI=20bridge=20to=20[bus=20=
04]=0A[=20=20=20=200.908117]=20pci_bus=200000:00:=20resource=204=20[io=20=
=200x0070-0x0077]=0A[=20=20=20=200.908120]=20pci_bus=200000:00:=20=
resource=205=20[io=20=200x0000-0x006f=20window]=0A[=20=20=20=200.908122]=20=
pci_bus=200000:00:=20resource=206=20[io=20=200x0078-0x0cf7=20window]=0A[=20=
=20=20=200.908124]=20pci_bus=200000:00:=20resource=207=20[io=20=20=
0x0d00-0xffff=20window]=0A[=20=20=20=200.908127]=20pci_bus=200000:00:=20=
resource=208=20[mem=200x000a0000-0x000bffff=20window]=0A[=20=20=20=20=
0.908129]=20pci_bus=200000:00:=20resource=209=20[mem=20=
0x000c0000-0x000dffff=20window]=0A[=20=20=20=200.908131]=20pci_bus=20=
0000:00:=20resource=2010=20[mem=200x000e0000-0x000fffff=20window]=0A[=20=20=
=20=200.908134]=20pci_bus=200000:00:=20resource=2011=20[mem=20=
0x60000001-0x7fffffff=20window]=0A[=20=20=20=200.908136]=20pci_bus=20=
0000:00:=20resource=2012=20[mem=200x5f800001-0x5fffffff=20window]=0A[=20=20=
=20=200.908138]=20pci_bus=200000:00:=20resource=2013=20[mem=20=
0x80000000-0xcfffffff=20window]=0A[=20=20=20=200.908141]=20pci_bus=20=
0000:00:=20resource=2014=20[mem=200xe0000000-0xefffffff=20window]=0A[=20=20=
=20=200.908143]=20pci_bus=200000:01:=20resource=200=20[io=20=20=
0xe000-0xefff]=0A[=20=20=20=200.908146]=20pci_bus=200000:01:=20resource=20=
1=20[mem=200x91200000-0x912fffff]=0A[=20=20=20=200.908148]=20pci_bus=20=
0000:03:=20resource=200=20[io=20=200xd000-0xdfff]=0A[=20=20=20=20=
0.908150]=20pci_bus=200000:03:=20resource=201=20[mem=20=
0x91100000-0x911fffff]=0A[=20=20=20=200.908368]=20NET:=20Registered=20=
protocol=20family=202=0A[=20=20=20=200.908608]=20TCP=20established=20=
hash=20table=20entries:=2032768=20(order:=206,=20262144=20bytes)=0A[=20=20=
=20=200.908810]=20TCP=20bind=20hash=20table=20entries:=2032768=20(order:=20=
7,=20524288=20bytes)=0A[=20=20=20=200.909083]=20TCP:=20Hash=20tables=20=
configured=20(established=2032768=20bind=2032768)=0A[=20=20=20=20=
0.909141]=20UDP=20hash=20table=20entries:=202048=20(order:=204,=2065536=20=
bytes)=0A[=20=20=20=200.909196]=20UDP-Lite=20hash=20table=20entries:=20=
2048=20(order:=204,=2065536=20bytes)=0A[=20=20=20=200.909328]=20NET:=20=
Registered=20protocol=20family=201=0A[=20=20=20=200.909539]=20RPC:=20=
Registered=20named=20UNIX=20socket=20transport=20module.=0A[=20=20=20=20=
0.909540]=20RPC:=20Registered=20udp=20transport=20module.=0A[=20=20=20=20=
0.909541]=20RPC:=20Registered=20tcp=20transport=20module.=0A[=20=20=20=20=
0.909542]=20RPC:=20Registered=20tcp=20NFSv4.1=20backchannel=20transport=20=
module.=0A[=20=20=20=200.909564]=20pci=200000:00:02.0:=20Video=20device=20=
with=20shadowed=20ROM=20at=20[mem=200x000c0000-0x000dffff]=0A[=20=20=20=20=
0.909614]=20pci=200000:00:15.0:=20enabling=20device=20(0000=20->=200002)=0A=
[=20=20=20=200.910019]=20PCI:=20CLS=200=20bytes,=20default=2064=0A[=20=20=
=20=200.985513]=20PCI-DMA:=20Using=20software=20bounce=20buffering=20for=20=
IO=20(SWIOTLB)=0A[=20=20=20=200.985521]=20software=20IO=20TLB=20[mem=20=
0x527e6000-0x567e6000]=20(64MB)=20mapped=20at=20=
[ffff8800527e6000-ffff8800567e5fff]=0A[=20=20=20=200.985769]=20RAPL=20=
PMU:=20API=20unit=20is=202^-32=20Joules,=204=20fixed=20counters,=20=
655360=20ms=20ovfl=20timer=0A[=20=20=20=200.985771]=20RAPL=20PMU:=20hw=20=
unit=20of=20domain=20pp0-core=202^-14=20Joules=0A[=20=20=20=200.985772]=20=
RAPL=20PMU:=20hw=20unit=20of=20domain=20package=202^-14=20Joules=0A[=20=20=
=20=200.985773]=20RAPL=20PMU:=20hw=20unit=20of=20domain=20dram=202^-14=20=
Joules=0A[=20=20=20=200.985774]=20RAPL=20PMU:=20hw=20unit=20of=20domain=20=
pp1-gpu=202^-14=20Joules=0A[=20=20=20=200.986279]=20Scanning=20for=20low=20=
memory=20corruption=20every=2060=20seconds=0A[=20=20=20=200.986645]=20=
futex=20hash=20table=20entries:=201024=20(order:=204,=2065536=20bytes)=0A=
[=20=20=20=200.987068]=20workingset:=20timestamp_bits=3D40=20=
max_order=3D20=20bucket_order=3D0=0A[=20=20=20=200.990634]=20squashfs:=20=
version=204.0=20(2009/01/31)=20Phillip=20Lougher=0A[=20=20=20=20=
0.990928]=20NFS:=20Registering=20the=20id_resolver=20key=20type=0A[=20=20=
=20=200.990941]=20Key=20type=20id_resolver=20registered=0A[=20=20=20=20=
0.990942]=20Key=20type=20id_legacy=20registered=0A[=20=20=20=200.990946]=20=
nfs4filelayout_init:=20NFSv4=20File=20Layout=20Driver=20Registering...=0A=
[=20=20=20=200.993630]=20Block=20layer=20SCSI=20generic=20(bsg)=20driver=20=
version=200.4=20loaded=20(major=20250)=0A[=20=20=20=200.993633]=20io=20=
scheduler=20noop=20registered=0A[=20=20=20=200.993720]=20io=20scheduler=20=
cfq=20registered=20(default)=0A[=20=20=20=200.995035]=20pcieport=20=
0000:00:13.0:=20Signaling=20PME=20through=20PCIe=20PME=20interrupt=0A[=20=
=20=20=200.995038]=20pci=200000:01:00.0:=20Signaling=20PME=20through=20=
PCIe=20PME=20interrupt=0A[=20=20=20=200.995042]=20pcie_pme=20=
0000:00:13.0:pcie001:=20service=20driver=20pcie_pme=20loaded=0A[=20=20=20=
=200.995072]=20pcieport=200000:00:13.1:=20Signaling=20PME=20through=20=
PCIe=20PME=20interrupt=0A[=20=20=20=200.995076]=20pcie_pme=20=
0000:00:13.1:pcie001:=20service=20driver=20pcie_pme=20loaded=0A[=20=20=20=
=200.995112]=20pcieport=200000:00:13.2:=20Signaling=20PME=20through=20=
PCIe=20PME=20interrupt=0A[=20=20=20=200.995114]=20pci=200000:03:00.0:=20=
Signaling=20PME=20through=20PCIe=20PME=20interrupt=0A[=20=20=20=20=
0.995119]=20pcie_pme=200000:00:13.2:pcie001:=20service=20driver=20=
pcie_pme=20loaded=0A[=20=20=20=200.995149]=20pcieport=200000:00:13.3:=20=
Signaling=20PME=20through=20PCIe=20PME=20interrupt=0A[=20=20=20=20=
0.995153]=20pcie_pme=200000:00:13.3:pcie001:=20service=20driver=20=
pcie_pme=20loaded=0A[=20=20=20=200.995184]=20efifb:=20probing=20for=20=
efifb=0A[=20=20=20=200.995210]=20efifb:=20framebuffer=20at=200x80000000,=20=
using=203072k,=20total=203072k=0A[=20=20=20=200.995211]=20efifb:=20mode=20=
is=201024x768x32,=20linelength=3D4096,=20pages=3D1=0A[=20=20=20=20=
0.995212]=20efifb:=20scrolling:=20redraw=0A[=20=20=20=200.995214]=20=
efifb:=20Truecolor:=20size=3D8:8:8:8,=20shift=3D24:16:8:0=0A[=20=20=20=20=
0.999882]=20Console:=20switching=20to=20colour=20frame=20buffer=20device=20=
128x48=0A[=20=20=20=201.004356]=20fb0:=20EFI=20VGA=20frame=20buffer=20=
device=0A[=20=20=20=201.004369]=20intel_idle:=20MWAIT=20substates:=20=
0x11242020=0A[=20=20=20=201.004371]=20intel_idle:=20v0.4.1=20model=20=
0x5C=0A[=20=20=20=201.004774]=20intel_idle:=20=
lapic_timer_reliable_states=200xffffffff=0A[=20=20=20=201.004883]=20=
input:=20Power=20Button=20as=20=
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0=0A[=20=20=20=20=
1.004888]=20ACPI:=20Power=20Button=20[PWRB]=0A[=20=20=20=201.008763]=20=
thermal=20LNXTHERM:00:=20registered=20as=20thermal_zone0=0A[=20=20=20=20=
1.008765]=20ACPI:=20Thermal=20Zone=20[TZ01]=20(39=20C)=0A[=20=20=20=20=
1.009024]=20Serial:=208250/16550=20driver,=204=20ports,=20IRQ=20sharing=20=
disabled=0A[=20=20=20=201.029885]=2000:01:=20ttyS0=20at=20I/O=200x3f8=20=
(irq=20=3D=204,=20base_baud=20=3D=20115200)=20is=20a=2016550A=0A[=20=20=20=
=201.030864]=20[drm]=20Initialized=0A[=20=20=20=201.031452]=20[drm]=20=
Memory=20usable=20by=20graphics=20device=20=3D=204096M=0A[=20=20=20=20=
1.031455]=20checking=20generic=20(80000000=20300000)=20vs=20hw=20=
(80000000=2010000000)=0A[=20=20=20=201.031457]=20fb:=20switching=20to=20=
inteldrmfb=20from=20EFI=20VGA=0A[=20=20=20=201.031497]=20Console:=20=
switching=20to=20colour=20dummy=20device=2080x25=0A[=20=20=20=20=
1.031695]=20[drm]=20Replacing=20VGA=20console=20driver=0A[=20=20=20=20=
1.032059]=20[drm]=20Supports=20vblank=20timestamp=20caching=20Rev=202=20=
(21.10.2013).=0A[=20=20=20=201.032060]=20[drm]=20Driver=20supports=20=
precise=20vblank=20timestamp=20query.=0A[=20=20=20=201.034761]=20[drm]=20=
Finished=20loading=20i915/bxt_dmc_ver1_07.bin=20(v1.7)=0A[=20=20=20=20=
1.035204]=20i915=200000:00:02.0:=20vgaarb:=20changed=20VGA=20decodes:=20=
olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem=0A[=20=20=20=20=
1.998337]=20tsc:=20Refined=20TSC=20clocksource=20calibration:=201497.599=20=
MHz=0A[=20=20=20=201.998349]=20clocksource:=20tsc:=20mask:=20=
0xffffffffffffffff=20max_cycles:=200x1596467b3e4,=20max_idle_ns:=20=
440795260276=20ns=0A[=20=20=20=202.024334]=20[drm]=20failed=20to=20=
retrieve=20link=20info,=20disabling=20eDP=0A[=20=20=20=202.045784]=20=
[drm]=20GuC=20firmware=20load=20skipped=0A[=20=20=20=202.066401]=20=
random:=20fast=20init=20done=0A[=20=20=20=202.090391]=20ACPI:=20Video=20=
Device=20[GFX0]=20(multi-head:=20yes=20=20rom:=20no=20=20post:=20no)=0A[=20=
=20=20=202.091278]=20acpi=20device:10:=20registered=20as=20=
cooling_device5=0A[=20=20=20=202.091381]=20input:=20Video=20Bus=20as=20=
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input1=0A[=20=
=20=20=202.091435]=20[drm]=20Initialized=20i915=201.6.0=2020161108=20for=20=
0000:00:02.0=20on=20minor=200=0A[=20=20=20=202.093802]=20------------[=20=
cut=20here=20]------------=0A[=20=20=20=202.093812]=20WARNING:=20CPU:=20=
0=20PID:=206=20at=20drivers/gpu/drm/i915/intel_dp.c:4068=20=
intel_dp_check_link_status+0x1a5/0x1d0=0A[=20=20=20=202.093813]=20=
WARN_ON_ONCE(!intel_dp->lane_count)=0A[=20=20=20=202.093815]=20Modules=20=
linked=20in:=0A[=20=20=20=202.093820]=20CPU:=200=20PID:=206=20Comm:=20=
kworker/u8:0=20Not=20tainted=204.9.0-rc5+=20#1=0A[=20=20=20=202.093822]=20=
Hardware=20name:=20To=20Be=20Filled=20By=20O.E.M.=20To=20Be=20Filled=20=
By=20O.E.M./J3455-ITX,=20BIOS=20P1.10=2009/29/2016=0A[=20=20=20=20=
2.093827]=20Workqueue:=20events_unbound=20async_run_entry_fn=0A[=20=20=20=
=202.093830]=20=200000000000000000=20ffffffff8138d075=20ffff88017b337c88=20=
0000000000000000=0A[=20=20=20=202.093834]=20=20ffffffff8104ac94=20=
ffff88017a6fc0f0=20ffff88017b337cd8=20ffff88017a6fc000=0A[=20=20=20=20=
2.093838]=20=20ffff88017a750258=20ffff88017a6fc0f0=20ffff88017a6fc000=20=
ffffffff8104acfb=0A[=20=20=20=202.093842]=20Call=20Trace:=0A[=20=20=20=20=
2.093849]=20=20[<ffffffff8138d075>]=20?=20dump_stack+0x5c/0x77=0A[=20=20=20=
=202.093852]=20=20[<ffffffff8104ac94>]=20?=20__warn+0xb4/0xd0=0A[=20=20=20=
=202.093855]=20=20[<ffffffff8104acfb>]=20?=20warn_slowpath_fmt+0x4b/0x50=0A=
[=20=20=20=202.093858]=20=20[<ffffffff81473cfb>]=20?=20=
drm_dp_dpcd_read+0x4b/0x60=0A[=20=20=20=202.093861]=20=20=
[<ffffffff81537715>]=20?=20intel_dp_check_link_status+0x1a5/0x1d0=0A[=20=20=
=20=202.093865]=20=20[<ffffffff8153d3b7>]=20?=20=
intel_dp_detect+0x5c7/0xa10=0A[=20=20=20=202.093868]=20=20=
[<ffffffff81474921>]=20?=20=
drm_helper_probe_single_connector_modes+0x3f1/0x4d0=0A[=20=20=20=20=
2.093871]=20=20[<ffffffff8148299a>]=20?=20=
drm_fb_helper_initial_config+0x7a/0x410=0A[=20=20=20=202.093874]=20=20=
[<ffffffff8107e719>]=20?=20pick_next_task_fair+0x139/0x480=0A[=20=20=20=20=
2.093878]=20=20[<ffffffff8152ef5f>]=20?=20=
intel_fbdev_initial_config+0xf/0x20=0A[=20=20=20=202.093881]=20=20=
[<ffffffff810677dd>]=20?=20async_run_entry_fn+0x2d/0xe0=0A[=20=20=20=20=
2.093884]=20=20[<ffffffff8105f687>]=20?=20process_one_work+0x137/0x410=0A=
[=20=20=20=202.093886]=20=20[<ffffffff8105f9a6>]=20?=20=
worker_thread+0x46/0x4e0=0A[=20=20=20=202.093889]=20=20=
[<ffffffff8105f960>]=20?=20process_one_work+0x410/0x410=0A[=20=20=20=20=
2.093892]=20=20[<ffffffff8106504a>]=20?=20kthread+0xba/0xd0=0A[=20=20=20=20=
2.093895]=20=20[<ffffffff81064f90>]=20?=20kthread_park+0x50/0x50=0A[=20=20=
=20=202.093899]=20=20[<ffffffff8196a405>]=20?=20ret_from_fork+0x25/0x30=0A=
[=20=20=20=202.093905]=20---[=20end=20trace=20e3370de1682602bf=20]---=0A=
[=20=20=20=202.095648]=20brd:=20module=20loaded=0A[=20=20=20=202.095697]=20=
loop:=20module=20loaded=0A[=20=20=20=202.097681]=20fbcon:=20inteldrmfb=20=
(fb0)=20is=20primary=20device=0A[=20=20=20=202.099762]=20nbd:=20=
registered=20device=20at=20major=2043=0A[=20=20=20=202.102509]=20=
usbcore:=20registered=20new=20interface=20driver=20rtsx_usb=0A[=20=20=20=20=
2.102524]=20Loading=20iSCSI=20transport=20class=20v2.0-870.=0A[=20=20=20=20=
2.102740]=20iscsi:=20registered=20transport=20(tcp)=0A[=20=20=20=20=
2.102742]=20megasas:=2006.811.02.00-rc1=0A[=20=20=20=202.103006]=20ahci=20=
0000:00:12.0:=20version=203.0=0A[=20=20=20=202.103018]=20ahci=20=
0000:00:12.0:=20enabling=20device=20(0000=20->=200003)=0A[=20=20=20=20=
2.103306]=20ahci=200000:00:12.0:=20AHCI=200001.0301=2032=20slots=202=20=
ports=206=20Gbps=200x3=20impl=20SATA=20mode=0A[=20=20=20=202.103310]=20=
ahci=200000:00:12.0:=20flags:=2064bit=20ncq=20sntf=20clo=20only=20pmp=20=
pio=20slum=20part=20deso=20sadm=20sds=20apst=20=0A[=20=20=20=202.104049]=20=
scsi=20host0:=20ahci=0A[=20=20=20=202.104537]=20scsi=20host1:=20ahci=0A[=20=
=20=20=202.104618]=20ata1:=20SATA=20max=20UDMA/133=20abar=20=
m2048@0x91317000=20port=200x91317100=20irq=2019=0A[=20=20=20=202.104622]=20=
ata2:=20SATA=20max=20UDMA/133=20abar=20m2048@0x91317000=20port=20=
0x91317180=20irq=2019=0A[=20=20=20=202.104792]=20ahci=200000:03:00.0:=20=
SSS=20flag=20set,=20parallel=20bus=20scan=20disabled=0A[=20=20=20=20=
2.104856]=20ahci=200000:03:00.0:=20AHCI=200001.0200=2032=20slots=202=20=
ports=206=20Gbps=200x3=20impl=20SATA=20mode=0A[=20=20=20=202.104860]=20=
ahci=200000:03:00.0:=20flags:=2064bit=20ncq=20sntf=20stag=20led=20clo=20=
pmp=20pio=20slum=20part=20ccc=20=0A[=20=20=20=202.105563]=20scsi=20=
host2:=20ahci=0A[=20=20=20=202.105908]=20scsi=20host3:=20ahci=0A[=20=20=20=
=202.105976]=20ata3:=20SATA=20max=20UDMA/133=20abar=20m512@0x91100000=20=
port=200x91100100=20irq=2020=0A[=20=20=20=202.105980]=20ata4:=20SATA=20=
max=20UDMA/133=20abar=20m512@0x91100000=20port=200x91100180=20irq=2020=0A=
[=20=20=20=202.106523]=20tun:=20Universal=20TUN/TAP=20device=20driver,=20=
1.6=0A[=20=20=20=202.106524]=20tun:=20(C)=201999-2004=20Max=20=
Krasnyansky=20<maxk@qualcomm.com>=0A[=20=20=20=202.106693]=20pcnet32:=20=
pcnet32.c:v1.35=2021.Apr.2008=20tsbogend@alpha.franken.de=0A[=20=20=20=20=
2.106722]=20Atheros(R)=20L2=20Ethernet=20Driver=20-=20version=202.2.3=0A=
[=20=20=20=202.106723]=20Copyright=20(c)=202007=20Atheros=20Corporation.=0A=
[=20=20=20=202.106826]=20cnic:=20QLogic=20cnicDriver=20v2.5.22=20(July=20=
20,=202015)=0A[=20=20=20=202.106934]=20uli526x:=20ULi=20M5261/M5263=20=
net=20driver,=20version=200.9.3=20(2005-7-29)=0A[=20=20=20=202.106952]=20=
e100:=20Intel(R)=20PRO/100=20Network=20Driver,=203.5.24-k2-NAPI=0A[=20=20=
=20=202.106953]=20e100:=20Copyright(c)=201999-2006=20Intel=20Corporation=0A=
[=20=20=20=202.106971]=20e1000:=20Intel(R)=20PRO/1000=20Network=20Driver=20=
-=20version=207.3.21-k8-NAPI=0A[=20=20=20=202.106972]=20e1000:=20=
Copyright=20(c)=201999-2006=20Intel=20Corporation.=0A[=20=20=20=20=
2.106994]=20e1000e:=20Intel(R)=20PRO/1000=20Network=20Driver=20-=20=
3.2.6-k=0A[=20=20=20=202.106995]=20e1000e:=20Copyright(c)=201999=20-=20=
2015=20Intel=20Corporation.=0A[=20=20=20=202.107017]=20igb:=20Intel(R)=20=
Gigabit=20Ethernet=20Network=20Driver=20-=20version=205.4.0-k=0A[=20=20=20=
=202.107018]=20igb:=20Copyright=20(c)=202007-2014=20Intel=20Corporation.=0A=
[=20=20=20=202.107036]=20ixgbe:=20Intel(R)=2010=20Gigabit=20PCI=20=
Express=20Network=20Driver=20-=20version=204.4.0-k=0A[=20=20=20=20=
2.107037]=20ixgbe:=20Copyright=20(c)=201999-2016=20Intel=20Corporation.=0A=
[=20=20=20=202.107187]=20ixgb:=20Intel(R)=20PRO/10GbE=20Network=20Driver=20=
-=20version=201.0.135-k2-NAPI=0A[=20=20=20=202.107188]=20ixgb:=20=
Copyright=20(c)=201999-2008=20Intel=20Corporation.=0A[=20=20=20=20=
2.107208]=20jme:=20JMicron=20JMC2XX=20ethernet=20driver=20version=20=
1.0.8=0A[=20=20=20=202.107243]=20sky2:=20driver=20version=201.30=0A[=20=20=
=20=202.107329]=20r8169=20Gigabit=20Ethernet=20driver=202.3LK-NAPI=20=
loaded=0A[=20=20=20=202.115993]=20r8169=200000:01:00.0=20eth0:=20=
RTL8168g/8111g=20at=200xffffc900007fc000,=2070:85:c2:21:0e:91,=20XID=20=
0c000800=20IRQ=20125=0A[=20=20=20=202.115996]=20r8169=200000:01:00.0=20=
eth0:=20jumbo=20features=20[frames:=209200=20bytes,=20tx=20checksumming:=20=
ko]=0A[=20=20=20=202.116150]=20ehci_hcd:=20USB=202.0=20'Enhanced'=20Host=20=
Controller=20(EHCI)=20Driver=0A[=20=20=20=202.116151]=20ehci-pci:=20EHCI=20=
PCI=20platform=20driver=0A[=20=20=20=202.116170]=20ohci_hcd:=20USB=201.1=20=
'Open'=20Host=20Controller=20(OHCI)=20Driver=0A[=20=20=20=202.116177]=20=
ohci-pci:=20OHCI=20PCI=20platform=20driver=0A[=20=20=20=202.116191]=20=
uhci_hcd:=20USB=20Universal=20Host=20Controller=20Interface=20driver=0A[=20=
=20=20=202.116446]=20xhci_hcd=200000:00:15.0:=20xHCI=20Host=20Controller=0A=
[=20=20=20=202.116455]=20xhci_hcd=200000:00:15.0:=20new=20USB=20bus=20=
registered,=20assigned=20bus=20number=201=0A[=20=20=20=202.117614]=20=
xhci_hcd=200000:00:15.0:=20hcc=20params=200x200077c1=20hci=20version=20=
0x100=20quirks=200x01009810=0A[=20=20=20=202.117623]=20xhci_hcd=20=
0000:00:15.0:=20cache=20line=20size=20of=2064=20is=20not=20supported=0A[=20=
=20=20=202.117996]=20hub=201-0:1.0:=20USB=20hub=20found=0A[=20=20=20=20=
2.118013]=20hub=201-0:1.0:=208=20ports=20detected=0A[=20=20=20=20=
2.119226]=20xhci_hcd=200000:00:15.0:=20xHCI=20Host=20Controller=0A[=20=20=
=20=202.119232]=20xhci_hcd=200000:00:15.0:=20new=20USB=20bus=20=
registered,=20assigned=20bus=20number=202=0A[=20=20=20=202.119469]=20hub=20=
2-0:1.0:=20USB=20hub=20found=0A[=20=20=20=202.119490]=20hub=202-0:1.0:=20=
7=20ports=20detected=0A[=20=20=20=202.120603]=20usbcore:=20registered=20=
new=20interface=20driver=20uas=0A[=20=20=20=202.120630]=20usbcore:=20=
registered=20new=20interface=20driver=20usb-storage=0A[=20=20=20=20=
2.120679]=20i8042:=20PNP:=20No=20PS/2=20controller=20found.=20Probing=20=
ports=20directly.=0A[=20=20=20=202.124123]=20serio:=20i8042=20KBD=20port=20=
at=200x60,0x64=20irq=201=0A[=20=20=20=202.124131]=20serio:=20i8042=20AUX=20=
port=20at=200x60,0x64=20irq=2012=0A[=20=20=20=202.124409]=20mousedev:=20=
PS/2=20mouse=20device=20common=20for=20all=20mice=0A[=20=20=20=20=
2.124937]=20rtc_cmos=2000:05:=20RTC=20can=20wake=20from=20S4=0A[=20=20=20=
=202.125533]=20rtc_cmos=2000:05:=20rtc=20core:=20registered=20rtc_cmos=20=
as=20rtc0=0A[=20=20=20=202.125627]=20rtc_cmos=2000:05:=20alarms=20up=20=
to=20one=20month,=20y3k,=20242=20bytes=20nvram,=20hpet=20irqs=0A[=20=20=20=
=202.125644]=20i2c=20/dev=20entries=20driver=0A[=20=20=20=202.126151]=20=
i801_smbus=200000:00:1f.1:=20can't=20derive=20routing=20for=20PCI=20INT=20=
A=0A[=20=20=20=202.126153]=20i801_smbus=200000:00:1f.1:=20PCI=20INT=20A:=20=
not=20connected=0A[=20=20=20=202.126178]=20i801_smbus=200000:00:1f.1:=20=
SPD=20Write=20Disable=20is=20set=0A[=20=20=20=202.126202]=20i801_smbus=20=
0000:00:1f.1:=20Failed=20to=20allocate=20irq=20-2147483648:=20-107=0A[=20=
=20=20=202.126203]=20i801_smbus=200000:00:1f.1:=20SMBus=20using=20=
polling=0A[=20=20=20=202.126923]=20intel_pstate:=20Intel=20P-state=20=
driver=20initializing=0A[=20=20=20=202.127303]=20sdhci:=20Secure=20=
Digital=20Host=20Controller=20Interface=20driver=0A[=20=20=20=20=
2.127304]=20sdhci:=20Copyright(c)=20Pierre=20Ossman=0A[=20=20=20=20=
2.127369]=20No=20iBFT=20detected.=0A[=20=20=20=202.127372]=20EFI=20=
Variables=20Facility=20v0.08=202004-May-17=0A[=20=20=20=202.160025]=20=
hidraw:=20raw=20HID=20events=20driver=20(C)=20Jiri=20Kosina=0A[=20=20=20=20=
2.160330]=20usbcore:=20registered=20new=20interface=20driver=20usbhid=0A=
[=20=20=20=202.160331]=20usbhid:=20USB=20HID=20core=20driver=0A[=20=20=20=
=202.160765]=20NET:=20Registered=20protocol=20family=2010=0A[=20=20=20=20=
2.161224]=20NET:=20Registered=20protocol=20family=2017=0A[=20=20=20=20=
2.161253]=20Key=20type=20dns_resolver=20registered=0A[=20=20=20=20=
2.161434]=20microcode:=20sig=3D0x506c9,=20pf=3D0x1,=20revision=3D0x1c=0A=
[=20=20=20=202.161728]=20microcode:=20Microcode=20Update=20Driver:=20=
v2.01=20<tigran@aivazian.fsnet.co.uk>,=20Peter=20Oruba=0A[=20=20=20=20=
2.162882]=20Btrfs=20loaded,=20crc32c=3Dcrc32c-generic=0A[=20=20=20=20=
2.180392]=20Console:=20switching=20to=20colour=20frame=20buffer=20device=20=
240x67=0A[=20=20=20=202.200630]=20i915=200000:00:02.0:=20fb0:=20=
inteldrmfb=20frame=20buffer=20device=0A[=20=20=20=202.200700]=20console=20=
[netcon0]=20enabled=0A[=20=20=20=202.200701]=20netconsole:=20network=20=
logging=20started=0A[=20=20=20=202.200898]=20rtc_cmos=2000:05:=20setting=20=
system=20clock=20to=202016-11-20=2013:31:03=20UTC=20(1479648663)=0A[=20=20=
=20=202.201067]=20ALSA=20device=20list:=0A[=20=20=20=202.201069]=20=20=20=
No=20soundcards=20found.=0A[=20=20=20=202.415068]=20ata3:=20SATA=20link=20=
down=20(SStatus=200=20SControl=20300)=0A[=20=20=20=202.415083]=20ata1:=20=
SATA=20link=20down=20(SStatus=204=20SControl=20300)=0A[=20=20=20=20=
2.415228]=20ata2:=20SATA=20link=20down=20(SStatus=204=20SControl=20300)=0A=
[=20=20=20=202.438432]=20usb=201-3:=20new=20low-speed=20USB=20device=20=
number=202=20using=20xhci_hcd=0A[=20=20=20=202.592185]=20input:=20=
PHILIPS=20OVU710023=20as=20=
/devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/0003:0471:2168.0001/inpu=
t/input5=0A[=20=20=20=202.649510]=20hid-generic=200003:0471:2168.0001:=20=
input,hiddev0,hidraw0:=20USB=20HID=20v1.11=20Keyboard=20[PHILIPS=20=
OVU710023]=20on=20usb-0000:00:15.0-3/input0=0A[=20=20=20=202.761761]=20=
usb=201-4:=20new=20low-speed=20USB=20device=20number=203=20using=20=
xhci_hcd=0A[=20=20=20=202.881766]=20ata4:=20SATA=20link=20up=203.0=20=
Gbps=20(SStatus=20123=20SControl=20300)=0A[=20=20=20=202.882482]=20=
ata4.00:=20ATA-8:=20Goldendisk=20GDSA-16GB,=2020121211,=20max=20UDMA/133=0A=
[=20=20=20=202.882487]=20ata4.00:=2030916608=20sectors,=20multi=200:=20=
LBA48=20=0A[=20=20=20=202.883469]=20ata4.00:=20configured=20for=20=
UDMA/133=0A[=20=20=20=202.883898]=20scsi=203:0:0:0:=20Direct-Access=20=20=
=20=20=20ATA=20=20=20=20=20=20Goldendisk=20GDSA-=201211=20PQ:=200=20=
ANSI:=205=0A[=20=20=20=202.903601]=20input:=20Dell=20Dell=20USB=20=
Keyboard=20as=20=
/devices/pci0000:00/0000:00:15.0/usb1/1-4/1-4:1.0/0003:413C:2003.0002/inpu=
t/input6=0A[=20=20=20=202.918961]=20sd=203:0:0:0:=20Attached=20scsi=20=
generic=20sg0=20type=200=0A[=20=20=20=202.918976]=20sd=203:0:0:0:=20=
[sda]=2030916608=20512-byte=20logical=20blocks:=20(15.8=20GB/14.7=20GiB)=0A=
[=20=20=20=202.919251]=20sd=203:0:0:0:=20[sda]=20Write=20Protect=20is=20=
off=0A[=20=20=20=202.919258]=20sd=203:0:0:0:=20[sda]=20Mode=20Sense:=20=
00=203a=2000=2000=0A[=20=20=20=202.919492]=20sd=203:0:0:0:=20[sda]=20=
Write=20cache:=20enabled,=20read=20cache:=20enabled,=20doesn't=20support=20=
DPO=20or=20FUA=0A[=20=20=20=202.923580]=20=20sda:=20sda1=20sda2=0A[=20=20=
=20=202.924607]=20sd=203:0:0:0:=20[sda]=20Attached=20SCSI=20disk=0A[=20=20=
=20=202.932657]=20Freeing=20unused=20kernel=20memory:=204068K=20=
(ffffffff82ec9000=20-=20ffffffff832c2000)=0A[=20=20=20=202.932660]=20=
Write=20protecting=20the=20kernel=20read-only=20data:=2030720k=0A[=20=20=20=
=202.933623]=20Freeing=20unused=20kernel=20memory:=20568K=20=
(ffff880001972000=20-=20ffff880001a00000)=0A[=20=20=20=202.938695]=20=
Freeing=20unused=20kernel=20memory:=201184K=20(ffff880002cd8000=20-=20=
ffff880002e00000)=0A[=20=20=20=202.966465]=20hid-generic=20=
0003:413C:2003.0002:=20input,hidraw1:=20USB=20HID=20v1.10=20Keyboard=20=
[Dell=20Dell=20USB=20Keyboard]=20on=20usb-0000:00:15.0-4/input0=0A[=20=20=
=20=203.012098]=20clocksource:=20Switched=20to=20clocksource=20tsc=0A[=20=
=20=20=203.078326]=20usb=201-6:=20new=20full-speed=20USB=20device=20=
number=204=20using=20xhci_hcd=0A[=20=20=20=203.217798]=20input:=20=
Microsoft=20Microsoft=C2=AE=20Nano=20Transceiver=20v2.0=20as=20=
/devices/pci0000:00/0000:00:15.0/usb1/1-6/1-6:1.0/0003:045E:0745.0003/inpu=
t/input7=0A[=20=20=20=203.272103]=20hid-generic=200003:045E:0745.0003:=20=
input,hidraw2:=20USB=20HID=20v1.11=20Keyboard=20[Microsoft=20Microsoft=C2=AE=
=20Nano=20Transceiver=20v2.0]=20on=20usb-0000:00:15.0-6/input0=0A[=20=20=20=
=203.278494]=20input:=20Microsoft=20Microsoft=C2=AE=20Nano=20Transceiver=20=
v2.0=20as=20=
/devices/pci0000:00/0000:00:15.0/usb1/1-6/1-6:1.1/0003:045E:0745.0004/inpu=
t/input8=0A[=20=20=20=203.331945]=20[drm]=20RC6=20on=0A[=20=20=20=20=
3.335629]=20hid-generic=200003:045E:0745.0004:=20input,hidraw3:=20USB=20=
HID=20v1.11=20Mouse=20[Microsoft=20Microsoft=C2=AE=20Nano=20Transceiver=20=
v2.0]=20on=20usb-0000:00:15.0-6/input1=0A[=20=20=20=203.351815]=20input:=20=
Microsoft=20Microsoft=C2=AE=20Nano=20Transceiver=20v2.0=20as=20=
/devices/pci0000:00/0000:00:15.0/usb1/1-6/1-6:1.2/0003:045E:0745.0005/inpu=
t/input9=0A[=20=20=20=203.408743]=20hid-generic=200003:045E:0745.0005:=20=
input,hiddev0,hidraw4:=20USB=20HID=20v1.11=20Device=20[Microsoft=20=
Microsoft=C2=AE=20Nano=20Transceiver=20v2.0]=20on=20=
usb-0000:00:15.0-6/input2=0A[=20=20=20=204.252487]=20EXT4-fs=20(sda2):=20=
couldn't=20mount=20as=20ext3=20due=20to=20feature=20incompatibilities=0A=
[=20=20=20=204.252780]=20EXT4-fs=20(sda2):=20couldn't=20mount=20as=20=
ext2=20due=20to=20feature=20incompatibilities=0A[=20=20=20=204.259664]=20=
EXT4-fs=20(sda2):=20mounted=20filesystem=20with=20ordered=20data=20mode.=20=
Opts:=20(null)=0A[=20=20=20=206.672696]=20systemd[1]:=20systemd=20230=20=
running=20in=20system=20mode.=20(-PAM=20-AUDIT=20-SELINUX=20-IMA=20=
-APPARMOR=20-SMACK=20-SYSVINIT=20-UTMP=20-LIBCRYPTSETUP=20-GCRYPT=20=
-GNUTLS=20-ACL=20-XZ=20-LZ4=20-SECCOMP=20+BLKID=20-ELFUTILS=20+KMOD=20=
-IDN)=0A[=20=20=20=206.672958]=20systemd[1]:=20Detected=20architecture=20=
x86-64.=0A[=20=20=20=206.673104]=20systemd[1]:=20Set=20hostname=20to=20=
<LibreELEC>.=0A[=20=20=20=206.696759]=20systemd[1]:=20Configuration=20=
file=20/storage/.config/system.d/storage-videos.mount=20is=20marked=20=
executable.=20Please=20remove=20executable=20permission=20bits.=20=
Proceeding=20anyway.=0A[=20=20=20=206.697588]=20systemd[1]:=20=
Configuration=20file=20/storage/.config/system.d/storage-tvshows.mount=20=
is=20marked=20executable.=20Please=20remove=20executable=20permission=20=
bits.=20Proceeding=20anyway.=0A[=20=20=20=206.697958]=20systemd[1]:=20=
storage-tvshows.mount:=20Where=3D=20setting=20doesn't=20match=20unit=20=
name.=20Refusing.=0A[=20=20=20=206.698174]=20systemd[1]:=20=
storage-tvshows.mount:=20Cannot=20add=20dependency=20job,=20ignoring:=20=
Unit=20storage-tvshows.mount=20is=20not=20loaded=20properly:=20Invalid=20=
argument.=0A[=20=20=20=206.698796]=20systemd[1]:=20Listening=20on=20=
/dev/initctl=20Compatibility=20Named=20Pipe.=0A[=20=20=20=206.698917]=20=
systemd[1]:=20Listening=20on=20Journal=20Socket.=0A[=20=20=20=20=
6.698979]=20systemd[1]:=20Started=20Dispatch=20Password=20Requests=20to=20=
Console=20Directory=20Watch.=0A[=20=20=20=206.765346]=20=
systemd-journald[226]:=20Received=20request=20to=20flush=20runtime=20=
journal=20from=20PID=201=0A[=20=20=20=206.832371]=20random:=20crng=20=
init=20done=0A[=20=20=20=207.206810]=20snd_soc_skl=200000:00:0e.0:=20=
bound=200000:00:02.0=20(ops=200xffffffff81aa4ec0)=0A[=20=20=20=20=
7.213760]=20snd_soc_skl=200000:00:0e.0:=20No=20matching=20machine=20=
driver=20found=0A[=20=20=20=207.217582]=20r8169=200000:01:00.0=20eth0:=20=
link=20down=0A[=20=20=20=207.217604]=20r8169=200000:01:00.0=20eth0:=20=
link=20down=0A[=20=20=20=207.217757]=20IPv6:=20ADDRCONF(NETDEV_UP):=20=
eth0:=20link=20is=20not=20ready=0A[=20=20=20=207.219024]=20snd_hda_intel=20=
0000:00:0e.0:=20bound=200000:00:02.0=20(ops=200xffffffff81aa4ec0)=0A[=20=20=
=20=207.249400]=20snd_hda_codec_realtek=20hdaudioC0D0:=20autoconfig=20=
for=20ALC892:=20line_outs=3D3=20(0x14/0x15/0x16/0x0/0x0)=20type:line=0A[=20=
=20=20=207.249403]=20snd_hda_codec_realtek=20hdaudioC0D0:=20=20=20=20=
speaker_outs=3D0=20(0x0/0x0/0x0/0x0/0x0)=0A[=20=20=20=207.249405]=20=
snd_hda_codec_realtek=20hdaudioC0D0:=20=20=20=20hp_outs=3D1=20=
(0x1b/0x0/0x0/0x0/0x0)=0A[=20=20=20=207.249407]=20snd_hda_codec_realtek=20=
hdaudioC0D0:=20=20=20=20mono:=20mono_out=3D0x0=0A[=20=20=20=207.249408]=20=
snd_hda_codec_realtek=20hdaudioC0D0:=20=20=20=20dig-out=3D0x1e/0x0=0A[=20=
=20=20=207.249409]=20snd_hda_codec_realtek=20hdaudioC0D0:=20=20=20=20=
inputs:=0A[=20=20=20=207.249412]=20snd_hda_codec_realtek=20hdaudioC0D0:=20=
=20=20=20=20=20Front=20Mic=3D0x19=0A[=20=20=20=207.249413]=20=
snd_hda_codec_realtek=20hdaudioC0D0:=20=20=20=20=20=20Rear=20Mic=3D0x18=0A=
[=20=20=20=207.249415]=20snd_hda_codec_realtek=20hdaudioC0D0:=20=20=20=20=
=20=20Line=3D0x1a=0A[=20=20=20=207.257578]=20intel_rapl:=20Found=20RAPL=20=
domain=20package=0A[=20=20=20=207.257582]=20intel_rapl:=20Found=20RAPL=20=
domain=20core=0A[=20=20=20=207.257586]=20intel_rapl:=20Found=20RAPL=20=
domain=20uncore=0A[=20=20=20=207.257589]=20intel_rapl:=20Found=20RAPL=20=
domain=20dram=0A[=20=20=20=208.297497]=20input:=20HDA=20Digital=20PCBeep=20=
as=20/devices/pci0000:00/0000:00:0e.0/sound/card0/input10=0A[=20=20=20=20=
8.298265]=20input:=20HDA=20Intel=20PCH=20Front=20Mic=20as=20=
/devices/pci0000:00/0000:00:0e.0/sound/card0/input11=0A[=20=20=20=20=
8.298353]=20input:=20HDA=20Intel=20PCH=20Rear=20Mic=20as=20=
/devices/pci0000:00/0000:00:0e.0/sound/card0/input12=0A[=20=20=20=20=
8.298423]=20input:=20HDA=20Intel=20PCH=20Line=20as=20=
/devices/pci0000:00/0000:00:0e.0/sound/card0/input13=0A[=20=20=20=20=
8.298486]=20input:=20HDA=20Intel=20PCH=20Line=20Out=20Front=20as=20=
/devices/pci0000:00/0000:00:0e.0/sound/card0/input14=0A[=20=20=20=20=
8.298554]=20input:=20HDA=20Intel=20PCH=20Line=20Out=20Surround=20as=20=
/devices/pci0000:00/0000:00:0e.0/sound/card0/input15=0A[=20=20=20=20=
8.298648]=20input:=20HDA=20Intel=20PCH=20Line=20Out=20CLFE=20as=20=
/devices/pci0000:00/0000:00:0e.0/sound/card0/input16=0A[=20=20=20=20=
8.298715]=20input:=20HDA=20Intel=20PCH=20Front=20Headphone=20as=20=
/devices/pci0000:00/0000:00:0e.0/sound/card0/input17=0A[=20=20=20=20=
8.298795]=20input:=20HDA=20Intel=20PCH=20HDMI/DP,pcm=3D3=20as=20=
/devices/pci0000:00/0000:00:0e.0/sound/card0/input18=0A[=20=20=20=20=
8.298862]=20input:=20HDA=20Intel=20PCH=20HDMI/DP,pcm=3D7=20as=20=
/devices/pci0000:00/0000:00:0e.0/sound/card0/input19=0A[=20=20=20=20=
8.298929]=20input:=20HDA=20Intel=20PCH=20HDMI/DP,pcm=3D8=20as=20=
/devices/pci0000:00/0000:00:0e.0/sound/card0/input20=0A[=20=20=20=
10.165215]=20r8169=200000:01:00.0=20eth0:=20link=20up=0A[=20=20=20=
10.165233]=20IPv6:=20ADDRCONF(NETDEV_CHANGE):=20eth0:=20link=20becomes=20=
ready=0A[=20=20=2010.169830]=208021q:=20802.1Q=20VLAN=20Support=20v1.8=0A=
[=20=20=2011.989694]=20snd_hda_intel=200000:00:0e.0:=20IRQ=20timing=20=
workaround=20is=20activated=20for=20card=20#0.=20Suggest=20a=20bigger=20=
bdl_pos_adj.=0A=0A=
##########################################################################=
######=0A#=20...=20output=20of=20lsmod=0A#=20LibreELEC=20release:=20=
Generic.x86_64-devel-20161120=0A#=20LibreELEC=20git:=20=
2e3081a9304242b3d10c78d55f673dfd1824da0d=0A=
##########################################################################=
######=0AModule=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
Size=20=20Used=20by=0A8021q=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=2017727=20=200=0Asnd_hda_codec_hdmi=20=20=20=20=2033057=20=201=0A=
intel_rapl=20=20=20=20=20=20=20=20=20=20=20=20=2010176=20=200=0A=
snd_hda_codec_realtek=20=20=20=2056387=20=201=0Asnd_hda_codec_generic=20=20=
=20=2053990=20=201=20snd_hda_codec_realtek=0Asnd_hda_intel=20=20=20=20=20=
=20=20=20=20=2020580=20=203=0Asnd_hda_codec=20=20=20=20=20=20=20=20=20=20=
82254=20=204=20=
snd_hda_intel,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_codec_realt=
ek=0Asnd_hwdep=20=20=20=20=20=20=20=20=20=20=20=20=20=20=205418=20=201=20=
snd_hda_codec=0Asnd_soc_skl=20=20=20=20=20=20=20=20=20=20=20=2038434=20=20=
0=0Asnd_soc_sst_match=20=20=20=20=20=20=201426=20=201=20snd_soc_skl=0A=
snd_soc_skl_ipc=20=20=20=20=20=20=20=2024174=20=201=20snd_soc_skl=0A=
snd_soc_sst_ipc=20=20=20=20=20=20=20=20=203550=20=201=20snd_soc_skl_ipc=0A=
snd_soc_sst_dsp=20=20=20=20=20=20=20=20=205766=20=201=20snd_soc_skl_ipc=0A=
snd_hda_ext_core=20=20=20=20=20=20=20=209489=20=201=20snd_soc_skl=0A=
snd_hda_core=20=20=20=20=20=20=20=20=20=20=2043137=20=207=20=
snd_hda_intel,snd_hda_codec,snd_hda_ext_core,snd_soc_skl,snd_hda_codec_hdm=
i,snd_hda_codec_generic,snd_hda_codec_realtek=0Asnd_soc_rt286=20=20=20=20=
=20=20=20=20=20=2029641=20=200=0Asnd_soc_rt298=20=20=20=20=20=20=20=20=20=
=2029384=20=200=0Asnd_soc_rl6347a=20=20=20=20=20=20=20=20=201514=20=202=20=
snd_soc_rt298,snd_soc_rt286=0A=0A=
##########################################################################=
######=0A#=20...=20output=20of=20ps=20xa=0A#=20LibreELEC=20release:=20=
Generic.x86_64-devel-20161120=0A#=20LibreELEC=20git:=20=
2e3081a9304242b3d10c78d55f673dfd1824da0d=0A=
##########################################################################=
######=0APID=20=20=20USER=20=20=20=20=20TIME=20=20=20COMMAND=0A=20=20=20=20=
1=20root=20=20=20=20=20=20=200:01=20/usr/lib/systemd/systemd=0A=20=20=20=20=
2=20root=20=20=20=20=20=20=200:00=20[kthreadd]=0A=20=20=20=203=20root=20=20=
=20=20=20=20=200:00=20[ksoftirqd/0]=0A=20=20=20=204=20root=20=20=20=20=20=
=20=200:00=20[kworker/0:0]=0A=20=20=20=205=20root=20=20=20=20=20=20=20=
0:00=20[kworker/0:0H]=0A=20=20=20=206=20root=20=20=20=20=20=20=200:00=20=
[kworker/u8:0]=0A=20=20=20=207=20root=20=20=20=20=20=20=200:00=20=
[rcu_sched]=0A=20=20=20=208=20root=20=20=20=20=20=20=200:00=20[rcu_bh]=0A=
=20=20=20=209=20root=20=20=20=20=20=20=200:00=20[migration/0]=0A=20=20=20=
10=20root=20=20=20=20=20=20=200:00=20[lru-add-drain]=0A=20=20=2011=20=
root=20=20=20=20=20=20=200:00=20[watchdog/0]=0A=20=20=2012=20root=20=20=20=
=20=20=20=200:00=20[cpuhp/0]=0A=20=20=2013=20root=20=20=20=20=20=20=20=
0:00=20[cpuhp/1]=0A=20=20=2014=20root=20=20=20=20=20=20=200:00=20=
[watchdog/1]=0A=20=20=2015=20root=20=20=20=20=20=20=200:00=20=
[migration/1]=0A=20=20=2016=20root=20=20=20=20=20=20=200:00=20=
[ksoftirqd/1]=0A=20=20=2017=20root=20=20=20=20=20=20=200:00=20=
[kworker/1:0]=0A=20=20=2018=20root=20=20=20=20=20=20=200:00=20=
[kworker/1:0H]=0A=20=20=2019=20root=20=20=20=20=20=20=200:00=20[cpuhp/2]=0A=
=20=20=2020=20root=20=20=20=20=20=20=200:00=20[watchdog/2]=0A=20=20=2021=20=
root=20=20=20=20=20=20=200:00=20[migration/2]=0A=20=20=2022=20root=20=20=20=
=20=20=20=200:00=20[ksoftirqd/2]=0A=20=20=2023=20root=20=20=20=20=20=20=20=
0:00=20[kworker/2:0]=0A=20=20=2024=20root=20=20=20=20=20=20=200:00=20=
[kworker/2:0H]=0A=20=20=2025=20root=20=20=20=20=20=20=200:00=20[cpuhp/3]=0A=
=20=20=2026=20root=20=20=20=20=20=20=200:00=20[watchdog/3]=0A=20=20=2027=20=
root=20=20=20=20=20=20=200:00=20[migration/3]=0A=20=20=2028=20root=20=20=20=
=20=20=20=200:00=20[ksoftirqd/3]=0A=20=20=2029=20root=20=20=20=20=20=20=20=
0:00=20[kworker/3:0]=0A=20=20=2030=20root=20=20=20=20=20=20=200:00=20=
[kworker/3:0H]=0A=20=20=2031=20root=20=20=20=20=20=20=200:00=20=
[kdevtmpfs]=0A=20=20=2032=20root=20=20=20=20=20=20=200:00=20[netns]=0A=20=
=20=2033=20root=20=20=20=20=20=20=200:00=20[khungtaskd]=0A=20=20=2034=20=
root=20=20=20=20=20=20=200:00=20[oom_reaper]=0A=20=20=2035=20root=20=20=20=
=20=20=20=200:00=20[writeback]=0A=20=20=2036=20root=20=20=20=20=20=20=20=
0:00=20[kcompactd0]=0A=20=20=2037=20root=20=20=20=20=20=20=200:00=20=
[khugepaged]=0A=20=20=2038=20root=20=20=20=20=20=20=200:00=20[crypto]=0A=20=
=20=2039=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=2040=20root=20=
=20=20=20=20=20=200:00=20[kblockd]=0A=20=20=2041=20root=20=20=20=20=20=20=
=200:00=20[kworker/0:1]=0A=20=20=2042=20root=20=20=20=20=20=20=200:00=20=
[kworker/1:1]=0A=20=20=2043=20root=20=20=20=20=20=20=200:00=20[ata_sff]=0A=
=20=20=2044=20root=20=20=20=20=20=20=200:00=20[kworker/3:1]=0A=20=20=20=
45=20root=20=20=20=20=20=20=200:00=20[rpciod]=0A=20=20=2046=20root=20=20=20=
=20=20=20=200:00=20[xprtiod]=0A=20=20=2047=20root=20=20=20=20=20=20=20=
0:00=20[kswapd0]=0A=20=20=2048=20root=20=20=20=20=20=20=200:00=20=
[vmstat]=0A=20=20=2049=20root=20=20=20=20=20=20=200:00=20[nfsiod]=0A=20=20=
=2050=20root=20=20=20=20=20=20=200:00=20[cifsiod]=0A=20=20=2066=20root=20=
=20=20=20=20=20=200:00=20[acpi_thermal_pm]=0A=20=20=2067=20root=20=20=20=20=
=20=20=200:00=20[kworker/u8:1]=0A=20=20=2068=20root=20=20=20=20=20=20=20=
0:00=20[kworker/3:2]=0A=20=20=2069=20root=20=20=20=20=20=20=200:00=20=
[i915/signal:0]=0A=20=20=2070=20root=20=20=20=20=20=20=200:00=20=
[i915/signal:1]=0A=20=20=2071=20root=20=20=20=20=20=20=200:00=20=
[i915/signal:2]=0A=20=20=2072=20root=20=20=20=20=20=20=200:00=20=
[i915/signal:4]=0A=20=20=2073=20root=20=20=20=20=20=20=200:00=20=
[kworker/2:1]=0A=20=20=2074=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=
=20=20=2075=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=2076=20=
root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=2077=20root=20=20=20=20=
=20=20=200:00=20[bioset]=0A=20=20=2078=20root=20=20=20=20=20=20=200:00=20=
[bioset]=0A=20=20=2079=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=
=2080=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=2081=20root=20=20=
=20=20=20=20=200:00=20[bioset]=0A=20=20=2082=20root=20=20=20=20=20=20=20=
0:00=20[bioset]=0A=20=20=2083=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=
=20=20=2084=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=2085=20=
root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=2086=20root=20=20=20=20=
=20=20=200:00=20[bioset]=0A=20=20=2087=20root=20=20=20=20=20=20=200:00=20=
[bioset]=0A=20=20=2088=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=
=2089=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=2090=20root=20=20=
=20=20=20=20=200:00=20[bioset]=0A=20=20=2091=20root=20=20=20=20=20=20=20=
0:00=20[bioset]=0A=20=20=2092=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=
=20=20=2093=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=2094=20=
root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=2095=20root=20=20=20=20=
=20=20=200:00=20[bioset]=0A=20=20=2096=20root=20=20=20=20=20=20=200:00=20=
[bioset]=0A=20=20=2097=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=
=2098=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20=2099=20root=20=20=
=20=20=20=20=200:00=20[bioset]=0A=20=20100=20root=20=20=20=20=20=20=20=
0:00=20[bioset]=0A=20=20101=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=
=20=20102=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=20103=20root=20=
=20=20=20=20=20=200:00=20[bioset]=0A=20=20104=20root=20=20=20=20=20=20=20=
0:00=20[bioset]=0A=20=20105=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=
=20=20106=20root=20=20=20=20=20=20=200:00=20[iscsi_eh]=0A=20=20107=20=
root=20=20=20=20=20=20=200:00=20[nvme]=0A=20=20108=20root=20=20=20=20=20=20=
=200:00=20[scsi_eh_0]=0A=20=20109=20root=20=20=20=20=20=20=200:00=20=
[scsi_tmf_0]=0A=20=20110=20root=20=20=20=20=20=20=200:00=20[scsi_eh_1]=0A=
=20=20111=20root=20=20=20=20=20=20=200:00=20[scsi_tmf_1]=0A=20=20112=20=
root=20=20=20=20=20=20=200:00=20[kworker/u8:2]=0A=20=20113=20root=20=20=20=
=20=20=20=200:00=20[kworker/u8:3]=0A=20=20114=20root=20=20=20=20=20=20=20=
0:00=20[scsi_eh_2]=0A=20=20115=20root=20=20=20=20=20=20=200:00=20=
[scsi_tmf_2]=0A=20=20116=20root=20=20=20=20=20=20=200:00=20[scsi_eh_3]=0A=
=20=20117=20root=20=20=20=20=20=20=200:00=20[scsi_tmf_3]=0A=20=20118=20=
root=20=20=20=20=20=20=200:00=20[kworker/u8:4]=0A=20=20119=20root=20=20=20=
=20=20=20=200:00=20[kworker/u8:5]=0A=20=20120=20root=20=20=20=20=20=20=20=
0:00=20[cnic_wq]=0A=20=20121=20root=20=20=20=20=20=20=200:00=20[ixgbe]=0A=
=20=20122=20root=20=20=20=20=20=20=200:00=20[kworker/2:2]=0A=20=20123=20=
root=20=20=20=20=20=20=200:00=20[kworker/u8:6]=0A=20=20124=20root=20=20=20=
=20=20=20=200:00=20[ipv6_addrconf]=0A=20=20125=20root=20=20=20=20=20=20=20=
0:00=20[bioset]=0A=20=20126=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=
=20=20152=20root=20=20=20=20=20=20=200:00=20[kworker/3:1H]=0A=20=20155=20=
root=20=20=20=20=20=20=200:00=20[kworker/2:3]=0A=20=20157=20root=20=20=20=
=20=20=20=200:00=20[kworker/2:1H]=0A=20=20158=20root=20=20=20=20=20=20=20=
0:00=20[kworker/0:1H]=0A=20=20165=20root=20=20=20=20=20=20=200:00=20=
[jbd2/sda2-8]=0A=20=20166=20root=20=20=20=20=20=20=200:00=20=
[ext4-rsv-conver]=0A=20=20177=20root=20=20=20=20=20=20=200:00=20=
[kworker/1:1H]=0A=20=20179=20root=20=20=20=20=20=20=200:00=20[bioset]=0A=20=
=20180=20root=20=20=20=20=20=20=200:00=20[loop0]=0A=20=20218=20root=20=20=
=20=20=20=20=200:00=20[kworker/3:3]=0A=20=20223=20root=20=20=20=20=20=20=20=
0:00=20[kworker/0:2]=0A=20=20226=20root=20=20=20=20=20=20=200:00=20=
/usr/lib/systemd/systemd-journald=0A=20=20238=20root=20=20=20=20=20=20=20=
0:00=20[kworker/1:2]=0A=20=20252=20root=20=20=20=20=20=20=200:00=20=
/usr/lib/systemd/systemd-udevd=0A=20=20254=20root=20=20=20=20=20=20=20=
0:00=20/usr/lib/systemd/systemd-logind=0A=20=20268=20root=20=20=20=20=20=20=
=200:00=20/usr/sbin/eventlircd=20-f=20--evmap=3D/etc/eventlircd.d=20=
--socket=3D/run/lirc/lircd=20--release=3D_UP=0A=20=20270=20root=20=20=20=20=
=20=20=200:00=20/usr/bin/pulseaudio=20--system=0A=20=20272=20dbus=20=20=20=
=20=20=20=200:00=20/usr/bin/dbus-daemon=20--system=20--address=3Dsystemd:=20=
--nofork=20--nopidfile=20--systemd-activation=0A=20=20280=20root=20=20=20=
=20=20=20=200:00=20/sbin/crond=20-f=20-S=0A=20=20287=20root=20=20=20=20=20=
=20=200:00=20/usr/sbin/sshd=20-D=0A=20=20298=20root=20=20=20=20=20=20=20=
0:00=20/usr/sbin/connmand=20-nr=20--config=3D/etc/connman/main.conf=0A=20=
=20307=20avahi=20=20=20=20=20=200:00=20avahi-daemon:=20running=20=
[LibreELEC.local]=0A=20=20308=20root=20=20=20=20=20=20=200:00=20=
/usr/bin/rpcbind=0A=20=20312=20root=20=20=20=20=20=20=200:00=20=
/usr/sbin/unfsd=20-d=20-e=20/storage/.config/exports=0A=20=20321=20root=20=
=20=20=20=20=20=200:00=20/usr/bin/wpa_supplicant=20-u=0A=20=20352=20root=20=
=20=20=20=20=20=200:00=20/usr/bin/nmbd=20=
--configfile=3D/run/samba/smb.conf=0A=20=20356=20root=20=20=20=20=20=20=20=
0:00=20[kworker/1:3]=0A=20=20570=20root=20=20=20=20=20=20=200:00=20=
/usr/bin/smbd=20--configfile=3D/run/samba/smb.conf=0A=20=20575=20root=20=20=
=20=20=20=20=200:00=20[kworker/1:4]=0A=20=20721=20root=20=20=20=20=20=20=20=
0:00=20[lockd]=0A=20=20724=20root=20=20=20=20=20=20=200:00=20=
xorg-launch-helper=20-nolisten=20tcp=20vt01=20-s=200=20-noreset=20=
-allowMouseOpenFail=0A=20=20726=20root=20=20=20=20=20=20=200:00=20=
/usr/bin/Xorg=20-nolisten=20tcp=20vt01=20-s=200=20-noreset=20=
-allowMouseOpenFail=0A=20=20735=20root=20=20=20=20=20=20=200:00=20=
/usr/bin/fluxbox=0A=20=20740=20root=20=20=20=20=20=20=200:00=20{kodi.sh}=20=
/bin/sh=20/usr/lib/kodi/kodi.sh=20--standalone=20-fs=20--lircdev=20=
/run/lirc/lircd=0A=20=20745=20root=20=20=20=20=20=20=200:02=20=
/usr/lib/kodi/kodi.bin=20--standalone=20-fs=20--lircdev=20=
/run/lirc/lircd=0A=20=20799=20root=20=20=20=20=20=20=200:00=20=
/usr/bin/smbd=20--configfile=3D/run/samba/smb.conf=0A=20=20808=20root=20=20=
=20=20=20=20=200:00=20sh=20-c=20createlog=0A=20=20809=20root=20=20=20=20=20=
=20=200:00=20{createlog}=20/bin/sh=20/usr/bin/createlog=0A=20=20838=20=
root=20=20=20=20=20=20=200:00=20ps=20xa=0A=0A=
##########################################################################=
######=0A#=20...=20output=20of=20cat=20=
/storage/.config/modprobe.d/alsa-base.conf=0A#=20LibreELEC=20release:=20=
Generic.x86_64-devel-20161120=0A#=20LibreELEC=20git:=20=
2e3081a9304242b3d10c78d55f673dfd1824da0d=0A=
##########################################################################=
######=0Aoptions=20snd-hda-intel=20power_save=3D0=20=
power_save_controller=3DN=0A=0A=
##########################################################################=
######=0A#=20...=20output=20of=20cat=20=
/storage/.config/modprobe.d/disable-spdif-for-hd-audio.conf=0A#=20=
LibreELEC=20release:=20Generic.x86_64-devel-20161120=0A#=20LibreELEC=20=
git:=202e3081a9304242b3d10c78d55f673dfd1824da0d=0A=
##########################################################################=
######=0A#=20INTEL=20HBR=20WORKAROUND=20FOR=20DTS-MA=20&=20Dolby=20=
TrueHD=20PLAYBACK=0A=0A#=20Uncomment=20the=20following=20lines=20to=20=
disable=20any=20S/PDIF=20out=20to=20deliver=0A#=20bitstreamed=20audio=20=
on=20Intel=20builds.=20This=20is=20a=20rough=20workaround=20for=0A#=20=
users=20that=20have=20both=20S/PDIF=20and=20HDMI=20audio=20outputs=20on=20=
their=20motherboard=0A#=20or=20motherboard+discrete=20graphics=20combo.=0A=
=0A#=20EVEN=20IF=20YOU=20ARE=20NOT=20USING=20THE=20S/PDIF=20OUTPUT=0A#=20=
but=20still=20have=20one,=20you=20will=20need=20to=20uncomment=20the=20=
lines=20below=20!=0A=0A#=20after=20uncommenting=20these=20lines,=20you=20=
must=20reboot=20for=20these=20settings=20to=20take=20effect=0A=0A=
#blacklist=20snd_hda_codec_realtek=0A#blacklist=20snd_soc_skl=0A=
#blacklist=20snd_hda_codec_generic=0A#blacklist=20snd_hda_intel=0A#=20=
blacklist=20snd_hda_codec_sigmatel=0A#=20blacklist=20=
snd_hda_codec_cirrus=0A=0A#=20blacklist=20snd_soc_skl=0A=0A=0A=0A=0A=
##########################################################################=
######=0A#=20...=20output=20of=20cat=20=
/storage/.config/sysctl.d/transmission.conf=0A#=20LibreELEC=20release:=20=
Generic.x86_64-devel-20161120=0A#=20LibreELEC=20git:=20=
2e3081a9304242b3d10c78d55f673dfd1824da0d=0A=
##########################################################################=
######=0A#=20transmission=20with=20uTP=20support=0A#=20please=20comment=20=
out=20the=20follow=20line=20to=20activate=20this=20values:=0A=0A#=20=
net.core.wmem_max=3D1048576=0A#=20net.core.rmem_max=3D4194304=0A=0A=
##########################################################################=
######=0A#=20...=20output=20of=20ls=20-laR=20/storage/.config/system.d=0A=
#=20LibreELEC=20release:=20Generic.x86_64-devel-20161120=0A#=20LibreELEC=20=
git:=202e3081a9304242b3d10c78d55f673dfd1824da0d=0A=
##########################################################################=
######=0A/storage/.config/system.d:=0Atotal=2064=0Adrwxr-xr-x=20=20=20=20=
3=20root=20=20=20=20=20root=20=20=20=20=20=20=20=20=20=204096=20Nov=2019=20=
16:13=20.=0Adrwxr-xr-x=20=20=2014=20root=20=20=20=20=20root=20=20=20=20=20=
=20=20=20=20=204096=20Nov=2019=2022:12=20..=0A-rw-r--r--=20=20=20=201=20=
root=20=20=20=20=20root=20=20=20=20=20=20=20=20=2028816=20Oct=2026=20=
20:24=20README=0A-rw-r--r--=20=20=20=201=20root=20=20=20=20=20root=20=20=20=
=20=20=20=20=20=20=201772=20Oct=2026=2020:24=20cifs.mount.sample=0A=
drwxr-xr-x=20=20=20=202=20root=20=20=20=20=20root=20=20=20=20=20=20=20=20=
=20=204096=20Nov=2019=2016:07=20multi-user.target.wants=0A-rw-r--r--=20=20=
=20=201=20root=20=20=20=20=20root=20=20=20=20=20=20=20=20=20=201729=20=
Nov=2019=2016:13=20nfs.mount.sample=0A-rw-r--r--=20=20=20=201=20root=20=20=
=20=20=20root=20=20=20=20=20=20=20=20=20=201145=20Oct=2026=2020:24=20=
openvpn.service.sample=0A-rwxr--r--=20=20=20=201=20root=20=20=20=20=20=
root=20=20=20=20=20=20=20=20=20=201737=20Nov=2019=2016:06=20=
storage-tvshows.mount=0A-rwxr--r--=20=20=20=201=20root=20=20=20=20=20=
root=20=20=20=20=20=20=20=20=20=201736=20Nov=2019=2016:05=20=
storage-videos.mount=0A=0A=
/storage/.config/system.d/multi-user.target.wants:=0Atotal=208=0A=
drwxr-xr-x=20=20=20=202=20root=20=20=20=20=20root=20=20=20=20=20=20=20=20=
=20=204096=20Nov=2019=2016:07=20.=0Adrwxr-xr-x=20=20=20=203=20root=20=20=20=
=20=20root=20=20=20=20=20=20=20=20=20=204096=20Nov=2019=2016:13=20..=0A=
lrwxrwxrwx=20=20=20=201=20root=20=20=20=20=20root=20=20=20=20=20=20=20=20=
=20=20=20=2047=20Nov=2019=2016:07=20storage-tvshows.mount=20->=20=
/storage/.config/system.d/storage-tvshows.mount=0Alrwxrwxrwx=20=20=20=20=
1=20root=20=20=20=20=20root=20=20=20=20=20=20=20=20=20=20=20=2046=20Nov=20=
19=2016:07=20storage-videos.mount=20->=20=
/storage/.config/system.d/storage-videos.mount=0A=0A=

--Apple-Mail=_0DBD6A7A-BF2A-4EE5-9284-B23F64BD2CE0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



Thanks
For any help or info where i can raport bug

Best regards
Piotr Kasprzak
--Apple-Mail=_0DBD6A7A-BF2A-4EE5-9284-B23F64BD2CE0--
