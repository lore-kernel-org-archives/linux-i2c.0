From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 35572] New: eeprom module: modprobing hangs
Date: Wed, 1 Jun 2011 14:42:40 -0700
Message-ID: <20110601144240.9525825b.akpm@linux-foundation.org>
References: <bug-35572-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bug-35572-10286-3bo0kxnWaOQUvHkbgXJLS5sdmw4N0Rt+2LY78lusg7I@public.gmane.org/>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: markotahal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sat, 21 May 2011 20:17:32 GMT
bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=35572
> 
>            Summary: eeprom module: modprobing hangs
>            Product: Other
>            Version: 2.5
>     Kernel Version: 2.6.39
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Modules
>         AssignedTo: other_modules-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
>         ReportedBy: markotahal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>         Regression: No

This is drivers/misc/eeprom/eeprom.c?

That driver doesn't really have a maintainer.  Perhaps the i2c
developers can help debug this?

> 
> modbrobing eeprom module hangs, but does not crash the kernel. Occurs with
> 2.6.39, with 2.6.38 and prev works ok.

So 2.6.38 did not have this bug?

The driver didn't change between .38 and .39.

> Confirmed by other user, the bug
> reported in Arch can be found here: 
> https://bugs.archlinux.org/24376
> 
> my HW: 
> i686, archlinux kernel (no relevant patch, almost same as mainline :
> ftp://ftp.archlinux.org/other/kernel26/patch-2.6.39-1-ARCH.bz2 ), 
> 
> 
> part from dmesg when modprobing eeprom:
>  57.222509] tg3 0000:02:00.0: eth0: Flow control is on for TX and on for RX
> [   57.223449] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [   67.936739] eth0: no IPv6 routers present
> [   93.797133] ip_tables: (C) 2000-2006 Netfilter Core Team
> [   94.057661] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
> [  106.272909] EXT4-fs (sda4): re-mounted. Opts: commit=0
> [  106.957966] EXT4-fs (sda9): re-mounted. Opts: commit=0
> [  107.181605] EXT4-fs (sda2): re-mounted. Opts: commit=0
> [  107.331670] EXT4-fs (sda12): re-mounted. Opts: commit=0
> [  136.933416] [drm] GMBUS timed out, falling back to bit banging on pin 0
> [i915 gmbus disabled]
> [  136.986739] [drm] GMBUS timed out, falling back to bit banging on pin 0
> [i915 gmbus disabled]
> [  137.043440] [drm] GMBUS timed out, falling back to bit banging on pin 0
> [i915 gmbus disabled]
> [  137.096738] [drm] GMBUS timed out, falling back to bit banging on pin 0
> [i915 gmbus disabled]
> [  137.150067] [drm] GMBUS timed out, falling back to bit banging on pin 0
> [i915 gmbus disabled]
> [  137.203415] [drm] GMBUS timed out, falling back to bit banging on pin 0
> [i915 gmbus disabled]
> [  137.256761] [drm] GMBUS timed out, falling back to bit banging on pin 0
> [i915 gmbus disabled]
> [  137.310101] [drm] GMBUS timed out, falling back to bit banging on pin 0
> [i915 gmbus disabled]
> [  137.523400] [drm] GMBUS timed out, falling back to bit banging on pin 4
> [i915 gmbus dpc]
> [  178.299024] kwin_opengl_tes[3439]: segfault at 2c ip b70a5c48 sp bfb90520
> error 4 in i915_dri.so[b706c000+35b000]
> [  213.183783] process `skype' is using obsolete setsockopt SO_BSDCOMPAT
> 
> 
> 
> 
> lspci -vvv
> 00:00.0 Host bridge: Intel Corporation Mobile 945GME Express Memory Controller
> Hub (rev 03)
>         Subsystem: Lenovo Device 386f
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ >SERR- <PERR- INTx-
>         Latency: 0
>         Capabilities: [e0] Vendor Specific Information: Len=09 <?>
>         Kernel driver in use: agpgart-intel
>         Kernel modules: intel-agp
> 
> 00:02.0 VGA compatible controller: Intel Corporation Mobile 945GME Express
> Integrated Graphics Controller (rev 03) (prog-if 00 [VGA controller])
>         Subsystem: Lenovo Device 3870
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at f0300000 (32-bit, non-prefetchable) [size=512K]
>         Region 1: I/O ports at 1800 [size=8]
>         Region 2: Memory at d0000000 (32-bit, prefetchable) [size=256M]
>         Region 3: Memory at f0400000 (32-bit, non-prefetchable) [size=256K]
>         Expansion ROM at <unassigned> [disabled]
>         Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
>                 Address: 00000000  Data: 0000
>         Capabilities: [d0] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: i915
>         Kernel modules: i915
> 
> 00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/GME, 943/940GML
> Express Integrated Graphics Controller (rev 03)
>         Subsystem: Lenovo Device 3870
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Region 0: Memory at f0380000 (32-bit, non-prefetchable) [size=512K]
>         Capabilities: [d0] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition Audio
> Controller (rev 02)
>         Subsystem: Lenovo Device 3bf8
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 43
>         Region 0: Memory at f0440000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee0300c  Data: 4179
>         Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI
> 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
> L1 <1us
>                         ExtTag- RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #0, Speed unknown, Width x0, ASPM unknown, Latency
> L0 <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk-
> DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [100 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>                         Status: NegoPending- InProgress-
>                 VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=1 ArbSelect=Fixed TC/VC=80
>                         Status: NegoPending- InProgress-
>         Capabilities: [130 v1] Root Complex Link
>                 Desc:   PortNumber=0f ComponentID=02 EltType=Config
>                 Link0:  Desc:   TargetPort=00 TargetComponent=02 AssocRCRB-
> LinkType=MemMapped LinkValid+
>                         Addr:   00000000fed1c000
>         Kernel driver in use: HDA Intel
>         Kernel modules: snd-hda-intel
> 
> 00:1c.0 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 1 (rev
> 02) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>         I/O behind bridge: 00002000-00002fff
>         Memory behind bridge: f0100000-f01fffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f00fffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>                         ExtTag- RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency
> L0 <256ns, L1 <4us
>                         ClockPM- Surprise- LLActRep+ BwNot-
>                 LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive+ BWMgmt- ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>                         Slot #2, PowerLimit 6.500W; Interlock- NoCompl-
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
> LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power-
> Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>                         Changed: MRL- PresDet- LinkState-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                 Address: fee0300c  Data: 4151
>         Capabilities: [90] Subsystem: Intel Corporation Device 1999
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [100 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed+ WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>                         Status: NegoPending- InProgress-
>                 VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable- ID=0 ArbSelect=Fixed TC/VC=00
>                         Status: NegoPending- InProgress-
>         Capabilities: [180 v1] Root Complex Link
>                 Desc:   PortNumber=01 ComponentID=02 EltType=Config
>                 Link0:  Desc:   TargetPort=00 TargetComponent=02 AssocRCRB-
> LinkType=MemMapped LinkValid+
>                         Addr:   00000000fed1c001
>         Kernel driver in use: pcieport
>         Kernel modules: shpchp
> 
> 00:1c.1 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 2 (rev
> 02) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>         I/O behind bridge: 00004000-00004fff
>         Memory behind bridge: 80200000-803fffff
>         Prefetchable memory behind bridge: 0000000080400000-00000000805fffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>                         ExtTag- RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency
> L0 <1us, L1 <4us
>                         ClockPM- Surprise- LLActRep+ BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>                         Slot #3, PowerLimit 6.500W; Interlock- NoCompl-
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
> LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power-
> Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>                         Changed: MRL- PresDet- LinkState-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                 Address: fee0300c  Data: 4159
>         Capabilities: [90] Subsystem: Intel Corporation Device 1999
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [100 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed+ WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>                         Status: NegoPending- InProgress-
>                 VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable- ID=0 ArbSelect=Fixed TC/VC=00
>                         Status: NegoPending- InProgress-
>         Capabilities: [180 v1] Root Complex Link
>                 Desc:   PortNumber=02 ComponentID=02 EltType=Config
>                 Link0:  Desc:   TargetPort=00 TargetComponent=02 AssocRCRB-
> LinkType=MemMapped LinkValid+
>                         Addr:   00000000fed1c001
>         Kernel driver in use: pcieport
>         Kernel modules: shpchp
> 
> 00:1c.2 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 3 (rev
> 02) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>         I/O behind bridge: 00003000-00003fff
>         Memory behind bridge: f0200000-f02fffff
>         Prefetchable memory behind bridge: 0000000080000000-00000000801fffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>                         ExtTag- RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency
> L0 <256ns, L1 <4us
>                         ClockPM- Surprise- LLActRep+ BwNot-
>                 LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive+ BWMgmt- ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>                         Slot #4, PowerLimit 6.500W; Interlock- NoCompl-
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
> LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power-
> Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>                         Changed: MRL- PresDet- LinkState-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                 Address: fee0300c  Data: 4161
>         Capabilities: [90] Subsystem: Intel Corporation Device 1999
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [100 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed+ WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>                         Status: NegoPending- InProgress-
>                 VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable- ID=0 ArbSelect=Fixed TC/VC=00
>                         Status: NegoPending- InProgress-
>         Capabilities: [180 v1] Root Complex Link
>                 Desc:   PortNumber=03 ComponentID=02 EltType=Config
>                 Link0:  Desc:   TargetPort=00 TargetComponent=02 AssocRCRB-
> LinkType=MemMapped LinkValid+
>                         Addr:   00000000fed1c001
>         Kernel driver in use: pcieport
>         Kernel modules: shpchp
> 
> 00:1d.0 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller
> #1 (rev 02) (prog-if 00 [UHCI])
>         Subsystem: Lenovo Device 3807
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 23
>         Region 4: I/O ports at 1820 [size=32]
>         Kernel driver in use: uhci_hcd
>         Kernel modules: uhci-hcd
> 
> 00:1d.1 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller
> #2 (rev 02) (prog-if 00 [UHCI])
>         Subsystem: Lenovo Device 3808
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin B routed to IRQ 19
>         Region 4: I/O ports at 1840 [size=32]
>         Kernel driver in use: uhci_hcd
>         Kernel modules: uhci-hcd
> 
> 00:1d.2 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller
> #3 (rev 02) (prog-if 00 [UHCI])
>         Subsystem: Lenovo Device 3809
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 18
>         Region 4: I/O ports at 1860 [size=32]
>         Kernel driver in use: uhci_hcd
>         Kernel modules: uhci-hcd
> 
> 00:1d.3 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller
> #4 (rev 02) (prog-if 00 [UHCI])
>         Subsystem: Lenovo Device 380a
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin D routed to IRQ 16
>         Region 4: I/O ports at 1880 [size=32]
>         Kernel driver in use: uhci_hcd
>         Kernel modules: uhci-hcd
> 
> 00:1d.7 USB Controller: Intel Corporation N10/ICH 7 Family USB2 EHCI Controller
> (rev 02) (prog-if 20 [EHCI])
>         Subsystem: Lenovo Device 380b
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 23
>         Region 0: Memory at f0644000 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [58] Debug port: BAR=1 offset=00a0
>         Kernel driver in use: ehci_hcd
>         Kernel modules: ehci-hcd
> 
> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) (prog-if
> 01 [Subtractive decode])
>         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: fff00000-000fffff
>         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>         Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [50] Subsystem: Lenovo Device 380c
> 
> 00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge
> (rev 02)
>         Subsystem: Lenovo Device 380d
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>         Kernel modules: intel-rng, leds-ss4200, iTCO_wdt
> 
> 00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller
> (rev 02) (prog-if 8a [Master SecP PriP])
>         Subsystem: Lenovo Device 3810
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx+
>         Latency: 0
>         Interrupt: pin B routed to IRQ 19
>         Region 0: I/O ports at 01f0 [size=8]
>         Region 1: I/O ports at 03f4 [size=1]
>         Region 2: I/O ports at 0170 [size=8]
>         Region 3: I/O ports at 0374 [size=1]
>         Region 4: I/O ports at 1810 [size=16]
>         Kernel driver in use: ata_piix
>         Kernel modules: piix, ata_piix
> 
> 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA IDE
> Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
>         Subsystem: Lenovo Device 3835
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 19
>         Region 0: I/O ports at 18c8 [size=8]
>         Region 1: I/O ports at 18c0 [size=4]
>         Region 2: I/O ports at 18a8 [size=8]
>         Region 3: I/O ports at 180c [size=4]
>         Region 4: I/O ports at 18b0 [size=16]
>         Region 5: Memory at f0644400 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [70] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: ata_piix
>         Kernel modules: ata_piix
> 
> 00:1f.3 SMBus: Intel Corporation N10/ICH 7 Family SMBus Controller (rev 02)
>         Subsystem: Lenovo Device 380f
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin B routed to IRQ 19
>         Region 4: I/O ports at 18e0 [size=32]
>         Kernel driver in use: i801_smbus
>         Kernel modules: i2c-i801
> 
> 02:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5906M Fast
> Ethernet PCI Express (rev 02)
>         Subsystem: Lenovo IdeaPad S10e
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 44
>         Region 0: Memory at f0100000 (64-bit, non-prefetchable) [size=64K]
>         Expansion ROM at <ignored> [disabled]
>         Capabilities: [48] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] Vital Product Data
>                 End
>         Capabilities: [58] Vendor Specific Information: Len=78 <?>
>         Capabilities: [e8] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee0300c  Data: 4199
>         Capabilities: [d0] Express (v1) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1
> unlimited
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 4096 bytes
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency
> L0 <4us, L1 <64us
>                         ClockPM+ Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
>         Capabilities: [13c v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>                         Status: NegoPending- InProgress-
>         Capabilities: [160 v1] Device Serial Number 00-23-8b-ff-fe-40-d5-e4
>         Kernel driver in use: tg3
>         Kernel modules: tg3
> 
> 04:00.0 Network controller: Broadcom Corporation BCM4312 802.11b/g LP-PHY (rev
> 01)
>         Subsystem: Broadcom Corporation Device 04b5
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 18
>         Region 0: Memory at f0200000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=2 PME-
>         Capabilities: [58] Vendor Specific Information: Len=78 <?>
>         Capabilities: [e8] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [d0] Express (v1) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1
> unlimited
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr-
> TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency
> L0 <4us, L1 <64us
>                         ClockPM+ Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
>         Capabilities: [13c v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>                         Status: NegoPending- InProgress-
>         Capabilities: [160 v1] Device Serial Number 2e-19-00-ff-ff-91-00-21
>         Capabilities: [16c v1] Power Budgeting <?>
>         Kernel driver in use: b43-pci-bridge
>         Kernel modules: ssb
> 
> 
> 
> Thank you and please let me know if i can provide more info to debug. 
> Regards, Mark

One thing you could try is to modprobe the driver and then from another
terminal, do a `ps aux' and see if the modprobe is in "R", "D" or "S"
state.  Then do an

	echo t > /proc/sysrq-trigger

(or "echo w" if it was in D state) and then run "dmesg -s 1000000 >
foo", then send us the backtrace for that stuck modprobe instance. 
Please ensure that your email client doesn't wordwrap the trace!

Thanks.
