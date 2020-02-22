From: Martin Volf <martin.volf.42@gmail.com>
Subject: [regression] nct6775 does not load in 5.4 and 5.5, bisected to b84398d6d7f90080
Date: Sat, 22 Feb 2020 12:13:07 +0100
Message-ID: <CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-hwmon-owner@vger.kernel.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

hardware monitoring sensors NCT6796D on my Asus PRIME Z390M-PLUS
motherboard with Intel i7-9700 CPU don't work with 5.4 and newer linux
kernels, the driver nct6775 does not load.

It is working OK in version 5.3. I have used almost all released stable
versions from 5.3.8 to 5.3.16; I didn't try older kernels.

Even on new kernels the sensors-detect finds the sensors:
        Found `Nuvoton NCT6796D Super IO Sensors' Success!
            (address 0x290, driver `nct6775')
but "modprobe nct6775" says:
        ERROR: could not insert 'nct6775': No such device
There is nothing interesting in dmesg.

git bisect found out the first bad commit is
b84398d6d7f900805662b1619223fd644d862d7c,
i2c: i801: Use iTCO version 6 in Cannon Lake PCH and beyond

Unfortunately I am not able to revert it in v5.4 to confirm it is really
the culprit.

Is there a way to have working hwmon sensors on my system in newer linux
kernels?

Thanks,

Martin

--8<--
lspci
00:00.0 Host bridge: Intel Corporation 8th Gen Core 8-core Desktop
Processor Host Bridge/DRAM Registers [Coffee Lake S] (rev 0d)
00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 630
(Desktop 9 Series) (rev 02)
00:14.0 USB controller: Intel Corporation Cannon Lake PCH USB 3.1 xHCI
Host Controller (rev 10)
00:14.2 RAM memory: Intel Corporation Cannon Lake PCH Shared SRAM (rev 10)
00:16.0 Communication controller: Intel Corporation Cannon Lake PCH
HECI Controller (rev 10)
00:17.0 SATA controller: Intel Corporation Cannon Lake PCH SATA AHCI
Controller (rev 10)
00:1b.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root
Port #17 (rev f0)
00:1c.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root
Port #1 (rev f0)
00:1c.6 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root
Port #7 (rev f0)
00:1d.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root
Port #9 (rev f0)
00:1f.0 ISA bridge: Intel Corporation Z390 Chipset LPC/eSPI Controller (rev 10)
00:1f.3 Audio device: Intel Corporation Cannon Lake PCH cAVS (rev 10)
00:1f.4 SMBus: Intel Corporation Cannon Lake PCH SMBus Controller (rev 10)
00:1f.5 Serial bus controller [0c80]: Intel Corporation Cannon Lake
PCH SPI Controller (rev 10)
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (7)
I219-V (rev 10)
