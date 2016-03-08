From: fetzerch <fetzer.ch@gmail.com>
Subject: Re: State of the i2c-piix4 driver
Date: Tue, 8 Mar 2016 19:36:32 +0100
Message-ID: <56DF1BB0.2050303@googlemail.com>
References: <20160308151341.48eb3f41@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38752 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcCHSgg (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 8 Mar 2016 13:36:36 -0500
Received: by mail-wm0-f45.google.com with SMTP id l68so39970144wml.1
        for <linux-i2c@vger.kernel.org>; Tue, 08 Mar 2016 10:36:35 -0800 (PST)
In-Reply-To: <20160308151341.48eb3f41@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Rudolf Marek <r.marek@assembler.cz>

Hi Jean,

On 08.03.2016 15:13, Jean Delvare wrote:
> Hi all,
> 
> I am still working on the i2c-piix4 driver. The current state doesn't
> look good, I see many problems.
> 
> 1* We do not check which SMBus ports are enabled before accessing them.
> So we create I2C buses which do not exist. I have a patch adding
> support for this for the SB800.
> 
> 2* Even if we only instantiate I2C buses for ports which do exist, that
> doesn't mean they are used. Unused ports may have their pins left
> floating by the hardware manufacturer, resulting in random behavior and
> boot delays. I suspect this is what was reported at:
>   https://bugzilla.kernel.org/show_bug.cgi?id=112811
> I don't really have a solution for this. One possibility would be to
> add a module parameter to specify which ports are present in case the
> default leads to problems. Another possibility is to enable all ports
> but disable device auto-detection on the extra ports, at least by
> default. Yet another possibility is a DMI-based list of boards with
> known mappings. Not sure what is best, maybe we need a mix of all that,
> opinions welcome.
> 
> Christian, please provide the DMI data for your board, in case we need
> it later.

Sure, see below.

Thanks,
Christian


# dmidecode 2.12
SMBIOS 2.6 present.
35 structures occupying 1145 bytes.
Table at 0x000FB330.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: HP
        Version: O41
        Release Date: 10/01/2013
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 2048 kB
        Characteristics:
                ISA is supported
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                BIOS ROM is socketed
                EDD is supported
                5.25"/1.2 MB floppy services are supported (int 13h)
                3.5"/720 kB floppy services are supported (int 13h)
                3.5"/2.88 MB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                LS-120 boot is supported
                ATAPI Zip drive boot is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
        BIOS Revision: 8.15

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: HP
        Product Name: ProLiant MicroServer
        Version:
        Serial Number: 5C7351P517
        UUID: 1419D680-1DD2-11B2-8000-9CB6540B0F31
        Wake-up Type: Power Switch
        SKU Number: 744900-421
        Family:

Handle 0x0002, DMI type 3, 21 bytes
Chassis Information
        Manufacturer: HP
        Type: Tower
        Lock: Not Present
        Version:
        Serial Number:
        Asset Tag:
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000000
        Height: Unspecified
        Number Of Power Cords: 1
        Contained Elements: 0

Handle 0x0003, DMI type 4, 42 bytes
Processor Information
        Socket Designation: CPU 1
        Type: Central Processor
        Family: Other
        Manufacturer: AMD
        ID: 63 0F 10 00 FF FB 8B 17
        Version: AMD Turion(tm) II Neo N54L Dual-Core Processor
        Voltage: 1.1 V
        External Clock: 200 MHz
        Max Speed: 2200 MHz
        Current Speed: 2200 MHz
        Status: Populated, Enabled
        Upgrade: Other
        L1 Cache Handle: 0x0004
        L2 Cache Handle: 0x0005
        L3 Cache Handle: 0x0006
        Serial Number: To Be Filled By O.E.M.
        Asset Tag: To Be Filled By O.E.M.
        Part Number: To Be Filled By O.E.M.
        Core Count: 2
        Core Enabled: 2
        Thread Count: 2
        Characteristics:
                64-bit capable

Handle 0x0004, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L1-Cache
        Configuration: Enabled, Not Socketed, Level 1
        Operational Mode: Varies With Memory Address
        Location: Internal
        Installed Size: 256 kB
        Maximum Size: 256 kB
        Supported SRAM Types:
                Pipeline Burst
        Installed SRAM Type: Pipeline Burst
        Speed: Unknown
        Error Correction Type: Single-bit ECC
        System Type: Data
        Associativity: 4-way Set-associative

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L2-Cache
        Configuration: Enabled, Not Socketed, Level 2
        Operational Mode: Varies With Memory Address
        Location: Internal
        Installed Size: 2048 kB
        Maximum Size: 2048 kB
        Supported SRAM Types:
                Pipeline Burst
        Installed SRAM Type: Pipeline Burst
        Speed: Unknown
        Error Correction Type: Single-bit ECC
        System Type: Unified
        Associativity: 4-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L3-Cache
        Configuration: Disabled, Not Socketed, Level 3
        Operational Mode: Unknown
        Location: Internal
        Installed Size: 0 kB
        Maximum Size: 0 kB
        Supported SRAM Types:
                Unknown
        Installed SRAM Type: Unknown
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unknown
        Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J13
        Internal Connector Type: None
        External Reference Designator: Front USB
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J14
        Internal Connector Type: None
        External Reference Designator: Front USB
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J15
        Internal Connector Type: None
        External Reference Designator: Rear USB
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J15
        Internal Connector Type: None
        External Reference Designator: LAN 1
        External Connector Type: RJ-45
        Port Type: Network Port

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J16
        Internal Connector Type: None
        External Reference Designator: VGA
        External Connector Type: DB-15 female
        Port Type: Video Port

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J23
        Internal Connector Type: None
        External Reference Designator: eSATA
        External Connector Type: SAS/SATA Plug Receptacle
        Port Type: SATA

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J8 - MINISAS
        Internal Connector Type: SAS/SATA Plug Receptacle
        External Reference Designator: Not Specified
        External Connector Type: None
        Port Type: SATA

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J20 -TPM
        Internal Connector Type: Other
        External Reference Designator: Not Specified
        External Connector Type: None
        Port Type: Other

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J22 -FAN
        Internal Connector Type: Other
        External Reference Designator: Not Specified
        External Connector Type: None
        Port Type: Other

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J24 - SATA ODD
        Internal Connector Type: SAS/SATA Plug Receptacle
        External Reference Designator: Not Specified
        External Connector Type: None
        Port Type: SATA

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J33 - Internal USB
        Internal Connector Type: Access Bus (USB)
        External Reference Designator: Not Specified
        External Connector Type: None
        Port Type: USB

Handle 0x0012, DMI type 9, 17 bytes
System Slot Information
        Designation: PCIE1-J5
        Type: x16 PCI Express
        Current Usage: Available
        Length: Short
        ID: 1
        Characteristics:
                3.3 V is provided
                Opening is shared
                PME signal is supported

Handle 0x0013, DMI type 9, 17 bytes
System Slot Information
        Designation: PCIE2-J6
        Type: x1 PCI Express
        Current Usage: Available
        Length: Short
        ID: 2
        Characteristics:
                3.3 V is provided
                Opening is shared
                PME signal is supported

Handle 0x0014, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: Single-bit ECC
        Maximum Capacity: 8 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x0015, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x002FFFFFFFF
        Range Size: 12 GB
        Physical Array Handle: 0x0014
        Partition Width: 1

Handle 0x0016, DMI type 17, 28 bytes
Memory Device
        Array Handle: 0x0014
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 8192 MB
        Form Factor: DIMM
        Set: None
        Locator: DIMM0
        Bank Locator: BANK0
        Type: Other
        Type Detail: Synchronous
        Speed: 1333 MHz
        Manufacturer: Manufacturer00
        Serial Number: SerNum00
        Asset Tag: Not Specified
        Part Number: ModulePartNumber00
        Rank: Unknown

Handle 0x0017, DMI type 126, 19 bytes
Inactive

Handle 0x0018, DMI type 17, 28 bytes
Memory Device
        Array Handle: 0x0014
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 4096 MB
        Form Factor: DIMM
        Set: None
        Locator: DIMM1
        Bank Locator: BANK1
        Type: Other
        Type Detail: Synchronous
        Speed: 1333 MHz
        Manufacturer: Manufacturer01
        Serial Number: SerNum01
        Asset Tag: Not Specified
        Part Number: ModulePartNumber01
        Rank: Unknown

Handle 0x0019, DMI type 126, 19 bytes
Inactive

Handle 0x001A, DMI type 32, 20 bytes
System Boot Information
        Status: No errors detected

Handle 0x001B, DMI type 38, 18 bytes
IPMI Device Information
        Interface Type: KCS (Keyboard Control Style)
        Specification Version: 2.0
        I2C Slave Address: 0x10
        NV Storage Device: Not Present
        Base Address: 0x0000000000000000 (Memory-mapped)
        Register Spacing: Successive Byte Boundaries

Handle 0x001C, DMI type 193, 7 bytes
OEM-specific Type
        Header and Data:
                C1 07 1C 00 00 01 02
        Strings:
                00/00/0000
                01/12/2013

Handle 0x001D, DMI type 208, 5 bytes
OEM-specific Type
        Header and Data:
                D0 05 1D 00 FF

Handle 0x001E, DMI type 208, 5 bytes
OEM-specific Type
        Header and Data:
                D0 05 1E 00 FF

Handle 0x001F, DMI type 209, 12 bytes
HP BIOS PXE NIC PCI and MAC Information
        NIC 1: PCI device 02:00.0, MAC address 9C:B6:54:0B:0F:31

Handle 0x0020, DMI type 224, 5 bytes
OEM-specific Type
        Header and Data:
                E0 05 20 00 00

Handle 0x0021, DMI type 225, 12 bytes
OEM-specific Type
        Header and Data:
                E1 0C 21 00 48 08 F1 FF 50 00 F0 FF

Handle 0x0022, DMI type 127, 4 bytes
End Of Table

> 
> 3* For the Hudson-2/Bolton, according to the datasheet there is no
> separate GPIO pin configuration registers for the SMBus ports. Pins are
> GPIO when the corresponding SMBus port is not enabled, and SMBus when
> the SMBus port is enabled. This means that it is impossible to detect
> which SMBus ports exist, except for the one being currently selected.
> Even worse, it means that activating any other SMBus port could send I/O
> signals over GPIO pins which were meant for something completely
> different. This has a potential for BREAKING THINGS BADLY, including
> HARDWARE DAMAGE. Therefore I believe that multiplexing support should
> be DISABLED by default on this hardware, as soon as possible.
> 
> 4* Didn't check Mullins and Carrizo yet, but odds are they behave the
> same as Hudson-2/Bolton, so I think we should disable them for the time
> being too.
> 
> 5* The I/O ports used for SMBus configuration and port switching are
> also needed by a watchdog driver, sp5100_tco. Both drivers request the
> region, so the first one wins, and the other driver can't be loaded.
> sp5100_tco was there first, so the changes done to the i2c-piix4 driver
> recently will cause a regression for some users by preventing them
> from using the sp5100_tco and i2c-piix4 drivers at the same time. In
> the long run I guess we will need a helper module to handle this shared
> resource. Unless IORESOURCE_MUXED can be used for that. Either way,
> that's more work than I can put into this before kernel v4.5 is
> released. For the time being, I think we should simply make it
> non-fatal if the I/O ports can't be requested, and continue without
> multiplexing (as before.)
> 
