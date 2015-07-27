From: Matt Fleming <matt-mF/unelCI9GS6iBeEJttW/XRex20P6io@public.gmane.org>
Subject: Re: Regression in v4.2-rc1 caused by hierarchical irqdomain changes
Date: Mon, 27 Jul 2015 22:15:02 +0100
Message-ID: <20150727211502.GA2492@codeblueprint.co.uk>
References: <20150727152107.GA3571@codeblueprint.co.uk>
 <55B65DD8.9020002@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55B65DD8.9020002-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, 28 Jul, at 12:35:36AM, Jiang Liu wrote:
> Hi Matt,
> 	Sorry for the regression. Could you please help to provide
> more information about the regression, such dmesg, /proc/interrupts
> and hardware(PCI) info from good and bad kernels?

See below. Let me know if you need anything else.

00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
00:02.0 VGA compatible controller: Intel Corporation Broadwell-U Integrated Graphics (rev 09)
00:03.0 Audio device: Intel Corporation Broadwell-U Audio Controller (rev 09)
00:04.0 Signal processing controller: Intel Corporation Broadwell-U Camarillo Device (rev 09)
00:14.0 USB controller: Intel Corporation Wildcat Point-LP USB xHCI Controller (rev 03)
00:16.0 Communication controller: Intel Corporation Wildcat Point-LP MEI Controller #1 (rev 03)
00:1c.0 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root Port #1 (rev e3)
00:1c.3 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root Port #4 (rev e3)
00:1f.0 ISA bridge: Intel Corporation Wildcat Point-LP LPC Controller (rev 03)
00:1f.2 SATA controller: Intel Corporation Wildcat Point-LP SATA Controller [AHCI Mode] (rev 03)
00:1f.3 SMBus: Intel Corporation Wildcat Point-LP SMBus Controller (rev 03)
00:1f.6 Signal processing controller: Intel Corporation Wildcat Point-LP Thermal Management Controller (rev 03)
01:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5249 PCI Express Card Reader (rev 01)
02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)

[BAD]

           CPU0       CPU1       CPU2       CPU3       
  0:         60          0          0          0  IR-IO-APIC   2-edge      timer
  1:       4535       2225      12990       2486  IR-IO-APIC   1-edge      i8042
  3:          1          0          0          0  IR-IO-APIC   3-edge    
  6:          0          0          0          0  IR-IO-APIC   6-edge      dw_dmac
  7:         15          1          0          0  IR-IO-APIC   7-edge      INT3432:00, INT3433:00
  8:          0          0          1          0  IR-IO-APIC   8-edge      rtc0
  9:       1078        737       1761        536  IR-IO-APIC   9-fasteoi   acpi
 12:          5          4         64         13  IR-IO-APIC  12-edge      i8042
 40:          0          0          0          0  DMAR-MSI   0-edge      dmar0
 41:          0          0          0          0  DMAR-MSI   1-edge      dmar1
 42:          0          0          0          0  IR-PCI-MSI 458752-edge      PCIe PME
 43:          0          0          0          0  IR-PCI-MSI 464896-edge      PCIe PME
 44:     263825      97055     149799      86574  IR-PCI-MSI 32768-edge      i915
 45:          4          1         20          1  IR-PCI-MSI 360448-edge      mei_me
 46:          8          7         10          5  IR-PCI-MSI 524288-edge      rtsx_pci
 47:     265262      96130     273599     126469  IR-PCI-MSI 512000-edge      0000:00:1f.2
 48:       6151       3298      11082       2702  IR-PCI-MSI 327680-edge      xhci_hcd
 49:        826         91        920        257  IR-PCI-MSI 49152-edge      snd_hda_intel
 50:     363127     229106     850576     196544  IR-PCI-MSI 1048576-edge      iwlwifi
NMI:       2190       2399       2221       1874   Non-maskable interrupts
LOC:    8199446    7602675    7137979    4973130   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:       2190       2399       2221       1874   Performance monitoring interrupts
IWI:          0          1          1          0   IRQ work interrupts
RTR:          3          0          0          0   APIC ICR read retries
RES:    1117932    1200561    1398843     873543   Rescheduling interrupts
CAL:     145275     153343     122202     118672   Function call interrupts
TLB:      30552      30936      31487      32651   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:         71         71         71         71   Machine check polls
ERR:         15
MIS:          0

[GOOD]

           CPU0       CPU1       CPU2       CPU3       
  0:         60          0          0          0  IR-IO-APIC-edge      timer
  1:         73         26        135         54  IR-IO-APIC-edge      i8042
  3:         16         17         49         20  IR-IO-APIC-fasteoi   AudioDSP, dw_dmac
  6:          0          0          0          0  IR-IO-APIC-fasteoi   dw_dmac
  7:       2662       3072      12307       5419  IR-IO-APIC-fasteoi   INT3432:00, INT3433:00
  8:          0          0          1          0  IR-IO-APIC-edge      rtc0
  9:        265         48        280         85  IR-IO-APIC-fasteoi   acpi
 12:         20          5         61          2  IR-IO-APIC-edge      i8042
 37:          0          0          0          0  IR-IO-APIC  37-fasteoi   rt286
 39:        415         74        480        116  IR-IO-APIC  39-fasteoi   DLL0665:01
 40:          0          0          0          0  DMAR-MSI   0-edge      dmar0
 41:          0          0          0          0  DMAR-MSI   1-edge      dmar1
 42:          0          0          0          0  IR-PCI-MSI 458752-edge      PCIe PME
 43:          0          0          0          0  IR-PCI-MSI 464896-edge      PCIe PME
 44:       1007        402        696        280  IR-PCI-MSI 32768-edge      i915
 45:          4          1         20          0  IR-PCI-MSI 360448-edge      mei_me
 46:         19          1         10          0  IR-PCI-MSI 524288-edge      rtsx_pci
 47:      12101       9057      14481      30320  IR-PCI-MSI 512000-edge      0000:00:1f.2
 48:         64         29        126         27  IR-PCI-MSI 327680-edge      xhci_hcd
 49:        635         21       1179        269  IR-PCI-MSI 49152-edge      snd_hda_intel
 50:        147         60        164        222  IR-PCI-MSI 1048576-edge      iwlwifi
NMI:         16         12         18         11   Non-maskable interrupts
LOC:      21542      28287      23149      17203   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:         16         12         18         11   Performance monitoring interrupts
IWI:          0          0          1          0   IRQ work interrupts
RTR:          3          0          0          0   APIC ICR read retries
RES:       5425       8358       6069       5476   Rescheduling interrupts
CAL:        308        297        340        293   Function call interrupts
TLB:        424        422        432        437   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:          2          2          2          2   Machine check polls
ERR:          0
MIS:          0


-- 
Matt Fleming, Intel Open Source Technology Center

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.bad"

[    0.000000] microcode: CPU0 microcode updated early to revision 0x18, date = 2014-12-05
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0+ (matt-ZqTwcBeJ+wsBof6jY8KHXm7IUlhRatedral2JQCrhuEAvxtiuMwx3w@public.gmane.org) (gcc version 4.9.2 20150212 (Red Hat 4.9.2-6) (GCC) ) #61 SMP Mon Jul 27 15:49:20 BST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.0.0+ root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/swap rd.lvm.lv=fedora/root rd.luks.uuid=luks-26312b50-d793-4686-a576-28b32bee5a21 LANG=en_GB.UTF-8 acpi.debug_level=0x00002425 acpi.debug_layer=0xe
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c6443fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c6444000-0x00000000c68e2fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c68e3000-0x00000000dadbefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dadbf000-0x00000000dae7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dae80000-0x00000000daeacfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000daead000-0x00000000db7f8fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000db7f9000-0x00000000dbafdfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dbafe000-0x00000000dbafefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dd000000-0x00000000df7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021e7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0xc4a7d018-0xc4a8d057] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000c4a7d017] usable
[    0.000000] reserve setup_data: [mem 0x00000000c4a7d018-0x00000000c4a8d057] usable
[    0.000000] reserve setup_data: [mem 0x00000000c4a8d058-0x00000000c6443fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c6444000-0x00000000c68e2fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000c68e3000-0x00000000dadbefff] usable
[    0.000000] reserve setup_data: [mem 0x00000000dadbf000-0x00000000dae7ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000dae80000-0x00000000daeacfff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000daead000-0x00000000db7f8fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000db7f9000-0x00000000dbafdfff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000dbafe000-0x00000000dbafefff] usable
[    0.000000] reserve setup_data: [mem 0x00000000dd000000-0x00000000df7fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000021e7fffff] usable
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0xdae89000  ACPI 2.0=0xdae89000  SMBIOS=0xf0000 
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. XPS 13 9343/0F5KF3, BIOS A00 11/04/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x21e800 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask 7E00000000 write-back
[    0.000000]   1 base 0200000000 mask 7FF0000000 write-back
[    0.000000]   2 base 0210000000 mask 7FF8000000 write-back
[    0.000000]   3 base 0218000000 mask 7FFC000000 write-back
[    0.000000]   4 base 021C000000 mask 7FFE000000 write-back
[    0.000000]   5 base 021E000000 mask 7FFF800000 write-back
[    0.000000]   6 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000]   7 base 00DE000000 mask 7FFE000000 uncachable
[    0.000000]   8 base 00DD000000 mask 7FFF000000 uncachable
[    0.000000]   9 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] e820: update [mem 0xdd000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xdbaff max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x02688000, 0x02688fff] PGTABLE
[    0.000000] BRK [0x02689000, 0x02689fff] PGTABLE
[    0.000000] BRK [0x0268a000, 0x0268afff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x21e600000-0x21e7fffff]
[    0.000000]  [mem 0x21e600000-0x21e7fffff] page 2M
[    0.000000] BRK [0x0268b000, 0x0268bfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x200000000-0x21e5fffff]
[    0.000000]  [mem 0x200000000-0x21e5fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x1e0000000-0x1ffffffff]
[    0.000000]  [mem 0x1e0000000-0x1ffffffff] page 1G
[    0.000000] init_memory_mapping: [mem 0x00100000-0xc6443fff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0xbfffffff] page 1G
[    0.000000]  [mem 0xc0000000-0xc63fffff] page 2M
[    0.000000]  [mem 0xc6400000-0xc6443fff] page 4k
[    0.000000] init_memory_mapping: [mem 0xc68e3000-0xdadbefff]
[    0.000000]  [mem 0xc68e3000-0xc69fffff] page 4k
[    0.000000]  [mem 0xc6a00000-0xdabfffff] page 2M
[    0.000000]  [mem 0xdac00000-0xdadbefff] page 4k
[    0.000000] BRK [0x0268c000, 0x0268cfff] PGTABLE
[    0.000000] BRK [0x0268d000, 0x0268dfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xdbafe000-0xdbafefff]
[    0.000000]  [mem 0xdbafe000-0xdbafefff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x1dfffffff]
[    0.000000]  [mem 0x100000000-0x1dfffffff] page 1G
[    0.000000] RAMDISK: [mem 0x3ee0e000-0x3fffafff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000DAE89000 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x00000000DAE890C0 000104 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000DAE9C640 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000DAE89258 0133E2 (v02 DELL   CBX3     01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x00000000DB7F6F80 000040
[    0.000000] ACPI: APIC 0x00000000DAE9C750 000084 (v03 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000DAE9C7D8 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x00000000DAE9C820 00009C (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000DAE9C8C0 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000DAE9C900 000038 (v01 DELL   CBX3     01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000DAE9C938 000455 (v01 SataRe SataTabl 00001000 INTL 20120913)
[    0.000000] ACPI: UEFI 0x00000000DAE9CD90 000042 (v01                 00000000      00000000)
[    0.000000] ACPI: SSDT 0x00000000DAE9CDD8 0004A7 (v02 Intel_ Tpm2Tabl 00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAE9D280 00004B (v02 MeSsdt MeSsdt   00003000 INTL 20120913)
[    0.000000] ACPI: TPM2 0x00000000DAE9D2D0 000034 (v03                 00000000      00000000)
[    0.000000] ACPI: LPIT 0x00000000DAE9D308 000094 (v01                 00000000      00000000)
[    0.000000] ACPI: SSDT 0x00000000DAE9D3A0 002402 (v02 AcpiRe Ult0Rtd3 00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAE9F7A8 000CDB (v02 Ther_R Ther_Rvp 00001000 INTL 20120913)
[    0.000000] ACPI: ASF! 0x00000000DAEA0488 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.000000] ACPI: SSDT 0x00000000DAEA0528 00051F (v02 PmRef  Cpu0Ist  00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA0A48 000B74 (v02 CpuRef CpuSsdt  00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA15C0 0001C7 (v02 PmRef  LakeTiny 00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA1788 0003A5 (v02 CppcTa CppcTabl 00001000 INTL 20120913)
[    0.000000] ACPI: PCCT 0x00000000DAEA1B30 00006E (v05 PcctTa PcctTabl 00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA1BA0 000AC4 (v02 Cpc_Ta Cpc_Tabl 00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA2668 0041AC (v02 SaSsdt SaSsdt   00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA6818 004646 (v01 DptfTa DptfTabl 00001000 INTL 20120913)
[    0.000000] ACPI: SLIC 0x00000000DAEAAE60 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
[    0.000000] ACPI: MSDM 0x00000000DAEAAFD8 000055 (v03 DELL   CBX3     06222004 AMI  00010013)
[    0.000000] ACPI: DMAR 0x00000000DAEAB030 0000F0 (v01 INTEL  BDW      00000001 INTL 00000001)
[    0.000000] ACPI: CSRT 0x00000000DAEAB120 0000C4 (v01 INTL   BDW-ULT  00000001 INTL 20100528)
[    0.000000] ACPI: BGRT 0x00000000DAEAB1E8 000038 (v00                 01072009 AMI  00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000021e7fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x21e7e9000-0x21e7fcfff]
[    0.000000]  [ffffea0000000000-ffffea00087fffff] PMD -> [ffff880215e00000-ffff88021ddfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000021e7fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.000000]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000c6443fff]
[    0.000000]   node   0: [mem 0x00000000c68e3000-0x00000000dadbefff]
[    0.000000]   node   0: [mem 0x00000000dbafe000-0x00000000dbafefff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000021e7fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000021e7fffff]
[    0.000000] On node 0 totalpages: 2068669
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13925 pages used for memmap
[    0.000000]   DMA32 zone: 891169 pages, LIFO batch:31
[    0.000000]   Normal zone: 18336 pages used for memmap
[    0.000000]   Normal zone: 1173504 pages, LIFO batch:31
[    0.000000] tboot: non-0 tboot_addr but it is not of type E820_RESERVED
[    0.000000] Reserving Intel graphics stolen memory at 0xdd800000-0xdf7fffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x0])
[    0.000000] ACPI: NMI not connected to LINT 1!
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x0])
[    0.000000] ACPI: NMI not connected to LINT 1!
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x0])
[    0.000000] ACPI: NMI not connected to LINT 1!
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] low level lint[0xe5])
[    0.000000] ACPI: NMI not connected to LINT 1!
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-39
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc4a7d000-0xc4a7dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xc4a8d000-0xc4a8dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xc6444000-0xc68e2fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdadbf000-0xdae7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdae80000-0xdaeacfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdaead000-0xdb7f8fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdb7f9000-0xdbafdfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdbaff000-0xdcffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdd000000-0xdf7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf800000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xdf800000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 33 pages/cpu @ffff88021e400000 s97048 r8192 d29928 u524288
[    0.000000] pcpu-alloc: s97048 r8192 d29928 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 2036323
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.0.0+ root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/swap rd.lvm.lv=fedora/root rd.luks.uuid=luks-26312b50-d793-4686-a576-28b32bee5a21 LANG=en_GB.UTF-8 acpi.debug_level=0x00002425 acpi.debug_layer=0xe
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
[    0.000000] Memory: 7680856K/8274676K available (11763K kernel code, 1718K rwdata, 4900K rodata, 1680K init, 1192K bss, 593820K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:4352 nr_irqs:728 16
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-3.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] tsc: Detected 2594.178 MHz processor
[    0.000022] Calibrating delay loop (skipped), value calculated using timer frequency.. 5188.35 BogoMIPS (lpj=2594178)
[    0.000027] pid_max: default: 32768 minimum: 301
[    0.000032] ACPI: Core revision 20150410
[    0.025925] ACPI: All ACPI Tables successfully acquired
[    0.027283]    hwacpi-0107 hw_set_mode           : Attempting to enable ACPI mode
[    0.027908] Security Framework initialized
[    0.027915] SELinux:  Initializing.
[    0.027921] SELinux:  Starting in permissive mode
[    0.028325] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.029603] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.030152] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.030162] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.030329] Initializing cgroup subsys blkio
[    0.030332] Initializing cgroup subsys memory
[    0.030339] Initializing cgroup subsys devices
[    0.030342] Initializing cgroup subsys freezer
[    0.030345] Initializing cgroup subsys net_cls
[    0.030348] Initializing cgroup subsys perf_event
[    0.030350] Initializing cgroup subsys net_prio
[    0.030353] Initializing cgroup subsys hugetlb
[    0.030375] CPU: Physical Processor ID: 0
[    0.030377] CPU: Processor Core ID: 0
[    0.030382] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.030384] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.031268] mce: CPU supports 7 MCE banks
[    0.031279] CPU0: Thermal monitoring enabled (TM1)
[    0.031286] process: using mwait in idle threads
[    0.031291] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.031293] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.031663] Freeing SMP alternatives memory: 36K (ffffffff82553000 - ffffffff8255c000)
[    0.041325] ftrace: allocating 40210 entries in 158 pages
[    0.055423] dmar: Host address width 39
[    0.055428] dmar: DRHD base: 0x000000fed90000 flags: 0x0
[    0.055437] dmar: IOMMU 0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e1ff0505e
[    0.055441] dmar: DRHD base: 0x000000fed91000 flags: 0x1
[    0.055446] dmar: IOMMU 1: reg_base_addr fed91000 ver 1:0 cap d2008c20660462 ecap f010da
[    0.055450] dmar: RMRR base: 0x000000db9e5000 end: 0x000000db9f3fff
[    0.055452] dmar: RMRR base: 0x000000dd000000 end: 0x000000df7fffff
[    0.055454] dmar: ANDD device: 1 name: \_SB.PCI0.SDMA
[    0.055456] dmar: ANDD device: 3 name: \_SB.PCI0.ADSP
[    0.055459] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.055461] HPET id 0 under DRHD base 0xfed91000
[    0.055819] Your BIOS is broken and requested that x2apic be disabled.
This will slightly decrease performance.
Use 'intremap=no_x2apic_optout' to override BIOS request.
[    0.055834] Enabled IRQ remapping in xapic mode
[    0.055836] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.056452] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.066466] TSC deadline timer enabled
[    0.066468] smpboot: CPU0: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz (fam: 06, model: 3d, stepping: 04)
[    0.066491] Performance Events: PEBS fmt2+, 16-deep LBR, Broadwell events, full-width counters, Intel PMU driver.
[    0.066508] ... version:                3
[    0.066510] ... bit width:              48
[    0.066512] ... generic registers:      4
[    0.066514] ... value mask:             0000ffffffffffff
[    0.066516] ... max period:             0000ffffffffffff
[    0.066518] ... fixed-purpose events:   3
[    0.066519] ... event mask:             000000070000000f
[    0.067338] x86: Booting SMP configuration:
[    0.067341] .... node  #0, CPUs:      #1
[    0.079102] microcode: CPU1 microcode updated early to revision 0x18, date = 2014-12-05
[    0.082119] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.082185]  #2 #3
[    0.110524] x86: Booted up 1 node, 4 CPUs
[    0.110529] smpboot: Total of 4 processors activated (20753.42 BogoMIPS)
[    0.114016] devtmpfs: initialized
[    0.115592] PM: Registering ACPI NVS region [mem 0xdaead000-0xdb7f8fff] (9748480 bytes)
[    0.115729] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.115789] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    0.115794] pinctrl core: initialized pinctrl subsystem
[    0.115894] NET: Registered protocol family 16
[    0.118862] cpuidle: using governor menu
[    0.118937] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.118941] ACPI: bus type PCI registered
[    0.118943] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.118992] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.118996] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.119065] PCI: Using configuration type 1 for base access
[    0.119072] dmi type 0xB1 record - unknown flag
[    0.124144] ACPI: Added _OSI(Module Device)
[    0.124147] ACPI: Added _OSI(Processor Device)
[    0.124149] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.124152] ACPI: Added _OSI(Processor Aggregator Device)
[    0.126471] Initializing General Purpose Events (GPEs):
[    0.126515]     Initialized GPE 00 to 7F [_GPE] 16 regs on interrupt 0x9 (SCI)
[    0.126598]   evxface-0664 install_fixed_event_ha: Enabled fixed event GlobalLock (1), Handler=ffffffff814dc413
[    0.128806] Initializing Region       \PNVA
[    0.129059] Initializing Region       \GNVS
[    0.129335] Initializing Region       \RCRB
[    0.129356] Initializing Region       \_SB_.PCI0.LPCB.LPC_
[    0.130024] Executing  Method       \_SB_.PCI0.SAT0._REG
[    0.130468] ACPI: Executed 17 blocks of module-level executable AML code
[    0.130861] Initializing Region       \_PR_.PNVS
[    0.130877] Initializing Region       \_PR_.IO_D
[    0.130895] Initializing Region       \_PR_.IO_P
[    0.131770] Initializing Region       \_SB_.PCI0.HBUS
[    0.131795] Initializing Region       \_SB_.PCI0.B0D3.RPCS
[    0.131810] Initializing Region       \SANV
[    0.131823] Initializing Region       \_SB_.PCI0.B0D3.RPCZ
[    0.131835] Initializing Region       \_SB_.PCI0.GFX0.PCS_
[    0.131858] Initializing BufferField  \_SB_.PCI0.GFX0.IVD6
[    0.131868] Initializing BufferField  \_SB_.PCI0.GFX0.IVD7
[    0.131876] Initializing BufferField  \_SB_.PCI0.GFX0.IVD8
[    0.131883] Initializing BufferField  \_SB_.PCI0.GFX0.VDP8
[    0.131893] Initializing Region       \_SB_.PCI0.GFX0.IGDP
[    0.131903] Initializing Region       \_SB_.PCI0.GFX0.IGDM
[    0.131983] Initializing Region       \_SB_.PCI0.B0D4.MBAR
[    0.132159] Initializing Region       \_SB_.PCI0.PEG0.PEGP.PCIS
[    0.132167] Initializing Region       \_SB_.PCI0.PEG0.PEGR
[    0.132197] Initializing Region       \_SB_.PCI0.PEG1.PEGP.PCIS
[    0.132205] Initializing Region       \_SB_.PCI0.PEG1.PEGR
[    0.132233] Initializing Region       \_SB_.PCI0.PEG2.PEGP.PCIS
[    0.132241] Initializing Region       \_SB_.PCI0.PEG2.PEGR
[    0.132269] Initializing Region       \_SB_.PCI0.RP01.PXCS
[    0.132291] Initializing Region       \_SB_.PCI0.RP02.PXCS
[    0.132308] Initializing Region       \_SB_.PCI0.RP02.PXSX.PCCX
[    0.132317] Initializing Region       \_SB_.PCI0.RP03.PXCS
[    0.132333] Initializing Region       \_SB_.PCI0.RP03.PXSX.PCCX
[    0.132342] Initializing Region       \_SB_.PCI0.RP04.PXCS
[    0.132359] Initializing Region       \_SB_.PCI0.RP04.PXSX.PCCX
[    0.132373] Initializing Region       \_SB_.PCI0.RP05.PXCS
[    0.132391] Initializing Region       \_SB_.PCI0.RP06.PXCS
[    0.132407] Initializing Region       \_SB_.PCI0.RP06.PXSX.PCCX
[    0.132417] Initializing Region       \_SB_.PCI0.RP07.PXCS
[    0.132433] Initializing Region       \_SB_.PCI0.RP07.PXSX.PCCX
[    0.132441] Initializing Region       \_SB_.PCI0.RP08.PXCS
[    0.132457] Initializing Region       \_SB_.PCI0.RP08.PXSX.PCCX
[    0.132466] Initializing Region       \_SB_.PCI0.LPCB.SMIE
[    0.132480] Initializing Region       \_SB_.PCI0.LPCB.SLPR
[    0.132492] Initializing Region       \_SB_.PCI0.LPCB.CPSB
[    0.132506] Initializing Region       \_SB_.PCI0.LPCB.LPCR
[    0.132556] Initializing Region       \_SB_.PCI0.LPCB.ECDV.ECOR
[    0.132630] Initializing Region       \_SB_.PCI0.GLAN.GLBA
[    0.132639] Initializing Region       \_SB_.PCI0.EHC1.PWCS
[    0.132646] Initializing Region       \_SB_.PCI0.EHC1.PWKE
[    0.132663] Initializing Region       \_SB_.PCI0.EHC2.PWCS
[    0.132670] Initializing Region       \_SB_.PCI0.EHC2.PWKE
[    0.132684] Initializing Region       \_SB_.PCI0.XHC_.XPRT
[    0.132694] Initializing Region       \_SB_.PCI0.XHC_.XHCP
[    0.132719] Initializing Region       \_SB_.PCI0.XHC_.PWCS
[    0.133024] Initializing BufferField  \_SB_.PCI0.GPI0.BMIN
[    0.133033] Initializing BufferField  \_SB_.PCI0.GPI0.BMAX
[    0.133118] Initializing Region       \_SB_.PCI0.HDEF.HDAR
[    0.133171] Initializing BufferField  \_SB_.PCI0.ADSP.B0VL
[    0.133179] Initializing BufferField  \_SB_.PCI0.ADSP.B1VL
[    0.133187] Initializing BufferField  \_SB_.PCI0.ADSP.IRQN
[    0.133211] Initializing BufferField  \_SB_.PCI0.SAT0.PIO0
[    0.133218] Initializing BufferField  \_SB_.PCI0.SAT0.DMA0
[    0.133226] Initializing BufferField  \_SB_.PCI0.SAT0.PIO1
[    0.133234] Initializing BufferField  \_SB_.PCI0.SAT0.DMA1
[    0.133242] Initializing BufferField  \_SB_.PCI0.SAT0.CHNF
[    0.133252] Initializing Region       \_SB_.PCI0.SBUS.SMBP
[    0.133260] Initializing Region       \_SB_.PCI0.SBUS.SMPB
[    0.133267] Initializing Region       \_SB_.PCI0.SBUS.SMBI
[    0.133295] Initializing Region       \_SB_.PCI0.MCHP
[    0.133351] Initializing Region       \_SB_.PCI0.TPCH.PCHT
[    0.133973] Initializing Region       \_SB_.RTCO
[    0.133989] Initializing Region       \_SB_.TPMI.SMIP
[    0.133996] Initializing Region       \_SB_.TPMI.FHCI
[    0.134004] Initializing Region       \_SB_.TPMI.TNVS
[    0.134470] Initializing Region       \EXBU
[    0.134479] Initializing Region       \DEGA
[    0.134527] Initializing Region       \PMIO
[    0.134564] Initializing Region       \LGPE
[    0.134592] Initializing Region       \GPR_
[    0.134633] Initializing Region       \GPRL
[    0.134665] Initializing Region       \PRT0
[    0.134672] Initializing Region       \SPRT
[    0.134683] Initializing Region       \USBD
[    0.134690] Initializing Region       \UBLK
[    0.134698] Initializing Region       \MBAR
[    0.134724] Initializing Region       \IO_H
[    0.134794] Initializing Region       \ABNV
[    0.134872] Initializing Region       \MENV
[    0.134987] Executing  Method       \_SB_._STA
[    0.134992] Executing  Method       \_SB_._INI
[    0.134998] Executing  Method       \_SB_.PCI0._STA
[    0.135002] Executing  Method       \_SB_.PCI0._INI
[    0.136326] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.137989] Executing  Method       \_SB_.PCI0.B0D3._STA
[    0.138014] Executing  Method       \_SB_.PCI0.B0D3._INI
[    0.138047] Executing  Method       \_SB_.PCI0.PEG0._STA
[    0.138051] Executing  Method       \_SB_.PCI0.PEG0._INI
[    0.138081] Executing  Method       \_SB_.PCI0.PEG1._STA
[    0.138084] Executing  Method       \_SB_.PCI0.PEG1._INI
[    0.138113] Executing  Method       \_SB_.PCI0.PEG2._STA
[    0.138116] Executing  Method       \_SB_.PCI0.PEG2._INI
[    0.138144] Executing  Method       \_SB_.PCI0.RP01._STA
[    0.138148] Executing  Method       \_SB_.PCI0.RP01._INI
[    0.138186] Executing  Method       \_SB_.PCI0.RP02._STA
[    0.138189] Executing  Method       \_SB_.PCI0.RP02._INI
[    0.138230] Executing  Method       \_SB_.PCI0.RP03._STA
[    0.138234] Executing  Method       \_SB_.PCI0.RP03._INI
[    0.138271] Executing  Method       \_SB_.PCI0.RP04._STA
[    0.138274] Executing  Method       \_SB_.PCI0.RP04._INI
[    0.138312] Executing  Method       \_SB_.PCI0.RP05._STA
[    0.138316] Executing  Method       \_SB_.PCI0.RP05._INI
[    0.138352] Executing  Method       \_SB_.PCI0.RP06._STA
[    0.138356] Executing  Method       \_SB_.PCI0.RP06._INI
[    0.138393] Executing  Method       \_SB_.PCI0.RP07._STA
[    0.138396] Executing  Method       \_SB_.PCI0.RP07._INI
[    0.138433] Executing  Method       \_SB_.PCI0.RP08._STA
[    0.138436] Executing  Method       \_SB_.PCI0.RP08._INI
[    0.138473] Executing  Method       \_SB_.PCI0.XHC_._STA
[    0.138476] Executing  Method       \_SB_.PCI0.XHC_._INI
[    0.138480] Executing  Method       \_SB_.PCI0.XHC_.RHUB._STA
[    0.138484] Executing  Method       \_SB_.PCI0.XHC_.RHUB._INI
[    0.138496] Executing  Method       \_SB_.PCI0.I2C0._STA
[    0.138525] Executing  Method       \_SB_.PCI0.I2C0._INI
[    0.138529] Executing  Method       \_SB_.PCI0.I2C0.ACD0._STA
[    0.138576] Executing  Method       \_SB_.PCI0.I2C0.ACD0._INI
[    0.138613] Executing  Method       \_SB_.PCI0.I2C0.ACD1._STA
[    0.138641] Executing  Method       \_SB_.PCI0.I2C0.ACD2._STA
[    0.138678] Executing  Method       \_SB_.PCI0.I2C0.ACD3._STA
[    0.138706] Executing  Method       \_SB_.PCI0.ADSP._STA
[    0.138739] Executing  Method       \_SB_.PCI0.ADSP._INI
[    0.139317] ACPI: Dynamic OEM Table Load:
[    0.139325] ACPI: SSDT 0xFFFF880214249C00 0003D3 (v02 PmRef  Cpu0Cst  00003001 INTL 20120913)
[    0.140192] ACPI: Dynamic OEM Table Load:
[    0.140198] ACPI: SSDT 0xFFFF880214205000 0005AA (v02 PmRef  ApIst    00003000 INTL 20120913)
[    0.141122] ACPI: Dynamic OEM Table Load:
[    0.141129] ACPI: SSDT 0xFFFF880214292C00 000119 (v02 PmRef  ApCst    00003000 INTL 20120913)
[    0.142716] ACPI : EC: EC started
[    0.142752] Executing  Method       \_SB_.PCI0.LPCB.ECDV._REG
[    0.150831] ACPI: Interpreter enabled
[    0.150842] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150410/hwxface-580)
[    0.150849] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150410/hwxface-580)
[    0.150863] ACPI: (supports S0 S3 S4 S5)
[    0.150866] ACPI: Using IOAPIC for interrupt routing
[    0.150894] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.152686] ACPI: Power Resource [PG00] (on)
[    0.153075] ACPI: Power Resource [PG01] (on)
[    0.153444] ACPI: Power Resource [PG02] (on)
[    0.153970] ACPI: Power Resource [PXP] (on)
[    0.155375] ACPI: Power Resource [PXP] (on)
[    0.159252] ACPI: Power Resource [PX05] (on)
[    0.160125] ACPI: Power Resource [PAUD] (on)
[    0.180832] ACPI: Power Resource [PXTC] (off)
[    0.182189] ACPI: Power Resource [P3PR] (off)
[    0.187410] ACPI: Power Resource [FN00] (off)
[    0.187476] ACPI: Power Resource [FN01] (off)
[    0.187538] ACPI: Power Resource [FN02] (off)
[    0.187601] ACPI: Power Resource [FN03] (off)
[    0.187665] ACPI: Power Resource [FN04] (off)
[    0.188489] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.188495] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.189077] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.189081] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.189502] PCI host bridge to bus 0000:00
[    0.189505] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.189508] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.189510] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.189513] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.189516] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    0.189520] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.189523] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    0.189526] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    0.189529] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.189533] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.189536] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.189539] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.189542] pci_bus 0000:00: root bus resource [mem 0xdf800000-0xfeafffff window]
[    0.189550] pci 0000:00:00.0: [8086:1604] type 00 class 0x060000
[    0.189633] pci 0000:00:02.0: [8086:1616] type 00 class 0x030000
[    0.189640] pci 0000:00:02.0: reg 0x10: [mem 0xf6000000-0xf6ffffff 64bit]
[    0.189646] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.189649] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.189729] pci 0000:00:03.0: [8086:160c] type 00 class 0x040300
[    0.189734] pci 0000:00:03.0: reg 0x10: [mem 0xf7218000-0xf721bfff 64bit]
[    0.189814] pci 0000:00:04.0: [8086:1603] type 00 class 0x118000
[    0.189822] pci 0000:00:04.0: reg 0x10: [mem 0xf7210000-0xf7217fff 64bit]
[    0.189916] pci 0000:00:14.0: [8086:9cb1] type 00 class 0x0c0330
[    0.189929] pci 0000:00:14.0: reg 0x10: [mem 0xf7200000-0xf720ffff 64bit]
[    0.189974] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.190032] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.190059] pci 0000:00:16.0: [8086:9cba] type 00 class 0x078000
[    0.190075] pci 0000:00:16.0: reg 0x10: [mem 0xf7221000-0xf722101f 64bit]
[    0.190131] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.190222] pci 0000:00:1c.0: [8086:9c90] type 01 class 0x060400
[    0.190271] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.190372] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.190398] pci 0000:00:1c.3: [8086:9c96] type 01 class 0x060400
[    0.190447] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.190540] pci 0000:00:1c.3: System wakeup disabled by ACPI
[    0.190572] pci 0000:00:1f.0: [8086:9cc3] type 00 class 0x060100
[    0.190733] pci 0000:00:1f.2: [8086:9c83] type 00 class 0x010601
[    0.190744] pci 0000:00:1f.2: reg 0x10: [io  0xf0b0-0xf0b7]
[    0.190749] pci 0000:00:1f.2: reg 0x14: [io  0xf0a0-0xf0a3]
[    0.190754] pci 0000:00:1f.2: reg 0x18: [io  0xf090-0xf097]
[    0.190760] pci 0000:00:1f.2: reg 0x1c: [io  0xf080-0xf083]
[    0.190765] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    0.190770] pci 0000:00:1f.2: reg 0x24: [mem 0xf721e000-0xf721e7ff]
[    0.190796] pci 0000:00:1f.2: PME# supported from D3hot
[    0.190862] pci 0000:00:1f.3: [8086:9ca2] type 00 class 0x0c0500
[    0.190874] pci 0000:00:1f.3: reg 0x10: [mem 0xf721d000-0xf721d0ff 64bit]
[    0.190889] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    0.190973] pci 0000:00:1f.6: [8086:9ca4] type 00 class 0x118000
[    0.190997] pci 0000:00:1f.6: reg 0x10: [mem 0xf721c000-0xf721cfff 64bit]
[    0.191214] pci 0000:01:00.0: [10ec:5249] type 00 class 0xff0000
[    0.191233] pci 0000:01:00.0: reg 0x10: [mem 0xf7100000-0xf7100fff]
[    0.191358] pci 0000:01:00.0: supports D1 D2
[    0.191359] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.191397] pci 0000:01:00.0: System wakeup disabled by ACPI
[    0.194341] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.194346] pci 0000:00:1c.0:   bridge window [mem 0xf7100000-0xf71fffff]
[    0.194447] pci 0000:02:00.0: [8086:095a] type 00 class 0x028000
[    0.194491] pci 0000:02:00.0: reg 0x10: [mem 0xf7000000-0xf7001fff 64bit]
[    0.194652] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.194696] pci 0000:02:00.0: System wakeup disabled by ACPI
[    0.197372] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    0.197378] pci 0000:00:1c.3:   bridge window [mem 0xf7000000-0xf70fffff]
[    0.202268] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.202333] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.202404] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.202458] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.202513] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.202565] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.202617] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.202670] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.203909] ACPI: Enabled 3 GPEs in block 00 to 7F
[    0.203968] ACPI : EC: GPE = 0x27, I/O: command/status = 0x934, data = 0x930
[    0.204095] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    0.204198] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.204201] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.204205] vgaarb: loaded
[    0.204207] vgaarb: bridge control possible 0000:00:02.0
[    0.204263] SCSI subsystem initialized
[    0.204294] libata version 3.00 loaded.
[    0.204310] ACPI: bus type USB registered
[    0.204325] usbcore: registered new interface driver usbfs
[    0.204333] usbcore: registered new interface driver hub
[    0.204345] usbcore: registered new device driver usb
[    0.207396] media: Linux media interface: v0.10
[    0.207406] Linux video capture interface: v2.00
[    0.207576] wmi: Mapper loaded
[    0.207598] Advanced Linux Sound Architecture Driver Initialized.
[    0.207611] PCI: Using ACPI for IRQ routing
[    0.208759] PCI: pci_cache_line_size set to 64 bytes
[    0.208821] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.208823] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.208824] e820: reserve RAM buffer [mem 0xc4a7d018-0xc7ffffff]
[    0.208825] e820: reserve RAM buffer [mem 0xc6444000-0xc7ffffff]
[    0.208825] e820: reserve RAM buffer [mem 0xdadbf000-0xdbffffff]
[    0.208827] e820: reserve RAM buffer [mem 0xdbaff000-0xdbffffff]
[    0.208827] e820: reserve RAM buffer [mem 0x21e800000-0x21fffffff]
[    0.208906] Bluetooth: Core ver 2.20
[    0.208912] NET: Registered protocol family 31
[    0.208914] Bluetooth: HCI device and connection manager initialized
[    0.208917] Bluetooth: HCI socket layer initialized
[    0.208919] Bluetooth: L2CAP socket layer initialized
[    0.208924] Bluetooth: SCO socket layer initialized
[    0.208983] NetLabel: Initializing
[    0.208986] NetLabel:  domain hash size = 128
[    0.208988] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.209001] NetLabel:  unlabeled traffic allowed by default
[    0.209044] cfg80211: Calling CRDA to update world regulatory domain
[    0.209096] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.209101] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.211126] Switched to clocksource hpet
[    0.218168] pnp: PnP ACPI init
[    0.218366] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.218371] system 00:00: [io  0xffff] has been reserved
[    0.218373] system 00:00: [io  0xffff] has been reserved
[    0.218376] system 00:00: [io  0xffff] has been reserved
[    0.218378] system 00:00: [io  0x1800-0x18fe] could not be reserved
[    0.218381] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.218386] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.218423] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.218454] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.218457] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.218580] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.218594] pnp 00:04: Plug and Play ACPI device, IDs DLL0665 PNP0f13 (active)
[    0.218749] system 00:05: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.218752] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.218754] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.218757] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.218759] system 00:05: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.218762] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.218765] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.218767] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.218770] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.218774] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.218777] system 00:05: [mem 0xf7fe0000-0xf7feffff] has been reserved
[    0.218779] system 00:05: [mem 0xf7ff0000-0xf7ffffff] has been reserved
[    0.218782] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.219184] system 00:06: [mem 0xfe102000-0xfe102fff] has been reserved
[    0.219187] system 00:06: [mem 0xfe104000-0xfe104fff] has been reserved
[    0.219189] system 00:06: [mem 0xfe106000-0xfe106fff] has been reserved
[    0.219193] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.223177]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[    0.223787] pnp: PnP ACPI: found 7 devices
[    0.229584] clocksource acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.229603] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.229608] pci 0000:00:1c.0:   bridge window [mem 0xf7100000-0xf71fffff]
[    0.229615] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    0.229620] pci 0000:00:1c.3:   bridge window [mem 0xf7000000-0xf70fffff]
[    0.229627] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.229629] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.229630] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.229631] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.229632] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.229633] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.229634] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.229635] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.229636] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.229637] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.229638] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.229639] pci_bus 0000:00: resource 15 [mem 0xdf800000-0xfeafffff window]
[    0.229640] pci_bus 0000:01: resource 1 [mem 0xf7100000-0xf71fffff]
[    0.229641] pci_bus 0000:02: resource 1 [mem 0xf7000000-0xf70fffff]
[    0.229675] NET: Registered protocol family 2
[    0.229817] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.229928] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.230036] TCP: Hash tables configured (established 65536 bind 65536)
[    0.230063] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.230085] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.230134] NET: Registered protocol family 1
[    0.230208] RPC: Registered named UNIX socket transport module.
[    0.230211] RPC: Registered udp transport module.
[    0.230212] RPC: Registered tcp transport module.
[    0.230214] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.230224] pci 0000:00:02.0: Video device with shadowed ROM
[    0.230423] PCI: CLS 64 bytes, default 64
[    0.230454] Unpacking initramfs...
[    0.432325] Freeing initrd memory: 18356K (ffff88003ee0e000 - ffff88003fffb000)
[    0.432355] dmar: ACPI device "INTL9C60:00" under DMAR at fed91000 as 00:15.0
[    0.432361] dmar: ACPI device "INT3438:00" under DMAR at fed91000 as 00:13.0
[    0.432370] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.432374] software IO TLB [mem 0xbe8fa000-0xc28fa000] (64MB) mapped at [ffff8800be8fa000-ffff8800c28f9fff]
[    0.432637] microcode: CPU0 sig=0x306d4, pf=0x40, revision=0x18
[    0.432646] microcode: CPU1 sig=0x306d4, pf=0x40, revision=0x18
[    0.432650] microcode: CPU2 sig=0x306d4, pf=0x40, revision=0x18
[    0.432656] microcode: CPU3 sig=0x306d4, pf=0x40, revision=0x18
[    0.432686] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    0.432924] AVX2 version of gcm_enc/dec engaged.
[    0.432927] AES CTR mode by8 optimization enabled
[    0.434392] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    0.435613] alg: No test for crc32 (crc32-pclmul)
[    0.435792] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.435803] Initialise system trusted keyring
[    0.435821] audit: initializing netlink subsys (disabled)
[    0.435829] audit: type=2000 audit(1438012293.415:1): initialized
[    0.436127] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.437084] zpool: loaded
[    0.437211] VFS: Disk quotas dquot_6.6.0
[    0.437238] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.437526] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
[    0.437618] fuse init (API version 7.23)
[    0.437712] Key type big_key registered
[    0.437715] SELinux:  Registering netfilter hooks
[    0.438527] alg: No test for stdrng (krng)
[    0.440323] NET: Registered protocol family 38
[    0.440330] Key type asymmetric registered
[    0.440333] Asymmetric key parser 'x509' registered
[    0.440365] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.440395] io scheduler noop registered
[    0.440399] io scheduler deadline registered
[    0.440410] io scheduler cfq registered (default)
[    0.440763] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    0.440766] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.440778] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    0.440790] pcieport 0000:00:1c.3: Signaling PME through PCIe PME interrupt
[    0.440793] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    0.440797] pcie_pme 0000:00:1c.3:pcie01: service driver pcie_pme loaded
[    0.440801] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.440814] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.440825] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.440857] efifb: probing for efifb
[    0.440888] efifb: framebuffer at 0xe0000000, mapped to 0xffffc90002000000, using 22500k, total 22500k
[    0.440892] efifb: mode is 3200x1800x32, linelength=12800, pages=1
[    0.440894] efifb: scrolling: redraw
[    0.440896] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.449338] Console: switching to colour frame buffer device 400x112
[    0.457312] fb0: EFI VGA frame buffer device
[    0.457331] intel_idle: MWAIT substates: 0x11142120
[    0.457331] intel_idle: v0.4 model 0x3D
[    0.457332] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.458365] ACPI: AC Adapter [AC] (on-line)
[    0.458502] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.459166] ACPI: Lid Switch [LID0]
[    0.459214] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.459237] ACPI: Power Button [PBTN]
[    0.459269] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.459296] ACPI: Sleep Button [SBTN]
[    0.459331] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.459351] ACPI: Power Button [PWRF]
[    0.459371]   evxface-0664 install_fixed_event_ha: Enabled fixed event PowerButton (2), Handler=ffffffff814c4e38
[    0.460569] thermal LNXTHERM:00: registered as thermal_zone0
[    0.460587] ACPI: Thermal Zone [THM] (25 C)
[    0.463796] thermal LNXTHERM:01: registered as thermal_zone1
[    0.463815] ACPI: Thermal Zone [TZ00] (68 C)
[    0.466817] thermal LNXTHERM:02: registered as thermal_zone2
[    0.466836] ACPI: Thermal Zone [TZ01] (68 C)
[    0.483339] ACPI: Battery Slot [BAT0] (battery present)
[    0.483411] GHES: HEST is not enabled!
[    0.483472] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.483924] Non-volatile memory driver v1.3
[    0.483965] Linux agpgart interface v0.103
[    0.484031] [drm] Initialized drm 1.1.0 20060810
[    0.484499] [drm] Memory usable by graphics device = 4096M
[    0.484518] checking generic (e0000000 15f9000) vs hw (e0000000 10000000)
[    0.484519] fb: switching to inteldrmfb from EFI VGA
[    0.484546] Console: switching to colour dummy device 80x25
[    0.484630] [drm] Replacing VGA console driver
[    0.485078] [drm] ACPI BIOS requests an excessive sleep of 10000 ms, using 1500 ms instead
[    0.491249] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.491254] [drm] Driver supports precise vblank timestamp query.
[    0.491357] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    0.506276] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    0.516366] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[    0.516396] fbcon: inteldrmfb (fb0) is primary device
[    0.516418] [drm] Initialized i915 1.6.0 20150327 for 0000:00:02.0 on minor 0
[    0.524522] rtsx_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    0.524637] rtsx_pci 0000:01:00.0: rtsx_pci_acquire_irq: pcr->msi_en = 1, pci->irq = 46
[    0.527920] ahci 0000:00:1f.2: version 3.0
[    0.528058] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.538391] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x8 impl SATA mode
[    0.538393] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo only pio slum part deso sadm sds apst 
[    0.538806] scsi host0: ahci
[    0.539037] scsi host1: ahci
[    0.539146] scsi host2: ahci
[    0.539233] scsi host3: ahci
[    0.539262] ata1: DUMMY
[    0.539263] ata2: DUMMY
[    0.539263] ata3: DUMMY
[    0.539264] ata4: SATA max UDMA/133 abar m2048@0xf721e000 port 0xf721e280 irq 47
[    0.539344] libphy: Fixed MDIO Bus: probed
[    0.539345] tun: Universal TUN/TAP device driver, 1.6
[    0.539346] tun: (C) 1999-2004 Max Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
[    0.539411] usbcore: registered new interface driver r8152
[    0.539418] usbcore: registered new interface driver cdc_ether
[    0.539588] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.539619] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.539684] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    0.539688] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.539785] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.539786] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.539787] usb usb1: Product: xHCI Host Controller
[    0.539788] usb usb1: Manufacturer: Linux 4.0.0+ xhci-hcd
[    0.539788] usb usb1: SerialNumber: 0000:00:14.0
[    0.539886] hub 1-0:1.0: USB hub found
[    0.539900] hub 1-0:1.0: 11 ports detected
[    0.543726] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.543756] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.543775] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    0.543776] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.543777] usb usb2: Product: xHCI Host Controller
[    0.543777] usb usb2: Manufacturer: Linux 4.0.0+ xhci-hcd
[    0.543778] usb usb2: SerialNumber: 0000:00:14.0
[    0.543844] hub 2-0:1.0: USB hub found
[    0.543849] hub 2-0:1.0: 4 ports detected
[    0.545200] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.545204] ehci-pci: EHCI PCI platform driver
[    0.545212] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.545214] ohci-pci: OHCI PCI platform driver
[    0.545220] uhci_hcd: USB Universal Host Controller Interface driver
[    0.545245] usbcore: registered new interface driver usb-storage
[    0.545262] usbcore: registered new interface driver usbserial
[    0.545266] usbcore: registered new interface driver usbserial_generic
[    0.545269] usbserial: USB Serial support registered for generic
[    0.545274] usbcore: registered new interface driver ftdi_sio
[    0.545278] usbserial: USB Serial support registered for FTDI USB Serial Device
[    0.545305] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.545887] i8042: Warning: Keylock active
[    0.548227] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.548230] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.548300] mousedev: PS/2 mouse device common for all mice
[    0.548491]   evxface-0664 install_fixed_event_ha: Enabled fixed event RealTimeClock (4), Handler=ffffffff81781a70
[    0.548494] rtc_cmos 00:01: RTC can wake from S4
[    0.548620] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    0.548653] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.548744] ACPI Warning: SystemIO range 0x000000000000F040-0x000000000000F05F conflicts with OpRegion 0x000000000000F040-0x000000000000F04F (\_SB_.PCI0.SBUS.SMBI) (20150410/utaddress-254)
[    0.548745] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    0.548773] usbcore: registered new interface driver uvcvideo
[    0.548773] USB Video Class driver (1.1.1)
[    0.549856] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[    0.551457] ACPI Warning: \_SB_.IETM._ART: Return Package type mismatch at index 0 - found Integer, expected Reference (20150410/nspredef-297)
[    0.551461] ACPI: Invalid package element [0]: got number, expecting [R]
[    0.585299] _ART package 0 is invalid, ignored
[    0.585299] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    0.605544] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    0.605582] iTCO_wdt: Found a Wildcat Point_LP TCO device (Version=2, TCOBASE=0x1860)
[    0.605671] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    0.605690] iTCO_vendor_support: vendor-support=0
[    0.605742] device-mapper: uevent: version 1.0.3
[    0.605858] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    0.605959] usbcore: registered new interface driver btusb
[    0.605970] Intel P-state driver initializing.
[    0.606125] sdhci: Secure Digital Host Controller Interface driver
[    0.606126] sdhci: Copyright(c) Pierre Ossman
[    0.609747] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    0.609760] EFI Variables Facility v0.08 2004-May-17
[    0.612861] hidraw: raw HID events driver (C) Jiri Kosina
[    0.613211] usbcore: registered new interface driver usbhid
[    0.613212] usbhid: USB HID core driver
[    1.051811] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    1.216763] usb 1-3: No LPM exit latency info found, disabling LPM.
[    1.217993] usb 1-3: New USB device found, idVendor=8087, idProduct=0a2a
[    1.217995] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.233715] Bluetooth: hci0: read Intel version: 370810011003110e00
[    1.233745] bluetooth hci0: Direct firmware load for intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq failed with error -2
[    1.233747] Bluetooth: hci0 failed to open Intel firmware file: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq(-2)
[    1.233780] bluetooth hci0: Direct firmware load for intel/ibt-hw-37.8.bseq failed with error -2
[    1.233781] Bluetooth: hci0 failed to open default Intel fw file: intel/ibt-hw-37.8.bseq
[    1.371953] usb 1-4: new full-speed USB device number 3 using xhci_hcd
[    1.434985] tsc: Refined TSC clocksource calibration: 2593.995 MHz
[    1.434987] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x256413873f2, max_idle_ns: 440795261455 ns
[    1.537920] usb 1-4: New USB device found, idVendor=04f3, idProduct=20d0
[    1.537921] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
[    1.537922] usb 1-4: Product: Touchscreen
[    1.537923] usb 1-4: Manufacturer: ELAN
[    1.538095] usb 1-4: ep 0x2 - rounding interval to 64 microframes, ep desc says 80 microframes
[    1.546130] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:20D0.0001/input/input8
[    1.546264] hid-multitouch 0003:04F3:20D0.0001: input,hiddev0,hidraw0: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
[    1.600038] Console: switching to colour frame buffer device 400x112
[    1.615017] i2c_designware INT3433:00: controller timed out
[    1.642496] i2c_designware INT3433:00: timeout in disabling adapter
[    1.642500] i2c_hid i2c-DLL0665:01: hid_descr_cmd failed
[    1.652393] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    1.653669] i915 0000:00:02.0: registered panic notifier
[    1.657621] input: Dell WMI hotkeys as /devices/virtual/input/input10
[    1.659594] snd_hda_intel 0000:00:03.0: enabling device (0000 -> 0002)
[    1.661087] drop_monitor: Initializing network drop monitor service
[    1.662378] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[    1.663952] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.665299] Initializing XFRM netlink socket
[    1.666650] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops)
[    1.666726] NET: Registered protocol family 10
[    1.666901] mip6: Mobile IPv6
[    1.666906] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    1.672119] NET: Registered protocol family 17
[    1.673485] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
[    1.674871] Ebtables v2.0 registered
[    1.676651] Loading compiled-in X.509 certificates
[    1.678662] Loaded X.509 cert 'Magrathea: Glacier signing key: fc047a540e21515ad039688bb8a1cf32a880e5c8'
[    1.680120] registered taskstats version 1
[    1.682000] rtc_cmos 00:01: setting system clock to 2015-07-27 15:51:34 UTC (1438012294)
[    1.683519] ALSA device list:
[    1.684925]   #0: HDA Intel HDMI at 0xf7218000 irq 49
[    1.702062] usb 1-5: new high-speed USB device number 4 using xhci_hcd
[    1.892483] usb 1-5: New USB device found, idVendor=0bda, idProduct=5682
[    1.894130] usb 1-5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    1.895492] usb 1-5: Product: Integrated_Webcam_HD
[    1.896871] usb 1-5: Manufacturer: CKFEH41F301030009340
[    1.898226] usb 1-5: SerialNumber: 200901010001
[    1.902918] uvcvideo: Found UVC 1.00 device Integrated_Webcam_HD (0bda:5682)
[    1.909242] input: Integrated_Webcam_HD as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input11
[    1.968309] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.972008] ata4.00: failed to get NCQ Send/Recv Log Emask 0x1
[    1.972011] ata4.00: ATA-9: SAMSUNG SSD PM851 M.2 2280 256GB, EXT25D0Q, max UDMA/133
[    1.973710] ata4.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.975486] ata4.00: failed to get NCQ Send/Recv Log Emask 0x1
[    1.975522] ata4.00: configured for UDMA/133
[    1.977107] scsi 3:0:0:0: Direct-Access     ATA      SAMSUNG SSD PM85 5D0Q PQ: 0 ANSI: 5
[    1.978900] sd 3:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    1.978921] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    1.981915] sd 3:0:0:0: [sda] Write Protect is off
[    1.983332] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.983339] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.987695]  sda: sda1 sda2 sda3
[    1.989829] sd 3:0:0:0: [sda] Attached SCSI disk
[    1.991608] Freeing unused kernel memory: 1680K (ffffffff823af000 - ffffffff82553000)
[    1.993274] Write protecting the kernel read-only data: 18432k
[    1.994928] Freeing unused kernel memory: 508K (ffff880001b81000 - ffff880001c00000)
[    1.996592] Freeing unused kernel memory: 1244K (ffff8800020c9000 - ffff880002200000)
[    2.002650] random: systemd urandom read with 29 bits of entropy available
[    2.004985] systemd[1]: systemd 216 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    2.006647] systemd[1]: Detected architecture 'x86-64'.
[    2.008206] systemd[1]: Running in initial RAM disk.
[    2.014693] systemd[1]: Set hostname to <mfleming-mobl1.ger.corp.intel.com>.
[    2.038356] systemd[1]: Expecting device dev-disk-by\x2duuid-AF27\x2d22C8.device...
[    2.041584] systemd[1]: Expecting device dev-mapper-fedora\x2dswap.device...
[    2.044757] systemd[1]: Expecting device dev-disk-by\x2duuid-e75ed791\x2dd3e4\x2d480d\x2daa9f\x2d499f34a15b23.device...
[    2.047949] systemd[1]: Expecting device dev-mapper-fedora\x2droot.device...
[    2.051141] systemd[1]: Starting Timers.
[    2.054265] systemd[1]: Reached target Timers.
[    2.055784] systemd[1]: Expecting device dev-disk-by\x2duuid-26312b50\x2dd793\x2d4686\x2da576\x2d28b32bee5a21.device...
[    2.058904] systemd[1]: Expecting device dev-mapper-luks\x2d26312b50\x2dd793\x2d4686\x2da576\x2d28b32bee5a21.device...
[    2.062025] systemd[1]: Starting -.slice.
[    2.068733] systemd[1]: Created slice -.slice.
[    2.070254] systemd[1]: Starting udev Control Socket.
[    2.073413] systemd[1]: Listening on udev Control Socket.
[    2.074935] systemd[1]: Starting udev Kernel Socket.
[    2.078041] systemd[1]: Listening on udev Kernel Socket.
[    2.079563] systemd[1]: Starting Journal Socket.
[    2.082673] systemd[1]: Listening on Journal Socket.
[    2.084168] systemd[1]: Starting System Slice.
[    2.087326] systemd[1]: Created slice System Slice.
[    2.088852] systemd[1]: Started dracut ask for additional cmdline parameters.
[    2.090388] systemd[1]: Starting dracut cmdline hook...
[    2.093775] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    2.097070] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    2.098659] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    2.102098] systemd[1]: Starting system-systemd\x2dcryptsetup.slice.
[    2.105677] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
[    2.107234] systemd[1]: Starting Journal Socket (/dev/log).
[    2.109025] systemd[1]: Starting Slices.
[    2.112524] systemd[1]: Reached target Slices.
[    2.114056] systemd[1]: Starting Setup Virtual Console...
[    2.117516] systemd[1]: Started Load Kernel Modules.
[    2.119050] systemd[1]: Starting Apply Kernel Variables...
[    2.133907] systemd[1]: Starting Swap.
[    2.137874] systemd[1]: Reached target Swap.
[    2.139535] systemd[1]: Starting Local File Systems.
[    2.143615] systemd[1]: Reached target Local File Systems.
[    2.147955] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    2.152059] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.155659] systemd[1]: Started Apply Kernel Variables.
[    2.160456] systemd[1]: Starting Sockets.
[    2.164560] systemd[1]: Reached target Sockets.
[    2.166545] systemd[1]: Starting Journal Service...
[    2.170929] systemd[1]: Starting Create Static Device Nodes in /dev...
[    2.179945] systemd[1]: Started Create Static Device Nodes in /dev.
[    2.187594] systemd[1]: Started Setup Virtual Console.
[    2.194946] systemd[1]: Started dracut cmdline hook.
[    2.196958] systemd[1]: Starting dracut pre-udev hook...
[    2.203746] systemd[1]: Started Journal Service.
[    2.435707] Switched to clocksource tsc
[    2.752647] i2c_designware INT3433:00: timeout in disabling adapter
[    3.364162] cfg80211: Calling CRDA to update world regulatory domain
[    6.518099] cfg80211: Calling CRDA to update world regulatory domain
[    9.672062] cfg80211: Calling CRDA to update world regulatory domain
[   12.195548] random: nonblocking pool is initialized
[   12.826017] cfg80211: Calling CRDA to update world regulatory domain
[   13.635457] psmouse serio1: Failed to deactivate mouse on isa0060/serio1
[   14.110759] psmouse serio1: Failed to enable mouse on isa0060/serio1
[   15.979827] cfg80211: Calling CRDA to update world regulatory domain
[   17.254897] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
[   17.509043] systemd-journald[291]: Received SIGTERM from PID 1 (systemd).
[   17.548446] audit: type=1404 audit(1438012310.355:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[   17.565597] SELinux: 32768 avtab hash slots, 105179 rules.
[   17.576835] SELinux: 32768 avtab hash slots, 105179 rules.
[   17.596012] SELinux:  8 users, 103 roles, 4998 types, 294 bools, 1 sens, 1024 cats
[   17.596014] SELinux:  83 classes, 105179 rules
[   17.598883] SELinux:  Permission audit_read in class capability2 not defined in policy.
[   17.600077] SELinux:  Class binder not defined in policy.
[   17.601246] SELinux: the above unknown classes and permissions will be allowed
[   17.602424] SELinux:  Completing initialization.
[   17.602425] SELinux:  Setting up existing superblocks.
[   17.607981] audit: type=1403 audit(1438012310.415:3): policy loaded auid=4294967295 ses=4294967295
[   17.612556] systemd[1]: Successfully loaded SELinux policy in 65.760ms.
[   17.624119] systemd[1]: RTC configured in localtime, applying delta of 60 minutes to system time.
[   17.642871] systemd[1]: Relabelled /dev and /run in 13.795ms.
[   17.869285] EXT4-fs (dm-2): re-mounted. Opts: (null)
[   17.897255] systemd-journald[781]: Received request to flush runtime journal from PID 1
[   18.200492] Intel(R) Wireless WiFi driver for Linux
[   18.202781] Copyright(c) 2003- 2015 Intel Corporation
[   18.202998] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[   18.204283] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-7265D-13.ucode failed with error -2
[   18.207012] sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
[   18.212887] iwlwifi 0000:02:00.0: loaded firmware version 25.17.12.0 op_mode iwlmvm
[   18.228318] (NULL device *): Direct firmware load for intel/IntcPP01.bin failed with error -2
[   18.228320] (NULL device *): fw image intel/IntcPP01.bin not available(-2)
[   18.228922] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[   18.258535] Adding 8126460k swap on /dev/mapper/fedora-swap.  Priority:-1 extents:1 across:8126460k SSFS
[   18.302549] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   18.315282] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input7
[   18.331243] FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   18.342020] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 7265, REV=0x210
[   18.344128] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[   18.345945] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[   18.409814] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   18.420331] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[   18.427141] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: (null)
[   18.442653] cfg80211: Calling CRDA to update world regulatory domain
[   18.455127] cfg80211: World regulatory domain updated:
[   18.456705] cfg80211:  DFS Master region: unset
[   18.456717] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
[   18.459866] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
[   18.461412] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
[   18.463120] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2000 mBm), (N/A)
[   18.464622] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
[   18.466151] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[   18.467708] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, 2000 mBm), (0 s)
[   18.469180] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2000 mBm), (N/A)
[   18.470776] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 0 mBm), (N/A)
[   18.517384] psmouse serio1: Failed to enable mouse on isa0060/serio1
[   18.528393] haswell-pcm-audio haswell-pcm-audio: ipc: --message timeout-- ipcx 0x40000000 isr 0x00000001 ipcd 0x20011b93 imrx 0x7fff0000
[   18.530053] (NULL device *): error: get version failed
[   18.831556] haswell-pcm-audio haswell-pcm-audio: ipc: --message timeout-- ipcx 0x40000000 isr 0x00000001 ipcd 0x20011b93 imrx 0x7fff0000
[   18.833569] (NULL device *): error: get stream info failed
[   18.835660] (NULL device *): error: failed to get stream info
[   18.848914] ------------[ cut here ]------------
[   18.850431] kernel BUG at /home/matt/src/kernels/efi/mm/slub.c:3413!
[   18.851972] invalid opcode: 0000 [#1] SMP 
[   18.853505] Modules linked in: iwlmvm iwlwifi snd_soc_sst_haswell_pcm(+) snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_rt286(+) snd_soc_sst_acpi
[   18.855077] CPU: 0 PID: 830 Comm: systemd-udevd Not tainted 4.0.0+ #61
[   18.856642] Hardware name: Dell Inc. XPS 13 9343/0F5KF3, BIOS A00 11/04/2014
[   18.858204] task: ffff88020fc1b900 ti: ffff88020fc80000 task.ti: ffff88020fc80000
[   18.859859] RIP: 0010:[<ffffffff81231102>]  [<ffffffff81231102>] kfree+0x152/0x160
[   18.861471] RSP: 0018:ffff88020fc83a98  EFLAGS: 00010246
[   18.863044] RAX: 005ffc0000000000 RBX: ffff880212910000 RCX: 0000000000007dff
[   18.864640] RDX: 000077ff80000000 RSI: ffff880212910028 RDI: ffff880212910000
[   18.866671] RBP: ffff88020fc83ab8 R08: 0000000000019c60 R09: ffffea00084a4400
[   18.868270] R10: ffffffff816621ed R11: ffff8800d9cf5a20 R12: ffff88020fc83af0
[   18.869804] R13: ffffffff816621ed R14: 0000000000000004 R15: ffff8800daaf1000
[   18.871339] FS:  00007f273d54f880(0000) GS:ffff88021e400000(0000) knlGS:0000000000000000
[   18.872885] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.874419] CR2: 00007f273d3f3000 CR3: 000000020fc8f000 CR4: 00000000003407f0
[   18.875949] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   18.877468] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   18.878969] Stack:
[   18.880464]  ffff8800daaf1028 ffff8800daaf1000 ffff88020fc83af0 ffff8800d8911410
[   18.881955]  ffff88020fc83b38 ffffffff816621ed 0000000000000286 ffff8800d8911668
[   18.883457]  ffff880000000000 ffff8800d8911668 ffff8802131d8480 ffff8800daaf1000
[   18.884934] Call Trace:
[   18.886429]  [<ffffffff816621ed>] release_nodes+0x14d/0x260
[   18.887920]  [<ffffffff81662410>] devres_release_all+0x40/0x70
[   18.889414]  [<ffffffff8165dc98>] driver_probe_device+0xc8/0x4b0
[   18.890913]  [<ffffffff8165e15b>] __driver_attach+0x9b/0xa0
[   18.892402]  [<ffffffff8165e0c0>] ? __device_attach+0x40/0x40
[   18.893888]  [<ffffffff8165b8f3>] bus_for_each_dev+0x73/0xc0
[   18.895374]  [<ffffffff8165d6ae>] driver_attach+0x1e/0x20
[   18.896857]  [<ffffffff8165d260>] bus_add_driver+0x180/0x250
[   18.898342]  [<ffffffffa0062964>] ? ftrace_define_fields_hsw_device_config_req+0xc6/0xc6 [snd_soc_sst_haswell_pcm]
[   18.899858]  [<ffffffff8165e954>] driver_register+0x64/0xf0
[   18.901342]  [<ffffffff8165fffa>] __platform_driver_register+0x4a/0x50
[   18.902839]  [<ffffffffa006297b>] hsw_pcm_driver_init+0x17/0x69c [snd_soc_sst_haswell_pcm]
[   18.904342]  [<ffffffff81000318>] do_one_initcall+0xd8/0x210
[   18.905840]  [<ffffffff81214e02>] ? __vunmap+0xa2/0x100
[   18.907328]  [<ffffffff812325c9>] ? kmem_cache_alloc_trace+0x1a9/0x230
[   18.908820]  [<ffffffff81b6b624>] ? do_init_module+0x28/0x1cc
[   18.910334]  [<ffffffff81b6b65d>] do_init_module+0x61/0x1cc
[   18.911838]  [<ffffffff811631eb>] load_module+0x20cb/0x2540
[   18.913313]  [<ffffffff8115ead0>] ? store_uevent+0x70/0x70
[   18.914779]  [<ffffffff812562e0>] ? kernel_read+0x50/0x80
[   18.916234]  [<ffffffff81163886>] SyS_finit_module+0xa6/0xe0
[   18.917684]  [<ffffffff81b762ee>] system_call_fastpath+0x12/0x71
[   18.919130] Code: 00 4d 8b 49 30 e9 35 ff ff ff 0f 1f 80 00 00 00 00 4c 89 d1 48 89 da 4c 89 ce e8 ea f9 ff ff e9 73 ff ff ff 0f 1f 44 00 00 0f 0b <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 89 
[   18.920682] RIP  [<ffffffff81231102>] kfree+0x152/0x160
[   18.922160]  RSP <ffff88020fc83a98>
[   18.923664] ---[ end trace 1fdbf340cd8718a0 ]---
[   19.056710] i2c_designware INT3432:00: controller timed out
[   19.059155] rt286 i2c-INT343A:00: I2C error -110
[   19.073730] rt286: probe of i2c-INT343A:00 failed with error -110
[  198.267302] audit: type=1305 audit(1438008890.963:4): audit_pid=934 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
[  198.582308] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[  198.584423] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[  199.593932] device virbr0-nic entered promiscuous mode
[  199.608470] virbr0: port 1(virbr0-nic) entered forwarding state
[  199.608480] virbr0: port 1(virbr0-nic) entered forwarding state
[  199.825141] virbr0: port 1(virbr0-nic) entered disabled state
[  205.479221] wlp2s0: authenticate with 7c:03:4c:71:c8:61
[  205.482283] wlp2s0: send auth to 7c:03:4c:71:c8:61 (try 1/3)
[  205.484861] wlp2s0: authenticated
[  205.485990] wlp2s0: associate with 7c:03:4c:71:c8:61 (try 1/3)
[  205.491045] wlp2s0: RX AssocResp from 7c:03:4c:71:c8:61 (capab=0x411 status=0 aid=2)
[  205.491675] wlp2s0: associated

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.good"

[    0.000000] microcode: CPU0 microcode updated early to revision 0x18, date = 2014-12-05
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0+ (matt-ZqTwcBeJ+wsBof6jY8KHXm7IUlhRatedral2JQCrhuEAvxtiuMwx3w@public.gmane.org) (gcc version 4.9.2 20150212 (Red Hat 4.9.2-6) (GCC) ) #60 SMP Sun Jul 26 14:59:58 BST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.0.0+ root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/swap rd.lvm.lv=fedora/root rd.luks.uuid=luks-26312b50-d793-4686-a576-28b32bee5a21 LANG=en_GB.UTF-8 acpi.debug_level=0x00002425 acpi.debug_layer=0xe
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c6443fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c6444000-0x00000000c68e2fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c68e3000-0x00000000dadbefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dadbf000-0x00000000dae7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dae80000-0x00000000daeacfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000daead000-0x00000000db7f8fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000db7f9000-0x00000000dbafdfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dbafe000-0x00000000dbafefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dd000000-0x00000000df7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021e7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0xc4a7d018-0xc4a8d057] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000c4a7d017] usable
[    0.000000] reserve setup_data: [mem 0x00000000c4a7d018-0x00000000c4a8d057] usable
[    0.000000] reserve setup_data: [mem 0x00000000c4a8d058-0x00000000c6443fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c6444000-0x00000000c68e2fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000c68e3000-0x00000000dadbefff] usable
[    0.000000] reserve setup_data: [mem 0x00000000dadbf000-0x00000000dae7ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000dae80000-0x00000000daeacfff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000daead000-0x00000000db7f8fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000db7f9000-0x00000000dbafdfff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000dbafe000-0x00000000dbafefff] usable
[    0.000000] reserve setup_data: [mem 0x00000000dd000000-0x00000000df7fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000021e7fffff] usable
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0xdae89000  ACPI 2.0=0xdae89000  SMBIOS=0xf0000 
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. XPS 13 9343/0F5KF3, BIOS A00 11/04/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x21e800 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask 7E00000000 write-back
[    0.000000]   1 base 0200000000 mask 7FF0000000 write-back
[    0.000000]   2 base 0210000000 mask 7FF8000000 write-back
[    0.000000]   3 base 0218000000 mask 7FFC000000 write-back
[    0.000000]   4 base 021C000000 mask 7FFE000000 write-back
[    0.000000]   5 base 021E000000 mask 7FFF800000 write-back
[    0.000000]   6 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000]   7 base 00DE000000 mask 7FFE000000 uncachable
[    0.000000]   8 base 00DD000000 mask 7FFF000000 uncachable
[    0.000000]   9 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] e820: update [mem 0xdd000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xdbaff max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x02688000, 0x02688fff] PGTABLE
[    0.000000] BRK [0x02689000, 0x02689fff] PGTABLE
[    0.000000] BRK [0x0268a000, 0x0268afff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x21e600000-0x21e7fffff]
[    0.000000]  [mem 0x21e600000-0x21e7fffff] page 2M
[    0.000000] BRK [0x0268b000, 0x0268bfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x200000000-0x21e5fffff]
[    0.000000]  [mem 0x200000000-0x21e5fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x1e0000000-0x1ffffffff]
[    0.000000]  [mem 0x1e0000000-0x1ffffffff] page 1G
[    0.000000] init_memory_mapping: [mem 0x00100000-0xc6443fff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0xbfffffff] page 1G
[    0.000000]  [mem 0xc0000000-0xc63fffff] page 2M
[    0.000000]  [mem 0xc6400000-0xc6443fff] page 4k
[    0.000000] init_memory_mapping: [mem 0xc68e3000-0xdadbefff]
[    0.000000]  [mem 0xc68e3000-0xc69fffff] page 4k
[    0.000000]  [mem 0xc6a00000-0xdabfffff] page 2M
[    0.000000]  [mem 0xdac00000-0xdadbefff] page 4k
[    0.000000] BRK [0x0268c000, 0x0268cfff] PGTABLE
[    0.000000] BRK [0x0268d000, 0x0268dfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xdbafe000-0xdbafefff]
[    0.000000]  [mem 0xdbafe000-0xdbafefff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x1dfffffff]
[    0.000000]  [mem 0x100000000-0x1dfffffff] page 1G
[    0.000000] RAMDISK: [mem 0x3ee0d000-0x3fffafff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000DAE89000 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x00000000DAE890C0 000104 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000DAE9C640 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000DAE89258 0133E2 (v02 DELL   CBX3     01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x00000000DB7F6F80 000040
[    0.000000] ACPI: APIC 0x00000000DAE9C750 000084 (v03 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000DAE9C7D8 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x00000000DAE9C820 00009C (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000DAE9C8C0 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000DAE9C900 000038 (v01 DELL   CBX3     01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000DAE9C938 000455 (v01 SataRe SataTabl 00001000 INTL 20120913)
[    0.000000] ACPI: UEFI 0x00000000DAE9CD90 000042 (v01                 00000000      00000000)
[    0.000000] ACPI: SSDT 0x00000000DAE9CDD8 0004A7 (v02 Intel_ Tpm2Tabl 00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAE9D280 00004B (v02 MeSsdt MeSsdt   00003000 INTL 20120913)
[    0.000000] ACPI: TPM2 0x00000000DAE9D2D0 000034 (v03                 00000000      00000000)
[    0.000000] ACPI: LPIT 0x00000000DAE9D308 000094 (v01                 00000000      00000000)
[    0.000000] ACPI: SSDT 0x00000000DAE9D3A0 002402 (v02 AcpiRe Ult0Rtd3 00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAE9F7A8 000CDB (v02 Ther_R Ther_Rvp 00001000 INTL 20120913)
[    0.000000] ACPI: ASF! 0x00000000DAEA0488 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.000000] ACPI: SSDT 0x00000000DAEA0528 00051F (v02 PmRef  Cpu0Ist  00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA0A48 000B74 (v02 CpuRef CpuSsdt  00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA15C0 0001C7 (v02 PmRef  LakeTiny 00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA1788 0003A5 (v02 CppcTa CppcTabl 00001000 INTL 20120913)
[    0.000000] ACPI: PCCT 0x00000000DAEA1B30 00006E (v05 PcctTa PcctTabl 00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA1BA0 000AC4 (v02 Cpc_Ta Cpc_Tabl 00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA2668 0041AC (v02 SaSsdt SaSsdt   00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DAEA6818 004646 (v01 DptfTa DptfTabl 00001000 INTL 20120913)
[    0.000000] ACPI: SLIC 0x00000000DAEAAE60 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
[    0.000000] ACPI: MSDM 0x00000000DAEAAFD8 000055 (v03 DELL   CBX3     06222004 AMI  00010013)
[    0.000000] ACPI: DMAR 0x00000000DAEAB030 0000F0 (v01 INTEL  BDW      00000001 INTL 00000001)
[    0.000000] ACPI: CSRT 0x00000000DAEAB120 0000C4 (v01 INTL   BDW-ULT  00000001 INTL 20100528)
[    0.000000] ACPI: BGRT 0x00000000DAEAB1E8 000038 (v00                 01072009 AMI  00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000021e7fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x21e7e9000-0x21e7fcfff]
[    0.000000]  [ffffea0000000000-ffffea00087fffff] PMD -> [ffff880215e00000-ffff88021ddfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000021e7fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.000000]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000c6443fff]
[    0.000000]   node   0: [mem 0x00000000c68e3000-0x00000000dadbefff]
[    0.000000]   node   0: [mem 0x00000000dbafe000-0x00000000dbafefff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000021e7fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000021e7fffff]
[    0.000000] On node 0 totalpages: 2068669
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13925 pages used for memmap
[    0.000000]   DMA32 zone: 891169 pages, LIFO batch:31
[    0.000000]   Normal zone: 18336 pages used for memmap
[    0.000000]   Normal zone: 1173504 pages, LIFO batch:31
[    0.000000] tboot: non-0 tboot_addr but it is not of type E820_RESERVED
[    0.000000] Reserving Intel graphics stolen memory at 0xdd800000-0xdf7fffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x0])
[    0.000000] ACPI: NMI not connected to LINT 1!
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x0])
[    0.000000] ACPI: NMI not connected to LINT 1!
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x0])
[    0.000000] ACPI: NMI not connected to LINT 1!
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x48])
[    0.000000] ACPI: NMI not connected to LINT 1!
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-39
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc4a7d000-0xc4a7dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xc4a8d000-0xc4a8dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xc6444000-0xc68e2fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdadbf000-0xdae7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdae80000-0xdaeacfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdaead000-0xdb7f8fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdb7f9000-0xdbafdfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdbaff000-0xdcffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdd000000-0xdf7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf800000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xdf800000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 33 pages/cpu @ffff88021e400000 s97048 r8192 d29928 u524288
[    0.000000] pcpu-alloc: s97048 r8192 d29928 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 2036323
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.0.0+ root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/swap rd.lvm.lv=fedora/root rd.luks.uuid=luks-26312b50-d793-4686-a576-28b32bee5a21 LANG=en_GB.UTF-8 acpi.debug_level=0x00002425 acpi.debug_layer=0xe
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
[    0.000000] Memory: 7680852K/8274676K available (11763K kernel code, 1718K rwdata, 4900K rodata, 1680K init, 1192K bss, 593824K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:4352 nr_irqs:728 16
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-3.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2594.150 MHz processor
[    0.000022] Calibrating delay loop (skipped), value calculated using timer frequency.. 5188.30 BogoMIPS (lpj=2594150)
[    0.000027] pid_max: default: 32768 minimum: 301
[    0.000032] ACPI: Core revision 20150410
[    0.025826] ACPI: All ACPI Tables successfully acquired
[    0.026875]    hwacpi-0107 hw_set_mode           : Attempting to enable ACPI mode
[    0.027500] Security Framework initialized
[    0.027506] SELinux:  Initializing.
[    0.027514] SELinux:  Starting in permissive mode
[    0.027916] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.029174] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.029715] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.029725] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.029894] Initializing cgroup subsys blkio
[    0.029898] Initializing cgroup subsys memory
[    0.029904] Initializing cgroup subsys devices
[    0.029908] Initializing cgroup subsys freezer
[    0.029910] Initializing cgroup subsys net_cls
[    0.029913] Initializing cgroup subsys perf_event
[    0.029916] Initializing cgroup subsys net_prio
[    0.029918] Initializing cgroup subsys hugetlb
[    0.029940] CPU: Physical Processor ID: 0
[    0.029942] CPU: Processor Core ID: 0
[    0.029946] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.029948] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.030832] mce: CPU supports 7 MCE banks
[    0.030844] CPU0: Thermal monitoring enabled (TM1)
[    0.030852] process: using mwait in idle threads
[    0.030856] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.030858] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.031227] Freeing SMP alternatives memory: 36K (ffffffff82553000 - ffffffff8255c000)
[    0.040872] ftrace: allocating 40204 entries in 158 pages
[    0.055016] dmar: Host address width 39
[    0.055020] dmar: DRHD base: 0x000000fed90000 flags: 0x0
[    0.055029] dmar: IOMMU 0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e1ff0505e
[    0.055033] dmar: DRHD base: 0x000000fed91000 flags: 0x1
[    0.055039] dmar: IOMMU 1: reg_base_addr fed91000 ver 1:0 cap d2008c20660462 ecap f010da
[    0.055042] dmar: RMRR base: 0x000000db9e5000 end: 0x000000db9f3fff
[    0.055045] dmar: RMRR base: 0x000000dd000000 end: 0x000000df7fffff
[    0.055047] dmar: ANDD device: 1 name: \_SB.PCI0.SDMA
[    0.055049] dmar: ANDD device: 3 name: \_SB.PCI0.ADSP
[    0.055052] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.055054] HPET id 0 under DRHD base 0xfed91000
[    0.055422] Your BIOS is broken and requested that x2apic be disabled.
This will slightly decrease performance.
Use 'intremap=no_x2apic_optout' to override BIOS request.
[    0.055438] Enabled IRQ remapping in xapic mode
[    0.055440] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.056068] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.066081] TSC deadline timer enabled
[    0.066083] smpboot: CPU0: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz (fam: 06, model: 3d, stepping: 04)
[    0.066107] Performance Events: PEBS fmt2+, 16-deep LBR, Broadwell events, full-width counters, Intel PMU driver.
[    0.066125] ... version:                3
[    0.066127] ... bit width:              48
[    0.066128] ... generic registers:      4
[    0.066130] ... value mask:             0000ffffffffffff
[    0.066132] ... max period:             0000ffffffffffff
[    0.066134] ... fixed-purpose events:   3
[    0.066136] ... event mask:             000000070000000f
[    0.066968] x86: Booting SMP configuration:
[    0.066971] .... node  #0, CPUs:      #1
[    0.078735] microcode: CPU1 microcode updated early to revision 0x18, date = 2014-12-05
[    0.081750] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.081816]  #2 #3
[    0.110158] x86: Booted up 1 node, 4 CPUs
[    0.110163] smpboot: Total of 4 processors activated (20753.20 BogoMIPS)
[    0.113712] devtmpfs: initialized
[    0.115292] PM: Registering ACPI NVS region [mem 0xdaead000-0xdb7f8fff] (9748480 bytes)
[    0.115430] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.115490] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    0.115494] pinctrl core: initialized pinctrl subsystem
[    0.115596] NET: Registered protocol family 16
[    0.118575] cpuidle: using governor menu
[    0.118647] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.118652] ACPI: bus type PCI registered
[    0.118654] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.118701] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.118706] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.118775] PCI: Using configuration type 1 for base access
[    0.118782] dmi type 0xB1 record - unknown flag
[    0.123843] ACPI: Added _OSI(Module Device)
[    0.123846] ACPI: Added _OSI(Processor Device)
[    0.123848] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.123851] ACPI: Added _OSI(Processor Aggregator Device)
[    0.126117] Initializing General Purpose Events (GPEs):
[    0.126162]     Initialized GPE 00 to 7F [_GPE] 16 regs on interrupt 0x9 (SCI)
[    0.126248]   evxface-0664 install_fixed_event_ha: Enabled fixed event GlobalLock (1), Handler=ffffffff814dc413
[    0.128455] Initializing Region       \PNVA
[    0.128708] Initializing Region       \GNVS
[    0.128984] Initializing Region       \RCRB
[    0.129005] Initializing Region       \_SB_.PCI0.LPCB.LPC_
[    0.129670] Executing  Method       \_SB_.PCI0.SAT0._REG
[    0.130112] ACPI: Executed 17 blocks of module-level executable AML code
[    0.130506] Initializing Region       \_PR_.PNVS
[    0.130523] Initializing Region       \_PR_.IO_D
[    0.130538] Initializing Region       \_PR_.IO_P
[    0.131408] Initializing Region       \_SB_.PCI0.HBUS
[    0.131433] Initializing Region       \_SB_.PCI0.B0D3.RPCS
[    0.131448] Initializing Region       \SANV
[    0.131460] Initializing Region       \_SB_.PCI0.B0D3.RPCZ
[    0.131473] Initializing Region       \_SB_.PCI0.GFX0.PCS_
[    0.131496] Initializing BufferField  \_SB_.PCI0.GFX0.IVD6
[    0.131505] Initializing BufferField  \_SB_.PCI0.GFX0.IVD7
[    0.131513] Initializing BufferField  \_SB_.PCI0.GFX0.IVD8
[    0.131521] Initializing BufferField  \_SB_.PCI0.GFX0.VDP8
[    0.131529] Initializing Region       \_SB_.PCI0.GFX0.IGDP
[    0.131537] Initializing Region       \_SB_.PCI0.GFX0.IGDM
[    0.131619] Initializing Region       \_SB_.PCI0.B0D4.MBAR
[    0.131794] Initializing Region       \_SB_.PCI0.PEG0.PEGP.PCIS
[    0.131803] Initializing Region       \_SB_.PCI0.PEG0.PEGR
[    0.131833] Initializing Region       \_SB_.PCI0.PEG1.PEGP.PCIS
[    0.131841] Initializing Region       \_SB_.PCI0.PEG1.PEGR
[    0.131869] Initializing Region       \_SB_.PCI0.PEG2.PEGP.PCIS
[    0.131877] Initializing Region       \_SB_.PCI0.PEG2.PEGR
[    0.131906] Initializing Region       \_SB_.PCI0.RP01.PXCS
[    0.131928] Initializing Region       \_SB_.PCI0.RP02.PXCS
[    0.131945] Initializing Region       \_SB_.PCI0.RP02.PXSX.PCCX
[    0.131954] Initializing Region       \_SB_.PCI0.RP03.PXCS
[    0.131970] Initializing Region       \_SB_.PCI0.RP03.PXSX.PCCX
[    0.131979] Initializing Region       \_SB_.PCI0.RP04.PXCS
[    0.131996] Initializing Region       \_SB_.PCI0.RP04.PXSX.PCCX
[    0.132009] Initializing Region       \_SB_.PCI0.RP05.PXCS
[    0.132027] Initializing Region       \_SB_.PCI0.RP06.PXCS
[    0.132044] Initializing Region       \_SB_.PCI0.RP06.PXSX.PCCX
[    0.132053] Initializing Region       \_SB_.PCI0.RP07.PXCS
[    0.132070] Initializing Region       \_SB_.PCI0.RP07.PXSX.PCCX
[    0.132079] Initializing Region       \_SB_.PCI0.RP08.PXCS
[    0.132095] Initializing Region       \_SB_.PCI0.RP08.PXSX.PCCX
[    0.132104] Initializing Region       \_SB_.PCI0.LPCB.SMIE
[    0.132117] Initializing Region       \_SB_.PCI0.LPCB.SLPR
[    0.132129] Initializing Region       \_SB_.PCI0.LPCB.CPSB
[    0.132143] Initializing Region       \_SB_.PCI0.LPCB.LPCR
[    0.132193] Initializing Region       \_SB_.PCI0.LPCB.ECDV.ECOR
[    0.132270] Initializing Region       \_SB_.PCI0.GLAN.GLBA
[    0.132278] Initializing Region       \_SB_.PCI0.EHC1.PWCS
[    0.132286] Initializing Region       \_SB_.PCI0.EHC1.PWKE
[    0.132302] Initializing Region       \_SB_.PCI0.EHC2.PWCS
[    0.132309] Initializing Region       \_SB_.PCI0.EHC2.PWKE
[    0.132324] Initializing Region       \_SB_.PCI0.XHC_.XPRT
[    0.132333] Initializing Region       \_SB_.PCI0.XHC_.XHCP
[    0.132359] Initializing Region       \_SB_.PCI0.XHC_.PWCS
[    0.132666] Initializing BufferField  \_SB_.PCI0.GPI0.BMIN
[    0.132675] Initializing BufferField  \_SB_.PCI0.GPI0.BMAX
[    0.132759] Initializing Region       \_SB_.PCI0.HDEF.HDAR
[    0.132813] Initializing BufferField  \_SB_.PCI0.ADSP.B0VL
[    0.132821] Initializing BufferField  \_SB_.PCI0.ADSP.B1VL
[    0.132829] Initializing BufferField  \_SB_.PCI0.ADSP.IRQN
[    0.132852] Initializing BufferField  \_SB_.PCI0.SAT0.PIO0
[    0.132860] Initializing BufferField  \_SB_.PCI0.SAT0.DMA0
[    0.132868] Initializing BufferField  \_SB_.PCI0.SAT0.PIO1
[    0.132876] Initializing BufferField  \_SB_.PCI0.SAT0.DMA1
[    0.132883] Initializing BufferField  \_SB_.PCI0.SAT0.CHNF
[    0.132894] Initializing Region       \_SB_.PCI0.SBUS.SMBP
[    0.132902] Initializing Region       \_SB_.PCI0.SBUS.SMPB
[    0.132909] Initializing Region       \_SB_.PCI0.SBUS.SMBI
[    0.132937] Initializing Region       \_SB_.PCI0.MCHP
[    0.132994] Initializing Region       \_SB_.PCI0.TPCH.PCHT
[    0.133615] Initializing Region       \_SB_.RTCO
[    0.133630] Initializing Region       \_SB_.TPMI.SMIP
[    0.133638] Initializing Region       \_SB_.TPMI.FHCI
[    0.133645] Initializing Region       \_SB_.TPMI.TNVS
[    0.134112] Initializing Region       \EXBU
[    0.134121] Initializing Region       \DEGA
[    0.134170] Initializing Region       \PMIO
[    0.134207] Initializing Region       \LGPE
[    0.134235] Initializing Region       \GPR_
[    0.134275] Initializing Region       \GPRL
[    0.134307] Initializing Region       \PRT0
[    0.134314] Initializing Region       \SPRT
[    0.134325] Initializing Region       \USBD
[    0.134332] Initializing Region       \UBLK
[    0.134340] Initializing Region       \MBAR
[    0.134366] Initializing Region       \IO_H
[    0.134438] Initializing Region       \ABNV
[    0.134515] Initializing Region       \MENV
[    0.134630] Executing  Method       \_SB_._STA
[    0.134634] Executing  Method       \_SB_._INI
[    0.134641] Executing  Method       \_SB_.PCI0._STA
[    0.134645] Executing  Method       \_SB_.PCI0._INI
[    0.135975] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.137603] Executing  Method       \_SB_.PCI0.B0D3._STA
[    0.137627] Executing  Method       \_SB_.PCI0.B0D3._INI
[    0.137661] Executing  Method       \_SB_.PCI0.PEG0._STA
[    0.137664] Executing  Method       \_SB_.PCI0.PEG0._INI
[    0.137694] Executing  Method       \_SB_.PCI0.PEG1._STA
[    0.137697] Executing  Method       \_SB_.PCI0.PEG1._INI
[    0.137726] Executing  Method       \_SB_.PCI0.PEG2._STA
[    0.137729] Executing  Method       \_SB_.PCI0.PEG2._INI
[    0.137758] Executing  Method       \_SB_.PCI0.RP01._STA
[    0.137761] Executing  Method       \_SB_.PCI0.RP01._INI
[    0.137800] Executing  Method       \_SB_.PCI0.RP02._STA
[    0.137803] Executing  Method       \_SB_.PCI0.RP02._INI
[    0.137844] Executing  Method       \_SB_.PCI0.RP03._STA
[    0.137847] Executing  Method       \_SB_.PCI0.RP03._INI
[    0.137884] Executing  Method       \_SB_.PCI0.RP04._STA
[    0.137888] Executing  Method       \_SB_.PCI0.RP04._INI
[    0.137926] Executing  Method       \_SB_.PCI0.RP05._STA
[    0.137929] Executing  Method       \_SB_.PCI0.RP05._INI
[    0.137966] Executing  Method       \_SB_.PCI0.RP06._STA
[    0.137969] Executing  Method       \_SB_.PCI0.RP06._INI
[    0.138006] Executing  Method       \_SB_.PCI0.RP07._STA
[    0.138009] Executing  Method       \_SB_.PCI0.RP07._INI
[    0.138046] Executing  Method       \_SB_.PCI0.RP08._STA
[    0.138049] Executing  Method       \_SB_.PCI0.RP08._INI
[    0.138086] Executing  Method       \_SB_.PCI0.XHC_._STA
[    0.138090] Executing  Method       \_SB_.PCI0.XHC_._INI
[    0.138094] Executing  Method       \_SB_.PCI0.XHC_.RHUB._STA
[    0.138097] Executing  Method       \_SB_.PCI0.XHC_.RHUB._INI
[    0.138110] Executing  Method       \_SB_.PCI0.I2C0._STA
[    0.138139] Executing  Method       \_SB_.PCI0.I2C0._INI
[    0.138142] Executing  Method       \_SB_.PCI0.I2C0.ACD0._STA
[    0.138190] Executing  Method       \_SB_.PCI0.I2C0.ACD0._INI
[    0.138227] Executing  Method       \_SB_.PCI0.I2C0.ACD1._STA
[    0.138255] Executing  Method       \_SB_.PCI0.I2C0.ACD2._STA
[    0.138291] Executing  Method       \_SB_.PCI0.I2C0.ACD3._STA
[    0.138319] Executing  Method       \_SB_.PCI0.ADSP._STA
[    0.138352] Executing  Method       \_SB_.PCI0.ADSP._INI
[    0.138931] ACPI: Dynamic OEM Table Load:
[    0.138938] ACPI: SSDT 0xFFFF880214249C00 0003D3 (v02 PmRef  Cpu0Cst  00003001 INTL 20120913)
[    0.139805] ACPI: Dynamic OEM Table Load:
[    0.139812] ACPI: SSDT 0xFFFF880214205000 0005AA (v02 PmRef  ApIst    00003000 INTL 20120913)
[    0.140736] ACPI: Dynamic OEM Table Load:
[    0.140741] ACPI: SSDT 0xFFFF880214292C00 000119 (v02 PmRef  ApCst    00003000 INTL 20120913)
[    0.142328] ACPI : EC: EC started
[    0.142365] Executing  Method       \_SB_.PCI0.LPCB.ECDV._REG
[    0.151247] ACPI: Interpreter enabled
[    0.151256] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150410/hwxface-580)
[    0.151264] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150410/hwxface-580)
[    0.151278] ACPI: (supports S0 S3 S4 S5)
[    0.151281] ACPI: Using IOAPIC for interrupt routing
[    0.151309] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.153104] ACPI: Power Resource [PG00] (on)
[    0.153493] ACPI: Power Resource [PG01] (on)
[    0.153864] ACPI: Power Resource [PG02] (on)
[    0.154388] ACPI: Power Resource [PXP] (on)
[    0.155787] ACPI: Power Resource [PXP] (on)
[    0.159667] ACPI: Power Resource [PX05] (on)
[    0.160540] ACPI: Power Resource [PAUD] (on)
[    0.181212] ACPI: Power Resource [PXTC] (off)
[    0.182566] ACPI: Power Resource [P3PR] (off)
[    0.187744] ACPI: Power Resource [FN00] (off)
[    0.187809] ACPI: Power Resource [FN01] (off)
[    0.187873] ACPI: Power Resource [FN02] (off)
[    0.187935] ACPI: Power Resource [FN03] (off)
[    0.187999] ACPI: Power Resource [FN04] (off)
[    0.188825] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.188832] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.189416] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.189420] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.189842] PCI host bridge to bus 0000:00
[    0.189846] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.189848] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.189851] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.189854] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.189857] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    0.189860] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.189863] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    0.189866] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    0.189870] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.189873] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.189876] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.189879] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.189882] pci_bus 0000:00: root bus resource [mem 0xdf800000-0xfeafffff window]
[    0.189890] pci 0000:00:00.0: [8086:1604] type 00 class 0x060000
[    0.189975] pci 0000:00:02.0: [8086:1616] type 00 class 0x030000
[    0.189983] pci 0000:00:02.0: reg 0x10: [mem 0xf6000000-0xf6ffffff 64bit]
[    0.189987] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.189991] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.190069] pci 0000:00:03.0: [8086:160c] type 00 class 0x040300
[    0.190075] pci 0000:00:03.0: reg 0x10: [mem 0xf7218000-0xf721bfff 64bit]
[    0.190153] pci 0000:00:04.0: [8086:1603] type 00 class 0x118000
[    0.190161] pci 0000:00:04.0: reg 0x10: [mem 0xf7210000-0xf7217fff 64bit]
[    0.190256] pci 0000:00:14.0: [8086:9cb1] type 00 class 0x0c0330
[    0.190270] pci 0000:00:14.0: reg 0x10: [mem 0xf7200000-0xf720ffff 64bit]
[    0.190314] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.190372] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.190397] pci 0000:00:16.0: [8086:9cba] type 00 class 0x078000
[    0.190411] pci 0000:00:16.0: reg 0x10: [mem 0xf7221000-0xf722101f 64bit]
[    0.190460] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.190550] pci 0000:00:1c.0: [8086:9c90] type 01 class 0x060400
[    0.190599] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.190697] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.190727] pci 0000:00:1c.3: [8086:9c96] type 01 class 0x060400
[    0.190776] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.190870] pci 0000:00:1c.3: System wakeup disabled by ACPI
[    0.190903] pci 0000:00:1f.0: [8086:9cc3] type 00 class 0x060100
[    0.191061] pci 0000:00:1f.2: [8086:9c83] type 00 class 0x010601
[    0.191072] pci 0000:00:1f.2: reg 0x10: [io  0xf0b0-0xf0b7]
[    0.191077] pci 0000:00:1f.2: reg 0x14: [io  0xf0a0-0xf0a3]
[    0.191082] pci 0000:00:1f.2: reg 0x18: [io  0xf090-0xf097]
[    0.191088] pci 0000:00:1f.2: reg 0x1c: [io  0xf080-0xf083]
[    0.191093] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    0.191098] pci 0000:00:1f.2: reg 0x24: [mem 0xf721e000-0xf721e7ff]
[    0.191124] pci 0000:00:1f.2: PME# supported from D3hot
[    0.191189] pci 0000:00:1f.3: [8086:9ca2] type 00 class 0x0c0500
[    0.191201] pci 0000:00:1f.3: reg 0x10: [mem 0xf721d000-0xf721d0ff 64bit]
[    0.191217] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    0.191301] pci 0000:00:1f.6: [8086:9ca4] type 00 class 0x118000
[    0.191324] pci 0000:00:1f.6: reg 0x10: [mem 0xf721c000-0xf721cfff 64bit]
[    0.191529] pci 0000:01:00.0: [10ec:5249] type 00 class 0xff0000
[    0.191553] pci 0000:01:00.0: reg 0x10: [mem 0xf7100000-0xf7100fff]
[    0.191668] pci 0000:01:00.0: supports D1 D2
[    0.191669] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.191703] pci 0000:01:00.0: System wakeup disabled by ACPI
[    0.194735] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.194741] pci 0000:00:1c.0:   bridge window [mem 0xf7100000-0xf71fffff]
[    0.194844] pci 0000:02:00.0: [8086:095a] type 00 class 0x028000
[    0.194884] pci 0000:02:00.0: reg 0x10: [mem 0xf7000000-0xf7001fff 64bit]
[    0.195053] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.195099] pci 0000:02:00.0: System wakeup disabled by ACPI
[    0.196754] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    0.196760] pci 0000:00:1c.3:   bridge window [mem 0xf7000000-0xf70fffff]
[    0.200658] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.200724] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.200794] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.200858] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.200923] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.200985] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.201047] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.201109] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.202484] ACPI: Enabled 3 GPEs in block 00 to 7F
[    0.202550] ACPI : EC: GPE = 0x27, I/O: command/status = 0x934, data = 0x930
[    0.202693] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    0.202797] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.202800] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.202804] vgaarb: loaded
[    0.202806] vgaarb: bridge control possible 0000:00:02.0
[    0.202863] SCSI subsystem initialized
[    0.202894] libata version 3.00 loaded.
[    0.202910] ACPI: bus type USB registered
[    0.202926] usbcore: registered new interface driver usbfs
[    0.202933] usbcore: registered new interface driver hub
[    0.202946] usbcore: registered new device driver usb
[    0.205782] media: Linux media interface: v0.10
[    0.205790] Linux video capture interface: v2.00
[    0.205953] wmi: Mapper loaded
[    0.205975] Advanced Linux Sound Architecture Driver Initialized.
[    0.205988] PCI: Using ACPI for IRQ routing
[    0.207147] PCI: pci_cache_line_size set to 64 bytes
[    0.207209] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.207210] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.207211] e820: reserve RAM buffer [mem 0xc4a7d018-0xc7ffffff]
[    0.207212] e820: reserve RAM buffer [mem 0xc6444000-0xc7ffffff]
[    0.207213] e820: reserve RAM buffer [mem 0xdadbf000-0xdbffffff]
[    0.207214] e820: reserve RAM buffer [mem 0xdbaff000-0xdbffffff]
[    0.207215] e820: reserve RAM buffer [mem 0x21e800000-0x21fffffff]
[    0.207293] Bluetooth: Core ver 2.20
[    0.207298] NET: Registered protocol family 31
[    0.207301] Bluetooth: HCI device and connection manager initialized
[    0.207303] Bluetooth: HCI socket layer initialized
[    0.207306] Bluetooth: L2CAP socket layer initialized
[    0.207311] Bluetooth: SCO socket layer initialized
[    0.207372] NetLabel: Initializing
[    0.207375] NetLabel:  domain hash size = 128
[    0.207377] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.207390] NetLabel:  unlabeled traffic allowed by default
[    0.207431] cfg80211: Calling CRDA to update world regulatory domain
[    0.207488] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.207495] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.209520] Switched to clocksource hpet
[    0.216499] pnp: PnP ACPI init
[    0.216700] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.216704] system 00:00: [io  0xffff] has been reserved
[    0.216707] system 00:00: [io  0xffff] has been reserved
[    0.216709] system 00:00: [io  0xffff] has been reserved
[    0.216712] system 00:00: [io  0x1800-0x18fe] could not be reserved
[    0.216714] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.216719] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.216763] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.216794] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.216798] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.216927] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.216944] pnp 00:04: Plug and Play ACPI device, IDs DLL0665 PNP0f13 (active)
[    0.217103] system 00:05: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.217106] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.217109] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.217111] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.217114] system 00:05: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.217116] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.217119] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.217122] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.217124] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.217127] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.217130] system 00:05: [mem 0xf7fe0000-0xf7feffff] has been reserved
[    0.217133] system 00:05: [mem 0xf7ff0000-0xf7ffffff] has been reserved
[    0.217136] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.217534] system 00:06: [mem 0xfe102000-0xfe102fff] has been reserved
[    0.217537] system 00:06: [mem 0xfe104000-0xfe104fff] has been reserved
[    0.217540] system 00:06: [mem 0xfe106000-0xfe106fff] has been reserved
[    0.217542] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.221567]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[    0.222170] pnp: PnP ACPI: found 7 devices
[    0.227957] clocksource acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.227976] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.227982] pci 0000:00:1c.0:   bridge window [mem 0xf7100000-0xf71fffff]
[    0.227988] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    0.227993] pci 0000:00:1c.3:   bridge window [mem 0xf7000000-0xf70fffff]
[    0.228000] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.228002] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.228003] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.228004] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.228005] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.228006] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.228007] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.228008] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.228009] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.228010] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.228011] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.228012] pci_bus 0000:00: resource 15 [mem 0xdf800000-0xfeafffff window]
[    0.228013] pci_bus 0000:01: resource 1 [mem 0xf7100000-0xf71fffff]
[    0.228014] pci_bus 0000:02: resource 1 [mem 0xf7000000-0xf70fffff]
[    0.228046] NET: Registered protocol family 2
[    0.228186] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.228295] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.228400] TCP: Hash tables configured (established 65536 bind 65536)
[    0.228427] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.228448] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.228498] NET: Registered protocol family 1
[    0.228568] RPC: Registered named UNIX socket transport module.
[    0.228571] RPC: Registered udp transport module.
[    0.228573] RPC: Registered tcp transport module.
[    0.228575] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.228585] pci 0000:00:02.0: Video device with shadowed ROM
[    0.228772] PCI: CLS 64 bytes, default 64
[    0.228806] Unpacking initramfs...
[    0.430693] Freeing initrd memory: 18360K (ffff88003ee0d000 - ffff88003fffb000)
[    0.430724] dmar: ACPI device "INTL9C60:00" under DMAR at fed91000 as 00:15.0
[    0.430730] dmar: ACPI device "INT3438:00" under DMAR at fed91000 as 00:13.0
[    0.430740] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.430744] software IO TLB [mem 0xbe8fa000-0xc28fa000] (64MB) mapped at [ffff8800be8fa000-ffff8800c28f9fff]
[    0.431015] microcode: CPU0 sig=0x306d4, pf=0x40, revision=0x18
[    0.431022] microcode: CPU1 sig=0x306d4, pf=0x40, revision=0x18
[    0.431028] microcode: CPU2 sig=0x306d4, pf=0x40, revision=0x18
[    0.431034] microcode: CPU3 sig=0x306d4, pf=0x40, revision=0x18
[    0.431066] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    0.431298] AVX2 version of gcm_enc/dec engaged.
[    0.431302] AES CTR mode by8 optimization enabled
[    0.432748] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    0.433942] alg: No test for crc32 (crc32-pclmul)
[    0.434120] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.434133] Initialise system trusted keyring
[    0.434146] audit: initializing netlink subsys (disabled)
[    0.434155] audit: type=2000 audit(1437922915.413:1): initialized
[    0.434452] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.435403] zpool: loaded
[    0.435530] VFS: Disk quotas dquot_6.6.0
[    0.435554] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.435826] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
[    0.435919] fuse init (API version 7.23)
[    0.436012] Key type big_key registered
[    0.436015] SELinux:  Registering netfilter hooks
[    0.436812] alg: No test for stdrng (krng)
[    0.438540] NET: Registered protocol family 38
[    0.438548] Key type asymmetric registered
[    0.438552] Asymmetric key parser 'x509' registered
[    0.438584] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.438612] io scheduler noop registered
[    0.438616] io scheduler deadline registered
[    0.438629] io scheduler cfq registered (default)
[    0.438994] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    0.438998] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.439001] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    0.439015] pcieport 0000:00:1c.3: Signaling PME through PCIe PME interrupt
[    0.439018] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    0.439022] pcie_pme 0000:00:1c.3:pcie01: service driver pcie_pme loaded
[    0.439026] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.439038] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.439060] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.439094] efifb: probing for efifb
[    0.439131] efifb: framebuffer at 0xe0000000, mapped to 0xffffc90002000000, using 22500k, total 22500k
[    0.439135] efifb: mode is 3200x1800x32, linelength=12800, pages=1
[    0.439137] efifb: scrolling: redraw
[    0.439140] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.447683] Console: switching to colour frame buffer device 400x112
[    0.455653] fb0: EFI VGA frame buffer device
[    0.455676] intel_idle: MWAIT substates: 0x11142120
[    0.455677] intel_idle: v0.4 model 0x3D
[    0.455678] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.456263]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[    0.456320]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (CPU0, 81) node ffff8802158aff50
[    0.456368]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (CPU1, 81) node ffff8802158aff78
[    0.456416]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (CPU2, 81) node ffff8802158affa0
[    0.456464]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (CPU3, 81) node ffff8802158affc8
[    0.456999] ACPI: AC Adapter [AC] (off-line)
[    0.457137] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.457864] ACPI: Lid Switch [LID0]
[    0.457915] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.457942] ACPI: Power Button [PBTN]
[    0.457977] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.457998] ACPI: Sleep Button [SBTN]
[    0.458030] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.458053] ACPI: Power Button [PWRF]
[    0.458079]   evxface-0664 install_fixed_event_ha: Enabled fixed event PowerButton (2), Handler=ffffffff814c4e38
[    0.459406] thermal LNXTHERM:00: registered as thermal_zone0
[    0.459423] ACPI: Thermal Zone [THM] (25 C)
[    0.462802] thermal LNXTHERM:01: registered as thermal_zone1
[    0.462823] ACPI: Thermal Zone [TZ00] (66 C)
[    0.465841] thermal LNXTHERM:02: registered as thermal_zone2
[    0.465860] ACPI: Thermal Zone [TZ01] (66 C)
[    0.482059] ACPI: Battery Slot [BAT0] (battery present)
[    0.482127] GHES: HEST is not enabled!
[    0.482190] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.482643] Non-volatile memory driver v1.3
[    0.482682] Linux agpgart interface v0.103
[    0.482753] [drm] Initialized drm 1.1.0 20060810
[    0.483235] [drm] Memory usable by graphics device = 4096M
[    0.483253] checking generic (e0000000 15f9000) vs hw (e0000000 10000000)
[    0.483254] fb: switching to inteldrmfb from EFI VGA
[    0.483281] Console: switching to colour dummy device 80x25
[    0.483371] [drm] Replacing VGA console driver
[    0.483862] [drm] ACPI BIOS requests an excessive sleep of 10000 ms, using 1500 ms instead
[    0.490037] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.490042] [drm] Driver supports precise vblank timestamp query.
[    0.490134] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    0.505040] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    0.515135] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[    0.515157] fbcon: inteldrmfb (fb0) is primary device
[    0.515186] [drm] Initialized i915 1.6.0 20150327 for 0000:00:02.0 on minor 0
[    0.517921] rtsx_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    0.518044] rtsx_pci 0000:01:00.0: rtsx_pci_acquire_irq: pcr->msi_en = 1, pci->irq = 46
[    0.521301] ahci 0000:00:1f.2: version 3.0
[    0.521403] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.531735] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x8 impl SATA mode
[    0.531737] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo only pio slum part deso sadm sds apst 
[    0.532124] scsi host0: ahci
[    0.532346] scsi host1: ahci
[    0.532463] scsi host2: ahci
[    0.532550] scsi host3: ahci
[    0.532579] ata1: DUMMY
[    0.532580] ata2: DUMMY
[    0.532580] ata3: DUMMY
[    0.532581] ata4: SATA max UDMA/133 abar m2048@0xf721e000 port 0xf721e280 irq 47
[    0.532638] libphy: Fixed MDIO Bus: probed
[    0.532640] tun: Universal TUN/TAP device driver, 1.6
[    0.532640] tun: (C) 1999-2004 Max Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
[    0.532688] usbcore: registered new interface driver r8152
[    0.532694] usbcore: registered new interface driver cdc_ether
[    0.532845] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.532875] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.532939] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    0.532943] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.532994] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.532995] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.532996] usb usb1: Product: xHCI Host Controller
[    0.532996] usb usb1: Manufacturer: Linux 4.0.0+ xhci-hcd
[    0.532997] usb usb1: SerialNumber: 0000:00:14.0
[    0.533073] hub 1-0:1.0: USB hub found
[    0.533082] hub 1-0:1.0: 11 ports detected
[    0.536872] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.536896] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.536915] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    0.536915] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.536916] usb usb2: Product: xHCI Host Controller
[    0.536917] usb usb2: Manufacturer: Linux 4.0.0+ xhci-hcd
[    0.536917] usb usb2: SerialNumber: 0000:00:14.0
[    0.536976] hub 2-0:1.0: USB hub found
[    0.536982] hub 2-0:1.0: 4 ports detected
[    0.538344] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.538347] ehci-pci: EHCI PCI platform driver
[    0.538353] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.538358] ohci-pci: OHCI PCI platform driver
[    0.538364] uhci_hcd: USB Universal Host Controller Interface driver
[    0.538387] usbcore: registered new interface driver usb-storage
[    0.538404] usbcore: registered new interface driver usbserial
[    0.538407] usbcore: registered new interface driver usbserial_generic
[    0.538411] usbserial: USB Serial support registered for generic
[    0.538416] usbcore: registered new interface driver ftdi_sio
[    0.538419] usbserial: USB Serial support registered for FTDI USB Serial Device
[    0.538445] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.539076] i8042: Warning: Keylock active
[    0.541252] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.541254] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.541342] mousedev: PS/2 mouse device common for all mice
[    0.541651]   evxface-0664 install_fixed_event_ha: Enabled fixed event RealTimeClock (4), Handler=ffffffff81781a70
[    0.541656] rtc_cmos 00:01: RTC can wake from S4
[    0.541775] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    0.541797] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.541883] ACPI Warning: SystemIO range 0x000000000000F040-0x000000000000F05F conflicts with OpRegion 0x000000000000F040-0x000000000000F04F (\_SB_.PCI0.SBUS.SMBI) (20150410/utaddress-254)
[    0.541884] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    0.541909] usbcore: registered new interface driver uvcvideo
[    0.541909] USB Video Class driver (1.1.1)
[    0.543040] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[    0.544575] ACPI Warning: \_SB_.IETM._ART: Return Package type mismatch at index 0 - found Integer, expected Reference (20150410/nspredef-297)
[    0.544577] ACPI: Invalid package element [0]: got number, expecting [R]
[    0.578431] _ART package 0 is invalid, ignored
[    0.578431] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    0.597612] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    0.597655] iTCO_wdt: Found a Wildcat Point_LP TCO device (Version=2, TCOBASE=0x1860)
[    0.597779] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    0.597797] iTCO_vendor_support: vendor-support=0
[    0.597846] device-mapper: uevent: version 1.0.3
[    0.597972] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    0.598129] usbcore: registered new interface driver btusb
[    0.598140] Intel P-state driver initializing.
[    0.598295] sdhci: Secure Digital Host Controller Interface driver
[    0.598296] sdhci: Copyright(c) Pierre Ossman
[    0.602231] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    0.602245] EFI Variables Facility v0.08 2004-May-17
[    0.605110] hidraw: raw HID events driver (C) Jiri Kosina
[    0.605476] usbcore: registered new interface driver usbhid
[    0.605477] usbhid: USB HID core driver
[    0.628848] i2c_hid i2c-DLL0665:01: failed to retrieve report from device.
[    0.637072] i2c_hid i2c-DLL0665:01: failed to retrieve report from device.
[    0.637922] i2c_hid i2c-DLL0665:01: failed to retrieve report from device.
[    0.639875] i2c_hid i2c-DLL0665:01: failed to retrieve report from device.
[    0.639923] input: DLL0665:01 06CB:76AD UNKNOWN as /devices/pci0000:00/INT3433:00/i2c-1/i2c-DLL0665:01/0018:06CB:76AD.0001/input/input8
[    0.640241] hid-multitouch 0018:06CB:76AD.0001: input,hidraw0: <UNKNOWN> HID v1.00 Mouse [DLL0665:01 06CB:76AD] on 
[    0.641551] input: Dell WMI hotkeys as /devices/virtual/input/input10
[    0.642201] snd_hda_intel 0000:00:03.0: enabling device (0000 -> 0002)
[    0.642334] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops)
[    0.642439] drop_monitor: Initializing network drop monitor service
[    0.642473] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[    0.642911] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.642980] Initializing XFRM netlink socket
[    0.643304] NET: Registered protocol family 10
[    0.643510] mip6: Mobile IPv6
[    0.643517] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    0.643732] NET: Registered protocol family 17
[    0.643745] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
[    0.643748] Ebtables v2.0 registered
[    0.644245] Loading compiled-in X.509 certificates
[    0.647757] Loaded X.509 cert 'Magrathea: Glacier signing key: fc047a540e21515ad039688bb8a1cf32a880e5c8'
[    0.648061] registered taskstats version 1
[    0.648514] rtc_cmos 00:01: setting system clock to 2015-07-26 15:01:56 UTC (1437922916)
[    0.648657] ALSA device list:
[    0.648657]   #0: HDA Intel HDMI at 0xf7218000 irq 49
[    0.889999] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    1.054881] usb 1-3: No LPM exit latency info found, disabling LPM.
[    1.056038] usb 1-3: New USB device found, idVendor=8087, idProduct=0a2a
[    1.056039] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.070998] Bluetooth: hci0: read Intel version: 370810011003110e00
[    1.071024] bluetooth hci0: Direct firmware load for intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq failed with error -2
[    1.071025] Bluetooth: hci0 failed to open Intel firmware file: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq(-2)
[    1.071033] bluetooth hci0: Direct firmware load for intel/ibt-hw-37.8.bseq failed with error -2
[    1.071033] Bluetooth: hci0 failed to open default Intel fw file: intel/ibt-hw-37.8.bseq
[    1.128287]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[    1.210206] usb 1-4: new full-speed USB device number 3 using xhci_hcd
[    1.376524] usb 1-4: New USB device found, idVendor=04f3, idProduct=20d0
[    1.376526] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
[    1.376527] usb 1-4: Product: Touchscreen
[    1.376528] usb 1-4: Manufacturer: ELAN
[    1.376729] usb 1-4: ep 0x2 - rounding interval to 64 microframes, ep desc says 80 microframes
[    1.385389] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:20D0.0002/input/input11
[    1.385910] hid-multitouch 0003:04F3:20D0.0002: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
[    1.433404] tsc: Refined TSC clocksource calibration: 2593.990 MHz
[    1.433410] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x25640ebfed9, max_idle_ns: 440795320785 ns
[    1.538379] usb 1-5: new high-speed USB device number 4 using xhci_hcd
[    1.592848] Console: switching to colour frame buffer device 400x112
[    1.682598] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    1.682599] i915 0000:00:02.0: registered panic notifier
[    1.726638] usb 1-5: New USB device found, idVendor=0bda, idProduct=5682
[    1.728415] usb 1-5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    1.729953] usb 1-5: Product: Integrated_Webcam_HD
[    1.731416] usb 1-5: Manufacturer: CKFEH41F301030009340
[    1.732891] usb 1-5: SerialNumber: 200901010001
[    1.737619] uvcvideo: Found UVC 1.00 device Integrated_Webcam_HD (0bda:5682)
[    1.744001] input: Integrated_Webcam_HD as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input13
[    1.993722] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.997466] ata4.00: failed to get NCQ Send/Recv Log Emask 0x1
[    1.997469] ata4.00: ATA-9: SAMSUNG SSD PM851 M.2 2280 256GB, EXT25D0Q, max UDMA/133
[    1.999193] ata4.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.000995] ata4.00: failed to get NCQ Send/Recv Log Emask 0x1
[    2.001031] ata4.00: configured for UDMA/133
[    2.002644] scsi 3:0:0:0: Direct-Access     ATA      SAMSUNG SSD PM85 5D0Q PQ: 0 ANSI: 5
[    2.004361] sd 3:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    2.004399] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    2.007611] sd 3:0:0:0: [sda] Write Protect is off
[    2.009100] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.009107] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.012288]  sda: sda1 sda2 sda3
[    2.014323] sd 3:0:0:0: [sda] Attached SCSI disk
[    2.016159] Freeing unused kernel memory: 1680K (ffffffff823af000 - ffffffff82553000)
[    2.017723] Write protecting the kernel read-only data: 18432k
[    2.019450] Freeing unused kernel memory: 508K (ffff880001b81000 - ffff880001c00000)
[    2.021209] Freeing unused kernel memory: 1244K (ffff8800020c9000 - ffff880002200000)
[    2.027486] random: systemd urandom read with 81 bits of entropy available
[    2.029942] systemd[1]: systemd 216 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    2.031667] systemd[1]: Detected architecture 'x86-64'.
[    2.033287] systemd[1]: Running in initial RAM disk.
[    2.040050] systemd[1]: Set hostname to <mfleming-mobl1.ger.corp.intel.com>.
[    2.063606] systemd[1]: Expecting device dev-disk-by\x2duuid-AF27\x2d22C8.device...
[    2.066933] systemd[1]: Expecting device dev-mapper-fedora\x2dswap.device...
[    2.070261] systemd[1]: Expecting device dev-disk-by\x2duuid-e75ed791\x2dd3e4\x2d480d\x2daa9f\x2d499f34a15b23.device...
[    2.073594] systemd[1]: Expecting device dev-mapper-fedora\x2droot.device...
[    2.076951] systemd[1]: Starting Timers.
[    2.080225] systemd[1]: Reached target Timers.
[    2.081817] systemd[1]: Expecting device dev-disk-by\x2duuid-26312b50\x2dd793\x2d4686\x2da576\x2d28b32bee5a21.device...
[    2.085200] systemd[1]: Expecting device dev-mapper-luks\x2d26312b50\x2dd793\x2d4686\x2da576\x2d28b32bee5a21.device...
[    2.088478] systemd[1]: Starting -.slice.
[    2.095337] systemd[1]: Created slice -.slice.
[    2.096945] systemd[1]: Starting udev Control Socket.
[    2.100227] systemd[1]: Listening on udev Control Socket.
[    2.101827] systemd[1]: Starting udev Kernel Socket.
[    2.105091] systemd[1]: Listening on udev Kernel Socket.
[    2.106657] systemd[1]: Starting Journal Socket.
[    2.109904] systemd[1]: Listening on Journal Socket.
[    2.111488] systemd[1]: Starting System Slice.
[    2.114859] systemd[1]: Created slice System Slice.
[    2.116445] systemd[1]: Started dracut ask for additional cmdline parameters.
[    2.118073] systemd[1]: Starting dracut cmdline hook...
[    2.121514] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    2.124979] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    2.126669] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    2.130309] systemd[1]: Starting system-systemd\x2dcryptsetup.slice.
[    2.134123] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
[    2.135762] systemd[1]: Starting Journal Socket (/dev/log).
[    2.137628] systemd[1]: Starting Slices.
[    2.141221] systemd[1]: Reached target Slices.
[    2.142834] systemd[1]: Starting Setup Virtual Console...
[    2.146490] systemd[1]: Started Load Kernel Modules.
[    2.148116] systemd[1]: Starting Apply Kernel Variables...
[    2.162120] systemd[1]: Starting Swap.
[    2.168223] systemd[1]: Reached target Swap.
[    2.171263] systemd[1]: Starting Local File Systems.
[    2.177399] systemd[1]: Reached target Local File Systems.
[    2.183979] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    2.190467] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.196937] systemd[1]: Started Apply Kernel Variables.
[    2.203330] systemd[1]: Started dracut cmdline hook.
[    2.211283] systemd[1]: Starting dracut pre-udev hook...
[    2.217606] systemd[1]: Starting Sockets.
[    2.223499] systemd[1]: Reached target Sockets.
[    2.225412] systemd[1]: Starting Journal Service...
[    2.229143] systemd[1]: Starting Create Static Device Nodes in /dev...
[    2.236303] systemd[1]: Started Setup Virtual Console.
[    2.240688] systemd[1]: Started Create Static Device Nodes in /dev.
[    2.243927] systemd[1]: Started dracut pre-udev hook.
[    2.247817] systemd[1]: Starting udev Kernel Device Manager...
[    2.255156] systemd[1]: Started udev Kernel Device Manager.
[    2.258248] systemd[1]: Started Journal Service.
[    2.434096] Switched to clocksource tsc
[    3.082655]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[    3.356550] cfg80211: Calling CRDA to update world regulatory domain
[    3.922408] random: nonblocking pool is initialized
[    5.297146]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[    6.502478] cfg80211: Calling CRDA to update world regulatory domain
[    7.245333]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[    8.031733]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [BAT0] (Device) Value 0x80 (Status Change) Node ffff8802158c3848
[    9.189996]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[    9.299384] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
[    9.567098] systemd-journald[329]: Received SIGTERM from PID 1 (systemd).
[    9.656345] cfg80211: Calling CRDA to update world regulatory domain
[    9.788153] audit: type=1404 audit(1437922925.633:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[    9.835622] SELinux: 32768 avtab hash slots, 105179 rules.
[    9.846337] SELinux: 32768 avtab hash slots, 105179 rules.
[    9.865029] SELinux:  8 users, 103 roles, 4998 types, 294 bools, 1 sens, 1024 cats
[    9.865032] SELinux:  83 classes, 105179 rules
[    9.867805] SELinux:  Permission audit_read in class capability2 not defined in policy.
[    9.869051] SELinux:  Class binder not defined in policy.
[    9.870302] SELinux: the above unknown classes and permissions will be allowed
[    9.871565] SELinux:  Completing initialization.
[    9.871565] SELinux:  Setting up existing superblocks.
[    9.876661] audit: type=1403 audit(1437922925.721:3): policy loaded auid=4294967295 ses=4294967295
[    9.881145] systemd[1]: Successfully loaded SELinux policy in 98.589ms.
[    9.927710] systemd[1]: RTC configured in localtime, applying delta of 60 minutes to system time.
[    9.953423] systemd[1]: Relabelled /dev and /run in 13.901ms.
[   10.445206] EXT4-fs (dm-2): re-mounted. Opts: (null)
[   10.467314] systemd-journald[688]: Received request to flush runtime journal from PID 1
[   11.144360]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[   12.225684] sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
[   12.247948] (NULL device *): Direct firmware load for intel/IntcPP01.bin failed with error -2
[   12.250139] (NULL device *): fw image intel/IntcPP01.bin not available(-2)
[   12.252737] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[   12.274157] Intel(R) Wireless WiFi driver for Linux
[   12.275839] Copyright(c) 2003- 2015 Intel Corporation
[   12.277375] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[   12.281280] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-7265D-13.ucode failed with error -2
[   12.295783] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mapping ok
[   12.298413] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapping ok
[   12.301010] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapping ok
[   12.303580] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapping ok
[   12.308338] iwlwifi 0000:02:00.0: loaded firmware version 25.17.12.0 op_mode iwlmvm
[   12.309390] broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mapping ok
[   12.320988] Adding 8126460k swap on /dev/mapper/fedora-swap.  Priority:-1 extents:1 across:8126460k SSFS
[   12.322155] input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwell-audio/sound/card1/input14
[   12.768663] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 7265, REV=0x210
[   12.770155] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[   12.771762] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[   12.810237] cfg80211: Calling CRDA to update world regulatory domain
[   12.834958] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   12.835921] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   12.932714] cfg80211: World regulatory domain updated:
[   12.934226] cfg80211:  DFS Master region: unset
[   12.934237] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
[   12.937100] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
[   12.938770] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
[   12.940195] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2000 mBm), (N/A)
[   12.941594] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
[   12.942981] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[   12.944379] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, 2000 mBm), (0 s)
[   12.945756] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2000 mBm), (N/A)
[   12.947229] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: (null)
[   12.949216] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 0 mBm), (N/A)
[   13.004247] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[   13.018044] FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   13.099059]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[   13.166806] audit: type=1305 audit(1437919329.009:4): audit_pid=847 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
[   13.636905] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[   13.637112] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[   13.733809] psmouse serio1: Failed to deactivate mouse on isa0060/serio1
[   14.199195] psmouse serio1: Failed to enable mouse on isa0060/serio1
[   14.588209] device virbr0-nic entered promiscuous mode
[   14.591501] virbr0: port 1(virbr0-nic) entered forwarding state
[   14.591510] virbr0: port 1(virbr0-nic) entered forwarding state
[   14.784693] virbr0: port 1(virbr0-nic) entered disabled state
[   15.297972]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[   17.251797]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[   18.403963] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input7
[   18.605882] psmouse serio1: Failed to enable mouse on isa0060/serio1
[   19.206355]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[   20.572826] wlp2s0: authenticate with a8:54:b2:90:ca:e4
[   20.576759] wlp2s0: send auth to a8:54:b2:90:ca:e4 (try 1/3)
[   20.578682] wlp2s0: authenticated
[   20.578999] wlp2s0: associate with a8:54:b2:90:ca:e4 (try 1/3)
[   20.582670] wlp2s0: RX AssocResp from a8:54:b2:90:ca:e4 (capab=0x431 status=0 aid=1)
[   20.583973] wlp2s0: associated
[   21.163253]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[   23.114762]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[   25.069126]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[   27.037155]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[   29.487448] Adjusting tsc more than 11% (5419137 vs 7179175)
[   37.791337]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [AMW0] (Device) Value 0xD0 (Hardware-Specific) Node ffff8802158bf1e0
[   37.806763]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [LCD_] (Device) Value 0x87 (Device-Specific) Node ffff8802158bfa50
[   64.306679] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[  320.512651] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[ 3193.010029] perf interrupt took too long (2507 > 2500), lowering kernel.perf_event_max_sample_rate to 50000
[ 4660.044644] IPv6: ADDRCONF(NETDEV_CHANGE): vpn0: link becomes ready
[ 4660.759309] IPv6: ADDRCONF(NETDEV_CHANGE): vpn0: link becomes ready
[ 4673.091918] device vnet0 entered promiscuous mode
[ 4673.093850] virbr0: port 2(vnet0) entered listening state
[ 4673.093860] virbr0: port 2(vnet0) entered listening state
[ 4673.601476] kvm: zapping shadow pages for mmio generation wraparound
[ 4675.102019] virbr0: port 2(vnet0) entered learning state
[ 4677.107252] virbr0: topology change detected, propagating
[ 4677.107263] virbr0: port 2(vnet0) entered forwarding state
[ 4689.796710] nf_conntrack: automatic helper assignment is deprecated and it will be removed soon. Use the iptables CT target to attach helpers instead.
[ 5343.661577] virbr0: port 2(vnet0) entered disabled state
[ 5343.662070] device vnet0 left promiscuous mode
[ 5343.662095] virbr0: port 2(vnet0) entered disabled state
[20917.044276]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [AC__] (Device) Value 0x80 (Status Change) Node ffff8802158c3758
[20917.044326]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [BAT0] (Device) Value 0x80 (Status Change) Node ffff8802158c3848
[20917.045204]    evmisc-0146 ev_queue_notify_reques: No notify handler for Notify, ignoring (PCCD, 82) node ffff8802158e8fc8
[20917.045239]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [CPU0] (Processor) Value 0x81 (Information Change) Node ffff8802158aff50
[20917.045266]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [CPU1] (Processor) Value 0x81 (Information Change) Node ffff8802158aff78
[20917.045291]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [CPU2] (Processor) Value 0x81 (Information Change) Node ffff8802158affa0
[20917.045316]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [CPU3] (Processor) Value 0x81 (Information Change) Node ffff8802158affc8
[20917.172364] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[20920.605614]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [BAT0] (Device) Value 0x80 (Status Change) Node ffff8802158c3848
[30244.861386]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [BAT0] (Device) Value 0x80 (Status Change) Node ffff8802158c3848
[47597.023554] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[71744.643242] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[72355.165743] device vnet0 entered promiscuous mode
[72355.171722] virbr0: port 2(vnet0) entered listening state
[72355.171733] virbr0: port 2(vnet0) entered listening state
[72355.706258] kvm: zapping shadow pages for mmio generation wraparound
[72357.175584] virbr0: port 2(vnet0) entered learning state
[72359.180813] virbr0: topology change detected, propagating
[72359.180827] virbr0: port 2(vnet0) entered forwarding state
[72509.746610] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[79642.220531] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[79670.600446] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[79744.346081] virbr0: port 2(vnet0) entered disabled state
[79744.347022] device vnet0 left promiscuous mode
[79744.347043] virbr0: port 2(vnet0) entered disabled state
[79744.422192] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[79971.465636]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [AMW0] (Device) Value 0xD0 (Hardware-Specific) Node ffff8802158bf1e0
[79971.466132]    evmisc-0171 ev_queue_notify_reques: Dispatching Notify on [LCD_] (Device) Value 0x87 (Device-Specific) Node ffff8802158bfa50
[80477.323500] usb 1-1: new low-speed USB device number 5 using xhci_hcd
[80477.492206] usb 1-1: New USB device found, idVendor=046d, idProduct=c404
[80477.492212] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[80477.492215] usb 1-1: Product: Trackball
[80477.492217] usb 1-1: Manufacturer: Logitech
[80477.493368] usb 1-1: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[80477.498167] input: Logitech Trackball as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:046D:C404.0003/input/input15
[80477.498690] hid-generic 0003:046D:C404.0003: input,hidraw2: USB HID v1.10 Mouse [Logitech Trackball] on usb-0000:00:14.0-1/input0
[83553.913804] iwlwifi 0000:02:00.0: Queue 16 stuck for 10000 ms.
[83553.913818] iwlwifi 0000:02:00.0: Current SW read_ptr 183 write_ptr 218
[83553.913861] iwl data: 00000000: bf 00 00 00 00 00 00 00 00 00 80 ff 00 00 00 00  ................
[83553.913886] iwlwifi 0000:02:00.0: FH TRBs(0) = 0x00000000
[83553.913910] iwlwifi 0000:02:00.0: FH TRBs(1) = 0xc01100c5
[83553.913931] iwlwifi 0000:02:00.0: FH TRBs(2) = 0x00000000
[83553.913952] iwlwifi 0000:02:00.0: FH TRBs(3) = 0x803000be
[83553.913973] iwlwifi 0000:02:00.0: FH TRBs(4) = 0x00000000
[83553.913994] iwlwifi 0000:02:00.0: FH TRBs(5) = 0x00000000
[83553.914015] iwlwifi 0000:02:00.0: FH TRBs(6) = 0x00000000
[83553.914036] iwlwifi 0000:02:00.0: FH TRBs(7) = 0x0070904f
[83553.914099] iwlwifi 0000:02:00.0: Q 0 is active and mapped to fifo 3 ra_tid 0x0000 [191,191]
[83553.914160] iwlwifi 0000:02:00.0: Q 1 is active and mapped to fifo 2 ra_tid 0x0000 [0,0]
[83553.914222] iwlwifi 0000:02:00.0: Q 2 is active and mapped to fifo 1 ra_tid 0x0000 [1,1]
[83553.914284] iwlwifi 0000:02:00.0: Q 3 is active and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.914346] iwlwifi 0000:02:00.0: Q 4 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.914408] iwlwifi 0000:02:00.0: Q 5 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.914470] iwlwifi 0000:02:00.0: Q 6 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.914528] iwlwifi 0000:02:00.0: Q 7 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.914591] iwlwifi 0000:02:00.0: Q 8 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.914653] iwlwifi 0000:02:00.0: Q 9 is active and mapped to fifo 7 ra_tid 0x0000 [80,80]
[83553.914723] iwlwifi 0000:02:00.0: Q 10 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.914785] iwlwifi 0000:02:00.0: Q 11 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.914847] iwlwifi 0000:02:00.0: Q 12 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.914909] iwlwifi 0000:02:00.0: Q 13 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.914971] iwlwifi 0000:02:00.0: Q 14 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.915033] iwlwifi 0000:02:00.0: Q 15 is active and mapped to fifo 5 ra_tid 0x0000 [0,0]
[83553.915095] iwlwifi 0000:02:00.0: Q 16 is active and mapped to fifo 1 ra_tid 0x0000 [183,218]
[83553.915157] iwlwifi 0000:02:00.0: Q 17 is inactive and mapped to fifo 3 ra_tid 0x0007 [57,57]
[83553.915219] iwlwifi 0000:02:00.0: Q 18 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.915281] iwlwifi 0000:02:00.0: Q 19 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[83553.915354] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x2000000.
[83553.915358] iwlwifi 0000:02:00.0: CSR values:
[83553.915360] iwlwifi 0000:02:00.0: (2nd byte of CSR_INT_COALESCING is CSR_INT_PERIODIC_REG)
[83553.915375] iwlwifi 0000:02:00.0:        CSR_HW_IF_CONFIG_REG: 0X00489200
[83553.915390] iwlwifi 0000:02:00.0:          CSR_INT_COALESCING: 0X00000040
[83553.915406] iwlwifi 0000:02:00.0:                     CSR_INT: 0X00000000
[83553.915421] iwlwifi 0000:02:00.0:                CSR_INT_MASK: 0X00000000
[83553.915436] iwlwifi 0000:02:00.0:           CSR_FH_INT_STATUS: 0X00000000
[83553.915452] iwlwifi 0000:02:00.0:                 CSR_GPIO_IN: 0X00000000
[83553.915467] iwlwifi 0000:02:00.0:                   CSR_RESET: 0X00000000
[83553.915482] iwlwifi 0000:02:00.0:                CSR_GP_CNTRL: 0X080403c5
[83553.915497] iwlwifi 0000:02:00.0:                  CSR_HW_REV: 0X00000210
[83553.915513] iwlwifi 0000:02:00.0:              CSR_EEPROM_REG: 0Xd55555d5
[83553.915528] iwlwifi 0000:02:00.0:               CSR_EEPROM_GP: 0X00000000
[83553.915543] iwlwifi 0000:02:00.0:              CSR_OTP_GP_REG: 0Xd55555d5
[83553.915559] iwlwifi 0000:02:00.0:                 CSR_GIO_REG: 0X00080042
[83553.915574] iwlwifi 0000:02:00.0:            CSR_GP_UCODE_REG: 0X00000000
[83553.915589] iwlwifi 0000:02:00.0:           CSR_GP_DRIVER_REG: 0X00000000
[83553.915604] iwlwifi 0000:02:00.0:           CSR_UCODE_DRV_GP1: 0X00000000
[83553.915620] iwlwifi 0000:02:00.0:           CSR_UCODE_DRV_GP2: 0X00000000
[83553.915635] iwlwifi 0000:02:00.0:                 CSR_LED_REG: 0X00000060
[83553.915650] iwlwifi 0000:02:00.0:        CSR_DRAM_INT_TBL_REG: 0X880d9476
[83553.915665] iwlwifi 0000:02:00.0:        CSR_GIO_CHICKEN_BITS: 0X27800200
[83553.915681] iwlwifi 0000:02:00.0:             CSR_ANA_PLL_CFG: 0Xd55555d5
[83553.915696] iwlwifi 0000:02:00.0:      CSR_MONITOR_STATUS_REG: 0Xebb7fff7
[83553.915711] iwlwifi 0000:02:00.0:           CSR_HW_REV_WA_REG: 0X0001001a
[83553.915727] iwlwifi 0000:02:00.0:        CSR_DBG_HPET_MEM_REG: 0Xffff0010
[83553.915729] iwlwifi 0000:02:00.0: FH register values:
[83553.915752] iwlwifi 0000:02:00.0:         FH_RSCSR_CHNL0_STTS_WPTR_REG: 0X2131d100
[83553.915764] iwlwifi 0000:02:00.0:        FH_RSCSR_CHNL0_RBDCB_BASE_REG: 0X021033e0
[83553.915777] iwlwifi 0000:02:00.0:                  FH_RSCSR_CHNL0_WPTR: 0X00000078
[83553.915794] iwlwifi 0000:02:00.0:         FH_MEM_RCSR_CHNL0_CONFIG_REG: 0X00801114
[83553.915817] iwlwifi 0000:02:00.0:          FH_MEM_RSSR_SHARED_CTRL_REG: 0X000000fc
[83553.915829] iwlwifi 0000:02:00.0:            FH_MEM_RSSR_RX_STATUS_REG: 0X03030000
[83553.915842] iwlwifi 0000:02:00.0:    FH_MEM_RSSR_RX_ENABLE_ERR_IRQ2DRV: 0X00000000
[83553.915854] iwlwifi 0000:02:00.0:                FH_TSSR_TX_STATUS_REG: 0X07ff0001
[83553.915867] iwlwifi 0000:02:00.0:                 FH_TSSR_TX_ERROR_REG: 0X00000000
[83553.915985] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[83553.915987] iwlwifi 0000:02:00.0: Status: 0x00000000, count: 6
[83553.915989] iwlwifi 0000:02:00.0: Loaded firmware version: 25.17.12.0
[83553.915992] iwlwifi 0000:02:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN       
[83553.915994] iwlwifi 0000:02:00.0: 0x000006F0 | uPc
[83553.915996] iwlwifi 0000:02:00.0: 0x00000000 | branchlink1
[83553.915998] iwlwifi 0000:02:00.0: 0x00042870 | branchlink2
[83553.916000] iwlwifi 0000:02:00.0: 0x00043154 | interruptlink1
[83553.916002] iwlwifi 0000:02:00.0: 0x00016F0A | interruptlink2
[83553.916004] iwlwifi 0000:02:00.0: 0x00000000 | data1
[83553.916006] iwlwifi 0000:02:00.0: 0x00000080 | data2
[83553.916007] iwlwifi 0000:02:00.0: 0x07030000 | data3
[83553.916009] iwlwifi 0000:02:00.0: 0x7440117A | beacon time
[83553.916011] iwlwifi 0000:02:00.0: 0x01D31E85 | tsf low
[83553.916013] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[83553.916015] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[83553.916017] iwlwifi 0000:02:00.0: 0x705033DE | time gp2
[83553.916019] iwlwifi 0000:02:00.0: 0x00000000 | time gp3
[83553.916021] iwlwifi 0000:02:00.0: 0x00041911 | uCode version
[83553.916023] iwlwifi 0000:02:00.0: 0x00000210 | hw version
[83553.916025] iwlwifi 0000:02:00.0: 0x00489200 | board version
[83553.916027] iwlwifi 0000:02:00.0: 0x0000001C | hcmd
[83553.916029] iwlwifi 0000:02:00.0: 0x00022002 | isr0
[83553.916030] iwlwifi 0000:02:00.0: 0x01800000 | isr1
[83553.916032] iwlwifi 0000:02:00.0: 0x0000000A | isr2
[83553.916034] iwlwifi 0000:02:00.0: 0x004150C0 | isr3
[83553.916036] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[83553.916038] iwlwifi 0000:02:00.0: 0x00000110 | isr_pref
[83553.916040] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[83553.916042] iwlwifi 0000:02:00.0: 0x0000822E | l2p_control
[83553.916044] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[83553.916045] iwlwifi 0000:02:00.0: 0x00000003 | l2p_mhvalid
[83553.916047] iwlwifi 0000:02:00.0: 0x00000020 | l2p_addr_match
[83553.916049] iwlwifi 0000:02:00.0: 0x00000005 | lmpm_pmg_sel
[83553.916051] iwlwifi 0000:02:00.0: 0x13041313 | timestamp
[83553.916053] iwlwifi 0000:02:00.0: 0x00347888 | flow_handler
[83553.916058] ieee80211 phy0: Hardware restart was requested
[83554.069281] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[83554.069490] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[84508.835973] wlp2s0: deauthenticating from a8:54:b2:90:ca:e4 by local choice (Reason: 3=DEAUTH_LEAVING)
[84512.600959] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[84512.601164] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[84519.492837] wlp2s0: authenticate with a8:54:b2:90:ca:e4
[84519.496057] wlp2s0: send auth to a8:54:b2:90:ca:e4 (try 1/3)
[84519.497917] wlp2s0: authenticated
[84519.498621] wlp2s0: associate with a8:54:b2:90:ca:e4 (try 1/3)
[84519.501851] wlp2s0: RX AssocResp from a8:54:b2:90:ca:e4 (capab=0x431 status=0 aid=1)
[84519.503353] wlp2s0: associated
[85292.570104] IPv6: ADDRCONF(NETDEV_CHANGE): vpn0: link becomes ready
[85292.963273] IPv6: ADDRCONF(NETDEV_CHANGE): vpn0: link becomes ready
[86864.871805] iwlwifi 0000:02:00.0: Queue 2 stuck for 10000 ms.
[86864.871810] iwlwifi 0000:02:00.0: Current SW read_ptr 167 write_ptr 229
[86864.871852] iwl data: 00000000: 00 00 00 00 00 00 00 00 80 ff 3f 00 00 00 00 00  ..........?.....
[86864.871876] iwlwifi 0000:02:00.0: FH TRBs(0) = 0x00000000
[86864.871897] iwlwifi 0000:02:00.0: FH TRBs(1) = 0x801020b5
[86864.871918] iwlwifi 0000:02:00.0: FH TRBs(2) = 0x00000000
[86864.871939] iwlwifi 0000:02:00.0: FH TRBs(3) = 0x8030001f
[86864.871960] iwlwifi 0000:02:00.0: FH TRBs(4) = 0x00000000
[86864.871981] iwlwifi 0000:02:00.0: FH TRBs(5) = 0x00000000
[86864.872002] iwlwifi 0000:02:00.0: FH TRBs(6) = 0x00000000
[86864.872022] iwlwifi 0000:02:00.0: FH TRBs(7) = 0x00709083
[86864.872085] iwlwifi 0000:02:00.0: Q 0 is active and mapped to fifo 3 ra_tid 0x0000 [32,32]
[86864.872146] iwlwifi 0000:02:00.0: Q 1 is active and mapped to fifo 2 ra_tid 0x0000 [0,0]
[86864.872208] iwlwifi 0000:02:00.0: Q 2 is active and mapped to fifo 1 ra_tid 0x0000 [167,229]
[86864.872270] iwlwifi 0000:02:00.0: Q 3 is active and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.872331] iwlwifi 0000:02:00.0: Q 4 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.872390] iwlwifi 0000:02:00.0: Q 5 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.872448] iwlwifi 0000:02:00.0: Q 6 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.872550] iwlwifi 0000:02:00.0: Q 7 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.872656] iwlwifi 0000:02:00.0: Q 8 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.872761] iwlwifi 0000:02:00.0: Q 9 is active and mapped to fifo 7 ra_tid 0x0000 [132,132]
[86864.872845] iwlwifi 0000:02:00.0: Q 10 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.872906] iwlwifi 0000:02:00.0: Q 11 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.872955] iwlwifi 0000:02:00.0: Q 12 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.873005] iwlwifi 0000:02:00.0: Q 13 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.873064] iwlwifi 0000:02:00.0: Q 14 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.873126] iwlwifi 0000:02:00.0: Q 15 is active and mapped to fifo 5 ra_tid 0x0000 [0,0]
[86864.873188] iwlwifi 0000:02:00.0: Q 16 is inactive and mapped to fifo 1 ra_tid 0x0000 [241,241]
[86864.873250] iwlwifi 0000:02:00.0: Q 17 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.873298] iwlwifi 0000:02:00.0: Q 18 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.873347] iwlwifi 0000:02:00.0: Q 19 is inactive and mapped to fifo 0 ra_tid 0x0000 [0,0]
[86864.873403] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x2000000.
[86864.873405] iwlwifi 0000:02:00.0: CSR values:
[86864.873407] iwlwifi 0000:02:00.0: (2nd byte of CSR_INT_COALESCING is CSR_INT_PERIODIC_REG)
[86864.873419] iwlwifi 0000:02:00.0:        CSR_HW_IF_CONFIG_REG: 0X00489200
[86864.873434] iwlwifi 0000:02:00.0:          CSR_INT_COALESCING: 0X00000040
[86864.873446] iwlwifi 0000:02:00.0:                     CSR_INT: 0X00000000
[86864.873457] iwlwifi 0000:02:00.0:                CSR_INT_MASK: 0X00000000
[86864.873469] iwlwifi 0000:02:00.0:           CSR_FH_INT_STATUS: 0X00000000
[86864.873481] iwlwifi 0000:02:00.0:                 CSR_GPIO_IN: 0X00000000
[86864.873497] iwlwifi 0000:02:00.0:                   CSR_RESET: 0X00000000
[86864.873512] iwlwifi 0000:02:00.0:                CSR_GP_CNTRL: 0X080403c5
[86864.873527] iwlwifi 0000:02:00.0:                  CSR_HW_REV: 0X00000210
[86864.873543] iwlwifi 0000:02:00.0:              CSR_EEPROM_REG: 0Xd55555d5
[86864.873558] iwlwifi 0000:02:00.0:               CSR_EEPROM_GP: 0X00000000
[86864.873573] iwlwifi 0000:02:00.0:              CSR_OTP_GP_REG: 0Xd55555d5
[86864.873588] iwlwifi 0000:02:00.0:                 CSR_GIO_REG: 0X00080042
[86864.873603] iwlwifi 0000:02:00.0:            CSR_GP_UCODE_REG: 0X00000000
[86864.873615] iwlwifi 0000:02:00.0:           CSR_GP_DRIVER_REG: 0X00000000
[86864.873626] iwlwifi 0000:02:00.0:           CSR_UCODE_DRV_GP1: 0X00000000
[86864.873638] iwlwifi 0000:02:00.0:           CSR_UCODE_DRV_GP2: 0X00000000
[86864.873649] iwlwifi 0000:02:00.0:                 CSR_LED_REG: 0X00000060
[86864.873661] iwlwifi 0000:02:00.0:        CSR_DRAM_INT_TBL_REG: 0X880d9476
[86864.873673] iwlwifi 0000:02:00.0:        CSR_GIO_CHICKEN_BITS: 0X27800200
[86864.873684] iwlwifi 0000:02:00.0:             CSR_ANA_PLL_CFG: 0Xd55555d5
[86864.873696] iwlwifi 0000:02:00.0:      CSR_MONITOR_STATUS_REG: 0Xebb7ff77
[86864.873712] iwlwifi 0000:02:00.0:           CSR_HW_REV_WA_REG: 0X0001001a
[86864.873727] iwlwifi 0000:02:00.0:        CSR_DBG_HPET_MEM_REG: 0Xffff0010
[86864.873730] iwlwifi 0000:02:00.0: FH register values:
[86864.873754] iwlwifi 0000:02:00.0:         FH_RSCSR_CHNL0_STTS_WPTR_REG: 0X2131d100
[86864.873779] iwlwifi 0000:02:00.0:        FH_RSCSR_CHNL0_RBDCB_BASE_REG: 0X021033e0
[86864.873811] iwlwifi 0000:02:00.0:                  FH_RSCSR_CHNL0_WPTR: 0X000000c8
[86864.873837] iwlwifi 0000:02:00.0:         FH_MEM_RCSR_CHNL0_CONFIG_REG: 0X00801114
[86864.873858] iwlwifi 0000:02:00.0:          FH_MEM_RSSR_SHARED_CTRL_REG: 0X000000fc
[86864.873878] iwlwifi 0000:02:00.0:            FH_MEM_RSSR_RX_STATUS_REG: 0X03030000
[86864.873890] iwlwifi 0000:02:00.0:    FH_MEM_RSSR_RX_ENABLE_ERR_IRQ2DRV: 0X00000000
[86864.873902] iwlwifi 0000:02:00.0:                FH_TSSR_TX_STATUS_REG: 0X07fd0001
[86864.873913] iwlwifi 0000:02:00.0:                 FH_TSSR_TX_ERROR_REG: 0X00000000
[86864.874031] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[86864.874033] iwlwifi 0000:02:00.0: Status: 0x00000000, count: 6
[86864.874034] iwlwifi 0000:02:00.0: Loaded firmware version: 25.17.12.0
[86864.874036] iwlwifi 0000:02:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN       
[86864.874038] iwlwifi 0000:02:00.0: 0x00000230 | uPc
[86864.874039] iwlwifi 0000:02:00.0: 0x00000000 | branchlink1
[86864.874041] iwlwifi 0000:02:00.0: 0x00042870 | branchlink2
[86864.874042] iwlwifi 0000:02:00.0: 0x00043154 | interruptlink1
[86864.874044] iwlwifi 0000:02:00.0: 0x00043154 | interruptlink2
[86864.874045] iwlwifi 0000:02:00.0: 0x00000000 | data1
[86864.874047] iwlwifi 0000:02:00.0: 0x00000080 | data2
[86864.874048] iwlwifi 0000:02:00.0: 0x07030000 | data3
[86864.874050] iwlwifi 0000:02:00.0: 0x4D4027CB | beacon time
[86864.874051] iwlwifi 0000:02:00.0: 0x39C67846 | tsf low
[86864.874053] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[86864.874054] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[86864.874055] iwlwifi 0000:02:00.0: 0x8C1E213D | time gp2
[86864.874057] iwlwifi 0000:02:00.0: 0x00000000 | time gp3
[86864.874058] iwlwifi 0000:02:00.0: 0x00041911 | uCode version
[86864.874060] iwlwifi 0000:02:00.0: 0x00000210 | hw version
[86864.874061] iwlwifi 0000:02:00.0: 0x00489200 | board version
[86864.874063] iwlwifi 0000:02:00.0: 0x0000001C | hcmd
[86864.874064] iwlwifi 0000:02:00.0: 0x24022002 | isr0
[86864.874066] iwlwifi 0000:02:00.0: 0x01800000 | isr1
[86864.874067] iwlwifi 0000:02:00.0: 0x0000000A | isr2
[86864.874069] iwlwifi 0000:02:00.0: 0x004140C0 | isr3
[86864.874070] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[86864.874072] iwlwifi 0000:02:00.0: 0x00000110 | isr_pref
[86864.874073] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[86864.874075] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[86864.874076] iwlwifi 0000:02:00.0: 0x00010030 | l2p_duration
[86864.874078] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[86864.874079] iwlwifi 0000:02:00.0: 0x000000CE | l2p_addr_match
[86864.874081] iwlwifi 0000:02:00.0: 0x00000005 | lmpm_pmg_sel
[86864.874082] iwlwifi 0000:02:00.0: 0x13041313 | timestamp
[86864.874084] iwlwifi 0000:02:00.0: 0x0034C8D8 | flow_handler
[86864.874087] ieee80211 phy0: Hardware restart was requested
[86865.040868] iwlwifi 0000:02:00.0: Failing on timeout while stopping DMA channel 8 [0x07fd0001]
[86865.041278] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[86865.041480] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[87025.198294] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[87129.249000] (NULL device *): FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
[87964.054523] perf interrupt took too long (5005 > 5000), lowering kernel.perf_event_max_sample_rate to 25000
[88325.640098] wlp2s0: deauthenticating from a8:54:b2:90:ca:e4 by local choice (Reason: 3=DEAUTH_LEAVING)
[88328.987676] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[88328.987887] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[88335.881037] wlp2s0: authenticate with a8:54:b2:90:ca:e4
[88335.884521] wlp2s0: send auth to a8:54:b2:90:ca:e4 (try 1/3)
[88335.886311] wlp2s0: authenticated
[88335.886506] wlp2s0: associate with a8:54:b2:90:ca:e4 (try 1/3)
[88335.889801] wlp2s0: RX AssocResp from a8:54:b2:90:ca:e4 (capab=0x431 status=0 aid=1)
[88335.893126] wlp2s0: associated
[88341.095641] wlp2s0: deauthenticating from a8:54:b2:90:ca:e4 by local choice (Reason: 3=DEAUTH_LEAVING)
[88346.176120] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[88346.176331] iwlwifi 0000:02:00.0: L1 Enabled - LTR Disabled
[88353.068841] wlp2s0: authenticate with a8:54:b2:90:ca:e4
[88353.072129] wlp2s0: send auth to a8:54:b2:90:ca:e4 (try 1/3)
[88353.073953] wlp2s0: authenticated
[88353.075060] wlp2s0: associate with a8:54:b2:90:ca:e4 (try 1/3)
[88353.078301] wlp2s0: RX AssocResp from a8:54:b2:90:ca:e4 (capab=0x431 status=0 aid=1)
[88353.083971] wlp2s0: associated
[88430.644301] wlp2s0: deauthenticating from a8:54:b2:90:ca:e4 by local choice (Reason: 3=DEAUTH_LEAVING)
[88434.048735] wlp2s0: authenticate with 7c:03:4c:71:c8:61
[88434.051570] wlp2s0: send auth to 7c:03:4c:71:c8:61 (try 1/3)
[88434.053386] wlp2s0: authenticated
[88434.053809] wlp2s0: associate with 7c:03:4c:71:c8:61 (try 1/3)
[88434.056475] wlp2s0: RX AssocResp from 7c:03:4c:71:c8:61 (capab=0x411 status=0 aid=2)
[88434.057891] wlp2s0: associated
[88462.307280] IPv6: ADDRCONF(NETDEV_CHANGE): vpn0: link becomes ready

--+QahgC5+KEYLbs62--
