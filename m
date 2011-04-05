From: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Subject: Re: Poulsbo I2C - /dev/i2c not seen when loading i2c-dev
Date: Tue, 5 Apr 2011 13:05:02 -0400
Message-ID: <b9ff3e86cbf2aa2c34f614adf80e7ffb.squirrel@host171.canaca.com>
References: <fb407773c6a76f3ffef06ff357df2118.squirrel@host171.canaca.com>
    <20110401121027.49ce012b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110401121027.49ce012b-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


>> The board is built around the Poulsbo and therefore using the 'i2c-i=
sch'
>> driver.
>
> Check for error messages when you load the i2c-isch driver. Note that
> in kernel 2.6.34 the structure of the i2c-isch driver was changed, fr=
om
> a standalone PCI driver to a MFD driver. Please make sure that you ha=
ve
> CONFIG_LPC_SCH installed and driver lpc_sch loaded, otherwise i2c-isc=
h
> will never see the platform device it is looking for.

Thanks for the suggestion, unfortunately there is an issue with lpc_sch
loading, and error is reported via dmesg.
--
[  403.809826] ACPI: resource (null) [io  0x0480-0x04bf] conflicts with
ACPI region PHO_ [io 0x4bc-0x4bc]
[  403.809834] ACPI: If an ACPI driver is available for this device, yo=
u
should use it instead of the native driver
[  403.809921] lpc_sch: probe of 0000:00:1f.0 failed with error -16
--
   34  rmmod i2c_isch
   35  rmmod lpc_sch
   36  rmmod i2c_gpio
   37  tree /sys/bus/i2c/
   38  modprobe i2c_isch
   39  modprobe i2c_gpio
   40  modprobe lpc_sch
   41  dmesg | tail
--

Any further suggestions would be much appreciated. The system reports t=
he
poulsbo under 'lspci' as:
--
00:1b.0 Audio device: Intel Corporation System Controller Hub (SCH
Poulsbo) HD Audio Controller (rev 07)
	Subsystem: Intel Corporation Device 8119
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dff5c000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI =
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0
<64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L0s Enabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D0 ArbSelect=3DFixed TC/VC=3D00
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=3D0f ComponentID=3D00 EltType=3DConfig
		Link0:	Desc:	TargetPort=3D00 TargetComponent=3D00 AssocRCRB-
LinkType=3DMemMapped LinkValid+
			Addr:	00000000f0000000
	Kernel driver in use: HDA Intel

00:1c.0 PCI bridge: Intel Corporation System Controller Hub (SCH Poulsb=
o)
PCI Express Port 1 (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: cfd00000-cfdfffff
	Prefetchable memory behind bridge: 80000000-801fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1
unlimited
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
<256ns, L1 <4us
			ClockPM+ Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [90] Subsystem: Intel Corporation Device 8119
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport

00:1d.0 USB Controller: Intel Corporation System Controller Hub (SCH
Poulsbo) USB UHCI #1 (rev 07) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Device 8119
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at e480 [size=3D32]
	Kernel driver in use: uhci_hcd

00:1d.1 USB Controller: Intel Corporation System Controller Hub (SCH
Poulsbo) USB UHCI #2 (rev 07) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Device 8119
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at e080 [size=3D32]
	Kernel driver in use: uhci_hcd

00:1d.2 USB Controller: Intel Corporation System Controller Hub (SCH
Poulsbo) USB UHCI #3 (rev 07) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Device 8119
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 22
	Region 4: I/O ports at ef00 [size=3D32]
	Kernel driver in use: uhci_hcd

00:1d.7 USB Controller: Intel Corporation System Controller Hub (SCH
Poulsbo) USB EHCI #1 (rev 07) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation Device 8119
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at dff5bc00 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Kernel driver in use: ehci_hcd

00:1f.0 ISA bridge: Intel Corporation System Controller Hub (SCH Poulsb=
o)
LPC Bridge (rev 07)
	Subsystem: Intel Corporation System Controller Hub (SCH Poulsbo) LPC B=
ridge
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt-
<MAbort- >SERR- <PERR- INTx-

00:1f.1 IDE interface: Intel Corporation System Controller Hub (SCH
Poulsbo) IDE Controller (rev 07) (prog-if 80 [Master])
	Subsystem: Intel Corporation Device 8119
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [siz=
e=3D8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [siz=
e=3D1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [siz=
e=3D8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [siz=
e=3D1]
	Region 4: I/O ports at ffa0 [size=3D16]
	Kernel driver in use: pata_sch
--



>> Reviewing the schematic I see that there are several buses, each goi=
ng
>> to
>> individual components:
>> IT8516 U5/110+111 -> LTC1760 U6/18+22 [battery charger =E2=80=93 0x1=
A/0x12]
>> IT8516 U5/115+116 -> W83L771 U60/8+7 [thermal sensor =E2=80=93 0x18?=
?]
>> IT8516 U5/117+118 -> LSM303DLH U64/19+20 [accel/compass =E2=80=93 0x=
19]
>> POULSBO U2/G37+H38 -> PCI Express Socket
>
> This suggests that the board uses the SMBus controllers in the ITE IT=
8516
> Super-I/O chip rather than the Intel SCH south bridge. Unfortunately =
we
> have no support for the SMBus controllers of the IT8516, and I doubt =
we
> get support anytime soon as I was unable to find a datasheet for the
> ITE IT8516.
>

I believe that Jean is correct, we have exchanged a few emails regardin=
g
the IT8516 SuperIO chip and have some ideas about getting some support.

Simon.
