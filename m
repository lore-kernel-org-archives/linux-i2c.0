From: Henrik Kretzschmar <henne@nachtwindheim.de>
Subject: Crash on reading the whole PCI config of PIIX4 SMBus
Date: Tue, 22 Sep 2009 17:46:10 +0200
Message-ID: <4AB8F142.9090609@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756726AbZIVPqV@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org, jbarnes@virtousgeek.org
Cc: linux-pci@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi there,

at boot time my system (Wincor/Nixdorf Beetle D1) sometimes crashs while loading the i2c-piix4 driver.
I found out that I can always trigger the crash as root, which one of those:  

# hexdump -C /proc/bus/pci/00/07.3
# hexdump -C /sys/bus/pci/devices/0000:00:07.3/config
# lspci -s 07.3 -xxx

While initialization the i2c-piix4 driver does two reads to the config space, at 0xd2 and 0xd6,
in a relative short time. That sometimes triggers the crash,
but isn't that precise like one of those commands.

While my investigations I put a printk() between those two reads and had no more crashs
on module loading. I tested that with a script, doing insmod/rmmod 100 times in a row.

But printk() can't be the solution, so I tried msleep(1) and udelay(250),
but with each of these my system crashed.
The time for the read and one printk() takes ~100 us on my machine,
so both time values should be more than enough, if time would have been the reason.

Does someone have an idea what the driver should do between those two reads, to avoid crashing?
Can somebody with the same device trigger this crash too (greped LKML 2001-2008, found nothing)?
I have another box with this device and I'll test this in 4 hours.
Or is just my Hardware broken and I should blacklist the module?

I used 2.6.26-2 (deb/lenny) and 2.6.31 (vanilla) whith the same results.

Btw, I also tried:

$ for i in `seq 300`; do sensors; done

which brought the same machine down (only 2.6.31) with an:

do_IRQ: 0.66 No irq handler for vector (irq -1)


#lspci -s 07.3 -vvvn

00:07.3 0680: 8086:7113 (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin ? routed to IRQ 9
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c-piix4
