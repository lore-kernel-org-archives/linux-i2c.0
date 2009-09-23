From: Henrik Kretzschmar <henne-lmEOmhgwvqJeCmjzdEDfrw@public.gmane.org>
Subject: Re: Crash on reading the whole PCI config of PIIX4 SMBus
Date: Wed, 23 Sep 2009 17:49:22 +0200
Message-ID: <4ABA4382.1000707@nachtwindheim.de>
References: <4AB8F142.9090609@nachtwindheim.de>	<20090922231839.GA20656@pengutronix.de>	<4ABA1B9C.9070302@nachtwindheim.de>	<20090923153531.1642b77d@hyperion.delvare>	<4ABA2CA1.8070806@nachtwindheim.de> <20090923161518.5cb29107@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090923161518.5cb29107-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare schrieb:

> That's right, but it doesn't explain why i2c-piix4 crashes in the first
> place, not why merely loading it causes further lspci -xxx to crash
> when they did not beforehand. I admit I am totally clueless.
>   
Sorry, I expressed myself a bit unclear.

With _worked_ I meant the system crashed (thats what killer commands are for).

lspci -xxx (and co) bring this system down in every case, module loaded or not.
Obvious this crash occuress when reading the config space in short periods.

lspci (or better proc-fs and sys-fs) do that, and i2c-piix4 does it sometimes.

Looking at read() of drivers/pci/proc.c i had the idea of stalking the critical area with:

#!/bin/sh
for i in `seq 100`; do
 dd if=/proc/bus/pci/00/07.3 of=/dev/null bs=1 count=n 2>/dev/null;
done


I got no crashes with n == 192, but with n == 193 theres no reaction from the system.

Maybe it's interesting, that (all the time after crashes) the screen
(in my case the console with a blinking cursor) can still be seen.
But no reaction on keyboard hits.

Also strange is, that the device works well IF those two read accesses have not done the crash.
I'll test tomorrow without the second read access, just to know if it works.
