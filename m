From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Crash on reading the whole PCI config of PIIX4 SMBus
Date: Tue, 22 Sep 2009 20:07:56 +0200
Message-ID: <20090922200756.245c43b0@hyperion.delvare>
References: <4AB8F142.9090609@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AB8F142.9090609-lmEOmhgwvqJeCmjzdEDfrw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Henrik Kretzschmar <henne-lmEOmhgwvqJeCmjzdEDfrw@public.gmane.org>
Cc: jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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
> Can somebody with the same device trigger this crash too (greped LKML 2001-2008, found nothing)?

And to answer this question: with the same device (except that it's at
01.3 instead of 07.3 here), none of the 3 above commands crash my
system (kernel 2.6.29.)

-- 
Jean Delvare
