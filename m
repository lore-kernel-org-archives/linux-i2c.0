From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Crash on reading the whole PCI config of PIIX4 SMBus
Date: Wed, 23 Sep 2009 18:30:29 +0200
Message-ID: <20090923183029.4f0e8ac5@hyperion.delvare>
References: <4AB8F142.9090609@nachtwindheim.de>
	<20090922231839.GA20656@pengutronix.de>
	<4ABA1B9C.9070302@nachtwindheim.de>
	<20090923153531.1642b77d@hyperion.delvare>
	<4ABA2CA1.8070806@nachtwindheim.de>
	<20090923161518.5cb29107@hyperion.delvare>
	<4ABA4382.1000707@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4ABA4382.1000707@nachtwindheim.de>
Sender: linux-pci-owner@vger.kernel.org
To: Henrik Kretzschmar <henne@nachtwindheim.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-pci@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 23 Sep 2009 17:49:22 +0200, Henrik Kretzschmar wrote:
> Jean Delvare schrieb:
> 
> > That's right, but it doesn't explain why i2c-piix4 crashes in the first
> > place, not why merely loading it causes further lspci -xxx to crash
> > when they did not beforehand. I admit I am totally clueless.
> >   
> Sorry, I expressed myself a bit unclear.
> 
> With _worked_ I meant the system crashed (thats what killer commands are for).
> 
> lspci -xxx (and co) bring this system down in every case, module loaded or not.
> Obvious this crash occuress when reading the config space in short periods.

Ah, OK, thanks for the clarification.

> lspci (or better proc-fs and sys-fs) do that, and i2c-piix4 does it sometimes.
> 
> Looking at read() of drivers/pci/proc.c i had the idea of stalking the critical area with:
> 
> #!/bin/sh
> for i in `seq 100`; do
>  dd if=/proc/bus/pci/00/07.3 of=/dev/null bs=1 count=n 2>/dev/null;
> done
> 
> 
> I got no crashes with n == 192, but with n == 193 theres no reaction from the system.
> 
> Maybe it's interesting, that (all the time after crashes) the screen
> (in my case the console with a blinking cursor) can still be seen.
> But no reaction on keyboard hits.

I think it is typical of IRQ routing gone out to lunch.

> Also strange is, that the device works well IF those two read accesses have not done the crash.
> I'll test tomorrow without the second read access, just to know if it works.

-- 
Jean Delvare
