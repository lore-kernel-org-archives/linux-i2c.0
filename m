From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Crash on reading the whole PCI config of PIIX4 SMBus
Date: Tue, 22 Sep 2009 19:04:12 +0200
Message-ID: <20090922190412.2f48dfa2@hyperion.delvare>
References: <4AB8F142.9090609@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756943AbZIVRES@vger.kernel.org>
In-Reply-To: <4AB8F142.9090609@nachtwindheim.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Kretzschmar <henne@nachtwindheim.de>
Cc: jbarnes@virtousgeek.org, linux-pci@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 22 Sep 2009 17:46:10 +0200, Henrik Kretzschmar wrote:
> Hi there,
> 
> at boot time my system (Wincor/Nixdorf Beetle D1) sometimes crashs while loading the i2c-piix4 driver.
> I found out that I can always trigger the crash as root, which one of those:  
> 
> # hexdump -C /proc/bus/pci/00/07.3
> # hexdump -C /sys/bus/pci/devices/0000:00:07.3/config
> # lspci -s 07.3 -xxx

Does this crash happens even is i2c-piix4 hasn't been ever loaded since
the last cold boot of the machine?

> 
> While initialization the i2c-piix4 driver does two reads to the config space, at 0xd2 and 0xd6,
> in a relative short time. That sometimes triggers the crash,
> but isn't that precise like one of those commands.
> 
> While my investigations I put a printk() between those two reads and had no more crashs
> on module loading. I tested that with a script, doing insmod/rmmod 100 times in a row.
> 
> But printk() can't be the solution, so I tried msleep(1) and udelay(250),
> but with each of these my system crashed.
> The time for the read and one printk() takes ~100 us on my machine,
> so both time values should be more than enough, if time would have been the reason.
> 
> Does someone have an idea what the driver should do between those two reads, to avoid crashing?

I doubt we can do anything reliable in the i2c-piix4 driver itself, as
this seems to be a rare hardware issue.

> Can somebody with the same device trigger this crash too (greped LKML 2001-2008, found nothing)?

You're rather search the lm-sensors list archives. I don't remember
anything like this, but OTOH the hardware must be so old that I doubt
many people are still using it.

> I have another box with this device and I'll test this in 4 hours.
> Or is just my Hardware broken and I should blacklist the module?

That would be my bet, yes.

> 
> I used 2.6.26-2 (deb/lenny) and 2.6.31 (vanilla) whith the same results.
> 

If there _any_ kernel that did not exhibit the problem?

> Btw, I also tried:
> 
> $ for i in `seq 300`; do sensors; done
> 
> which brought the same machine down (only 2.6.31) with an:
> 
> do_IRQ: 0.66 No irq handler for vector (irq -1)
> 
> 
> #lspci -s 07.3 -vvvn
> 
> 00:07.3 0680: 8086:7113 (rev 02)

That's a pretty old chip... I have one in a 1997 machine. Presumably
you can easily find a replacement machine, ten times more powerful, for
cheap. It might be a more constructive approach that trying to keep the
old thing running.

> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin ? routed to IRQ 9

This "?" looks rather suspicious. Smells like an IRQ routing issue?

> 	Kernel driver in use: piix4_smbus
> 	Kernel modules: i2c-piix4

-- 
Jean Delvare
